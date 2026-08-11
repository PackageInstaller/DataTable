#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Threading;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class ServerCommandSystem : BaseSystem
{
	public enum LockStepGameResult
	{
		None,
		GameOver,
		GameError
	}

	public class KcpTime : IReference
	{
		public float Time;

		public bool IsOverTime;

		public void Update(float deltaTime)
		{
			Time -= deltaTime;
			if (Time <= 0f)
			{
				IsOverTime = true;
			}
		}

		public void Check()
		{
			Time = 4f;
		}

		public void Reset()
		{
			Time = 4f;
			IsOverTime = false;
		}

		public void Clear()
		{
			Time = 0f;
			IsOverTime = false;
		}
	}

	private KcpSocketSystem _kcpSocketSystem;

	private ConcurrentDictionary<uint, VerityServerFrameData> _serverCommands = new ConcurrentDictionary<uint, VerityServerFrameData>();

	private ConcurrentDictionary<int, GameMs> _gameMsDic = new ConcurrentDictionary<int, GameMs>();

	private uint _gameMsCooing;

	private float _checkGameMs;

	private long _userId = 10001L;

	private long _roomKey = 999L;

	private bool _kcpConnectSuccess;

	private LockStepWorldType _lockStepWorldType;

	private bool _isNeedSendReloadMessage;

	private bool _isCanSendReloadMessage;

	private bool _isCanSendBattleFrame;

	private bool _isExecuteSystem;

	private int _reconnectionServerTick;

	private Action<int, int> _updateProgressAction;

	private Action _gameStartAction;

	private Action _lostConnectAction;

	private bool _isBattleReload;

	private float _kcpTimeOver;

	private float _gameMsCheckTime;

	private float _heartBeatTime;

	private bool _isCanSendHeartBeat;

	private bool _battleStart;

	private float _checkAbNormalTick;

	private float _reloadTimeOutTime;

	private bool _startCheckReload;

	private int _cacheVeritySuccessPacketNumber;

	private bool _isExecuteServerCommand;

	private LockStepGameResult _gameResult;

	private long _ms;

	public const int GameOverCode = 200092;

	public const int GameErrorCode = 201019;

	protected override bool IsLogicSystem => true;

	public bool KcpConnectSuccess => _kcpConnectSuccess;

	public bool BattleStart => _battleStart;

	public int CacheVeritySuccessPacketNumber => _cacheVeritySuccessPacketNumber;

	public void SystemInit(LockStepWorldType lockStepWorldType, bool isExecuteServerCommand, long userId, long roomKey, Action<int, int> updateProgressAction, Action gameStart, Action lostConnectAction)
	{
		_kcpSocketSystem = GetSystem<KcpSocketSystem>();
		_lockStepWorldType = lockStepWorldType;
		_isCanSendBattleFrame = true;
		_updateProgressAction = updateProgressAction;
		_gameStartAction = gameStart;
		_lostConnectAction = lostConnectAction;
		_userId = userId;
		_roomKey = roomKey;
		_gameMsCooing = 66u;
		_gameMsCheckTime = 3f;
		_isNeedSendReloadMessage = _lockStepWorldType == LockStepWorldType.Reconnect;
		_isBattleReload = false;
		_isCanSendHeartBeat = true;
		_isExecuteSystem = true;
		_checkAbNormalTick = 5f;
		_cacheVeritySuccessPacketNumber = 0;
		_isExecuteServerCommand = isExecuteServerCommand;
		_gameResult = LockStepGameResult.None;
		ResetTimeOver();
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (_isExecuteSystem && _kcpConnectSuccess && _isExecuteServerCommand)
		{
			CheckReloadError(deltaTime);
			CheckGameMs(deltaTime);
			SocketTimeOver(deltaTime);
			CheckAbNormalApplyTick(deltaTime);
			CheckReloadConnect();
			CheckGameAbnormal();
		}
	}

	private void CheckGameAbnormal()
	{
		if (_gameResult == LockStepGameResult.GameError)
		{
			LostConnect("检测到游戏异常...", KcpErrorLevelEnum.QuitBattle);
		}
		if (_gameResult == LockStepGameResult.GameOver)
		{
			LostConnect("游戏已经结束...", KcpErrorLevelEnum.QuitBattle);
		}
	}

	private void CheckReloadError(float deltaTime)
	{
		if (_startCheckReload)
		{
			_reloadTimeOutTime -= deltaTime;
			if (_reloadTimeOutTime <= 0f)
			{
				LostConnect("重连超时,是否重新连接...", KcpErrorLevelEnum.CanReloadError);
				_kcpSocketSystem.KcpConnectOut(shutdown: false);
				Log.Error("重连超时：长时间未收到服务器帧消息...");
				_reloadTimeOutTime = 5f;
				_startCheckReload = false;
			}
		}
	}

	private void ResetReloadCheck()
	{
		_startCheckReload = false;
		_reloadTimeOutTime = 5f;
		_lockStepWorldType = LockStepWorldType.Normal;
	}

	private void SocketTimeOver(float deltaTime)
	{
		if (_battleStart)
		{
			_kcpTimeOver -= deltaTime;
			if (_kcpTimeOver <= 0f)
			{
				LostConnect("连接超时是否重新连接.", KcpErrorLevelEnum.CanReloadError);
				_kcpSocketSystem.KcpConnectOut(shutdown: false);
				Log.Error("长时间未收到服务器消息,客户端断开连接...");
			}
		}
	}

	private void CheckAbNormalApplyTick(float deltaTime)
	{
		if (_battleStart && _kcpConnectSuccess)
		{
			_checkAbNormalTick -= deltaTime;
			if (_checkAbNormalTick <= 0f)
			{
				LostConnect("连接超时是否重新连接.", KcpErrorLevelEnum.CanReloadError);
				_kcpSocketSystem.KcpConnectOut(shutdown: false);
				Log.Error("执行指令异常，缺少指令...");
				_checkAbNormalTick = 5f;
			}
		}
	}

	private void GameStartTimeOut(float deltaTime)
	{
	}

	private void CheckReloadConnect()
	{
		if (KcpConnectSuccess && _isNeedSendReloadMessage && _isCanSendReloadMessage)
		{
			int startTick = (int)((world.Tick == 0) ? 1 : world.Tick);
			KcpReload(startTick, world.RealServerTick);
			_isNeedSendReloadMessage = false;
			_isCanSendReloadMessage = false;
		}
	}

	private void CheckGameMs(float deltaTime)
	{
		if (_battleStart)
		{
			_gameMsCheckTime -= deltaTime;
			if (_gameMsCheckTime <= 0f)
			{
				world.GameMs = 460;
				_gameMsCheckTime = 3f;
			}
		}
	}

	public void SendBattleFrameMessage(MsgPlayerInput playerInput, int localActorId, uint sendTick)
	{
		if (_isCanSendBattleFrame)
		{
			OneBattleFrameMessage messageObject = StructureServerData(playerInput, localActorId, sendTick);
			SendMessage<OneBattleFrameMessage>(messageObject);
			RecodeSendTickTime((int)sendTick);
		}
	}

	private OneBattleFrameMessage StructureServerData(MsgPlayerInput msgPlayerInput, int localActorId, uint sendTick)
	{
		OneBattleFrameMessage oneBattleFrameMessage = OneBattleFrameMessage.Create();
		oneBattleFrameMessage.Actor = localActorId;
		oneBattleFrameMessage.Tick = (int)sendTick;
		oneBattleFrameMessage.inputUV.Add(msgPlayerInput.inputUV.x);
		oneBattleFrameMessage.inputUV.Add(msgPlayerInput.inputUV.y);
		oneBattleFrameMessage.skillJoyUv.Add(msgPlayerInput.skillJoyUv.x);
		oneBattleFrameMessage.skillJoyUv.Add(msgPlayerInput.skillJoyUv.y);
		oneBattleFrameMessage.optionCode = (int)msgPlayerInput.optionCode;
		oneBattleFrameMessage.SkillState = msgPlayerInput.SkillState;
		oneBattleFrameMessage.AutoFight = msgPlayerInput.AutoFight;
		oneBattleFrameMessage.AutoUseProp = msgPlayerInput.AutoUseProp;
		_ = KCPLog.Open;
		return oneBattleFrameMessage;
	}

	private void ReceiveBattleFrameResponse(GlobalBattleFrame packet, bool isReloadPacket)
	{
		_gameMsCheckTime = 3f;
		if (!_isExecuteServerCommand)
		{
			return;
		}
		if (KCPLog.Open)
		{
		}
		if (packet.Tick < world.Tick)
		{
			_ = KCPLog.Open;
			return;
		}
		int count = packet.BattleFrames.Count;
		uint num = ((packet.Tick == 0) ? 1u : ((uint)packet.Tick));
		if (!_serverCommands.TryGetValue(num, out var value))
		{
			value = ReferencePool.Acquire<VerityServerFrameData>();
			value.SetCommandNumber((packet.Tick != 0) ? count : 0);
			if (packet.Tick != 0)
			{
				foreach (OneBattleFrameMessage battleFrame in packet.BattleFrames)
				{
					MsgPlayerInput msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
					msgPlayerInput.RefreshData(battleFrame, packet.Tick);
					value.SetData(msgPlayerInput);
					_ = KCPLog.Open;
					if (!isReloadPacket)
					{
						RecodeReceiveTickTime(battleFrame);
					}
				}
			}
			if (_serverCommands.TryAdd(num, value))
			{
				Interlocked.Increment(ref _cacheVeritySuccessPacketNumber);
			}
			else
			{
				value.Clear();
				ReferencePool.Release(value);
				Log.Error($"[KCP] 添加帧数据失败，key={num} 已存在");
			}
		}
		world.RealServerTick = packet.Tick;
		if (_isNeedSendReloadMessage)
		{
			_isCanSendReloadMessage = true;
		}
	}

	private void ReloadBattleFrameResponse(List<GlobalBattleFrame> globalBattleFrames)
	{
		if (!_isExecuteServerCommand)
		{
			return;
		}
		foreach (GlobalBattleFrame globalBattleFrame in globalBattleFrames)
		{
			ReceiveBattleFrameResponse(globalBattleFrame, isReloadPacket: true);
			_ = KCPLog.Open;
		}
	}

	public VerityServerFrameData GetServerCommand(uint tick)
	{
		if (_serverCommands.TryGetValue(tick, out var value) && value.IsCanExecuteCommand)
		{
			if (_updateProgressAction != null)
			{
				_updateProgressAction((int)tick, _reconnectionServerTick);
			}
			if (_reconnectionServerTick != 0 && _reconnectionServerTick == tick)
			{
				_updateProgressAction = null;
				_isCanSendBattleFrame = true;
			}
			_checkAbNormalTick = 5f;
			return value;
		}
		return null;
	}

	public void SetConnectState(bool isConnect)
	{
		_kcpConnectSuccess = isConnect;
		if (!_kcpConnectSuccess)
		{
			ResetDataOnCloseConnect();
		}
		else
		{
			_isCanSendHeartBeat = true;
			ResetTimeOver();
			if (_lockStepWorldType == LockStepWorldType.Reconnect)
			{
				_startCheckReload = true;
				_reloadTimeOutTime = 5f;
			}
		}
		_ = KCPLog.Open;
	}

	private void ResetDataOnCloseConnect()
	{
		ResetTimeOver();
		_battleStart = false;
		_isCanSendHeartBeat = false;
		if (world != null)
		{
			world.GameMs = 460;
		}
		_checkAbNormalTick = 5f;
	}

	public void ClearServerCommand(VerityServerFrameData verityServerFrameData, uint tick)
	{
		if (_serverCommands.Remove(tick, out var value))
		{
			value.Clear();
			ReferencePool.Release(value);
			Interlocked.Decrement(ref _cacheVeritySuccessPacketNumber);
		}
	}

	private void ResetTimeOver()
	{
		_kcpTimeOver = 4f;
	}

	public bool SendBattleStart()
	{
		C2G_LoginBattleFieldGate c2G_LoginBattleFieldGate = new C2G_LoginBattleFieldGate();
		c2G_LoginBattleFieldGate.UserId = _userId;
		c2G_LoginBattleFieldGate.Key = _roomKey;
		if (_isBattleReload || _lockStepWorldType == LockStepWorldType.Reconnect)
		{
			c2G_LoginBattleFieldGate.ReConnect = true;
		}
		else
		{
			c2G_LoginBattleFieldGate.ReConnect = false;
		}
		bool flag = SendMessage<C2G_LoginBattleFieldGate>(c2G_LoginBattleFieldGate);
		_ = KCPLog.Open & flag;
		return true;
	}

	public bool SendBattleEnd()
	{
		MultiFightFinishNotification multiFightFinishNotification = new MultiFightFinishNotification();
		multiFightFinishNotification.UserId = _userId;
		SendMessage<MultiFightFinishNotification>(multiFightFinishNotification);
		_ = KCPLog.Open;
		return true;
	}

	public void HideSystem()
	{
		_isExecuteSystem = false;
	}

	private void GameStart(bool isReloadConnect)
	{
		_ = KCPLog.Open;
		_gameStartAction?.Invoke();
		_battleStart = true;
		if (isReloadConnect)
		{
			ResetReloadCheck();
		}
	}

	public void LostConnect(string tipsContent, KcpErrorLevelEnum kcpErrorLevelEnum)
	{
		_lostConnectAction?.Invoke();
		SetConnectState(isConnect: false);
		if (kcpErrorLevelEnum == KcpErrorLevelEnum.CanReloadError)
		{
			IAsyncResult<int> result = Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(tipsContent, isDoubleButton: true);
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result == -1)
				{
					StartReload();
				}
				else
				{
					world?.GameSettlement(GameSettlementType.LostConnect);
				}
			});
		}
		else
		{
			_lostConnectAction?.Invoke();
			Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(tipsContent, isDoubleButton: false).Callbackable()
				.OnCallback(delegate
				{
					world?.GameSettlement(GameSettlementType.BattleOver);
				});
		}
	}

	private void StartReload()
	{
		_isBattleReload = true;
		_ = KCPLog.Open;
		if (!GetSystem<KcpSocketSystem>().Connect(isReloadConnect: true))
		{
			LostConnect("重新连接失败请重试.", KcpErrorLevelEnum.CanReloadError);
		}
		else
		{
			_isNeedSendReloadMessage = true;
		}
	}

	private void KcpReload(int startTick, int endTick)
	{
		if (startTick <= 0)
		{
			Log.Error($"[KCP] KcpReload 错误：startTick={startTick}，修正为1");
			startTick = 1;
		}
		ClientCatchUpFrameRequest clientCatchUpFrameRequest = ClientCatchUpFrameRequest.Create();
		clientCatchUpFrameRequest.StartFrameIdx = startTick;
		clientCatchUpFrameRequest.EndFrameIdx = endTick;
		clientCatchUpFrameRequest.UserId = _userId;
		bool num = SendMessage<ClientCatchUpFrameRequest>(clientCatchUpFrameRequest);
		_reconnectionServerTick = endTick;
		_isCanSendBattleFrame = false;
		if (num)
		{
			_ = KCPLog.Open;
		}
		else
		{
			_ = KCPLog.Open;
		}
	}

	private void RecodeSendTickTime(int tick)
	{
		if (_gameMsDic != null && !_gameMsDic.ContainsKey(tick))
		{
			GameMs value = new GameMs
			{
				SendTimeStamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()
			};
			_gameMsDic.TryAdd(tick, value);
		}
	}

	private void RecodeReceiveTickTime(OneBattleFrameMessage oneBattleFrame)
	{
		if (oneBattleFrame.SkillState != 999 && oneBattleFrame.Actor == world.ActorId)
		{
			if (_gameMsDic.TryGetValue(oneBattleFrame.Tick, out var value))
			{
				value.ReceiveTimeStamp = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
				value.GetMs();
				_ms += value.Ms - 10;
			}
			if (_gameMsDic.Count >= 66)
			{
				world.GameMs = Mathf.Clamp((int)((float)_ms * 1f / (float)_gameMsDic.Count), 10, 460);
				_gameMsDic.Clear();
				_ms = 0L;
			}
		}
	}

	public override void OnDispose()
	{
		_userId = 0L;
		_roomKey = 0L;
		_kcpSocketSystem = null;
		_reconnectionServerTick = 0;
		_isCanSendBattleFrame = true;
		_serverCommands.Clear();
		_serverCommands = null;
		_gameMsDic.Clear();
		_gameMsDic = null;
		_kcpConnectSuccess = false;
		_lockStepWorldType = LockStepWorldType.Normal;
		_isNeedSendReloadMessage = false;
		_battleStart = false;
		_isBattleReload = false;
		_startCheckReload = false;
		_gameStartAction = null;
		_lostConnectAction = null;
		_updateProgressAction = null;
		_checkAbNormalTick = 0f;
		_cacheVeritySuccessPacketNumber = 0;
		_gameResult = LockStepGameResult.None;
		ResetDataOnCloseConnect();
		base.OnDispose();
	}

	private bool SendMessage<T>(MessageObject messageObject) where T : MessageObject
	{
		if (_kcpSocketSystem == null)
		{
			return false;
		}
		return _kcpSocketSystem.Send<T>(messageObject);
	}

	public bool ProcessProtocol(MemoryStream memoryStream)
	{
		if (_kcpSocketSystem == null)
		{
			return true;
		}
		memoryStream.Seek(2L, SeekOrigin.Begin);
		ushort num = BitConverter.ToUInt16(memoryStream.GetBuffer(), 0);
		Type type = Singleton<NetCodes>.Instance.GetType(num);
		int num2 = (int)memoryStream.Length;
		byte[] buffer = memoryStream.GetBuffer();
		MessageObject messageObject = MessageSerializeHelper.Deserialize(type, buffer, 2, num2 - 2);
		ResetTimeOver();
		try
		{
			switch (num)
			{
			case 10029:
			{
				GlobalBattleFrame globalBattleFrame = (GlobalBattleFrame)messageObject;
				if (globalBattleFrame == null)
				{
					_kcpSocketSystem.KcpError("GlobalBattleFrame == null", KcpErrorLevelEnum.CanReloadError);
					return true;
				}
				if (globalBattleFrame.Tick == 0)
				{
					string text = BitConverter.ToString(buffer, 0, Math.Min(50, num2)).Replace("-", " ");
					Log.Error("[KCP Bug] 收到第0帧数据包!\n" + $"  Opcode={num}, ActualLength={num2}\n" + "  Buffer=[" + text + "]\n" + $"  当前客户端状态: world.Tick={world?.Tick}, RealServerTick={world?.RealServerTick}\n" + string.Format("  KcpConnectSuccess={0}\n", _kcpSocketSystem?.GetType().GetField("_isConnected", BindingFlags.Instance | BindingFlags.NonPublic)?.GetValue(_kcpSocketSystem)) + $"  IsBattleReload={_isBattleReload}, _lockStepWorldType={_lockStepWorldType}\n" + $"  时间: {DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}");
					return true;
				}
				ReceiveBattleFrameResponse(globalBattleFrame, isReloadPacket: false);
				break;
			}
			case 10026:
			{
				S2C_Global_GameStart s2C_Global_GameStart = (S2C_Global_GameStart)messageObject;
				if (s2C_Global_GameStart == null)
				{
					_kcpSocketSystem.KcpError("S2C_Global_GameStart == null", KcpErrorLevelEnum.CanReloadError);
					return true;
				}
				if (s2C_Global_GameStart.Error == 0)
				{
					GameStart(isReloadConnect: false);
					if (!KCPLog.Open)
					{
					}
					break;
				}
				if (s2C_Global_GameStart.Error == 200092)
				{
					_gameResult = LockStepGameResult.GameOver;
					_ = KCPLog.Open;
					return true;
				}
				if (s2C_Global_GameStart.Error != 201019)
				{
					break;
				}
				_gameResult = LockStepGameResult.GameError;
				_ = KCPLog.Open;
				return true;
			}
			case 10503:
			{
				ClientCatchUpFrameNotify clientCatchUpFrameNotify = (ClientCatchUpFrameNotify)messageObject;
				if (clientCatchUpFrameNotify == null)
				{
					_kcpSocketSystem.KcpError("ClientCatchUpFrameNotify == null", KcpErrorLevelEnum.CanReloadError);
					return true;
				}
				GetSystem<ServerCommandSystem>().ReloadBattleFrameResponse(clientCatchUpFrameNotify.ClientFrames);
				GameStart(isReloadConnect: true);
				if (!KCPLog.Open)
				{
				}
				break;
			}
			case 10618:
			{
				BattleUserOnlineStateChangeNotify battleUserOnlineStateChangeNotify = (BattleUserOnlineStateChangeNotify)messageObject;
				if (battleUserOnlineStateChangeNotify != null)
				{
					GetSystem<BattleSystem>().UpdateTeamMateOnlineState((int)battleUserOnlineStateChangeNotify.UserEntityActorId, battleUserOnlineStateChangeNotify.Offline);
				}
				break;
			}
			}
		}
		catch (Exception ex)
		{
			_kcpSocketSystem.KcpError("ProcessProtocolError : " + ex.Message, KcpErrorLevelEnum.CanReloadError);
			return true;
		}
		return false;
	}
}
