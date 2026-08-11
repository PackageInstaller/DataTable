#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using GameFramework.WebRequest;
using UnityEngine;

namespace Ase;

public class StartupViewModel : OptionBase
{
	private SimpleCommand loginCommand;

	private SimpleCommand enterGameCommand;

	private SimpleCommand openAnnouncementCmd;

	private SimpleCommand repairCmd;

	private SimpleCommand openProtoWebCmd;

	private bool isLogin;

	private string versionInfo;

	private ISubscription<AccounetNotifyMessager> accounetDisconnectSubscription;

	private PlayerNameSetViewModel playerNameSetViewModel;

	private CGViewModel cgviewModel;

	private bool enterGameShowMask;

	private bool showPreServerBtn;

	public ICommand LoginCommand => loginCommand;

	public SimpleCommand OpenAnnouncementCmd => openAnnouncementCmd;

	public SimpleCommand RepairCmd => repairCmd;

	public SimpleCommand OpenProtoWebCmd => openProtoWebCmd;

	public SimpleCommand EnterGameCommand => enterGameCommand;

	public bool IsLogin
	{
		get
		{
			return isLogin;
		}
		set
		{
			Set(ref isLogin, value, "IsLogin");
		}
	}

	public bool EnterGameShowMask
	{
		get
		{
			return enterGameShowMask;
		}
		set
		{
			Set(ref enterGameShowMask, value, "EnterGameShowMask");
		}
	}

	public string VersionInfo
	{
		get
		{
			return versionInfo;
		}
		set
		{
			Set(ref versionInfo, value, "VersionInfo");
		}
	}

	public bool ShowPreServerBtn
	{
		get
		{
			return showPreServerBtn;
		}
		set
		{
			Set(ref showPreServerBtn, value, "ShowPreServerBtn");
		}
	}

	public StartupViewModel()
	{
		openAnnouncementCmd = new SimpleCommand(OpenAnnouncementWindow);
		loginCommand = new SimpleCommand(LoginBySDK);
		repairCmd = new SimpleCommand(Repair);
		openProtoWebCmd = new SimpleCommand(OpenProtoWeb);
		enterGameCommand = new SimpleCommand(EnterGame);
		VersionInfo = GameEntry.Setting.GetString("版本信息");
	}

	private async void OnAccounetNotify(AccounetNotifyMessager msg)
	{
		if (!msg.IsLogin)
		{
			if (msg.DisconnectReason == 0)
			{
				Toast.ShowInfo("已退出登录");
			}
			IsLogin = false;
			loginCommand.Enabled = true;
			if (playerNameSetViewModel != null)
			{
				playerNameSetViewModel.SetError();
			}
			if (cgviewModel != null)
			{
				cgviewModel.Result = 999;
				cgviewModel.IsEnd = true;
			}
		}
	}

	public void StartUp()
	{
		if (!Singleton<ServiceSystem>.Instance.Initialized)
		{
			Singleton<ServiceSystem>.Instance.RegisterGlobalService();
		}
		Singleton<ServiceSystem>.Instance.RegisterSystemService();
		accounetDisconnectSubscription = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AccounetNotifyMessager>(OnAccounetNotify);
	}

	public void ShowLogin()
	{
		if (TimeHelper.ClientNowSeconds() != 0L && TimeHelper.ClientNowSeconds() <= GameEntry.BuiltinData.LoginOpenTime)
		{
			AlertDialog.Show("提示", GameEntry.BuiltinData.LoginOpenTip, null, null, "确定");
		}
		else
		{
			LoginBySDK();
		}
	}

	private async void LoginBySDK()
	{
		Loading loading = null;
		try
		{
			if (loginCommand.Enabled)
			{
				loginCommand.Enabled = false;
				loading = await Loading.ShowWithMessage("登录中...");
				await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().LoginBySDK();
				await UniTask.Delay(1000);
				loading?.Dispose();
				LoginFinish();
			}
		}
		catch (Exception)
		{
			loading?.Dispose();
		}
	}

	private void Login()
	{
	}

	private async void LoginFinish()
	{
		IAccountService service = Singleton<ServiceSystem>.Instance.GetService<IAccountService>();
		IsLogin = service.IsLogin;
		if (!IsLogin)
		{
			LoginFail();
		}
	}

	private async void PreServerSet()
	{
		string webRequestUri = "https://" + GameEntry.BuiltinData.PlatformUrl + "/game_api/preview_check";
		string channel = GameEntry.BuiltinData.Channel;
		WWWForm val = new WWWForm();
		val.AddField("channel", channel);
		try
		{
			WebRequestResponse webRequestResponse = await GameEntry.WebRequest.AddWebRequest(webRequestUri, val);
			if (webRequestResponse == null)
			{
				return;
			}
			(PreServerReqData, string) responseData = webRequestResponse.GetResponseData<PreServerReqData>();
			PreServerReqData preServerReqData;
			if (responseData.Item1 != null)
			{
				(preServerReqData, _) = responseData;
			}
			else
			{
				preServerReqData = new PreServerReqData();
			}
			PreServerReqData preServerReqData2 = preServerReqData;
			if (GameEntry.BuiltinData.PreServiceStatus)
			{
				if (!preServerReqData2.isOpen)
				{
					GameEntry.BuiltinData.SetPreServiceStatus(value: false);
				}
				else
				{
					if (preServerReqData2.isPreview)
					{
						return;
					}
					IAsyncResult<int> dialogResult = AlertDialog.Show("提示", "当前未在测试时间内，请留意测试时间，将切换至正式服", "", "", "确定", canceledOnTouchOutside: false, canceledOnTop: false);
					dialogResult.Callbackable().OnCallback(delegate
					{
						if (dialogResult.Result == -3)
						{
							GameEntry.BuiltinData.SetPreServiceStatus(value: false);
						}
					});
				}
			}
			else if (preServerReqData2.isOpen && preServerReqData2.isPreview)
			{
				ShowPreServerBtn = true;
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private async void EnterGame()
	{
		_ = 2;
		try
		{
			enterGameCommand.Enabled = false;
			IRoleService roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (roleService.NeedCreateRole)
			{
				bool flag = !(await ShowCGView());
				if (!flag)
				{
					flag = !(await ShowCreateRoleView());
				}
				if (flag)
				{
					throw new GameFrameworkException("创建角色失败");
				}
			}
			await ShowSelectImageQuality();
			foreach (GameSettingConfigHelper.SettingData value in GameSettingConfigHelper.Settings.Values)
			{
				value.LoadRemoteSetting(roleService.Uid);
			}
			Context.GetApplicationContext().GetService<IMessenger>().Publish(new AccounetLoginNotifyMessager(this, 0));
			Singleton<AudioSystem>.Instance?.InitLanguage();
			Singleton<ServiceSystem>.Instance.GetService<ISOService>().RequestData();
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			RoleViewModel roleData = roleService.GetRoleData();
			ExtraGameData extraGameData = new ExtraGameData();
			extraGameData.dataType = 1;
			extraGameData.roleID = roleData.Uid.ToString();
			extraGameData.roleName = roleData.PlayerInfo.Name;
			extraGameData.serverID = 1;
			extraGameData.serverName = Singleton<NetworkSystem>.Instance.ServerName;
			extraGameData.vipLevel = roleData.PlayerInfo.Vip;
			extraGameData.roleLevel = roleData.PlayerInfo.Level.ToString();
			extraGameData.gangName = myGuildData?.Name;
			extraGameData.createRoleTime = 0.ToString();
			extraGameData.monyNum_1 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher);
			extraGameData.monyNum_2 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
			extraGameData.accumulateNum = 0;
			Singleton<ServiceSystem>.Instance.GetService<ISDKService>().ReportPlayerData(extraGameData);
			if (!roleService.GuideLevelComplete)
			{
				Go2GuideLevel();
			}
			else if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
			{
				Go2FirstLevel();
			}
			else
			{
				Go2MainWindow();
			}
		}
		catch (Exception ex)
		{
			Log.Error("EnterGame发生异常: " + ex.Message + "\n" + ex.StackTrace);
			EnterGameFail();
		}
	}

	private async UniTask<bool> ShowCGView()
	{
		cgviewModel = new CGViewModel();
		await (await GameEntry.UI.LoadWindow<CGWindow>("CG/CGWindow", cgviewModel)).Show();
		EnterGameShowMask = true;
		cgviewModel.PlayCG();
		await new WaitUntil(() => cgviewModel.IsEnd);
		cgviewModel.Close();
		bool num = cgviewModel.Result == 0;
		cgviewModel = null;
		if (num)
		{
			C2G_LogEventRequest notification = new C2G_LogEventRequest
			{
				Type = 2,
				Account = Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Account,
				UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid
			};
			Singleton<NetworkSystem>.Instance.Call(notification);
		}
		return num;
	}

	private async UniTask<bool> ShowCreateRoleView()
	{
		bool flag = false;
		playerNameSetViewModel = new PlayerNameSetViewModel(null, NameSetMode.Create);
		await GameEntry.UI.OpenWindow<PlayerNameSetWindow>("User/PlayerNameSetWindow", "POPUP", playerNameSetViewModel, delegate
		{
			flag = true;
		});
		await UniTask.WaitUntil(() => flag);
		int result = playerNameSetViewModel.Result;
		playerNameSetViewModel = null;
		return result == 0;
	}

	private async UniTask<bool> ShowSelectImageQuality()
	{
		if (PlayerPrefs.GetInt("SelectImageQuality", 0) == 1)
		{
			return true;
		}
		if (Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GuideLevelComplete)
		{
			return true;
		}
		bool flag = false;
		ImageQualityViewModel userData = new ImageQualityViewModel();
		await GameEntry.UI.OpenWindow<ImageQualitySelectWindow>("User/ImageQualitySelectWindow", "POPUP", userData, delegate
		{
			flag = true;
		});
		await UniTask.WaitUntil(() => flag);
		return true;
	}

	private void Repair()
	{
		IAsyncResult<int> result = AlertDialog.Show("系统提示", "是否修复游戏", "确定", "取消");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				GameEntry.Resource.RepairResources();
			}
		});
	}

	private void OpenProtoWeb()
	{
		string text = GameEntry.Web.OpenWebViewWithUid("https://kiifstudio.com/service.html", ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
		if (!string.IsNullOrEmpty(text))
		{
			Toast.ShowInfo(text);
		}
	}

	private async void Go2MainWindow()
	{
		LoadingMainViewModel loadViewModel = new LoadingMainViewModel();
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Outer);
		loadViewModel.SetRandomLoadingTap(randomLoadingTap);
		await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadViewModel);
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		openWindowRequest.Raise(new OpenViewArg(typeof(UIDWindow), service.GetRoleData().UidVM, "StartUp", isOpenWindow: true, "Top"));
		await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
		bool loadingSuccess = loadViewModel.LoadingSuccess;
		if (loadViewModel.LoadingSuccess)
		{
			MainWindow mainWindow = await GameEntry.UI.LoadWindow<MainWindow>("Main/MainWindow", new MainViewModel());
			SendOpenMainEvent();
			Close();
			mainWindow.HideLeftAndRight();
			await mainWindow.Show();
			await loadViewModel.CloseLoading();
			mainWindow.PlayEnter();
		}
		else
		{
			await loadViewModel.CloseLoading();
			EnterGameFail();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
		if (loadingSuccess)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetBonfireActiveList(100);
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateBonfireMapMaskState(100, 10102, 0L);
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ChangeMapMaskData(100, 2, 1);
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ChangeMapMaskData(100, 3, 1);
		}
	}

	private void SendOpenMainEvent()
	{
		ViewConfig? viewConfig = ViewConfigSetting.GetViewConfig((ViewConfig p) => p.ViewClass.Equals(typeof(MainWindow).FullName));
		if (viewConfig.HasValue)
		{
			TDAHandler.Instance.SendViewStart(viewConfig.Value.Id, viewConfig.Value.PageType, "StartUp");
		}
	}

	private async void Go2GuideLevel()
	{
		BlackScreen blackScreen = await BlackScreen.Show("POPUP");
		await UniTask.WaitForSeconds(1);
		LoadingGuideLevelViewModel loadViewModel = LoadingGuideLevelViewModel.CreateGuideFirstStep(Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.CharacterIndex);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Story);
		loadViewModel.SetRandomLoadingTap(randomLoadingTap);
		LoadingWindow obj = await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadViewModel);
		blackScreen.Dispose();
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		openWindowRequest.Raise(new OpenViewArg(typeof(UIDWindow), service.GetRoleData().UidVM, "StartUp", isOpenWindow: true, "Top"));
		obj.DoShow(ignoreAnimation: true);
		await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
		bool loadingSuccess = loadViewModel.LoadingSuccess;
		if (loadViewModel.LoadingSuccess)
		{
			Close();
			await loadViewModel.CloseLoading();
		}
		else
		{
			await loadViewModel.CloseLoading();
			EnterGameFail();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}

	private async void Go2FirstLevel()
	{
		BlackScreen blackScreen = await BlackScreen.Show("POPUP");
		await UniTask.WaitForSeconds(1);
		LoadingGuideLevelViewModel loadViewModel = LoadingGuideLevelViewModel.CreateGuideThirdStep();
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Story);
		loadViewModel.SetRandomLoadingTap(randomLoadingTap);
		LoadingWindow obj = await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadViewModel);
		blackScreen.Dispose();
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		openWindowRequest.Raise(new OpenViewArg(typeof(UIDWindow), service.GetRoleData().UidVM, "StartUp", isOpenWindow: true, "Top"));
		obj.DoShow(ignoreAnimation: true);
		await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
		bool loadingSuccess = loadViewModel.LoadingSuccess;
		if (loadViewModel.LoadingSuccess)
		{
			Close();
			await loadViewModel.CloseLoading();
		}
		else
		{
			await loadViewModel.CloseLoading();
			EnterGameFail();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}

	private void LoginFail()
	{
		loginCommand.Enabled = true;
	}

	private async UniTask EnterGameFail()
	{
		Log.Error("Loading发生异常！");
		EnterGameShowMask = false;
		Logout();
		Singleton<ServiceSystem>.Instance.UnregisterSystemService();
		Singleton<ServiceSystem>.Instance.RegisterSystemService();
		enterGameCommand.Enabled = true;
		await UniTask.Delay(1000);
		Toast.ShowInfo("加载游戏发生异常，请重新登录！");
	}

	public async void Logout()
	{
		Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData().UidVM.Close();
		IsLogin = false;
		Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Logout();
		loginCommand.Enabled = true;
	}

	public void TryOpenAnnouncementWindow()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().GetUnReadList().Count > 0)
		{
			OpenAnnouncementWindow();
		}
	}

	private void OpenAnnouncementWindow()
	{
		openAnnouncementCmd.Enabled = false;
		openWindowRequest.Raise(new OpenViewArg(typeof(AnnouncementWindow), new AnnouncementViewModel(this, 1, 0, userOpen: false)), delegate
		{
			openAnnouncementCmd.Enabled = true;
		});
	}

	private new void Close()
	{
		dismissRequest.Raise();
		if (accounetDisconnectSubscription != null)
		{
			accounetDisconnectSubscription.Dispose();
			accounetDisconnectSubscription = null;
		}
	}
}
