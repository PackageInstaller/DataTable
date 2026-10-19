using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Local;
using ACT.LocalLoader;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Pb;
using Unity.Profiling;
using UnityEngine;

namespace ACT.Net;

public class NetManager : Singleton<NetManager>
{
	private sealed class ReconnectAckLostException : Exception
	{
		public ReconnectAckLostException(IEnumerable<uint> sessionIds)
			: base("Reconnect ACK recovery failed. Missing sessionIds: " + string.Join(", ", sessionIds))
		{
		}
	}

	private sealed class NetFrameBatch
	{
		public readonly List<NetPacket> Packets;

		public NetFrameBatch(List<NetPacket> packets)
		{
			Packets = packets;
		}
	}

	private const int TCP_CONNECT_TIMEOUT_MILLISECONDS = 10000;

	private INetTransport m_Transport;

	private NetConnectionStateMachine m_ConnectionStateMachine;

	private HashSet<uint> m_ReconnectPendingRequestSessions;

	private uint m_LastGameServerAckSessionId;

	private uint m_ReconnectLastGameServerAckSessionId;

	private bool m_IsReconnectRunning;

	private int m_ReconnectVersion;

	private NetDisconnectReason? m_PendingTerminalDisconnectReason;

	private const int REQUEST_ACK_TIMEOUT_MILLISECONDS = 10000;

	private Dictionary<uint, long> m_NetworkSendList;

	private Dictionary<uint, ushort> m_TrackedRequestCommandIds;

	private bool m_IsNetworkFluctuating;

	private NetConnectionState m_StateBeforeDegraded;

	private static readonly ProfilerMarker s_UpdateProfilerMarker = new ProfilerMarker("ACT.Net.NetManager.Update");

	private const int MAX_MESSAGES_RECEIVED_PER_FRAME = 10;

	private Dictionary<ushort, ActionList<IMessage, bool>> m_MessageListeners;

	private Dictionary<ushort, bool> m_CommandResetFlags;

	private ConcurrentQueue<NetPacket> m_ReceivedPackets;

	private byte[] m_DecryptBuffer;

	private const int CONNECTION_REQUEST_TIMEOUT_MILLISECONDS = 10000;

	private Dictionary<uint, Action<IMessage>> m_ResponseCallbacks;

	private Dictionary<uint, TaskCompletionSource<IMessage>> m_AsyncResponseSources;

	private ErrorAck m_ClientErrorResponse;

	private Dictionary<uint, long> m_RequestTimeoutRemainingMilliseconds;

	private List<uint> m_RequestTimeoutSessionSnapshot;

	private long m_LastRequestTimeoutUpdateTimestampMs;

	private const int MAX_PENDING_FRAME_PACKET_COUNT = 256;

	private List<NetPacket> m_CurrentFramePackets;

	private Queue<NetFrameBatch> m_PendingFrameBatches;

	private Queue<NetPacket> m_PendingConnectionPackets;

	private HashSet<uint> m_QueuedRequestSessions;

	private int m_PendingFramePacketCount;

	private NetByteBuffer m_SendBuffer;

	private bool IsReconnectInProgress
	{
		get
		{
			if (!m_IsReconnectRunning)
			{
				return ConnectionState == NetConnectionState.Reconnecting;
			}
			return true;
		}
	}

	private bool HasPendingTerminalDisconnect => m_PendingTerminalDisconnectReason.HasValue;

	public bool IsConnected
	{
		get
		{
			if (m_Transport != null)
			{
				return m_Transport.Connected;
			}
			return false;
		}
	}

	public NetConnectionState ConnectionState => m_ConnectionStateMachine.Current;

	private bool IsOnline
	{
		get
		{
			NetConnectionState connectionState = ConnectionState;
			return connectionState == NetConnectionState.Online || connectionState == NetConnectionState.Degraded;
		}
	}

	public override ContextType ContextType => ContextType.GLOBAL;

	public event Action NetworkDisconnected;

	public event Action NetworkReconnect;

	public event Action<Exception> ReconnectFailed;

	public event Action<NetConnectionState, NetConnectionState> ConnectionStateChanged;

	public event Action<bool> NetworkFluctuation;

	internal void LogTransportDebugInfo()
	{
		if (LuminApplication.LogEnabled)
		{
			m_Transport.DebugLog();
		}
	}

	private void InitializeConnection()
	{
		m_ConnectionStateMachine = new NetConnectionStateMachine();
		m_ConnectionStateMachine.StateChanged += OnConnectionStateChanged;
		m_ReconnectPendingRequestSessions = new HashSet<uint>();
		m_Transport = CreateTransport();
		BindTransportCallbacks();
	}

	private static INetTransport CreateTransport()
	{
		return new LuminTelepathyTransport();
	}

	public void Disconnect(bool clearCachedPacket = true)
	{
		Disconnect(NetDisconnectReason.UserRequested, clearCachedPacket);
	}

	public void Disconnect(NetDisconnectReason reason)
	{
		Disconnect(reason, clearCachedPacket: true);
	}

	private void Disconnect(NetDisconnectReason reason, bool clearCachedPacket)
	{
		m_PendingTerminalDisconnectReason = null;
		CancelReconnect();
		bool flag = reason != NetDisconnectReason.ServerKicked;
		if (flag && IsOnline)
		{
			TransitionTo(NetConnectionState.Closing, NetConnectionTrigger.DisconnectRequested);
		}
		if (LuminApplication.LogEnabled)
		{
			LogTerminalDisconnect($"apply reason={reason}, state={ConnectionState}");
		}
		ResetTransport(clearCachedPacket, (!flag) ? NetConnectionState.Disconnected : NetConnectionState.Idle);
	}

	private void RequestTerminalDisconnect(NetDisconnectReason reason)
	{
		if (!HasPendingTerminalDisconnect)
		{
			m_PendingTerminalDisconnectReason = reason;
			CancelReconnect();
			if (LuminApplication.LogEnabled)
			{
				LogTerminalDisconnect($"requested reason={reason}, state={ConnectionState}");
			}
		}
	}

	private void ApplyPendingTerminalDisconnect()
	{
		if (m_PendingTerminalDisconnectReason.HasValue)
		{
			Disconnect(m_PendingTerminalDisconnectReason.Value);
		}
	}

	private void ResetTransport(bool clearCachedPacket, NetConnectionState nextState)
	{
		bool flag = nextState == NetConnectionState.Reconnecting;
		m_Transport.Disconnect();
		TransitionTo(nextState, (nextState == NetConnectionState.Reconnecting) ? NetConnectionTrigger.ReconnectStarted : NetConnectionTrigger.DisconnectRequested);
		if (!flag)
		{
			CancelAllPendingRequests();
		}
		if (clearCachedPacket)
		{
			ClearPendingPackets();
		}
		if (!flag)
		{
			m_TrackedRequestCommandIds.Clear();
			m_NetworkSendList.Clear();
			m_ReconnectPendingRequestSessions.Clear();
			m_LastGameServerAckSessionId = 0u;
			m_ReconnectLastGameServerAckSessionId = 0u;
		}
		m_IsNetworkFluctuating = false;
	}

	private void BindTransportCallbacks()
	{
		m_Transport.DataReceived += OnTransportData;
		m_Transport.Disconnected += OnTransportDisconnected;
	}

	private void OnTransportDisconnected()
	{
		if (HasPendingTerminalDisconnect)
		{
			if (LuminApplication.LogEnabled)
			{
				LogTerminalDisconnect($"transport disconnected while pending reason={m_PendingTerminalDisconnectReason}, state={ConnectionState}");
			}
			return;
		}
		NetConnectionState connectionState = ConnectionState;
		if (connectionState == NetConnectionState.Idle || connectionState == NetConnectionState.Disconnected || connectionState == NetConnectionState.Closing)
		{
			return;
		}
		LogTransportDisconnectReason("TransportCallback");
		if (!IsReconnectInProgress)
		{
			connectionState = ConnectionState;
			if (connectionState != NetConnectionState.Connecting && connectionState != NetConnectionState.Authenticating && connectionState != NetConnectionState.Synchronizing)
			{
				if (IsOnline && ShouldAutoReconnect())
				{
					ResetTransport(clearCachedPacket: false, NetConnectionState.Reconnecting);
					BeginReconnect();
					NetworkReconnect?.Invoke();
				}
				else
				{
					ResetTransport(clearCachedPacket: true, NetConnectionState.Disconnected);
					NetworkDisconnected?.Invoke();
				}
				return;
			}
		}
		CancelReconnect();
		ResetTransport(clearCachedPacket: true, NetConnectionState.Disconnected);
		NetworkDisconnected?.Invoke();
	}

	public async Task<bool> ConnectAsync(string host, int port)
	{
		bool isReconnect = IsReconnectInProgress;
		if (!isReconnect)
		{
			TransitionTo(NetConnectionState.Connecting, NetConnectionTrigger.ConnectRequested);
		}
		if (await m_Transport.ConnectAsync(host, port, 10000))
		{
			if (!isReconnect)
			{
				NetPacket._sessionId = 0u;
				m_ReconnectPendingRequestSessions.Clear();
				m_LastGameServerAckSessionId = 0u;
				m_ReconnectLastGameServerAckSessionId = 0u;
				TransitionTo(NetConnectionState.TransportConnected, NetConnectionTrigger.TransportConnected);
			}
			return true;
		}
		if (!isReconnect)
		{
			TransitionTo(NetConnectionState.Disconnected, NetConnectionTrigger.Disconnected);
		}
		Debug.LogError($"[NetFailure] [NetConnection] TCP connect failed, host={host}, port={port}, " + $"state={ConnectionState}, isReconnect={isReconnect}, timeoutMs={10000}");
		return false;
	}

	private void OnConnectionStateChanged(NetConnectionState previous, NetConnectionState current)
	{
		if (LuminApplication.LogEnabled)
		{
			LogReconnectStage($"state {previous} -> {current}");
		}
		ConnectionStateChanged?.Invoke(previous, current);
	}

	private bool TransitionTo(NetConnectionState next, NetConnectionTrigger trigger)
	{
		return m_ConnectionStateMachine.Fire(trigger, next);
	}

	private void MarkAuthenticating()
	{
		TransitionTo(NetConnectionState.Authenticating, NetConnectionTrigger.AuthenticationStarted);
	}

	internal void MarkSynchronizing()
	{
		TransitionTo(NetConnectionState.Synchronizing, NetConnectionTrigger.SynchronizationStarted);
	}

	internal void MarkOnline()
	{
		TransitionTo(NetConnectionState.Online, NetConnectionTrigger.ConnectionReady);
	}

	private void BeginReconnect()
	{
		if (m_IsReconnectRunning || HasPendingTerminalDisconnect)
		{
			return;
		}
		m_ReconnectLastGameServerAckSessionId = m_LastGameServerAckSessionId;
		m_ReconnectPendingRequestSessions.Clear();
		foreach (uint key in m_NetworkSendList.Keys)
		{
			m_ReconnectPendingRequestSessions.Add(key);
		}
		if (LuminApplication.LogEnabled)
		{
			LogReconnectStage($"begin lastSeqId={m_ReconnectLastGameServerAckSessionId}, " + $"pendingCount={m_ReconnectPendingRequestSessions.Count}, " + "pendingSessions=[" + string.Join(", ", m_ReconnectPendingRequestSessions) + "]");
		}
		ReconnectAsync(++m_ReconnectVersion).Forget();
	}

	private void CancelReconnect()
	{
		m_ReconnectVersion++;
		m_IsReconnectRunning = false;
	}

	private bool IsCurrentReconnect(int reconnectVersion)
	{
		return reconnectVersion == m_ReconnectVersion;
	}

	private async UniTask ReconnectAsync(int reconnectVersion)
	{
		m_IsReconnectRunning = true;
		try
		{
			await ExecuteReconnectFlowAsync(reconnectVersion);
		}
		catch (Exception ex)
		{
			if (IsCurrentReconnect(reconnectVersion))
			{
				LogReconnectFailure(ex);
				ResetTransport(clearCachedPacket: true, NetConnectionState.Disconnected);
				if (ex is ReconnectAckLostException)
				{
					NetworkDisconnected?.Invoke();
				}
				else
				{
					ReconnectFailed?.Invoke(ex);
				}
			}
		}
		finally
		{
			if (IsCurrentReconnect(reconnectVersion))
			{
				m_IsReconnectRunning = false;
			}
		}
	}

	private async UniTask ExecuteReconnectFlowAsync(int reconnectVersion)
	{
		await UniTask.WaitUntil(() => !IsCurrentReconnect(reconnectVersion) || CanReconnectNow());
		if (!IsCurrentReconnect(reconnectVersion))
		{
			return;
		}
		LogReconnectStage("gameplay state allows reconnect");
		VersionCheckOption versionCheckOperation = VersionCheckUtil.CheckVersionWithUpdateConfig(GameUtility.gameLoader);
		await versionCheckOperation;
		if (!IsCurrentReconnect(reconnectVersion))
		{
			return;
		}
		RuntimeVersionCheck.CheckVersion(versionCheckOperation);
		LogReconnectStage("version check completed");
		Singleton<GameState>.instance.SetGameServerState(GameServerState.Connecting);
		MarkListenersForReconnect();
		ContextManager.ResetAll(ContextType.NET);
		LoginAck la = await LoginUtility.ConnectLoginServer(preserveCachedPackets: true);
		if (!IsCurrentReconnect(reconnectVersion))
		{
			return;
		}
		LogReconnectStage("login server connected");
		G.service.SetNetState(IGameService.NetState.Reconnet);
		await LoginUtility.ConnectGameServerWithGateFallback(la);
		if (!IsCurrentReconnect(reconnectVersion))
		{
			return;
		}
		LogReconnectStage("game server authenticated");
		if (LuminApplication.LogEnabled)
		{
			LogReconnectStage($"request ACK replay lastSeqId={m_ReconnectLastGameServerAckSessionId}");
		}
		await LoginUtility.SyncUserInfo(new EnterGameLoadReq
		{
			LastSeqID = m_ReconnectLastGameServerAckSessionId
		});
		if (IsCurrentReconnect(reconnectVersion))
		{
			if (LuminApplication.LogEnabled)
			{
				LogReconnectStage($"ACK replay boundary received, remainingCount={m_ReconnectPendingRequestSessions.Count}, " + "remainingSessions=[" + string.Join(", ", m_ReconnectPendingRequestSessions) + "]");
			}
			if (m_ReconnectPendingRequestSessions.Count > 0)
			{
				LogIncompleteAckReplayRequests();
				throw new ReconnectAckLostException(m_ReconnectPendingRequestSessions);
			}
			m_ReconnectPendingRequestSessions.Clear();
			m_ReconnectLastGameServerAckSessionId = 0u;
			MonoECS.instance.ResetPingMessage(0L);
			Singleton<GameState>.instance.SetGameServerState(GameServerState.Connected);
			MarkOnline();
			if (LuminApplication.LogEnabled)
			{
				LogReconnectStage($"completed, cachedPacketCount={m_PendingFramePacketCount}");
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ReconnectServer, null);
		}
	}

	private static void LogReconnectStage(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[NetReconnect] " + message);
		}
	}

	private static void LogReconnectFailure(Exception exception)
	{
		Debug.LogError($"[NetFailure] [NetReconnect] failed\n{exception}");
	}

	private static void LogTerminalDisconnect(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("[NetDisconnect] " + message);
		}
	}

	private static bool CanReconnectNow()
	{
		if (Singleton<GameState>.instance.GameControlStateMachine.Current == GameControlState.Skill)
		{
			return false;
		}
		return Singleton<GameState>.instance.RunningState == GameRunningState.Playing;
	}

	private bool ShouldAutoReconnect()
	{
		if (!HasPendingTerminalDisconnect)
		{
			return Singleton<GameState>.instance.RunningState != GameRunningState.Login;
		}
		return false;
	}

	public NetManager()
	{
		NetPacket._sessionId = 0u;
		InitializeReceiving();
		InitializeRequests();
		InitializeSending();
		InitializeNetworkHealth();
		InitializeConnection();
	}

	public void Update()
	{
		using (s_UpdateProfilerMarker.Auto())
		{
			ProcessReceivedPackets();
			m_Transport.Tick();
			ApplyPendingTerminalDisconnect();
			UpdateNetworkHealth();
			FlushPendingSends();
		}
	}

	public override void UnInit()
	{
		m_Transport?.Disconnect();
		base.UnInit();
		foreach (ActionList<IMessage, bool> value in m_MessageListeners.Values)
		{
			value.Clear();
		}
		m_MessageListeners.Clear();
		m_CommandResetFlags.Clear();
	}

	private void InitializeNetworkHealth()
	{
		m_NetworkSendList = new Dictionary<uint, long>();
		m_TrackedRequestCommandIds = new Dictionary<uint, ushort>();
		m_IsNetworkFluctuating = false;
		m_StateBeforeDegraded = NetConnectionState.Idle;
	}

	private void UpdateNetworkHealth()
	{
		if (HasPendingTerminalDisconnect)
		{
			return;
		}
		if (!m_Transport.Connected)
		{
			if (m_Transport.IsDisconnectNotificationPending)
			{
				return;
			}
			if (IsOnline && ShouldAutoReconnect())
			{
				LogTransportDisconnectReason("TransportStateFallback");
				ResetTransport(clearCachedPacket: false, NetConnectionState.Reconnecting);
				BeginReconnect();
				NetworkReconnect?.Invoke();
				return;
			}
			NetConnectionState connectionState = ConnectionState;
			if (connectionState != NetConnectionState.Idle && connectionState != NetConnectionState.Disconnected && connectionState != NetConnectionState.Closing && connectionState != NetConnectionState.Connecting && connectionState != NetConnectionState.Reconnecting)
			{
				LogTransportDisconnectReason("TransportStateFallback");
				if (TransitionTo(NetConnectionState.Disconnected, NetConnectionTrigger.ConnectionLost))
				{
					NetworkDisconnected?.Invoke();
				}
			}
		}
		else
		{
			if (!IsOnline)
			{
				return;
			}
			bool flag = GetRequestReceiptWaitingMilliseconds() >= 10000;
			if (m_IsNetworkFluctuating == flag)
			{
				if (flag)
				{
					StartReconnectFromReceiptTimeout();
				}
				return;
			}
			if (flag)
			{
				m_StateBeforeDegraded = ConnectionState;
				if (!TransitionTo(NetConnectionState.Degraded, NetConnectionTrigger.NetworkDegraded))
				{
					return;
				}
			}
			else if (ConnectionState == NetConnectionState.Degraded && !TransitionTo(m_StateBeforeDegraded, NetConnectionTrigger.NetworkRecovered))
			{
				return;
			}
			m_IsNetworkFluctuating = flag;
			NetworkFluctuation?.Invoke(m_IsNetworkFluctuating);
			if (flag)
			{
				StartReconnectFromReceiptTimeout();
			}
		}
	}

	private void RecordPacketAcceptedByTransport(NetPacket packet)
	{
		uint sessionId = packet.sessionId;
		if (!ShouldTrackGameServerReceipt(packet))
		{
			m_TrackedRequestCommandIds.Remove(sessionId);
			m_NetworkSendList.Remove(sessionId);
			m_ReconnectPendingRequestSessions.Remove(sessionId);
		}
		else if (m_TrackedRequestCommandIds.ContainsKey(sessionId))
		{
			m_NetworkSendList[sessionId] = GetMonotonicMilliseconds();
		}
	}

	private static bool ShouldTrackGameServerReceipt(NetPacket packet)
	{
		return packet.cmdId != 6;
	}

	private void RecordGameServerAckReceived(NetPacket packet)
	{
		if (packet.cmdId != 7)
		{
			m_TrackedRequestCommandIds.Remove(packet.sessionId);
			m_NetworkSendList.Remove(packet.sessionId);
			m_LastGameServerAckSessionId = packet.sessionId;
			if (m_ReconnectPendingRequestSessions.Remove(packet.sessionId) && LuminApplication.LogEnabled)
			{
				LogReconnectStage($"replayed ACK sessionId={packet.sessionId}, " + $"remainingCount={m_ReconnectPendingRequestSessions.Count}");
			}
		}
	}

	private long GetRequestReceiptWaitingMilliseconds()
	{
		long monotonicMilliseconds = GetMonotonicMilliseconds();
		long num = 0L;
		foreach (KeyValuePair<uint, long> networkSend in m_NetworkSendList)
		{
			long value = networkSend.Value;
			long num2 = monotonicMilliseconds - value;
			if (num2 > num)
			{
				num = num2;
			}
		}
		return num;
	}

	private void LogReceiptTimeoutReconnectReason()
	{
		long monotonicMilliseconds = GetMonotonicMilliseconds();
		int num = 0;
		foreach (KeyValuePair<uint, long> networkSend in m_NetworkSendList)
		{
			if (IsReceiptTimeoutTrigger(networkSend.Value, monotonicMilliseconds))
			{
				num++;
			}
		}
		Debug.LogError($"[NetFailure] [NetReconnect] reason=RequestReceiptTimeout, state={ConnectionState}, " + $"timeoutMs={10000}, " + $"triggeringRequestCount={num}, " + $"pendingRequestCount={m_NetworkSendList.Count}, lastAckSessionId={m_LastGameServerAckSessionId}");
		foreach (KeyValuePair<uint, long> networkSend2 in m_NetworkSendList)
		{
			if (IsReceiptTimeoutTrigger(networkSend2.Value, monotonicMilliseconds))
			{
				LogUnreceivedRequest("RequestReceiptTimeout", "ReconnectTrigger", networkSend2.Key, monotonicMilliseconds);
			}
		}
	}

	private void LogTransportDisconnectReason(string source)
	{
		long monotonicMilliseconds = GetMonotonicMilliseconds();
		Debug.LogError($"[NetFailure] [NetReconnect] reason=TransportDisconnected, source={source}, state={ConnectionState}, " + $"triggerMessageType=None, pendingRequestCount={m_NetworkSendList.Count}, " + $"lastAckSessionId={m_LastGameServerAckSessionId}");
		foreach (KeyValuePair<uint, long> networkSend in m_NetworkSendList)
		{
			LogUnreceivedRequest("TransportDisconnected", "PendingAtDisconnect", networkSend.Key, monotonicMilliseconds);
		}
	}

	private void LogIncompleteAckReplayRequests()
	{
		long monotonicMilliseconds = GetMonotonicMilliseconds();
		Debug.LogError("[NetFailure] [NetReconnect] reason=AckReplayIncomplete, " + $"missingRequestCount={m_ReconnectPendingRequestSessions.Count}");
		foreach (uint reconnectPendingRequestSession in m_ReconnectPendingRequestSessions)
		{
			LogUnreceivedRequest("AckReplayIncomplete", "MissingAfterAckReplay", reconnectPendingRequestSession, monotonicMilliseconds);
		}
	}

	private static bool IsReceiptTimeoutTrigger(long sentTimestamp, long now)
	{
		return now - sentTimestamp >= 10000;
	}

	private void LogUnreceivedRequest(string reason, string requestState, uint sessionId, long now)
	{
		bool flag = m_TrackedRequestCommandIds.TryGetValue(sessionId, out var value);
		string text;
		if (!flag)
		{
			text = "Unknown";
		}
		else
		{
			NetCommand netCommand = (NetCommand)value;
			text = netCommand.ToString();
		}
		string text2 = text;
		string text3 = (flag ? value.ToString() : "Unknown");
		string arg = (m_NetworkSendList.TryGetValue(sessionId, out var value2) ? Math.Max(0L, now - value2).ToString() : "Unknown");
		Debug.LogError("[NetFailure] [NetReconnect] reason=" + reason + ", requestState=" + requestState + ", responseNotReceived=true, requestMessageType=" + text2 + ", requestCmdId=" + text3 + ", " + $"sessionId={sessionId}, waitingMs={arg}");
	}

	private void StartReconnectFromReceiptTimeout()
	{
		if (ConnectionState != NetConnectionState.Reconnecting && !HasPendingTerminalDisconnect)
		{
			LogReceiptTimeoutReconnectReason();
			ResetTransport(clearCachedPacket: false, NetConnectionState.Reconnecting);
			BeginReconnect();
			NetworkReconnect?.Invoke();
		}
	}

	private static long GetMonotonicMilliseconds()
	{
		return (long)((double)Stopwatch.GetTimestamp() * 1000.0 / (double)Stopwatch.Frequency);
	}

	private void InitializeReceiving()
	{
		m_MessageListeners = new Dictionary<ushort, ActionList<IMessage, bool>>();
		m_CommandResetFlags = new Dictionary<ushort, bool>();
		m_ReceivedPackets = new ConcurrentQueue<NetPacket>();
		m_DecryptBuffer = Array.Empty<byte>();
	}

	private void OnTransportData(ArraySegment<byte> data)
	{
		if (!HasPendingTerminalDisconnect)
		{
			if (data.Array == null || data.Count < 10)
			{
				throw new InvalidOperationException($"Invalid packet length: {data.Count}");
			}
			int offset = data.Offset;
			ushort c = NetUtils.BigEndianToUshort(data.Array, offset);
			uint s = NetUtils.BigEndianToUint(data.Array, offset + 2);
			int num = (int)NetUtils.BigEndianToUint(data.Array, offset + 6);
			if (num != data.Count)
			{
				throw new InvalidOperationException($"Packet length mismatch: header={num}, actual={data.Count}");
			}
			DecodeAndQueuePacket(new NetReceivePacket(c, s, offset + 10, num - 10, data.Array));
		}
	}

	private void DecodeAndQueuePacket(NetReceivePacket packet)
	{
		Span<byte> span = packet.data.AsSpan(packet.offset, packet.length);
		if (m_DecryptBuffer.Length < span.Length)
		{
			m_DecryptBuffer = new byte[span.Length];
		}
		bool flag = LuminApplication.TryGcmDecrypt(span, m_DecryptBuffer, out var written);
		if (!flag && packet.cmdId == 1 && LuminApplication.IsGcmEncryptionEnabled)
		{
			flag = LuminApplication.TryCopyPlaintext(span, m_DecryptBuffer, out written);
		}
		if (!flag)
		{
			throw new InvalidOperationException($"Failed to process packet content. cmdId={(NetCommand)packet.cmdId}, length={span.Length}");
		}
		IMessage message = CommandMap.Parse(packet.cmdId, m_DecryptBuffer, 0, written);
		NetPacket netPacket = new NetPacket(packet.cmdId, packet.sessionId, message);
		if (netPacket.sessionId != 0)
		{
			RecordGameServerAckReceived(netPacket);
		}
		m_ReceivedPackets.Enqueue(netPacket);
		if (packet.cmdId == 5)
		{
			RequestTerminalDisconnect(NetDisconnectReason.ServerKicked);
		}
		if (LuminApplication.LogEnabled && NetDebugConfig.config.NeedLog((NetCommand)packet.cmdId))
		{
			if (packet.cmdId == 1)
			{
				Debug.LogError($"{(NetCommand)packet.cmdId} {packet.sessionId} {message}");
			}
			else
			{
				Debug.Log($"{(NetCommand)packet.cmdId} {packet.sessionId} {message}");
			}
		}
	}

	private void ProcessReceivedPackets()
	{
		int num = Mathf.Min(m_ReceivedPackets.Count, 10);
		for (int i = 0; i < num; i++)
		{
			if (!m_ReceivedPackets.TryDequeue(out var result))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("Failed to dequeue a received network packet.");
				}
				break;
			}
			DispatchMessage(result);
			CompleteResponse(result);
		}
	}

	private void DispatchMessage(NetPacket packet)
	{
		if (m_MessageListeners.TryGetValue(packet.cmdId, out var value))
		{
			bool arg = m_CommandResetFlags[packet.cmdId];
			value.Invoke(packet.content, arg);
			m_CommandResetFlags[packet.cmdId] = false;
		}
	}

	private void CompleteResponse(NetPacket packet)
	{
		if (packet.sessionId != 0)
		{
			CompletePendingRequest(packet);
		}
	}

	public void AddListener(ushort cmd, Action<IMessage, bool> action)
	{
		if (!m_MessageListeners.TryGetValue(cmd, out var value))
		{
			value = new ActionList<IMessage, bool>();
			m_MessageListeners.Add(cmd, value);
			m_CommandResetFlags.Add(cmd, value: false);
		}
		value += action;
	}

	private void MarkListenersForReconnect()
	{
		foreach (ushort item in new List<ushort>(m_CommandResetFlags.Keys))
		{
			m_CommandResetFlags[item] = true;
		}
	}

	public void LocalDispatch(ushort cmd, IMessage message)
	{
		if (!m_MessageListeners.TryGetValue(cmd, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Cannot dispatch command {cmd} because no listener is registered.");
			}
		}
		else
		{
			value.Invoke(message, arg2: false);
		}
	}

	private void InitializeRequests()
	{
		m_ResponseCallbacks = new Dictionary<uint, Action<IMessage>>();
		m_AsyncResponseSources = new Dictionary<uint, TaskCompletionSource<IMessage>>();
		m_ClientErrorResponse = new ErrorAck
		{
			Code = -1,
			Message = "client error",
			ErrCode = "C01-0004",
			CodeType = 3,
			CodeModule = 1,
			SubCode = 4
		};
		m_RequestTimeoutRemainingMilliseconds = new Dictionary<uint, long>();
		m_RequestTimeoutSessionSnapshot = new List<uint>();
		m_LastRequestTimeoutUpdateTimestampMs = GetMonotonicMilliseconds();
	}

	private bool ShouldCacheUntilOnline(IMessage message)
	{
		if (message is EnterGameReq)
		{
			return false;
		}
		NetConnectionState connectionState = ConnectionState;
		return connectionState == NetConnectionState.Connecting || connectionState == NetConnectionState.TransportConnected || connectionState == NetConnectionState.Authenticating || connectionState == NetConnectionState.Synchronizing || connectionState == NetConnectionState.Degraded || connectionState == NetConnectionState.Reconnecting;
	}

	private Task<IMessage> EnqueueCachedRequestAsync(IMessage message)
	{
		NetPacket packet = CreatePacket(message);
		TaskCompletionSource<IMessage> taskCompletionSource = new TaskCompletionSource<IMessage>(TaskCreationOptions.RunContinuationsAsynchronously);
		m_AsyncResponseSources[packet.sessionId] = taskCompletionSource;
		if (TryEnqueueCurrentFramePacket(packet, expectsResponse: true))
		{
			return taskCompletionSource.Task;
		}
		TryCompleteAsyncRequest(packet.sessionId, m_ClientErrorResponse);
		return taskCompletionSource.Task;
	}

	private bool EnqueueCachedRequest(IMessage message, Action<IMessage> callback)
	{
		NetPacket packet = CreatePacket(message);
		m_ResponseCallbacks[packet.sessionId] = callback;
		if (TryEnqueueCurrentFramePacket(packet, expectsResponse: true))
		{
			return true;
		}
		m_ResponseCallbacks.Remove(packet.sessionId);
		callback?.Invoke(m_ClientErrorResponse);
		return false;
	}

	private bool EnqueueCachedPost(IMessage message)
	{
		return TryEnqueueCurrentFramePacket(CreatePacket(message), expectsResponse: false);
	}

	private void RegisterRequestTimeout(uint sessionId, int timeoutMilliseconds)
	{
		m_RequestTimeoutRemainingMilliseconds[sessionId] = timeoutMilliseconds;
	}

	private void UpdateRequestTimeouts()
	{
		long monotonicMilliseconds = GetMonotonicMilliseconds();
		long num = monotonicMilliseconds - m_LastRequestTimeoutUpdateTimestampMs;
		m_LastRequestTimeoutUpdateTimestampMs = monotonicMilliseconds;
		m_RequestTimeoutSessionSnapshot.Clear();
		m_RequestTimeoutSessionSnapshot.AddRange(m_RequestTimeoutRemainingMilliseconds.Keys);
		for (int i = 0; i < m_RequestTimeoutSessionSnapshot.Count; i++)
		{
			uint num2 = m_RequestTimeoutSessionSnapshot[i];
			if (m_RequestTimeoutRemainingMilliseconds.TryGetValue(num2, out var value))
			{
				value -= num;
				if (value <= 0)
				{
					TryCompleteAsyncRequest(num2, m_ClientErrorResponse);
				}
				else
				{
					m_RequestTimeoutRemainingMilliseconds[num2] = value;
				}
			}
		}
	}

	private void CancelAllPendingRequests()
	{
		List<TaskCompletionSource<IMessage>> list = new List<TaskCompletionSource<IMessage>>(m_AsyncResponseSources.Values);
		m_AsyncResponseSources.Clear();
		m_RequestTimeoutRemainingMilliseconds.Clear();
		foreach (TaskCompletionSource<IMessage> item in list)
		{
			item.TrySetResult(m_ClientErrorResponse);
		}
		m_ResponseCallbacks.Clear();
	}

	private bool TryCompleteAsyncRequest(uint sessionId, IMessage result)
	{
		m_TrackedRequestCommandIds.Remove(sessionId);
		m_NetworkSendList.Remove(sessionId);
		m_RequestTimeoutRemainingMilliseconds.Remove(sessionId);
		if (!m_AsyncResponseSources.TryGetValue(sessionId, out var value))
		{
			return false;
		}
		m_AsyncResponseSources.Remove(sessionId);
		return value.TrySetResult(result);
	}

	private void CompletePendingRequest(NetPacket packet)
	{
		m_RequestTimeoutRemainingMilliseconds.Remove(packet.sessionId);
		if (m_ResponseCallbacks.TryGetValue(packet.sessionId, out var value))
		{
			m_ResponseCallbacks.Remove(packet.sessionId);
			value(packet.content);
		}
		if (m_AsyncResponseSources.TryGetValue(packet.sessionId, out var value2))
		{
			m_AsyncResponseSources.Remove(packet.sessionId);
			value2.TrySetResult(packet.content);
		}
	}

	public bool Post(IMessage data)
	{
		if (data is EnterGameReq)
		{
			MarkAuthenticating();
		}
		if (ShouldCacheUntilOnline(data))
		{
			return EnqueueCachedPost(data);
		}
		if (!IsOnline && !(data is EnterGameReq))
		{
			return false;
		}
		NetPacket packet = CreatePacket(data);
		if (!(data is EnterGameReq))
		{
			return TrySendPostPacket(packet);
		}
		return TrySendConnectionPostPacket(packet);
	}

	public Task<IMessage> RequestAsync(IMessage data)
	{
		if (data is EnterGameReq)
		{
			MarkAuthenticating();
		}
		if (ShouldCacheUntilOnline(data))
		{
			return EnqueueCachedRequestAsync(data);
		}
		if (!IsOnline && !(data is EnterGameReq))
		{
			return System.Threading.Tasks.Task.FromResult((IMessage)m_ClientErrorResponse);
		}
		return RequestImmediateAsync(data, data is EnterGameReq);
	}

	internal Task<IMessage> RequestConnectionAsync(IMessage data)
	{
		if (data is EnterGameReq)
		{
			MarkAuthenticating();
		}
		return RequestImmediateWithTimeoutAsync(data, 10000, useConnectionQueue: true);
	}

	private Task<IMessage> RequestImmediateWithTimeoutAsync(IMessage data, int timeoutMilliseconds, bool useConnectionQueue = false)
	{
		NetPacket packet = CreatePacket(data);
		TaskCompletionSource<IMessage> taskCompletionSource = new TaskCompletionSource<IMessage>(TaskCreationOptions.RunContinuationsAsynchronously);
		m_AsyncResponseSources[packet.sessionId] = taskCompletionSource;
		RegisterRequestTimeout(packet.sessionId, timeoutMilliseconds);
		if (!(useConnectionQueue ? TrySendConnectionRequestPacket(packet) : TrySendRequestPacket(packet)))
		{
			m_AsyncResponseSources.Remove(packet.sessionId);
			m_RequestTimeoutRemainingMilliseconds.Remove(packet.sessionId);
			return System.Threading.Tasks.Task.FromResult((IMessage)m_ClientErrorResponse);
		}
		return taskCompletionSource.Task;
	}

	private Task<IMessage> RequestImmediateAsync(IMessage data, bool useConnectionQueue = false)
	{
		NetPacket packet = CreatePacket(data);
		TaskCompletionSource<IMessage> taskCompletionSource = new TaskCompletionSource<IMessage>(TaskCreationOptions.RunContinuationsAsynchronously);
		m_AsyncResponseSources[packet.sessionId] = taskCompletionSource;
		if (useConnectionQueue ? TrySendConnectionRequestPacket(packet) : TrySendRequestPacket(packet))
		{
			return taskCompletionSource.Task;
		}
		m_AsyncResponseSources.Remove(packet.sessionId);
		return System.Threading.Tasks.Task.FromResult((IMessage)m_ClientErrorResponse);
	}

	private NetPacket CreatePacket(IMessage data)
	{
		return new NetPacket(CommandMap.GetCmdId(data.GetType()), data);
	}

	public bool Request(IMessage data, Action<IMessage> callback)
	{
		if (data is EnterGameReq)
		{
			MarkAuthenticating();
		}
		if (ShouldCacheUntilOnline(data))
		{
			return EnqueueCachedRequest(data, callback);
		}
		if (!IsOnline && !(data is EnterGameReq))
		{
			return false;
		}
		NetPacket packet = CreatePacket(data);
		uint sessionId = packet.sessionId;
		m_ResponseCallbacks[sessionId] = callback;
		if ((data is EnterGameReq) ? TrySendConnectionRequestPacket(packet) : TrySendRequestPacket(packet))
		{
			return true;
		}
		m_ResponseCallbacks.Remove(sessionId);
		return false;
	}

	private void InitializeSending()
	{
		m_CurrentFramePackets = new List<NetPacket>();
		m_PendingFrameBatches = new Queue<NetFrameBatch>();
		m_PendingConnectionPackets = new Queue<NetPacket>();
		m_QueuedRequestSessions = new HashSet<uint>();
		m_SendBuffer = new NetByteBuffer();
	}

	private bool TryEnqueueCurrentFramePacket(NetPacket packet, bool expectsResponse)
	{
		if (m_PendingFramePacketCount >= 256)
		{
			return false;
		}
		LogPacketQueuedForSend(packet);
		m_CurrentFramePackets.Add(packet);
		m_PendingFramePacketCount++;
		if (expectsResponse)
		{
			m_QueuedRequestSessions.Add(packet.sessionId);
		}
		return true;
	}

	private void FlushPendingSends()
	{
		UpdateRequestTimeouts();
		FreezeCurrentFramePackets();
		if (m_PendingConnectionPackets.Count > 0)
		{
			SendNextPendingConnectionPacket();
		}
		else if (ConnectionState == NetConnectionState.Online)
		{
			SendNextPendingFrameBatch();
		}
	}

	private void FreezeCurrentFramePackets()
	{
		if (m_CurrentFramePackets.Count != 0)
		{
			m_PendingFrameBatches.Enqueue(new NetFrameBatch(m_CurrentFramePackets));
			m_CurrentFramePackets = new List<NetPacket>();
		}
	}

	private void SendNextPendingFrameBatch()
	{
		if (!m_Transport.CanSend || m_PendingFrameBatches.Count == 0)
		{
			return;
		}
		NetFrameBatch netFrameBatch = m_PendingFrameBatches.Peek();
		List<NetPacket> list = new List<NetPacket>(netFrameBatch.Packets.Count);
		for (int i = 0; i < netFrameBatch.Packets.Count; i++)
		{
			NetPacket item = netFrameBatch.Packets[i];
			if (m_QueuedRequestSessions.Contains(item.sessionId) && !m_ResponseCallbacks.ContainsKey(item.sessionId) && !m_AsyncResponseSources.ContainsKey(item.sessionId))
			{
				m_QueuedRequestSessions.Remove(item.sessionId);
			}
			else
			{
				list.Add(item);
			}
		}
		if (list.Count == 0)
		{
			DequeuePendingFrameBatch(netFrameBatch);
		}
		else
		{
			if (!TryWriteFrameToSendBuffer(list))
			{
				return;
			}
			for (int j = 0; j < list.Count; j++)
			{
				NetPacket packet = list[j];
				if (m_QueuedRequestSessions.Contains(packet.sessionId) && ShouldTrackGameServerReceipt(packet))
				{
					m_TrackedRequestCommandIds[packet.sessionId] = packet.cmdId;
				}
			}
			byte[] array = CopySendBuffer();
			if (!m_Transport.Send(new ArraySegment<byte>(array)))
			{
				for (int k = 0; k < list.Count; k++)
				{
					m_TrackedRequestCommandIds.Remove(list[k].sessionId);
				}
				return;
			}
			DequeuePendingFrameBatch(netFrameBatch);
			for (int l = 0; l < list.Count; l++)
			{
				m_QueuedRequestSessions.Remove(list[l].sessionId);
				RecordPacketAcceptedByTransport(list[l]);
			}
		}
	}

	private void DequeuePendingFrameBatch(NetFrameBatch batch)
	{
		m_PendingFrameBatches.Dequeue();
		m_PendingFramePacketCount -= batch.Packets.Count;
	}

	private bool TryWriteFrameToSendBuffer(List<NetPacket> packets)
	{
		ResetSendBuffer();
		List<NetPacket> list = new List<NetPacket>();
		List<NetPacket> list2 = new List<NetPacket>();
		for (int i = 0; i < packets.Count; i++)
		{
			if (packets[i].cmdId == 6)
			{
				list.Add(packets[i]);
			}
			else
			{
				list2.Add(packets[i]);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			if (!m_SendBuffer.TryWrite(list[j]))
			{
				return false;
			}
		}
		if (list2.Count == 0)
		{
			return m_SendBuffer.length > 0;
		}
		if (list2.Count == 1)
		{
			return m_SendBuffer.TryWrite(list2[0]);
		}
		if (!TryBuildBatchPacket(list2, out var packetToWrite))
		{
			return false;
		}
		return m_SendBuffer.TryWrite(packetToWrite);
	}

	private bool TrySendConnectionPacket(NetPacket packet)
	{
		if (!m_Transport.Connected)
		{
			return false;
		}
		LogPacketQueuedForSend(packet);
		m_PendingConnectionPackets.Enqueue(packet);
		return true;
	}

	private void SendNextPendingConnectionPacket()
	{
		if (!m_Transport.CanSend)
		{
			return;
		}
		NetPacket packet = m_PendingConnectionPackets.Peek();
		ResetSendBuffer();
		if (m_SendBuffer.TryWrite(packet))
		{
			byte[] array = CopySendBuffer();
			if (m_Transport.Send(new ArraySegment<byte>(array)))
			{
				m_PendingConnectionPackets.Dequeue();
				RecordPacketAcceptedByTransport(packet);
			}
		}
	}

	private void ResetSendBuffer()
	{
		m_SendBuffer.length = 0;
		m_SendBuffer.readerIndex = 0;
	}

	private byte[] CopySendBuffer()
	{
		byte[] array = new byte[m_SendBuffer.length];
		Buffer.BlockCopy(m_SendBuffer.data, 0, array, 0, m_SendBuffer.length);
		return array;
	}

	private static bool TryBuildBatchPacket(List<NetPacket> packets, out NetPacket packetToWrite)
	{
		List<byte> list = new List<byte>();
		for (int i = 0; i < packets.Count; i++)
		{
			list.AddRange(NetByteBuffer.ToByteArray(packets[i]));
		}
		if (list.Count == 0)
		{
			packetToWrite = default;
			return false;
		}
		packetToWrite = new NetPacket(2002, new GameBatchPacket
		{
			PacketData = ByteString.CopyFrom(list.ToArray())
		});
		return true;
	}

	private static void LogPacketQueuedForSend(NetPacket packet)
	{
	}

	private void ClearPendingPackets()
	{
		m_CurrentFramePackets.Clear();
		m_PendingFrameBatches.Clear();
		m_PendingConnectionPackets.Clear();
		m_PendingFramePacketCount = 0;
		m_QueuedRequestSessions.Clear();
	}

	private bool TrySendRequestPacket(NetPacket packet)
	{
		return TryEnqueueCurrentFramePacket(packet, expectsResponse: true);
	}

	private bool TrySendPostPacket(NetPacket packet)
	{
		return TryEnqueueCurrentFramePacket(packet, expectsResponse: false);
	}

	private bool TrySendConnectionRequestPacket(NetPacket packet)
	{
		if (ShouldTrackGameServerReceipt(packet))
		{
			m_TrackedRequestCommandIds[packet.sessionId] = packet.cmdId;
		}
		if (TrySendConnectionPacket(packet))
		{
			return true;
		}
		m_TrackedRequestCommandIds.Remove(packet.sessionId);
		return false;
	}

	private bool TrySendConnectionPostPacket(NetPacket packet)
	{
		return TrySendConnectionPacket(packet);
	}
}
