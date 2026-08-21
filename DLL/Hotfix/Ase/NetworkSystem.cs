#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Network;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class NetworkSystem : Singleton<NetworkSystem>, ISingletonUpdate
{
	public enum NetworkConnectState
	{
		Connecting,
		Connected,
		Disconnected
	}

	private INetworkChannel mainChannel;

	private INetworkSubscription<EventArgs> eventSubscription;

	private INetworkSubscription<INotification> messageSubscription;

	private IMessenger m_NetMessenger;

	private NetworkReachability curStatus;

	private int requestTimeoutCount;

	private const string MAIN_CHANNEL = "MAIN_CHANNEL";

	private const int HeartbeatInterval = 45000;

	private const float ReconnectDelayConfig = 1.5f;

	private const int MaxRequestTimeoutCount = 3;

	private const int RequestTimeoutMilliseconds = 15000;

	private int missHeartBeatCount;

	private C2S_HeartBeat hearbeat = new C2S_HeartBeat();

	private NetworkHeartbeatThread heartbeatThread;

	private NetworkConnectState networkConnectState = NetworkConnectState.Disconnected;

	private float reconnectDelay;

	public long SecretKey { get; private set; }

	public int ServerId { get; private set; }

	public string IP { get; private set; }

	public int Port { get; private set; }

	public int HttpPort { get; private set; }

	public string ServerName { get; private set; }

	public NetworkConnectState CurrentNetworkConnectState => networkConnectState;

	public NetworkSystem()
	{
		m_NetMessenger = new Messenger();
		curStatus = Application.internetReachability;
	}

	public async UniTask<ServerInfo> GetActivedServerInfos()
	{
		List<ServerInfo> serverIpList = GameEntry.BuiltinData.ServerList;
		ServerInfo serverInfo = null;
		List<int> ipRandomIndexList = new List<int>();
		for (int i = 0; i < serverIpList.Count; i++)
		{
			ipRandomIndexList.Add(i);
		}
		ipRandomIndexList.Shuffle();
		for (int j = 0; j < ipRandomIndexList.Count; j++)
		{
			if (await PingServerAsync(serverIpList[ipRandomIndexList[j]]) > 0)
			{
				serverInfo = serverIpList[ipRandomIndexList[j]];
				break;
			}
		}
		return serverInfo;
	}

	private async UniTask<long> PingServerAsync(ServerInfo server)
	{
		try
		{
			Ping ping = new Ping(server.ip);
			float startTime = Time.realtimeSinceStartup;
			while (!ping.isDone && Time.realtimeSinceStartup - startTime < 3f)
			{
				await UniTask.Yield();
			}
			if (ping.isDone)
			{
				return ping.time;
			}
			return -1L;
		}
		catch (Exception)
		{
			return -1L;
		}
	}

	public async UniTask<bool> ConnectToServer(ServerInfo serverInfo = null)
	{
		DisposeMainChannel();
		if (serverInfo == null)
		{
			serverInfo = await GetActivedServerInfos();
		}
		if (serverInfo == null)
		{
			Log.Error("没有可用的服务器信息.");
			return false;
		}
		try
		{
			mainChannel = GameEntry.Network.CreateNetworkChannel("MAIN_CHANNEL", ServiceType.Tcp, new DefaultChannelHelper());
			eventSubscription = mainChannel.Events().Filter((EventArgs e) => e is ConnectionEventArgs).ObserveOn(SynchronizationContext.Current)
				.Subscribe(OnConnectEventReceived);
			messageSubscription = mainChannel.Received().ObserveOn(SynchronizationContext.Current).Subscribe(delegate(INotification notification)
			{
				if (m_NetMessenger != null)
				{
					m_NetMessenger.Publish(notification);
				}
			});
			IP = serverInfo.ip;
			HttpPort = serverInfo.httpport;
			ServerName = serverInfo.name;
			Port = serverInfo.port;
			await mainChannel.Connect(serverInfo.ip, serverInfo.port, 5000);
		}
		catch (Exception)
		{
			DisposeMainChannel();
			return false;
		}
		return mainChannel != null && mainChannel.Connected;
	}

	public async UniTask<bool> ConnectToServer(IAccountService.LoginParam loginParam)
	{
		await ConnectToServer(await GetActivedServerInfos());
		if (mainChannel == null || !mainChannel.Connected)
		{
			return false;
		}
		try
		{
			LoginGameRequest loginGameRequest;
			KiifLoginHallRequest kiifLoginHallRequest;
			if (loginParam.IsSDKLogin)
			{
				loginGameRequest = LoginGameRequest.Create();
				loginGameRequest.Account = loginParam.Account;
				loginGameRequest.PlatformName = loginParam.UserName;
				loginGameRequest.Token = loginParam.Token;
				loginGameRequest.ChannelId = loginParam.ChannelID;
				loginGameRequest.DistinctId = TDAHandler.Instance.GetDistinctId();
				loginGameRequest.DeviceId = loginParam.DeviceId;
				loginGameRequest.SubChannelId = GameEntry.BuiltinData.SubChannel;
				loginGameRequest.VersionId = GameEntry.BuiltinData.VersionInfo;
				LoginGameResponse loginGameResponse = await QueuingLogin(LoginFunc);
				if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(loginGameResponse, "请求登录") || !Singleton<NetResponseHandler>.Instance.ValidateErrorCode(loginGameResponse.Error, loginGameResponse.Message))
				{
					loginGameRequest.Dispose();
					loginGameResponse?.Dispose();
					throw new GameFrameworkException("登录失败");
				}
				SecretKey = loginGameResponse.SecretKey;
				ServerId = loginGameResponse.TargetServerId;
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().CreateRoleData(loginGameResponse.UserId, loginGameResponse.UserBaseInfo, loginGameResponse.ServerOpneTime);
				loginGameRequest.Dispose();
				loginGameResponse?.Dispose();
				OnConnected();
			}
			else
			{
				if (!long.TryParse(loginParam.Token, out var result))
				{
					Log.Error("登录密钥无效，请检查登录参数。");
					return false;
				}
				kiifLoginHallRequest = KiifLoginHallRequest.Create();
				kiifLoginHallRequest.Key = result;
				kiifLoginHallRequest.Account = loginParam.Account;
				kiifLoginHallRequest.Password = loginParam.Password;
				kiifLoginHallRequest.DeviceId = loginParam.DeviceId;
				kiifLoginHallRequest.VersionId = GameEntry.BuiltinData.VersionInfo;
				KiifLoginHallResponse kiifLoginHallResponse = await QueuingLogin(LoginFunc2);
				if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(kiifLoginHallResponse, "请求登录") || !Singleton<NetResponseHandler>.Instance.ValidateErrorCode(kiifLoginHallResponse.Error, kiifLoginHallResponse.Message))
				{
					kiifLoginHallRequest.Dispose();
					kiifLoginHallResponse?.Dispose();
					throw new GameFrameworkException("登录失败");
				}
				SecretKey = kiifLoginHallResponse.SecretKey;
				ServerId = kiifLoginHallResponse.TargetServerId;
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().CreateRoleData(kiifLoginHallResponse.UserId, kiifLoginHallResponse.UserBaseInfo, kiifLoginHallResponse.ServerOpneTime);
				kiifLoginHallRequest.Dispose();
				kiifLoginHallResponse?.Dispose();
				OnConnected();
			}
			async UniTask<LoginGameResponse> LoginFunc()
			{
				return await Call<LoginGameResponse>(loginGameRequest);
			}
			async UniTask<KiifLoginHallResponse> LoginFunc2()
			{
				return await Call<KiifLoginHallResponse>(kiifLoginHallRequest);
			}
		}
		catch (Exception)
		{
			DisposeMainChannel();
			return false;
		}
		return true;
	}

	private async UniTask<T> QueuingLogin<T>(Func<UniTask<T>> loginFunc) where T : IResponse
	{
		T val = await loginFunc();
		if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(val, "请求登录"))
		{
			return val;
		}
		int error = val.Error;
		if (error.Equals(201019))
		{
			await UniTask.Delay(5000);
			val = await loginFunc();
		}
		else if (error.Equals(201017))
		{
			AsyncResult<int> result = new AsyncResult<int>();
			AlertDialogViewModel alertDialogViewModel = new AlertDialogViewModel();
			alertDialogViewModel.Message = "排队登录中，请稍候...";
			alertDialogViewModel.Title = "提示";
			alertDialogViewModel.ConfirmButtonText = null;
			alertDialogViewModel.NeutralButtonText = "取消";
			alertDialogViewModel.CancelButtonText = null;
			alertDialogViewModel.CanceledOnTouchOutside = false;
			alertDialogViewModel.CanceledOnTop = false;
			alertDialogViewModel.Click = delegate(int which)
			{
				result.SetResult(which);
			};
			await AlertDialog.ShowMessage(AlertDialog.ViewName, alertDialogViewModel, "POPUP");
			do
			{
				await UniTask.Delay(5000);
				val = await loginFunc();
			}
			while (val != null && val.Error.Equals(201017) && !result.IsDone);
			AlertDialog.ClearActiveDialogs();
		}
		return val;
	}

	private void OnConnected()
	{
		networkConnectState = NetworkConnectState.Connected;
		requestTimeoutCount = 0;
	}

	public async void DisposeMainChannel()
	{
		networkConnectState = NetworkConnectState.Disconnected;
		if (eventSubscription != null)
		{
			eventSubscription.Dispose();
			eventSubscription = null;
		}
		if (messageSubscription != null)
		{
			messageSubscription.Dispose();
			messageSubscription = null;
		}
		if (mainChannel != null)
		{
			GameEntry.Network.DestroyNetworkChannel("MAIN_CHANNEL");
			mainChannel = null;
		}
	}

	public ISubscription<T> Subscribe<T>(Action<T> action) where T : INotification
	{
		return m_NetMessenger.Subscribe(action);
	}

	public async UniTask<T> Call<T>(IActorLocationRequest request) where T : IActorLocationResponse
	{
		if (request == null)
		{
			throw new GameFrameworkException("请求不能为空.");
		}
		request.LoginSecretKey = SecretKey;
		request.LoginServerId = ServerId;
		try
		{
			return await Call<T>(request, false);
		}
		catch (TimeoutException exception)
		{
			OnSendTimeout(request, exception);
			throw;
		}
	}

	public async UniTask<T> Call<T>(IRequest request, bool showRequestLoading = false) where T : IResponse
	{
		if (!Connected())
		{
			throw new GameFrameworkException("没有网络连接.");
		}
		try
		{
			return await mainChannel.Send<T>(request, 15000);
		}
		catch (TimeoutException exception)
		{
			OnSendTimeout(request, exception);
			throw;
		}
	}

	public void Call(IActorNotification notification)
	{
		if (!Connected())
		{
			throw new GameFrameworkException("没有网络连接.");
		}
		notification.LoginSecretKey = SecretKey;
		notification.LoginServerId = ServerId;
		try
		{
			mainChannel.Send(notification);
		}
		catch (TimeoutException exception)
		{
			OnSendTimeout(notification, exception);
			throw;
		}
	}

	public void Call(IActorMessage message)
	{
		if (!Connected())
		{
			throw new GameFrameworkException("没有网络连接.");
		}
		try
		{
			mainChannel.Send(message);
		}
		catch (TimeoutException exception)
		{
			OnSendTimeout(message, exception);
			throw;
		}
	}

	public void Call(INotification notification)
	{
		if (!Connected())
		{
			throw new GameFrameworkException("没有网络连接.");
		}
		try
		{
			mainChannel.Send(notification);
		}
		catch (TimeoutException exception)
		{
			OnSendTimeout(notification, exception);
			throw;
		}
	}

	private void OnSendTimeout(IMessage message, TimeoutException exception)
	{
		if (!(message is ReloginRequest) && !(message is C2S_HeartBeat))
		{
			Log.Error("网络请求超时. MessageType: " + message.GetType().Name);
			requestTimeoutCount++;
			if (requestTimeoutCount >= 3)
			{
				requestTimeoutCount = 0;
				StartReconnect();
			}
		}
	}

	public async Task<bool> Reconnect()
	{
		try
		{
			if (mainChannel != null)
			{
				await mainChannel.Reconnect();
			}
		}
		catch (Exception ex)
		{
			Log.Error("重新连接服务器失败: " + ex.Message);
			DisposeMainChannel();
		}
		if (mainChannel == null || !mainChannel.Connected)
		{
			int count = 3;
			while (count > 0)
			{
				try
				{
					count--;
					if (await ConnectToServer())
					{
						break;
					}
					await UniTask.Delay(3000);
					continue;
				}
				catch (Exception ex2)
				{
					Log.Error("重新连接服务器失败: " + ex2.Message);
					await UniTask.Delay(3000);
					continue;
				}
			}
		}
		if (mainChannel != null && mainChannel.Connected)
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Relogin())
			{
				return true;
			}
			DisposeMainChannel();
		}
		return false;
	}

	public bool Connected()
	{
		if (mainChannel == null)
		{
			return false;
		}
		return mainChannel.Connected;
	}

	public override void Dispose()
	{
		DisposeMainChannel();
		m_NetMessenger = null;
		if (heartbeatThread != null)
		{
			heartbeatThread.Dispose();
			heartbeatThread = null;
		}
	}

	public IMessenger GetMessager()
	{
		return m_NetMessenger;
	}

	public async UniTask ShowDisconnect(int disconnectType = 0)
	{
		DisposeMainChannel();
		string message;
		switch (disconnectType)
		{
		case 1:
			message = "与服务器断开连接，请重新登录！";
			break;
		case 2:
			message = "账号在其他位置登录，请检查账号安全!";
			break;
		case 3:
			message = "根据国家防沉迷政策，未成年人仅可在周五、周六、周日和法定节假日的 20:00-21:00 游戏。今日为工作日，且不属于法定节假日，当前时间已超过限制，账号将被强制下线。请遵守规定，合理规划学习与娱乐时间。";
			break;
		case 4:
			message = "您的账号因违反《游戏用户协议》相关规定，已被临时封停。";
			break;
		case 5:
			message = "服务器维护中，请稍后再试。";
			break;
		case 6:
			message = "加载发生异常，请退出后重试！";
			break;
		case 7:
			message = "网络连接中断，请稍后重新登录。";
			break;
		default:
			return;
		}
		AlertDialog.ClearActiveDialogs();
		await AlertDialog.ShowInGroup("提示", message, null, null, "确定", "LOADING");
	}

	public IAsyncResult<int> ShowDisconnect(string tipsContent, bool isDoubleButton)
	{
		AlertDialog.ClearActiveDialogs();
		if (isDoubleButton)
		{
			return AlertDialog.ShowInGroup("提示", tipsContent, "确定", "取消", null, "Tip");
		}
		return AlertDialog.ShowInGroup("提示", tipsContent, null, null, "确定", "Tip");
	}

	public void OnConnectEventReceived(EventArgs e)
	{
		try
		{
			if (!(e is ConnectionEventArgs e2))
			{
				return;
			}
			if (e2.Name.Equals(Constant.NetworkEventConfig.Exception) | e2.Name.Equals(Constant.NetworkEventConfig.Closed))
			{
				if (heartbeatThread != null)
				{
					heartbeatThread.Stop();
				}
			}
			else if (e2.Name.Equals(Constant.NetworkEventConfig.Connected))
			{
				if (heartbeatThread == null)
				{
					heartbeatThread = new NetworkHeartbeatThread(45000, SendHeartBeat);
				}
				missHeartBeatCount = 0;
				reconnectDelay = 0f;
				heartbeatThread.Start();
			}
		}
		catch (Exception)
		{
			Log.Error("{0}", e);
		}
	}

	public async void SendHeartBeat()
	{
		try
		{
			if (mainChannel != null)
			{
				await Call<S2C_HeartBeat>(hearbeat);
				missHeartBeatCount = 0;
			}
		}
		catch (TimeoutException)
		{
			Log.Error("心跳超时.");
			OnSendHeartBeatTimeout();
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
			OnSendHeartBeatTimeout();
		}
	}

	private async void OnSendHeartBeatTimeout()
	{
		missHeartBeatCount++;
		if (missHeartBeatCount >= 2)
		{
			StartReconnect();
		}
	}

	private async UniTask StartReconnect()
	{
		if (networkConnectState == NetworkConnectState.Connecting)
		{
			return;
		}
		if (!Singleton<ServiceSystem>.Instance.GetService<IAccountService>().IsLogin || Singleton<ServiceSystem>.Instance.GetService<IAccountService>().WaittingForLoginOut)
		{
			DisposeMainChannel();
			return;
		}
		networkConnectState = NetworkConnectState.Connecting;
		m_NetMessenger.Publish(new NetworkReconnectMessager(this, networkConnectState));
		try
		{
			if (await Singleton<NetworkSystem>.Instance.Reconnect())
			{
				Toast.ShowInfo("重连成功！");
				OnConnected();
			}
			else
			{
				networkConnectState = NetworkConnectState.Disconnected;
			}
			m_NetMessenger.Publish(new NetworkReconnectMessager(this, networkConnectState));
		}
		catch (Exception ex)
		{
			Log.Error("重新连接服务器失败！" + ex.Message);
			networkConnectState = NetworkConnectState.Disconnected;
			m_NetMessenger.Publish(new NetworkReconnectMessager(this, networkConnectState));
		}
	}

	private async UniTask TryReconnect()
	{
		reconnectDelay += Time.deltaTime;
		if (!(reconnectDelay < 1.5f))
		{
			StartReconnect();
		}
	}

	public void Update()
	{
		if (networkConnectState == NetworkConnectState.Connected && (mainChannel == null || !mainChannel.Connected || Application.internetReachability == NetworkReachability.NotReachable))
		{
			TryReconnect();
		}
	}
}
