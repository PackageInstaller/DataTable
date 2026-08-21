#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MainViewModel : OptionBase
{
	private IMessenger _messenger;

	private InteractionRequest<OpenViewArgTemp> openWindowRequest2;

	private BoardHeroViewModel boardHeroViewModel;

	private MultiRoomViewModel _multiRoomViewModel;

	private ChatBarViewModel chatBarViewModel;

	private MailViewModel mailViewModel;

	private RoleViewModel roleViewModel;

	private CopyViewModel copyViewModel;

	private TeamInviteViewModel teamInviteViewModel;

	private OperatingActivityViewModel oaViewModel;

	private AnnouncementViewModel announcementViewModel;

	private CopySelectViewModel copySelectViewModel;

	private GameActivityViewModel gameActivityViewModel;

	private CopyEntryData copyRed0;

	private ActivityScrollViewModel activityScrollViewModel;

	private InteractionRequest boardBackgroundChanged = new InteractionRequest();

	private SimpleCommand<string> openWindowCmd;

	private SimpleCommand<string> optCmd;

	private string taskContinueText;

	private string boardBgAssetPath = "";

	private bool showInner = true;

	private Vector3 outerBgPos = Vector3.zero;

	private Vector3 outerBgScale = Vector3.one;

	private Action openMultiRoomAction;

	private Action<bool> achievementPointAction;

	private bool achievementRedPoint;

	private bool gameActivityRedPoint;

	private bool gameNoteRedPoint;

	private Action<bool> gameActivityRedPointAction;

	private bool passportOpenState;

	private ISubscription<ServerToClientMessage> subscription_ServerToClient;

	private ISubscription<ShopMessage> subscription_Shop;

	private ISubscription<OpActivityMessage> subscription_OpActivity;

	private bool showActivityBtn;

	private ActivityVersionTypeEnum showActivityVersionType;

	private BoardHeroChangeData boardHeroChangeViewModel;

	private string _campaignOpenText;

	private Timer _campaignOpenTimer;

	private long _campaignOpenTime;

	private bool firstPop_MonthlyCard;

	private TaskDataViewModel curMainTask;

	private TaskRedPointData taskRedData;

	private SimpleCommand openTaskCmd;

	private ISubscription<TaskChangeNotifyMessager> subscription_TaskNotify;

	private bool hasTask;

	private bool showBoardHeroPreviewBack;

	private bool _isBoardHeroPreviewing;

	private int _previewOriginBoardHeroId;

	private readonly int taskTimerConfig = 3600;

	private int taskTimer = -1;

	private bool hasTaskLock;

	private readonly int returnMultiTimerConfig = 10;

	private int timerTick = 1;

	private int returnMultiTimer = -1;

	private Action OnTimerUpdate;

	private List<int> openAchiCache;

	private Timer timer;

	private Loading loading;

	private bool canPopBanner = true;

	public string CampaignOpenText
	{
		get
		{
			return _campaignOpenText;
		}
		set
		{
			Set(ref _campaignOpenText, value, "CampaignOpenText");
		}
	}

	public bool FirstPopMonthlyCard => firstPop_MonthlyCard;

	public TaskRedPointData TaskRedData
	{
		get
		{
			return taskRedData;
		}
		private set
		{
			Set(ref taskRedData, value, "TaskRedData");
		}
	}

	public ICommand OpenTaskCmd => openTaskCmd;

	public bool ShowBoardHeroPreviewBack
	{
		get
		{
			return showBoardHeroPreviewBack;
		}
		set
		{
			Set(ref showBoardHeroPreviewBack, value, "ShowBoardHeroPreviewBack");
		}
	}

	public Vector3 OuterBgPos
	{
		get
		{
			return outerBgPos;
		}
		set
		{
			Set(ref outerBgPos, value, "OuterBgPos");
		}
	}

	public Vector3 OuterBgScale
	{
		get
		{
			return outerBgScale;
		}
		set
		{
			Set(ref outerBgScale, value, "OuterBgScale");
		}
	}

	public string TaskContinueText
	{
		get
		{
			return taskContinueText;
		}
		set
		{
			Set(ref taskContinueText, value, "TaskContinueText");
		}
	}

	public string BoardBgAssetPath
	{
		get
		{
			return boardBgAssetPath;
		}
		set
		{
			if (!boardBgAssetPath.Equals(value))
			{
				Set(ref boardBgAssetPath, value, "BoardBgAssetPath");
				boardBackgroundChanged.Raise();
			}
		}
	}

	public bool ShowInner
	{
		get
		{
			return showInner;
		}
		set
		{
			Set(ref showInner, value, "ShowInner");
		}
	}

	public bool AchievementRedPoint
	{
		get
		{
			return achievementRedPoint;
		}
		set
		{
			Set(ref achievementRedPoint, value, "AchievementRedPoint");
		}
	}

	public bool PassportOpenState
	{
		get
		{
			return passportOpenState;
		}
		set
		{
			Set(ref passportOpenState, value, "PassportOpenState");
		}
	}

	public bool GameActivityRedPoint
	{
		get
		{
			return gameActivityRedPoint;
		}
		set
		{
			Set(ref gameActivityRedPoint, value, "GameActivityRedPoint");
		}
	}

	public bool GameNoteRedPoint
	{
		get
		{
			return gameNoteRedPoint;
		}
		set
		{
			Set(ref gameNoteRedPoint, value, "GameNoteRedPoint");
		}
	}

	public BoardHeroViewModel BoardHeroViewModel => boardHeroViewModel;

	public ActivityScrollViewModel ActivityScrollViewModel => activityScrollViewModel;

	public InteractionRequest BoardBackgroundChanged => boardBackgroundChanged;

	public MailViewModel MailViewModel
	{
		get
		{
			return mailViewModel;
		}
		set
		{
			Set(ref mailViewModel, value, "MailViewModel");
		}
	}

	public IInteractionRequest OpenWindowRequest2 => openWindowRequest2;

	public SimpleCommand<string> OpenWindowCmd => openWindowCmd;

	public ICommand OptCmd => optCmd;

	public RoleViewModel RoleViewModel => roleViewModel;

	public ChatBarViewModel ChatBar => chatBarViewModel;

	public CopyEntryData CopyRed0
	{
		get
		{
			return copyRed0;
		}
		private set
		{
			Set(ref copyRed0, value, "CopyRed0");
		}
	}

	public CopyViewModel CopyViewModel
	{
		get
		{
			return copyViewModel;
		}
		set
		{
			Set(ref copyViewModel, value, "CopyViewModel");
		}
	}

	public bool ShowActivityBtn
	{
		get
		{
			return showActivityBtn;
		}
		set
		{
			Set(ref showActivityBtn, value, "ShowActivityBtn");
		}
	}

	public ActivityVersionTypeEnum ShowActivityVersionType
	{
		get
		{
			return showActivityVersionType;
		}
		set
		{
			Set(ref showActivityVersionType, value, "ShowActivityVersionType");
		}
	}

	public bool CanPopBanner => canPopBanner;

	public MainViewModel()
	{
		_messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_ServerToClient = Singleton<NetworkSystem>.Instance.Subscribe<ServerToClientMessage>(ServerToClient);
		subscription_Shop = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMessager().Subscribe<ShopMessage>(OnShopMsg);
		subscription_OpActivity = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetMessager().Subscribe<OpActivityMessage>(OnOpActivityNotify);
		roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		roleViewModel.SetParent(this);
		mailViewModel = Singleton<ServiceSystem>.Instance.GetService<IMailService>().GetMailViewModel();
		copyViewModel = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		openWindowRequest2 = new InteractionRequest<OpenViewArgTemp>();
		InitDrawCardUseGameNoteData();
		InitMailRedPointBeforeRequest();
		copyRed0 = copyViewModel.CopyEntryDatas[2];
		RefreshBoardBg();
		boardHeroViewModel = AddChild(new BoardHeroViewModel(this));
		chatBarViewModel = AddChild(new ChatBarViewModel(this));
		activityScrollViewModel = AddChild(new ActivityScrollViewModel(this));
		openWindowCmd = new SimpleCommand<string>(OpenWindow);
		openTaskCmd = new SimpleCommand(OpenTaskMainWindow);
		optCmd = new SimpleCommand<string>(OnOptClick);
		subscription_TaskNotify = _messenger.Subscribe<TaskChangeNotifyMessager>(GetTaskNotify);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: true);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().BindInviteMessage(BeInvited, bind: true);
		Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
			.OpenAutoAddEnergy();
		InitAchievementRedPoint();
		Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().LoadRedPoint();
		Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().RequestAchievementData();
		PassportOpenState = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().CheckPassportOpen();
		InitGameGuideRedPoint();
		CreateGameActivity();
		AddBpGetListener();
		RefreshOpActivityData();
		openMultiRoomAction = OpenMultiRoomWindow;
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().AddOpenMultiRoomAction(openMultiRoomAction);
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDailyNew();
		taskRedData = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRedPoint();
		taskRedData.InitRedPoint();
	}

	private async void InitDrawCardUseGameNoteData()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().RequestGameNoteData();
	}

	private void InitGameGuideRedPoint()
	{
		IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
		if (service != null)
		{
			GameNoteRedPoint = service.GetServerRed(new List<ServerRedType> { ServerRedType.Handbook });
		}
	}

	private void InitAchievementRedPoint()
	{
		achievementPointAction = CheckAchievementRedPoint;
		Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().AddAchievementRedPoint(achievementPointAction);
		IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
		if (service != null)
		{
			AchievementRedPoint = service.GetServerRed(new List<ServerRedType> { ServerRedType.Achievement });
		}
	}

	private void InitMailRedPointBeforeRequest()
	{
		if (mailViewModel == null)
		{
			return;
		}
		IMailService service = Singleton<ServiceSystem>.Instance.GetService<IMailService>();
		if (service != null && !service.IsMailDataRequested)
		{
			IRedPointService service2 = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
			if (service2 != null)
			{
				mailViewModel.HasNew = service2.GetServerRed(new List<ServerRedType> { ServerRedType.Mail });
			}
		}
	}

	private void ServerToClient(ServerToClientMessage message)
	{
		if (!string.IsNullOrEmpty(message.Message))
		{
			Toast.ShowInfo(message.Message);
		}
	}

	private void OnShopMsg(ShopMessage msg)
	{
		if (msg == null || msg.Type != ShopMessageEnum.ReceivedPayRewards)
		{
			return;
		}
		Toast.ShowInfo("充值成功");
		if (msg.Arg != null && msg.Arg is RewardThings rewardThings)
		{
			openWindowCmd.Enabled = false;
			PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
	}

	private void OnOpActivityNotify(OpActivityMessage msg)
	{
		if (msg.Type == OpActivityMessageEnum.ActivityOpen || msg.Type == OpActivityMessageEnum.ActivityClose || msg.Type == OpActivityMessageEnum.ActivityOn || msg.Type == OpActivityMessageEnum.ActivityOff)
		{
			RefreshOpActivityData();
		}
	}

	private void RefreshOpActivityData()
	{
		ShowActivityBtn = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityOpenState(out var _);
		OpActViewModel activityVm = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm();
		if (activityVm.GetActivityViewModel(10) != null)
		{
			ShowActivityVersionType = ActivityVersionTypeEnum.Version1;
		}
		else if (activityVm.GetActivityViewModel(19) != null)
		{
			ShowActivityVersionType = ActivityVersionTypeEnum.Version2;
		}
		else
		{
			ShowActivityVersionType = ActivityVersionTypeEnum.None;
		}
	}

	private async void CreateGameActivity()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendGetGameActivityInfoRequest();
		gameActivityViewModel = Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().GetGameActivityViewModel();
		gameActivityViewModel.SetParent(this);
		GameActivityRedPoint = gameActivityViewModel.RedPoint;
		gameActivityRedPointAction = CheckGameActivityRedPoint;
		gameActivityViewModel.AddAction(gameActivityRedPointAction);
	}

	private void CheckGameActivityRedPoint(bool redPoint)
	{
		GameActivityRedPoint = redPoint;
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is string text)
		{
			if (text.Equals("Logout"))
			{
				Logout();
			}
			else if (text.Equals("DrawCardWindow"))
			{
				OpenDrawCardWindow();
			}
			else if (text.Equals("TaskMainWindow"))
			{
				OpenTaskMainWindow();
			}
			else if (text.Equals("LevelMapWindow"))
			{
				OpenCopy();
			}
			else if (text.Equals("HomeLandPlantWindow"))
			{
				OpenHomeLand(1);
			}
			else if (text.Equals("BattlePropMakeWindow"))
			{
				OpenHomeLand(4);
			}
			else if (text.Equals("HomeShopWindow"))
			{
				OpenHomeLand(3);
			}
			else if (!text.Equals("CopySecondType3Window") && !text.Equals("CopySecondType4Window") && !text.Equals("CopySecondType5Window"))
			{
			}
		}
		else if (obj is ChatViewModel chatViewModel)
		{
			chatViewModel.OnOpen();
			openWindowRequest.Raise(new OpenViewArg(typeof(ChatWindow), chatViewModel), delegate
			{
				chatBarViewModel.ActiveChatCommand();
			});
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is CopyData copyData)
			{
				if ("OnMulti".Equals(optionArg.OptionName))
				{
					OnMulti(copyData);
				}
			}
			else if (optionArg.Obj is TeamInviteViewModel teamInviteViewModel)
			{
				if ("Cancel".Equals(optionArg.OptionName))
				{
					InviteOpe(2, teamInviteViewModel.FriendId, teamInviteViewModel.RoomId, teamInviteViewModel.Model);
				}
				if ("Confirm".Equals(optionArg.OptionName))
				{
					roleViewModel.SetFirstFlagUsed();
					if (oaViewModel != null)
					{
						oaViewModel.Close();
					}
					if (CopyEntryLimitHelper.TryBlockEntry(teamInviteViewModel.CopyData, isMulti: true))
					{
						return;
					}
					CloseBoardHeroEditForSceneSwitch();
					InviteOpe(1, teamInviteViewModel.FriendId, teamInviteViewModel.RoomId, teamInviteViewModel.Model, teamInviteViewModel.CopyData);
				}
				this.teamInviteViewModel?.CloseWaitTime();
				this.teamInviteViewModel?.Close();
			}
			else if (optionArg.Obj is MultiRoomViewModel && "Close".Equals(optionArg.OptionName))
			{
				if (copySelectViewModel != null)
				{
					copySelectViewModel.EnableEnterPlayEffect();
				}
			}
			else if (optionArg.Obj is OperatingActivityViewModel)
			{
				EnablePopBanner(isEnable: true);
			}
			else if (optionArg.OptionName == "BoardHeroPreviewEnter" && optionArg.Obj is BoardHeroChangeData changeVm)
			{
				EnterBoardHeroPreview(changeVm);
			}
		}
		else if (obj is MultiRoomData multiRoomData)
		{
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveRoomId(multiRoomData.RoomId);
			if (_multiRoomViewModel != null)
			{
				_multiRoomViewModel.Close();
			}
			if (!CopyEntryLimitHelper.TryBlockEntry(multiRoomData.CopyData, isMulti: true))
			{
				_multiRoomViewModel = AddChild(new MultiRoomViewModel(this, multiRoomData.CopyData, multiRoomData.Gamers));
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.SetRoom(_multiRoomViewModel);
				openWindowRequest.Raise(new OpenViewArg(typeof(MultiRoomWindow), _multiRoomViewModel));
			}
		}
		else if (obj is MultiRoomViewModel)
		{
			if (this.teamInviteViewModel != null)
			{
				this.teamInviteViewModel.Close();
			}
		}
		else if (obj is DRBanner drBanner)
		{
			OpenBannerJumpWindow(drBanner);
		}
		else if (obj is GameGuideViewModel gameGuideViewModel)
		{
			GameNoteRedPoint = false;
			foreach (TabItemNormalData tagData in gameGuideViewModel.TagDataList)
			{
				if (tagData.RedPoint)
				{
					GameNoteRedPoint = true;
				}
			}
			if (!GameNoteRedPoint)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.SetServerRed(ServerRedType.Handbook, red: false);
			}
		}
		else if (obj is AchievementViewModel achievementViewModel)
		{
			bool flag = false;
			foreach (AchievementItemData achievementItemData in achievementViewModel.AchievementItemDataList)
			{
				if (achievementItemData.ShowRedPoint)
				{
					flag = true;
				}
			}
			if (!flag)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SetServerRed(ServerRedType.Achievement, red: false);
			}
		}
		else if (obj is HomelandMainViewModel)
		{
			IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
			bool valueOrDefault = service?.GetHomeShopViewModel()?.GetHomeShopRefreshRed() == true;
			bool valueOrDefault2 = service?.GetHomeShopViewModel()?.GetFriendHomeShopRefreshRed() == true;
			bool valueOrDefault3 = service?.GetHomeShopViewModel()?.CheckFriendHomeShopOpened() == true;
			bool valueOrDefault4 = service?.GetVm()?.CheckCanUpgradeLevel() == true;
			bool valueOrDefault5 = service?.GetVm()?.CheckCanHarvestByType(2) == true;
			bool valueOrDefault6 = service?.GetVm()?.CheckCanHarvestByType(1) == true;
			if (!((valueOrDefault3 & valueOrDefault2) | valueOrDefault | valueOrDefault4 | valueOrDefault5 | valueOrDefault6))
			{
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SetServerRed(ServerRedType.Homeland, red: false);
			}
		}
		else if (obj is ViewBackArg viewBackArg && viewBackArg.Obj is GameScoreViewModel)
		{
			Singleton<ServiceSystem>.Instance.GetService<IBannerService>()?.SetBannerNull();
		}
	}

	private async void OpenWindow(string arg)
	{
		openWindowCmd.Enabled = false;
		if (arg.Equals("OpenOpActivity"))
		{
			OpenOpActivityWindow();
		}
		if (arg.Equals("OpenAnnouncement"))
		{
			OpenAnnouncementWindow(1);
		}
		else if (arg.Equals("OpenDrawCard"))
		{
			OpenDrawCardWindow();
		}
		else if (arg.Equals("OpenFriend"))
		{
			OpenFriendWindow();
		}
		else if (arg.Equals("OpenGameSetting"))
		{
			OpenGameSettingWindow();
		}
		else if (arg.Equals("OpenHeroWarehouse"))
		{
			OpenHeroWarehouseWindow();
		}
		else if (arg.Equals("OpenHomeland"))
		{
			OpenHomelandWindow();
		}
		else if (arg.Equals("OpenWorldMap"))
		{
			OpenWorldMapWindow();
		}
		else if (arg.Equals("OpenMail"))
		{
			OpenMailMainWindow();
		}
		else if (arg.Equals("OpenRank"))
		{
			OpenRankWindow();
		}
		else if (arg.Equals("OpenUserInfo"))
		{
			OpenUserInfoWindow();
		}
		else if (arg.Equals("OpenWarehouse"))
		{
			OpenWarehouseWindow();
		}
		else if (arg.Equals("OpenBoardChange"))
		{
			OpenBoardChangeView();
		}
		else if (arg.Equals("OpenBubbleFrameBattleEmote"))
		{
			OpenBFBEWindow();
		}
		else if (arg.Equals("OpenShop"))
		{
			OpenShopWindow();
		}
		else if (arg.Equals("OpenTaskContinue"))
		{
			TaskContinue();
		}
		else if (arg.Equals("OpenAchievement"))
		{
			OpenAchievement();
		}
		else if (arg.Equals("OpenGuild"))
		{
			OpenGuild();
		}
		else if (arg.Equals("OpenGameGuide"))
		{
			OpenGameGuide();
		}
		else if (arg.Equals("OpenTeachingManual"))
		{
			OpenTeachingManual();
		}
		else if (arg.Equals("OpenPassport"))
		{
			OpenPassport();
		}
		else if (arg.Equals("OpenGameActivity"))
		{
			OpenGameActivity();
		}
		else if (arg.Equals("OpenActivityVersion"))
		{
			OpenActivityVersion(10);
		}
		else if (arg.Equals("OpenActivityVersion2"))
		{
			OpenActivityVersion(19);
		}
		else if (arg.Equals("HomeCome"))
		{
			OpenHomeCome();
		}
		else if (arg.Equals("OpenHeroSkinTl"))
		{
			OpenHeroSkinTl();
		}
		else if (arg.Equals("OpenCampaign"))
		{
			OpenCampaign();
		}
	}

	private async void OpenHomeCome()
	{
		openWindowCmd.Enabled = false;
		try
		{
			IHomeComeService homeComeService = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
			if (homeComeService == null)
			{
				openWindowCmd.Enabled = true;
				return;
			}
			if (!(await homeComeService.GetHomeComeInfoRst()))
			{
				openWindowCmd.Enabled = true;
				return;
			}
			HomeComeData data = homeComeService.GetData();
			if (data == null || !data.IsInReturn)
			{
				Toast.ShowInfo("当前不在回归活动期间");
				openWindowCmd.Enabled = true;
				return;
			}
			HomeComeWindowViewModel userData = new HomeComeWindowViewModel(this, requestOnInitialize: false);
			openWindowRequest.Raise(new OpenViewArg(typeof(HomeComeWindow), userData), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private async void OpenHeroSkinTl()
	{
		openWindowCmd.Enabled = false;
		HeroSkinTlViewModel vm = new HeroSkinTlViewModel(this);
		await vm.RequestSaveData();
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinTlWindow), vm), delegate
		{
			openWindowCmd.Enabled = true;
		});
	}

	private async void OpenCampaign()
	{
		_ = 1;
		try
		{
			if (!(Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetCampaignOpenState() ?? false))
			{
				openWindowCmd.Enabled = true;
				Toast.ShowInfo("尊敬的传火者大人，活动已结束，期待下次再见");
				return;
			}
			openWindowCmd.Enabled = false;
			if (await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestCampaignMainInfo() == null)
			{
				openWindowCmd.Enabled = true;
				return;
			}
			CampaignMainViewModel vm = new CampaignMainViewModel(this);
			await vm.RequestData();
			openWindowRequest.Raise(new OpenViewArg(typeof(CampaignMainWindow), vm), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenBannerJumpWindow(DRBanner drBanner)
	{
		if (!openWindowCmd.Enabled)
		{
			return;
		}
		try
		{
			if (!string.IsNullOrEmpty(drBanner.JumpWeb))
			{
				string text = GameEntry.Web.OpenWebViewWithUid($"{drBanner.JumpWeb}?uid={Singleton<ServiceSystem>.Instance.GetService<IRoleService>().Uid}", ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: false, null, null);
				if (!string.IsNullOrEmpty(text))
				{
					Toast.ShowInfo(text);
				}
			}
			else
			{
				if (string.IsNullOrEmpty(drBanner.JumpWindow))
				{
					return;
				}
				List<object> list = new List<object>();
				if (drBanner.JumpConfig != null)
				{
					foreach (int item in drBanner.JumpConfig)
					{
						list.Add(item);
					}
				}
				JumpWindowParams pars = new JumpWindowParams(drBanner.JumpWindow, list);
				openWindowCmd.Enabled = false;
				OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(pars, parent, "PropInfo", delegate
				{
					openWindowCmd.Enabled = true;
				});
				if (openViewArg == null)
				{
					openWindowCmd.Enabled = true;
				}
				else
				{
					base.ItemOnClick((object)openViewArg);
				}
			}
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private async void OpenGameGuide()
	{
		Loading gameGuideLoading = await Loading.Show();
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().RequestGameNoteData())
			{
				GameGuideViewModel userData = new GameGuideViewModel(this);
				openWindowRequest.Raise(new OpenViewArg(typeof(GameGuideWindow), userData), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
			gameGuideLoading?.Dispose();
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			gameGuideLoading?.Dispose();
			Log.Error("打开图鉴失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async void OpenGameActivity()
	{
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendGetGameActivityInfoRequest())
			{
				gameActivityViewModel.RefreshData();
				openWindowRequest.Raise(new OpenViewArg(typeof(GameActivityWindow), gameActivityViewModel), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
			else
			{
				Toast.ShowInfo("活跃度打开失败,请稍后重试!");
				openWindowCmd.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			throw ex;
		}
	}

	private async void OpenPassport()
	{
		_ = 1;
		try
		{
			Loading openPassport = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetPassportInfoRequest();
			openPassport.Dispose();
			if (num)
			{
				PassportViewModel passportViewModel = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportViewModel();
				if (passportViewModel != null)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(PassportWindow), passportViewModel), delegate
					{
						openWindowCmd.Enabled = true;
					});
				}
				else
				{
					openWindowCmd.Enabled = true;
				}
			}
			else
			{
				Toast.ShowInfo("通行证界面打开失败,请稍后重试!");
				openWindowCmd.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			throw ex;
		}
	}

	private async void OpenBannerWindow(BannerInfo bannerInfo)
	{
		openWindowCmd.Enabled = false;
		try
		{
			BannerViewModel userData = new BannerViewModel(this);
			if (bannerInfo.Id == 98 || bannerInfo.Id == 99)
			{
				if (GameEntry.BuiltinData.OpenTestFlight)
				{
					return;
				}
				int id = 3;
				string exText = "";
				openWindowRequest.Raise(new OpenViewArg(typeof(GameScoreWindow), new GameScoreViewModel(this, id, exText)));
			}
			else
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(BannerWindow), userData), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
			BannerService.SendTDAEventPopup(bannerInfo.Id, bannerInfo.Source);
			openWindowCmd.Enabled = true;
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	public async UniTask OpenOpActivityWindow(int autoOpenActivityId, CopyData copyData)
	{
		try
		{
			oaViewModel = new OperatingActivityViewModel(this, autoOpenActivityId);
			openWindowRequest.Raise(new OpenViewArg(typeof(OperatingActivityWindow), oaViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
			if (copyData != null && autoOpenActivityId == copyData.ActivityTypeId)
			{
				await oaViewModel.ActivityViewModels.Find((ActivityViewModelBase p) => p.ActivityTypeId == autoOpenActivityId).SetLastPlayCopyData(copyData);
			}
			int versionType = autoOpenActivityId;
			if (copyData != null)
			{
				versionType = copyData?.ActivityTypeId ?? 10;
			}
			if (autoOpenActivityId != versionType)
			{
				return;
			}
			await UniTask.WaitUntil(() => oaViewModel != null && oaViewModel.IsWindowVisible);
			ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(autoOpenActivityId);
			if (activityViewModel == null)
			{
				return;
			}
			ActivityVersion1ViewModel vm = activityViewModel as ActivityVersion1ViewModel;
			if (vm != null)
			{
				vm.SetParent(oaViewModel);
				vm.SetPanel2(copyData);
				openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityVersion1Window), ActivityVersionConfig.GetConfigWindowPath(versionType), vm), delegate
				{
					vm.OnMainWindowClosed();
				});
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public async UniTask<bool> OpenOpActivityChallengeWindow(int activityTypeId, CopyData copyData, bool openBattleReady = false, bool fromBattleReturn = false)
	{
		try
		{
			oaViewModel = new OperatingActivityViewModel(this, activityTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(OperatingActivityWindow), oaViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
			await UniTask.WaitUntil(() => oaViewModel != null && oaViewModel.IsWindowVisible);
			ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(activityTypeId);
			if (activityViewModel != null && activityViewModel is ActivityChallengeViewModel activityChallengeViewModel)
			{
				activityChallengeViewModel.SetParent(oaViewModel);
				activityChallengeViewModel.SelectCopy(copyData);
				if (activityChallengeViewModel.SelectItemViewModel == null)
				{
					return false;
				}
				activityChallengeViewModel.SetOpenTag();
				activityChallengeViewModel.CreateTimeDura();
				bool flag = activityChallengeViewModel.IsTimeValid();
				if (flag | fromBattleReturn)
				{
					if ((openBattleReady & flag) && activityChallengeViewModel is ActivityChallengeViewModel2 activityChallengeViewModel2)
					{
						activityChallengeViewModel2.OpenSingleBattleReady();
					}
					OpenActivityChallengeWindow(activityChallengeViewModel);
					return flag;
				}
				activityChallengeViewModel.ResetOpenTag();
			}
			return false;
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
		return false;
	}

	private void OpenActivityChallengeWindow(ActivityChallengeViewModel vm)
	{
		ActivityChallengeWindowOpenArg challengeWindowArg = vm.CreateChallengeWindowOpenArg();
		if (string.IsNullOrEmpty(challengeWindowArg.WindowPath))
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(ActivityChallengeWindow), challengeWindowArg.ViewModel, challengeWindowArg.Callback));
			return;
		}
		openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityChallengeWindow), challengeWindowArg.WindowPath, challengeWindowArg.ViewModel), delegate
		{
			challengeWindowArg.Callback?.Invoke();
		});
	}

	public async UniTask<ActivityEquipViewModel> OpenOpActivityEquipWindow(int activityTypeId, CopyData copyData)
	{
		try
		{
			oaViewModel = new OperatingActivityViewModel(this, activityTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(OperatingActivityWindow), oaViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
			await UniTask.WaitUntil(() => oaViewModel != null && oaViewModel.IsWindowVisible);
			ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(activityTypeId);
			if (activityViewModel != null && activityViewModel is ActivityEquipViewModel activityEquipViewModel)
			{
				activityEquipViewModel.SetParent(oaViewModel);
				activityEquipViewModel.SelectCopy(copyData);
				if (activityEquipViewModel.SelectItemViewModel == null)
				{
					return null;
				}
				openWindowRequest.Raise(new OpenViewArg(typeof(ActivityEquipWindow), activityEquipViewModel));
				activityEquipViewModel.SetOpenTag();
				return activityEquipViewModel;
			}
			return null;
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
		return null;
	}

	public async void OpenOpActivityWindow()
	{
		openWindowCmd.Enabled = false;
		try
		{
			oaViewModel = new OperatingActivityViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(OperatingActivityWindow), oaViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenGuild()
	{
		MyGuildData myGuildData = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestMyGuildBaseInfo();
		try
		{
			if (myGuildData != null)
			{
				await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGuildActivityExpeditionData();
				GuildViewModel vm = new GuildViewModel(this);
				await vm.RequestData();
				openWindowRequest.Raise(new OpenViewArg(typeof(GuildWindow), vm), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
			else
			{
				GuildApplicationViewModel userData = new GuildApplicationViewModel(this);
				openWindowRequest.Raise(new OpenViewArg(typeof(GuildApplicationWindow), userData), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			openWindowCmd.Enabled = true;
		}
	}

	public async UniTask<bool> OpenGuild(int tabId, CopyData copyData, bool openRoom)
	{
		MyGuildData myGuildData = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestMyGuildBaseInfo();
		try
		{
			if (myGuildData != null)
			{
				await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGuildActivityExpeditionData();
				GuildViewModel vm = new GuildViewModel(this, tabId);
				await vm.RequestData();
				openWindowRequest.Raise(new OpenViewArg(typeof(GuildWindow), vm), delegate
				{
					openWindowCmd.Enabled = true;
				});
				bool result = vm.SetOpenActivityExpedition(copyData);
				if (result & openRoom)
				{
					await UniTask.WaitUntil(() => vm.initParam == null);
					BackToMultiRoom();
				}
				return result;
			}
			openWindowCmd.Enabled = true;
			Toast.ShowInfo("您已不在此公会！");
			return false;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			openWindowCmd.Enabled = true;
		}
		return false;
	}

	private async void OpenTeachingManual()
	{
		try
		{
			TeachingManualWindowViewModel vm = new TeachingManualWindowViewModel(this);
			if (await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().InitManualServerInfo())
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(TeachingManualWindow), vm), delegate
				{
					openWindowCmd.Enabled = true;
				});
			}
			else
			{
				Toast.ShowInfo("打开界面异常！");
				openWindowCmd.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenAnnouncementWindow(int type)
	{
		try
		{
			announcementViewModel = new AnnouncementViewModel(this, type);
			openWindowRequest.Raise(new OpenViewArg(typeof(AnnouncementWindow), announcementViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenDrawCardWindow()
	{
		_ = 3;
		try
		{
			Loading drawCardLoading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryPool();
			drawCardLoading?.Dispose();
			if (num)
			{
				List<DrawCardTabData> drawCardTabInfos = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetDrawCardTabInfos();
				List<DrawCardItemInfo> lotteryResultInfos = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryResultInfos();
				DrawCardViewModel drawCardViewModel = new DrawCardViewModel(this, RoleViewModel.GetMoneyData(), drawCardTabInfos, lotteryResultInfos);
				await drawCardViewModel.InitAllCardsInfo();
				drawCardViewModel.TabItemOnclick(drawCardViewModel.PoolTabsData[0]);
				openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardWindow), drawCardViewModel), delegate
				{
					openWindowCmd.Enabled = true;
				});
				await Task.Delay(1000);
				drawCardViewModel.OnShow();
			}
			else
			{
				openWindowCmd.Enabled = true;
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private void CheckAchievementRedPoint(bool redPoint)
	{
		AchievementRedPoint = redPoint;
	}

	private async void OpenFriendWindow()
	{
		try
		{
			FriendWindowViewModel vm = new FriendWindowViewModel(this);
			await vm.RequestAllFriendData();
			openWindowRequest.Raise(new OpenViewArg(typeof(FriendWindow), vm), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenGameSettingWindow()
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(GameSettingWindow), new GameSettingViewModel(this, "主界面")), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenHeroWarehouseWindow()
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroWarehouseWindow), new HeroWarehouseViewModel(this)), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private void OpenHomelandWindow()
	{
		try
		{
			openWindowCmd.Enabled = true;
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private void OpenWorldMapWindow(int worldId = 1)
	{
		try
		{
			WorldMapViewModel userData = new WorldMapViewModel(this, worldId);
			openWindowRequest.Raise(new OpenViewArg(typeof(WorldMapWindow), userData), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenWarehouseWindow()
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(WarehouseWindow), new WarehouseViewModel(this)), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenMailMainWindow()
	{
		_ = 1;
		try
		{
			IMailService mailService = Singleton<ServiceSystem>.Instance.GetService<IMailService>();
			if (mailService != null && !mailService.IsMailDataRequested)
			{
				Loading loading = await Loading.Show();
				bool num = await mailService.RequestMailData();
				loading.Dispose();
				if (!num)
				{
					openWindowCmd.Enabled = true;
					return;
				}
			}
			if (mailViewModel == null)
			{
				openWindowCmd.Enabled = true;
				return;
			}
			mailViewModel.SetParent(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(MailWindow), mailViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenRankWindow()
	{
		try
		{
			RankViewModel rankVm = new RankViewModel(this);
			await rankVm.RequestHeroChallengeData();
			openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), rankVm), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception)
		{
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenUserInfoWindow()
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(UserInfoWindow), new UserInfoViewModel()), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenBFBEWindow()
	{
		try
		{
			await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().RequestDatas();
			openWindowRequest.Raise(new OpenViewArg(typeof(BFBEWindow), new BFBEViewModel(this)), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenBoardChangeView()
	{
		_ = 1;
		try
		{
			openWindowCmd.Enabled = true;
			if (boardHeroChangeViewModel == null)
			{
				boardHeroChangeViewModel = new BoardHeroChangeData(this, boardHeroViewModel.GetSpineGameObject());
				AddChild(boardHeroChangeViewModel);
				await boardHeroChangeViewModel.RequestBgData();
			}
			else
			{
				await boardHeroChangeViewModel.RequestBgData();
				boardHeroChangeViewModel.Refresh(boardHeroViewModel.GetSpineGameObject());
			}
			boardHeroChangeViewModel.RemoveAllHideCallback();
			boardHeroChangeViewModel.AddHideCallback(delegate
			{
				RefreshBoardBg();
				if (boardHeroViewModel != null)
				{
					int valueOrDefault = (boardHeroChangeViewModel?.CurSelectSpineItemData?.DrHero?.Id).GetValueOrDefault();
					BoardHeroData boardHeroData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.BoardHeroData;
					if (boardHeroChangeViewModel != null && boardHeroData != null)
					{
						if (valueOrDefault == boardHeroData.BoardHeroId && boardHeroChangeViewModel.HeroSpine != null)
						{
							boardHeroViewModel.ReturnSpineGameObject(boardHeroChangeViewModel.HeroSpine);
						}
						else
						{
							boardHeroViewModel.Refresh();
						}
						RemoveChild(boardHeroChangeViewModel);
						boardHeroChangeViewModel.Close();
						boardHeroChangeViewModel = null;
					}
					openWindowCmd.Enabled = true;
				}
			});
			openWindowRequest.Raise(new OpenViewArg(typeof(BoardHeroChangeView), boardHeroChangeViewModel, "Main", isOpenWindow: false));
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenShopWindow()
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(ShopWindow), new ShopWindowViewModel(this)), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	public async Task OpenHeroCultivateWindow(HeroModel heroModel)
	{
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivateWindow), new HeroCultivateViewModel(this, heroModel)), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	private async Task OpenUserInfo()
	{
		PlayerInfoViewModel infoViewModel = new PlayerInfoViewModel(this, roleViewModel.PlayerInfo, isSelf: true);
		await infoViewModel.AddSelfShowHeros(roleViewModel.HeroIds);
		await infoViewModel.AddSelfShowAchi(roleViewModel.PlayerInfo.WearMedals);
		openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoWindow), infoViewModel), delegate
		{
			optCmd.Enabled = true;
		});
	}

	public async Task<CopySelectViewModel> OpenCopy()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateRealisticTime();
		copySelectViewModel = new CopySelectViewModel(this);
		openWindowRequest.Raise(new OpenViewArg(typeof(CopySelectWindow), copySelectViewModel), delegate
		{
			optCmd.Enabled = true;
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RemoveCopyTimer();
		});
		return copySelectViewModel;
	}

	public async Task OpenActivityVersion(int activityTypeId)
	{
		try
		{
			ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(activityTypeId);
			if (activityViewModel == null || activityViewModel.State != OpActivityState.On)
			{
				openWindowCmd.Enabled = true;
				return;
			}
			ActivityVersion1ViewModel vm = activityViewModel as ActivityVersion1ViewModel;
			if (vm != null)
			{
				vm.SetParent(this);
				vm.SetOpenTag();
				openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityVersion1Window), ActivityVersionConfig.GetConfigWindowPath(activityTypeId), vm), delegate
				{
					vm.OnMainWindowClosed();
					openWindowCmd.Enabled = true;
				});
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
		}
	}

	public async Task OpenHomeLand(int index = 0)
	{
		try
		{
			await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestAllData();
			HomelandMainViewModel userData = new HomelandMainViewModel(index);
			openWindowRequest.Raise(new OpenViewArg(typeof(HomelandMainWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			optCmd.Enabled = true;
		}
	}

	public async Task OpenBattleProp()
	{
		try
		{
			BattlePropMakeViewModel userData = new BattlePropMakeViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropMakeWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			optCmd.Enabled = true;
		}
	}

	public void AddBpGetListener()
	{
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().AddShowGetBPListener(delegate(BattlePropGetViewModel vm)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropGetWindow), vm));
		});
	}

	public void StartCampaignTimer()
	{
		DateTime dateTime = new DateTime(2026, 7, 1, 4, 0, 0);
		DateTime curServerDateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerDateTime();
		if (dateTime <= curServerDateTime)
		{
			CampaignOpenText = "";
			return;
		}
		_campaignOpenTime = (long)(dateTime - curServerDateTime).TotalSeconds;
		_campaignOpenTimer = Timer.Register(1f, OnCampaignTimerComplete, null, isLooped: true, useRealTime: true);
	}

	private void OnCampaignTimerComplete()
	{
		_campaignOpenTime--;
		if (_campaignOpenTime <= 0)
		{
			_campaignOpenTime = 0L;
			CancelCampaignTimer();
		}
		TimeSpan timeSpan = TimeSpan.FromSeconds(_campaignOpenTime);
		CampaignOpenText = $"{timeSpan:dd\\天hh\\时}后开启";
	}

	private void CancelCampaignTimer()
	{
		if (_campaignOpenTimer != null)
		{
			_campaignOpenTimer.Cancel();
			_campaignOpenTimer = null;
		}
	}

	private async void Logout()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Logout();
	}

	private async void OnOptClick(string opt)
	{
		optCmd.Enabled = false;
		try
		{
			if (opt.Equals("OpenUserInfo"))
			{
				await OpenUserInfo();
			}
			else if (opt.Equals("OpenCopy"))
			{
				OpenCopy();
			}
			else if (opt.Equals("OpenBattleProp"))
			{
				OpenBattleProp();
			}
			else if (opt.Equals("OpenHomeLand"))
			{
				OpenHomeLand();
			}
			else if (opt.Equals("BoardHeroPreviewBack"))
			{
				ExitBoardHeroPreview();
				optCmd.Enabled = true;
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
			optCmd.Enabled = true;
		}
	}

	private void BeInvited(MultiFightInviteFriendNotify message)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(message.FriendId))
		{
			CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(message.CopyId);
			if (copyData == null)
			{
				Log.Error($"找不到副本数据{message.CopyId}");
				copyData = CopyData.CreateTemp(GameEntry.DataTable.GetDataRow<DRCopy>(message.CopyId));
			}
			if (teamInviteViewModel != null)
			{
				teamInviteViewModel.Close();
			}
			teamInviteViewModel = new TeamInviteViewModel(this, message, copyData);
			openWindowRequest.Raise(new OpenViewArg(typeof(TeamInviteWindow), teamInviteViewModel, "Main", isOpenWindow: true, "DEFAULTTEMP"));
		}
	}

	private void InviteOpe(int ope, long inviteUserId, long roomId, int model, CopyData copyData = null)
	{
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().InviteOperate(ope, inviteUserId, roomId, model, copyData);
	}

	private async void OnMulti(CopyData copyData)
	{
		if (CopyEntryLimitHelper.TryBlockEntry(copyData, isMulti: true))
		{
			copySelectViewModel?.EnableOpenMulti();
			return;
		}
		Loading loading = await Loading.Show();
		ProtocolRequestResult num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateMultiRoom(copyData);
		loading.Dispose();
		if (num != ProtocolRequestResult.Success)
		{
			copySelectViewModel?.EnableOpenMulti();
		}
	}

	public void BackToMultiRoom()
	{
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().BackToMultiRoom();
	}

	private void OpenMultiRoomWindow()
	{
		if (_multiRoomViewModel != null)
		{
			_multiRoomViewModel.Close();
		}
		_multiRoomViewModel = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetMultiRoomViewModel();
		_multiRoomViewModel.SetParent(this);
		AddChild(_multiRoomViewModel);
		openWindowRequest.Raise(new OpenViewArg(typeof(MultiRoomWindow), _multiRoomViewModel), delegate
		{
			if (copySelectViewModel != null)
			{
				copySelectViewModel.EnableOpenMulti();
			}
		});
	}

	public bool CheckMonthlyCardOpen()
	{
		IShopService service = Singleton<ServiceSystem>.Instance.GetService<IShopService>();
		if (service.GetMonthlyCardLeftDay() >= 0)
		{
			return !service.GetMonthlyCardTodayGot();
		}
		return false;
	}

	public void FirstOpenMonthlyCard()
	{
		openWindowCmd.Enabled = false;
		try
		{
			firstPop_MonthlyCard = true;
			openWindowRequest.Raise(new OpenViewArg(typeof(MonthlyCardRewardWindow), new MonthlyCardRewardViewModel(this)), delegate
			{
				openWindowCmd.Enabled = true;
				firstPop_MonthlyCard = false;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openWindowCmd.Enabled = true;
			firstPop_MonthlyCard = false;
		}
	}

	public void CheckOpenBanner(int guideIdNeed)
	{
		if (!Singleton<GuidanceManager>.Instance.CheckGuidanceFinish(guideIdNeed) && !GuidanceManager.skip)
		{
			return;
		}
		BannerInfo bannerInfo = Singleton<ServiceSystem>.Instance.GetService<IBannerService>()?.GetBannerWaitShow() ?? null;
		if (bannerInfo != null)
		{
			if (bannerInfo.Special)
			{
				OpenBannerWindow(bannerInfo);
			}
			if (roleViewModel.EveryLoginMark)
			{
				roleViewModel.SetEveryLoginMarkUsed();
				OpenBannerWindow(bannerInfo);
			}
		}
	}

	public void InitTask()
	{
		GetTask();
	}

	private void GetTaskNotify(TaskChangeNotifyMessager obj)
	{
		GetTask();
	}

	private void GetTask()
	{
		curMainTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
		if (curMainTask == null)
		{
			TaskContinueText = "未完待续";
			return;
		}
		if (curMainTask.IsTimeLock)
		{
			hasTaskLock = HasTaskLock(curMainTask);
			if (hasTaskLock)
			{
				return;
			}
		}
		if (!curMainTask.IsOpenTask)
		{
			TaskContinueText = curMainTask.PreviousDesc;
			return;
		}
		DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(curMainTask.LevelMapId);
		TaskContinueText = ((dataRow == null) ? curMainTask.TaskName : (dataRow.Name + " " + curMainTask.TaskName));
	}

	private bool HasTaskLock(TaskDataViewModel curMainTask)
	{
		long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ServerOpenTime + curMainTask.TimeLockDays * 24 * 3600;
		long num2 = (long)(DateTime.Now - new DateTime(1970, 1, 1, 8, 0, 0)).TotalSeconds;
		if (num2 >= num)
		{
			return false;
		}
		if (num - num2 < 3600)
		{
			taskTimer = (int)(num - num2);
		}
		else
		{
			taskTimer = taskTimerConfig - (DateTime.Now.Second + DateTime.Now.Minute * 60);
		}
		float num3 = (float)(num - num2) / 3600f;
		if (num3 < 24f)
		{
			TaskContinueText = $"{Mathf.CeilToInt(num3)}小时后解锁";
		}
		else
		{
			float num4 = num3 / 24f;
			if ((float)curMainTask.TimeLockDays > num4)
			{
				TaskContinueText = $"{Mathf.Floor(num4)}天后解锁";
			}
		}
		return true;
	}

	private void OpenTaskMainWindow()
	{
		openTaskCmd.Enabled = false;
		try
		{
			List<TaskDataViewModel> allTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
			TaskMainViewModel taskMainViewModel = new TaskMainViewModel(this, taskRedData, allTask);
			OnTimerUpdate = (Action)Delegate.Combine(OnTimerUpdate, new Action(taskMainViewModel.OnTimerUpdate));
			openWindowRequest.Raise(new OpenViewArg(typeof(TaskMainWindow), taskMainViewModel), delegate
			{
				openTaskCmd.Enabled = true;
				OnTimerUpdate = (Action)Delegate.Remove(OnTimerUpdate, new Action(taskMainViewModel.OnTimerUpdate));
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openTaskCmd.Enabled = true;
		}
	}

	private void TaskContinue()
	{
		openWindowCmd.Enabled = true;
		TaskDataViewModel currentMainTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
		if (currentMainTask == null)
		{
			Toast.ShowInfo("未完待续");
			openWindowCmd.Enabled = true;
			return;
		}
		if (!currentMainTask.IsOpenTask || hasTaskLock)
		{
			Toast.ShowInfo(TaskContinueText);
			openWindowCmd.Enabled = true;
			return;
		}
		if (GameEntry.DataTable.GetDataRow<DRMap>(currentMainTask.LevelMapId) == null)
		{
			openWindowCmd.Enabled = true;
			return;
		}
		try
		{
			MapViewModel mapViewModel = new MapViewModel(this, MapMode.Outer, currentMainTask.LevelMapId);
			mapViewModel.TrackTaskId = currentMainTask.TaskId;
			openWindowRequest.Raise(new OpenViewArg(typeof(MapWindow), mapViewModel), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception)
		{
			openWindowCmd.Enabled = true;
		}
	}

	private async void OpenAchievement()
	{
		openWindowCmd.Enabled = false;
		try
		{
			await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().RequestAchievementData();
			AchievementViewModel userData = new AchievementViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(AchievementWindow), userData), delegate
			{
				openWindowCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			openWindowCmd.Enabled = true;
			throw ex;
		}
	}

	private void EnterBoardHeroPreview(BoardHeroChangeData changeVm)
	{
		if (!_isBoardHeroPreviewing && changeVm != null && boardHeroViewModel != null)
		{
			_isBoardHeroPreviewing = true;
			ShowBoardHeroPreviewBack = true;
			_previewOriginBoardHeroId = boardHeroViewModel.Id;
			int boardHeroId = changeVm?.CurSelectSpineItemData?.DrHero?.Id ?? _previewOriginBoardHeroId;
			boardHeroViewModel.SetPreviewTransformData(changeVm.PreviewTransformData);
			GameObject heroSpine = changeVm.HeroSpine;
			changeVm.HeroSpine = null;
			if (heroSpine != null)
			{
				boardHeroViewModel.PreviewSpine(boardHeroId, heroSpine);
			}
			else
			{
				boardHeroViewModel.Refresh();
			}
			changeVm.PreviewAlphaRst.Raise(context: false);
			_isBoardHeroPreviewing = true;
			ShowBoardHeroPreviewBack = true;
		}
	}

	private void ExitBoardHeroPreview()
	{
		if (_isBoardHeroPreviewing && boardHeroChangeViewModel != null && boardHeroViewModel != null)
		{
			_isBoardHeroPreviewing = false;
			ShowBoardHeroPreviewBack = false;
			GameObject spineGameObject = boardHeroViewModel.GetSpineGameObject();
			boardHeroViewModel.ClearPreviewTransformData();
			boardHeroChangeViewModel.HeroSpine = spineGameObject;
			boardHeroViewModel.SetTempBoardHeroId(_previewOriginBoardHeroId);
			boardHeroChangeViewModel.RebindSpineRst.Raise();
			boardHeroChangeViewModel.PreviewAlphaRst.Raise(context: true);
			_isBoardHeroPreviewing = false;
			ShowBoardHeroPreviewBack = false;
		}
	}

	private void CloseBoardHeroEditForSceneSwitch()
	{
		ShowBoardHeroPreviewBack = false;
		_isBoardHeroPreviewing = false;
		boardHeroViewModel?.ClearPreviewTransformData();
		boardHeroChangeViewModel?.ClearPreviewTransformData();
		if (boardHeroChangeViewModel != null)
		{
			boardHeroChangeViewModel.Hide();
		}
	}

	private void RefreshBoardBg()
	{
		if (roleViewModel == null)
		{
			return;
		}
		DRBoardBackGround background = roleViewModel.GetBackground();
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(roleViewModel.BoardHeroData.BoardHeroId);
		ShowInner = dataRow == null || dataRow.StateType == 0;
		if (background != null)
		{
			BoardBgAssetPath = background.AssetPath;
			if (dataRow != null)
			{
				float num = 0f;
				List<float> list = ((dataRow.StateType == 0) ? background.FgimagePosition : background.OriginalPosition);
				List<float> list2 = ((dataRow.StateType == 0) ? background.FgimageScale : background.OriginalScale);
				float x = ((list.Count > 0) ? list[0] : 0f);
				float y = ((list.Count > 1) ? list[1] : 0f);
				float z = ((list.Count > 2) ? list[2] : 0f);
				float x2 = ((list2.Count > 0) ? list2[0] : 1f);
				float y2 = ((list2.Count > 1) ? list2[1] : 1f);
				num = ((list2.Count > 2) ? list2[2] : 1f);
				OuterBgPos = new Vector3(x, y, z);
				OuterBgScale = new Vector3(x2, y2, num);
			}
		}
	}

	private void OnComplete()
	{
		if (returnMultiTimer >= 0)
		{
			if (returnMultiTimer == 0)
			{
				ReconnectResult(isSuccess: false);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ClearMultiReconnect();
			}
			returnMultiTimer--;
		}
		if (taskTimer >= 0)
		{
			if (taskTimer == 0)
			{
				hasTaskLock = HasTaskLock(curMainTask);
				if (!hasTaskLock)
				{
					UpdateTaskState();
					taskTimer = -1;
				}
			}
			taskTimer--;
		}
		OnTimerUpdate?.Invoke();
	}

	private async void UpdateTaskState()
	{
		bool isOpenTask = await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckTaskTimeLock(curMainTask.TaskId);
		curMainTask.IsOpenTask = isOpenTask;
		GetTask();
	}

	public void OnGoldfingerTaskTest()
	{
		if (timer == null)
		{
			timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		HasTaskLock(curMainTask);
	}

	public void InitTimer()
	{
		if ((returnMultiTimer > 0 || hasTaskLock) && timer == null)
		{
			timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
	}

	public async void OpenAchiWindow()
	{
		await Task.Delay(100);
		openAchiCache = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchiCacheList();
		OpenAchiWindow(0);
	}

	private void OpenAchiWindow(int index)
	{
		if (openAchiCache.Count <= index)
		{
			Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().ClearAchiCache();
			return;
		}
		DRAchievementMedal dataRow = GameEntry.DataTable.GetDataRow<DRAchievementMedal>(openAchiCache[index]);
		AchievementGetPropViewModel userData = new AchievementGetPropViewModel(dataRow.MedalIcon, dataRow.Name, dataRow.Rarity);
		openWindowRequest.Raise(new OpenViewArg(typeof(AchievementGetPropWindow), userData), delegate
		{
			OpenAchiWindow(index + 1);
		});
	}

	public override void Close()
	{
		if (announcementViewModel != null)
		{
			announcementViewModel.Close();
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.BindInviteMessage(BeInvited, bind: false);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.ClearMultiReconnect();
		Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData().GetMoneyData().CloseAutoAddEnergy();
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
		if (chatBarViewModel != null)
		{
			chatBarViewModel.Dispose();
			chatBarViewModel = null;
		}
		if (subscription_ServerToClient != null)
		{
			subscription_ServerToClient.Dispose();
			subscription_ServerToClient = null;
		}
		if (subscription_Shop != null)
		{
			subscription_Shop.Dispose();
			subscription_Shop = null;
		}
		if (subscription_OpActivity != null)
		{
			subscription_OpActivity.Dispose();
			subscription_OpActivity = null;
		}
		CancelCampaignTimer();
		base.Close();
	}

	public async void CheckReconnectMulti()
	{
		loading = await Loading.Show();
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: false);
		if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().AddMultiBackListener(LoadingMulti))
		{
			returnMultiTimer = returnMultiTimerConfig;
			return;
		}
		returnMultiTimer = -1;
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: true);
		loading.Dispose();
	}

	private void ReconnectResult(bool isSuccess)
	{
		if (!isSuccess)
		{
			Log.Error("等待通知 GetBattleFieldUserFightInfoResponse 10s 已超时，结束重连");
			Toast.ShowInfo("重连多人失败，请退出后重试！");
		}
		if (loading != null)
		{
			loading.Dispose();
		}
	}

	private async void LoadingMulti(LoadingMultiBattleViewModel loadingViewModel)
	{
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ClearMultiReconnect();
		if (loadingViewModel == null)
		{
			Log.Error("多人重连发生异常！");
			ReconnectResult(isSuccess: false);
			return;
		}
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
		loadingViewModel.SetRandomLoadingTap(randomLoadingTap);
		openWindowRequest.Raise(new OpenViewArg(typeof(LoadingMultiWindow), loadingViewModel, "Main", isOpenWindow: true, "LOADING"));
		ReconnectResult(isSuccess: true);
		await UniTask.WaitUntil(() => loadingViewModel.IsLoadingFinish);
		if (!loadingViewModel.LoadingSuccess)
		{
			if (loadingViewModel.LoadingException == LoadingExceptionEnum.BeforeUnloadOuter)
			{
				Log.Error("Loading异常 卸载外围场景 退回登录界面 关闭Loading");
				await loadingViewModel.CloseLoading();
				Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().ResetOuter();
				Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(6);
			}
			else if (loadingViewModel.LoadingException == LoadingExceptionEnum.Unknow)
			{
				Log.Error("未知战斗异常 关闭Loading");
				await loadingViewModel.CloseLoading();
			}
			else
			{
				Log.Error("无Loading异常 关闭Loading");
				await loadingViewModel.CloseLoading();
			}
		}
		else
		{
			await loadingViewModel.CloseLoading();
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingViewModel.LoadingSuccess);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyEnterInfoData());
		}
	}

	public void InitParam()
	{
		if (chatBarViewModel != null)
		{
			chatBarViewModel = AddChild(new ChatBarViewModel(this));
		}
	}

	public void EnablePopBanner(bool isEnable)
	{
		canPopBanner = isEnable;
	}
}
