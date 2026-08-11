#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using AOT;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using Lockstep.Core;
using Microsoft.IO;

namespace Ase;

public class KcpSocketSystem : BaseSystem
{
	private IntPtr kcp;

	private static long Id;

	private readonly byte[] _cache = new byte[2048];

	private static Socket _socket;

	private volatile bool _isConnected;

	private static IPEndPoint _remoteEndPoint;

	private EndPoint _endPoint;

	private uint _timeNow;

	private long _startTime;

	private static MemoryStream _memoryStream;

	private RecyclableMemoryStreamManager _memoryStreamManager;

	private bool _running;

	private string _ip = "192.168.130.56";

	private int _port = 10003;

	private ServerCommandSystem _serverCommandSystem;

	private static bool _isError;

	private static string _errorContent;

	private KcpErrorLevelEnum _kcpErrorLevel;

	private bool _needFlush;

	private CancellationTokenSource _synCancellationTokenSource;

	private CancellationTokenSource _cancellationTokenSource;

	private Task _task;

	public static uint LocalConn => (uint)Id;

	public uint RemoteConn { get; private set; }

	protected override bool IsLogicSystem => false;

	public void InitSocketData(string ip, int port, uint localConnectId)
	{
		_ip = ip;
		_port = port;
		Id = localConnectId;
		_serverCommandSystem = GetSystem<ServerCommandSystem>();
	}

	private void InitKcp()
	{
		_startTime = TimeHelper.ClientNow();
		_timeNow = (uint)(TimeHelper.ClientNow() - _startTime);
		kcp = Kcp.KcpCreate(0u, new IntPtr(LocalConn));
		Kcp.KcpNodelay(kcp, 1, 10, 2, 1);
		Kcp.KcpWndsize(kcp, 512, 512);
		Kcp.KcpSetmtu(kcp, 470);
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		return Connect(isReloadConnect: false);
	}

	public bool Connect(bool isReloadConnect)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Expected O, but got Unknown
		_memoryStreamManager = new RecyclableMemoryStreamManager();
		_memoryStream = (MemoryStream)(object)_memoryStreamManager.GetStream("message", 65535L);
		InitKcp();
		SetOutput();
		_socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
		try
		{
			_remoteEndPoint = new IPEndPoint(IPAddress.Parse(_ip), _port);
			_socket.Connect(_remoteEndPoint);
			Init();
			if (isReloadConnect)
			{
				StartSynTask();
				_ = KCPLog.Open;
			}
			_ = KCPLog.Open;
		}
		catch (Exception ex)
		{
			Log.Error("Connect error: " + ex.Message);
			return false;
		}
		if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
		{
			_socket.IOControl(-1744830452, new byte[1] { Convert.ToByte(value: false) }, null);
		}
		return true;
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		StartSynTask();
	}

	private void Init()
	{
		if (!_running)
		{
			_running = true;
			_task = new Task(StartUpdate);
			_task.Start();
			StartGameStartTask();
		}
	}

	private async Task SendKcpCheck(CancellationToken cancellationToken)
	{
		try
		{
			while (!_isConnected && !cancellationToken.WaitHandle.WaitOne(1000))
			{
				cancellationToken.ThrowIfCancellationRequested();
				if (_isConnected)
				{
					break;
				}
				Socket socket = _socket;
				MemoryStream memoryStream = _memoryStream;
				if (socket == null || memoryStream == null)
				{
					_ = KCPLog.Open;
					break;
				}
				cancellationToken.ThrowIfCancellationRequested();
				byte[] buffer = memoryStream.GetBuffer();
				buffer.WriteTo(0, (byte)1);
				buffer.WriteTo(1, LocalConn);
				if (socket.Send(buffer, 0, 5, SocketFlags.None) == 0)
				{
					KcpError("发送 SYN失败 : 连接可能已经关闭...", KcpErrorLevelEnum.CanReloadError);
					break;
				}
				_ = KCPLog.Open;
			}
		}
		catch (OperationCanceledException)
		{
			_ = KCPLog.Open;
		}
		catch (SocketException ex2)
		{
			string[] obj = new string[8] { "Network is unreachable", "No route to host", "Destination address required", "Access denied", "Invalid arguments", "Invalid handle", "Connection reset by peer", "Connection timed out" };
			bool flag = false;
			string[] array = obj;
			foreach (string value in array)
			{
				if (ex2.Message.Contains(value) || ((int)ex2.SocketErrorCode).ToString().Contains(value))
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				_ = KCPLog.Open;
				return;
			}
			Log.Error("发送 SYN失败 (SocketException): " + ex2.Message);
			throw new Exception("KCP连接异常 : " + ex2.Message);
		}
		catch (Exception ex3)
		{
			Log.Error("发送 SYN失败 : 连接可能已经关闭... " + ex3.Message);
			throw new Exception("KCP连接异常 : " + ex3.Message);
		}
	}

	private void StartUpdate()
	{
		while (_running)
		{
			_timeNow = (uint)(TimeHelper.ClientNow() - _startTime);
			Update();
			Receive();
		}
	}

	private void KcpFlush()
	{
		if (_needFlush)
		{
			Kcp.KcpFlush(kcp);
			_needFlush = false;
		}
	}

	private void CheckGameStart(CancellationToken cancellationToken)
	{
		for (int i = 0; i < 42; i++)
		{
			cancellationToken.ThrowIfCancellationRequested();
			Thread.Sleep(1000);
			if (cancellationToken.IsCancellationRequested)
			{
				return;
			}
		}
		if (world == null)
		{
			Log.Error("KCP连接异常： world == null...");
			throw new Exception("KCP连接异常!");
		}
		if (!_isConnected || !world.IsRunning)
		{
			Log.Error($"KCP连接异常： _isConnected = {_isConnected} || world.IsRunning = {world.IsRunning}");
			throw new Exception("KCP连接异常!");
		}
	}

	private async void HeartBeat()
	{
		try
		{
			while (_isConnected)
			{
				await Task.Delay(2000);
				C2S_HeartBeat messageObject = C2S_HeartBeat.Create();
				if (Send<C2S_HeartBeat>(messageObject))
				{
					_ = KCPLog.Open;
				}
			}
		}
		catch (Exception ex)
		{
			throw new Exception("KCP连接异常 : " + ex.Message);
		}
	}

	private void Update()
	{
		uint timeNow = _timeNow;
		try
		{
			Kcp.KcpUpdate(kcp, timeNow);
		}
		catch (Exception ex)
		{
			KcpError("Update Error : " + ex.Message, KcpErrorLevelEnum.CanReloadError);
			return;
		}
		if (kcp != IntPtr.Zero)
		{
			Kcp.KcpCheck(kcp, timeNow);
		}
	}

	private void HandleConnect(uint remoteConn)
	{
		if (!_isConnected)
		{
			_synCancellationTokenSource?.Cancel();
			RemoteConn = remoteConn;
			kcp = Kcp.KcpCreate(RemoteConn, new IntPtr(LocalConn));
			SetOutput();
			Kcp.KcpNodelay(kcp, 1, 10, 2, 1);
			Kcp.KcpWndsize(kcp, 256, 256);
			Kcp.KcpSetmtu(kcp, 470);
			_isConnected = true;
			_serverCommandSystem.SetConnectState(isConnect: true);
			_serverCommandSystem.SendBattleStart();
			StartHeartBeat();
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		CheckLostConnect();
	}

	private void CheckLostConnect()
	{
		if (Singleton<NetworkSystem>.Instance.Connected() && _isError)
		{
			_isError = false;
			KcpConnectOut(shutdown: false);
			if (string.IsNullOrEmpty(_errorContent))
			{
				_serverCommandSystem.LostConnect("连接超时,是否重新连接...", _kcpErrorLevel);
			}
			else
			{
				_serverCommandSystem.LostConnect("连接超时,是否重新连接...", _kcpErrorLevel);
			}
		}
	}

	private void SetOutput()
	{
		Kcp.KcpSetoutput(KcpOutput);
	}

	[MonoPInvokeCallback(typeof(KcpOutput))]
	private static int KcpOutput(IntPtr bytes, int len, IntPtr kcp, IntPtr user)
	{
		Output(bytes, len);
		return len;
	}

	private static void Output(IntPtr bytes, int count)
	{
		if (!_socket.Connected)
		{
			return;
		}
		try
		{
			if (count != 0)
			{
				byte[] buffer = _memoryStream.GetBuffer();
				buffer.WriteTo(0, (byte)4);
				buffer.WriteTo(1, LocalConn);
				Marshal.Copy(bytes, buffer, 5, count);
				if (_socket.Send(buffer, 0, count + 5, SocketFlags.None) == 0)
				{
					_errorContent = "Output Error : 连接可能已经关闭";
					_isError = true;
				}
			}
		}
		catch (Exception ex)
		{
			_errorContent = "Output Error : " + ex.Message;
			_isError = true;
		}
	}

	public bool Send<T>(MessageObject messageObject) where T : MessageObject
	{
		if (!_isConnected)
		{
			return false;
		}
		ushort opcode = Singleton<NetCodes>.Instance.GetOpcode(messageObject.GetType());
		byte[] array = MessageSerializeHelper.Serialize((T)messageObject);
		byte[] array2 = new byte[array.Length + 2];
		WriteUShort(array2, 0, opcode);
		CopyByteArray(array, 0, array2, 2, array.Length);
		if (kcp != IntPtr.Zero && Kcp.KcpWaitsnd(kcp) > 1536)
		{
			KcpError("Kcp超出三倍窗口大小", KcpErrorLevelEnum.CanReloadError);
			return false;
		}
		if (Kcp.KcpSend(kcp, array2, 0, array2.Length) < 0)
		{
			KcpError("Kcp 发送失败...", KcpErrorLevelEnum.CanReloadError);
			return false;
		}
		return true;
	}

	private void WriteUShort(byte[] buffer, int offset, ushort value)
	{
		buffer[offset] = (byte)value;
		buffer[offset + 1] = (byte)(value >> 8);
	}

	private void CopyByteArray(byte[] source, int sourceOffset, byte[] destination, int destOffset, int count)
	{
		Buffer.BlockCopy(source, sourceOffset, destination, destOffset, count);
	}

	private void Receive()
	{
		if (!_running || _socket == null || !_socket.Connected)
		{
			return;
		}
		while (_socket != null && _socket.Available > 0)
		{
			int num = 0;
			try
			{
				num = _socket.Receive(_cache);
			}
			catch (Exception ex)
			{
				KcpError("KCP ReceiveError : " + ex.Message, KcpErrorLevelEnum.CanReloadError);
				continue;
			}
			if (num < 1)
			{
				continue;
			}
			switch (_cache[0])
			{
			case 2:
				if (num == 9)
				{
					uint remoteConn = BitConverter.ToUInt32(_cache, 1);
					HandleConnect(remoteConn);
				}
				break;
			case 3:
				if (num == 13)
				{
				}
				break;
			case 4:
				if (num >= 9)
				{
					HandleReceive(_cache, 5, num - 5);
				}
				break;
			}
		}
	}

	private void HandleReceive(byte[] date, int offset, int length)
	{
		int num = Kcp.KcpInput(kcp, date, offset, length);
		if (num < 0)
		{
			Log.Error($"[KCP] KcpInput 失败，返回码: {num}");
			return;
		}
		if (length > 5)
		{
			bool flag = true;
			for (int i = 5; i < Math.Min(length, 30); i++)
			{
				if (date[offset + i] != 0)
				{
					flag = false;
					break;
				}
			}
		}
		while (true)
		{
			int num2 = Kcp.KcpPeeksize(kcp);
			if (num2 < 0)
			{
				break;
			}
			if (num2 == 0)
			{
				Log.Error(SocketError.NetworkReset);
				break;
			}
			byte[] buffer = _memoryStream.GetBuffer();
			if (buffer.Length < num2)
			{
				Log.Error($"[KCP] 缓冲区不足，需要 {num2}，实际 {buffer.Length}");
				break;
			}
			_memoryStream.SetLength(num2);
			_memoryStream.Seek(0L, SeekOrigin.Begin);
			int num3 = Kcp.KcpRecv(kcp, buffer, 0, num2);
			if (num2 != num3)
			{
				Log.Error($"[KCP] 数据接收异常，期望 {num2}，实际 {num3}");
				break;
			}
			if (num3 <= 0)
			{
				break;
			}
			OnRead(_memoryStream);
			_memoryStream.SetLength(0L);
		}
	}

	private void OnRead(MemoryStream memoryStream)
	{
		_serverCommandSystem.ProcessProtocol(memoryStream);
	}

	public void KcpError(string content, KcpErrorLevelEnum kcpErrorLevelEnum)
	{
		Log.Error(content ?? "");
		_errorContent = content;
		_isError = true;
		_kcpErrorLevel = kcpErrorLevelEnum;
	}

	public async void KcpConnectOut(bool shutdown)
	{
		if (_synCancellationTokenSource != null)
		{
			_synCancellationTokenSource.Cancel();
			_synCancellationTokenSource.Dispose();
			_synCancellationTokenSource = null;
		}
		if (_cancellationTokenSource != null)
		{
			_cancellationTokenSource.Cancel();
			_cancellationTokenSource.Dispose();
			_cancellationTokenSource = null;
		}
		_isConnected = false;
		_running = false;
		if (_socket == null)
		{
			return;
		}
		object obj = null;
		try
		{
			try
			{
				_socket.Shutdown(SocketShutdown.Both);
			}
			catch
			{
			}
		}
		catch (object obj3)
		{
			obj = obj3;
		}
		_socket.Close();
		_socket = null;
		await Task.Delay(100);
		if (_task != null)
		{
			_task.Dispose();
			_task = null;
		}
		_memoryStream = null;
		_memoryStreamManager = null;
		_isError = false;
		if (shutdown)
		{
			_serverCommandSystem = null;
		}
		object obj4 = obj;
		if (obj4 != null)
		{
			ExceptionDispatchInfo.Capture((obj4 as Exception) ?? throw obj4).Throw();
		}
	}

	public override void OnDispose()
	{
		if (_isConnected)
		{
			Socket socket = _socket;
			if (socket != null && socket.Connected)
			{
				byte[] buffer = _memoryStream.GetBuffer();
				buffer.WriteTo(0, (byte)3);
				buffer.WriteTo(1, LocalConn);
				buffer.WriteTo(5, RemoteConn);
				buffer.WriteTo(9, 0);
				_socket?.Send(buffer, 0, 13, SocketFlags.None);
			}
		}
		KcpConnectOut(shutdown: true);
		base.OnDispose();
	}

	private async void StartSynTask()
	{
		try
		{
			_synCancellationTokenSource = new CancellationTokenSource();
			await Task.Run(() => SendKcpCheck(_synCancellationTokenSource.Token));
		}
		catch (Exception ex)
		{
			KcpConnectOut(shutdown: false);
			Log.Error("发送SYN失败 ： " + ex.Message);
			_serverCommandSystem?.LostConnect("连接超时,是否重新连接...", KcpErrorLevelEnum.CanReloadError);
		}
	}

	private async void StartGameStartTask()
	{
		try
		{
			_cancellationTokenSource = new CancellationTokenSource();
			await Task.Run(delegate
			{
				CheckGameStart(_cancellationTokenSource.Token);
			}, _cancellationTokenSource.Token);
		}
		catch (Exception)
		{
			Log.Error("KCP连接异常： StartGameStartTask _isConnected = false...");
			Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(1);
		}
	}

	private async void StartHeartBeat()
	{
		try
		{
			await Task.Run((Action)HeartBeat);
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception)
		{
			KcpConnectOut(shutdown: false);
			Log.Error("心跳发送失败,准备打开退出界面");
			_serverCommandSystem?.LostConnect("连接超时,是否重新连接...", KcpErrorLevelEnum.CanReloadError);
		}
	}
}
