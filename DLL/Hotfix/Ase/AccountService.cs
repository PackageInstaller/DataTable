#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public sealed class AccountService : IAccountService
{
	private ISubscription<S2C_UserDisconnectNotify> S2C_UserDisconnectNotify;

	private IMessenger m_Messenger;

	private IAccountService.LoginParam loginParam;

	private ISubscription<NetworkReconnectMessager> reconnectSubscription;

	private Loading m_loading;

	private bool showLoading;

	private long _loginSeconds;

	private Timer _loginSecondTimer;

	private bool accountDataRequested;

	public string Account { get; set; }

	public long ReloginKey { get; set; }

	public bool IsLogin { get; set; }

	public bool WaittingForLoginOut { get; set; }

	public int DisconnectReason { get; set; }

	public AccountService()
	{
		m_Messenger = Context.GetApplicationContext().GetService<IMessenger>();
		reconnectSubscription = Singleton<NetworkSystem>.Instance.GetMessager().Subscribe<NetworkReconnectMessager>(OnNetworkConnectionEvent);
	}

	public IMessenger GetMessager()
	{
		return m_Messenger;
	}

	public async UniTask<bool> LoginBySDK()
	{
		SDKLoginResult loginResult = await Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Login();
		if (loginResult.State != "Success")
		{
			return false;
		}
		loginParam = new IAccountService.LoginParam
		{
			IsSDKLogin = true,
			Account = loginResult.Uid,
			UserName = loginResult.Username,
			Token = loginResult.Token,
			ChannelID = loginResult.ChannelID,
			DeviceId = GameEntry.BuiltinData.DeviceId
		};
		IsLogin = await Singleton<NetworkSystem>.Instance.ConnectToServer(loginParam);
		if (IsLogin)
		{
			OnLoginSuccess(loginResult.Uid);
		}
		return IsLogin;
	}

	private void OnLoginSuccess(string account)
	{
		Account = account;
		StartTimer();
		SubscribeNetworkNotify();
	}

	public async UniTask<bool> Relogin()
	{
		ReloginRequest request = ReloginRequest.Create();
		request.Key = Singleton<NetworkSystem>.Instance.SecretKey;
		request.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().Uid;
		ReloginResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ReloginResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "账号重连登录", showToast: false) && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "账号重连登录", showToast: false))
			{
				IsLogin = true;
				bool num = await RequestAccountData();
				if (num)
				{
					m_Messenger.Publish(new UserInfoMessage(this, UserInfoMessage.MsgTypeEnum.AccountDataRefreshByReLogin));
				}
				return num;
			}
		}
		catch (TimeoutException)
		{
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("重连登录失败！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask Logout()
	{
		if (!IsLogin)
		{
			return;
		}
		LoginOutRequest loginOutRequest = LoginOutRequest.Create();
		try
		{
			WaittingForLoginOut = true;
			await Singleton<NetworkSystem>.Instance.Call<LoginOutResponse>(loginOutRequest);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			OnAccountDisconnect(0);
		}
		catch (Exception ex2)
		{
			Log.Error("发送账号登出通知，出现异常：" + ex2.ToString());
			OnAccountDisconnect(0);
		}
		finally
		{
			WaittingForLoginOut = false;
			loginOutRequest.Dispose();
		}
	}

	public async UniTask<IAccountService.ChangeRoleResult> CreateUser(string name, int gender = 1)
	{
		C2H_CreateUser c2HCreateUser = C2H_CreateUser.Create();
		c2HCreateUser.Account = Account;
		c2HCreateUser.Name = name;
		c2HCreateUser.Gender = gender;
		c2HCreateUser.distinctId = TDAHandler.Instance.GetDistinctId();
		H2C_CreateUser response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_CreateUser>(c2HCreateUser);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "创建角色"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "创建角色失败"))
				{
					Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().CreateUser(response.UserId, response.UserBaseInfo, response.ServerOpenTime);
					TDAHandler.Instance.Login($"{response.UserId}");
					ExtraGameData extraGameData = new ExtraGameData();
					extraGameData.dataType = 2;
					extraGameData.roleID = response.UserBaseInfo.UserId.ToString();
					extraGameData.roleName = name;
					extraGameData.serverID = 0;
					extraGameData.serverName = "";
					extraGameData.vipLevel = response.UserBaseInfo.Vip;
					extraGameData.roleLevel = response.UserBaseInfo.Level.ToString();
					extraGameData.gangName = "";
					extraGameData.createRoleTime = response.ServerTime.ToString();
					extraGameData.monyNum_1 = response.UserBaseInfo.Voucher;
					extraGameData.monyNum_2 = response.UserBaseInfo.Diamond;
					extraGameData.accumulateNum = 0;
					Singleton<ServiceSystem>.Instance.GetService<ISDKService>().ReportPlayerData(extraGameData);
				}
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().DeleteSaveData();
				return new IAccountService.ChangeRoleResult(response.Error, response.Message);
			}
		}
		catch (TimeoutException)
		{
			return new IAccountService.ChangeRoleResult(-1, "网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("创建角色发生异常，" + ex2.Message + " / " + ex2.StackTrace);
			return new IAccountService.ChangeRoleResult(-1, "创建角色发生异常");
		}
		finally
		{
			c2HCreateUser.Dispose();
			response?.Dispose();
		}
		return new IAccountService.ChangeRoleResult(999, "创建角色，请求服务器失败！");
	}

	public async UniTask<IAccountService.ChangeRoleResult> ChangeName(string newName)
	{
		C2H_ChangeUserNameRequest rst = C2H_ChangeUserNameRequest.Create();
		rst.NewName = newName;
		H2C_ChangeUserNameResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ChangeUserNameResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改昵称"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改昵称失败"))
				{
					Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.ChangeName(newName);
					await PropHelper.AnalyzeRewardFromServer(response.Rewards);
				}
				return new IAccountService.ChangeRoleResult(response.Error, response.Message);
			}
		}
		catch (TimeoutException)
		{
			return new IAccountService.ChangeRoleResult(-1, "网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return new IAccountService.ChangeRoleResult(999, "修改昵称，请求服务器失败！");
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return new IAccountService.ChangeRoleResult(999, "修改昵称，请求服务器失败！");
	}

	public async UniTask<bool> RequestAccountData(Action<int> onProcessUpdate = null)
	{
		_ = 25;
		try
		{
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RequestServerRefreshHour()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().RequestAllNoticeData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ISOService>().RequestData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RequestUsedEquipmentData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			UniTask<bool> task = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RequestUnusedEquipmentData();
			int progress = 0;
			while (task.Status == UniTaskStatus.Pending)
			{
				if (progress < 300)
				{
					progress += 10;
					onProcessUpdate?.Invoke(10);
				}
				await UniTask.WaitForSeconds(0.5f);
			}
			if (!task.GetAwaiter().GetResult())
			{
				return false;
			}
			onProcessUpdate?.Invoke(300 - progress);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetPassportInfoRequest()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().RequestServiceData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().RequestKnapsackData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ITeamService>().InitTeamData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().RequestData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().RequestTaskData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestAllData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestDatas()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().RequestData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IRankService>().RequestDatas()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestInitData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().RequestOpActDatas()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestTowerData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<GuidanceManager>.Instance.RequestGuidanceData()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetSubChannel()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().RequestServerRedPoints()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(30);
			Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().InitRedPointDatas();
			onProcessUpdate?.Invoke(10);
			Singleton<ServiceSystem>.Instance.GetService<IBannerService>().RequestBannerDataAfterLogin();
			onProcessUpdate?.Invoke(10);
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
				.SetState(1);
			onProcessUpdate?.Invoke(10);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().RequestUseDatas()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().GetAllActivityAchievementDataRst()))
			{
				return false;
			}
			onProcessUpdate?.Invoke(10);
			await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestCampaignMainInfo();
			onProcessUpdate?.Invoke(10);
			accountDataRequested = true;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message);
			return false;
		}
		try
		{
			AudioHelper.SetGlobalGenderParameter();
		}
		catch (Exception ex2)
		{
			Log.Error(ex2.Message);
			return true;
		}
		return true;
	}

	private async UniTask DoRequestTask(UniTask<bool> requesttTask, Action OnProcessUpdate)
	{
		if (!(await requesttTask))
		{
			throw new GameFrameworkException("加载用户数据失败");
		}
		OnProcessUpdate?.Invoke();
	}

	protected async UniTask DoRequestTaskWithCancelToken(UniTask<bool> requesttTask, Action OnProcessUpdate, CancellationToken cancellationToken)
	{
		if (!(await requesttTask.AttachExternalCancellation(cancellationToken)))
		{
			cancellationToken.ThrowIfCancellationRequested();
			throw new GameFrameworkException("加载用户数据失败");
		}
		OnProcessUpdate?.Invoke();
	}

	private async UniTask<bool> WrapTaskWithLogging(UniTask<bool> task, string serviceName, Action onProcessUpdate, CancellationTokenSource token)
	{
		try
		{
			if (!(await task.AttachExternalCancellation(token.Token)))
			{
				if (task.Status == UniTaskStatus.Succeeded)
				{
					Log.Error("加载用户数据失败: " + serviceName);
				}
				token.Cancel(throwOnFirstException: true);
			}
			onProcessUpdate?.Invoke();
			return true;
		}
		catch (OperationCanceledException)
		{
			return false;
		}
		catch (Exception ex2)
		{
			throw new GameFrameworkException("加载用户数据失败: " + serviceName + " 出现异常: " + ex2.Message + "\n" + ex2.StackTrace);
		}
	}

	private bool StartTimer()
	{
		ClearTimer();
		try
		{
			_loginSecondTimer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception ex)
		{
			Log.Error("RoleService 登录计时 ：开启计时器失败:" + ex?.ToString() + ex.StackTrace);
			return false;
		}
		return true;
	}

	private void OnComplete()
	{
		_loginSeconds++;
		if (_loginSeconds % 60 == 0L)
		{
			m_Messenger.Publish(new UserInfoMessage(this, UserInfoMessage.MsgTypeEnum.SingleLoginMinutesChanged, _loginSeconds));
		}
	}

	private void ClearTimer()
	{
		_loginSeconds = 0L;
		if (_loginSecondTimer != null)
		{
			_loginSecondTimer.Cancel();
			_loginSecondTimer = null;
		}
	}

	public long GetLoginSeconds()
	{
		return _loginSeconds;
	}

	public void SubscribeNetworkNotify()
	{
		S2C_UserDisconnectNotify = Singleton<NetworkSystem>.Instance.Subscribe<S2C_UserDisconnectNotify>(ReturnStartUp);
	}

	public void UnSubscribeNetworkNotify()
	{
		S2C_UserDisconnectNotify?.Dispose();
		S2C_UserDisconnectNotify = null;
	}

	public async void OnAccountDisconnect(int reason)
	{
		if (IsLogin)
		{
			DisconnectReason = reason;
			IsLogin = false;
			loginParam = null;
			accountDataRequested = false;
			ClearTimer();
			UnSubscribeNetworkNotify();
			await Singleton<NetworkSystem>.Instance.ShowDisconnect(reason);
			m_Messenger.Publish(new AccounetNotifyMessager(this, IsLogin, DisconnectReason));
		}
	}

	public IAsyncResult<int> OnAccountDisconnect(string tipsContent, bool isDoubleButton)
	{
		return Singleton<NetworkSystem>.Instance.ShowDisconnect(tipsContent, isDoubleButton);
	}

	private void ReturnStartUp(S2C_UserDisconnectNotify notify)
	{
		if (notify.Reason == 1)
		{
			OnAccountDisconnect(0);
		}
		else if (notify.Reason == 2 || notify.Reason == 4)
		{
			OnAccountDisconnect(2);
		}
		else if (notify.Reason == 3)
		{
			OnAccountDisconnect(7);
		}
		else if (notify.Reason == 6)
		{
			OnAccountDisconnect(3);
		}
		else if (notify.Reason == 7)
		{
			OnAccountDisconnect(4);
		}
		else if (notify.Reason == 8)
		{
			OnAccountDisconnect(5);
		}
	}

	private async void OnNetworkConnectionEvent(NetworkReconnectMessager msg)
	{
		if (msg == null)
		{
			return;
		}
		if (msg.IsReconnecting)
		{
			if (!showLoading)
			{
				showLoading = true;
				m_loading = await Loading.ShowWithMessage("网络重连中...");
				await UniTask.WaitUntil(() => !showLoading);
				m_loading?.Dispose();
				m_loading = null;
			}
		}
		else
		{
			showLoading = false;
			if (msg.IsFailed)
			{
				OnAccountDisconnect(1);
			}
		}
	}

	public void Dispose()
	{
		showLoading = false;
		DisconnectReason = 0;
		IsLogin = false;
		WaittingForLoginOut = false;
		accountDataRequested = false;
		loginParam = null;
		UnSubscribeNetworkNotify();
		ClearTimer();
	}
}
