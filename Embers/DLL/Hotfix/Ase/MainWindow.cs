#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MainWindow : UGuiWindowBase
{
	[SerializeField]
	private Animator windowAnimator;

	[SerializeField]
	private int announceGuide;

	[SerializeField]
	private RectTransform Outer;

	[SerializeField]
	private RectTransform OuterRoot;

	[SerializeField]
	private RectTransform Inner;

	[SerializeField]
	private RectTransform BoardHero;

	[SerializeField]
	private RectTransform UIMain;

	[SerializeField]
	private GravitySensingView gravitySensingView;

	[SerializeField]
	private MainRoleInfoView roleInfoView;

	[SerializeField]
	private ChatBarView chatBarView;

	[SerializeField]
	private ButtonState BtnWarehouse;

	[SerializeField]
	private Button BtnLevel;

	[SerializeField]
	private Button BtnContinueTask;

	[SerializeField]
	private TextMeshProUGUI ContinueTaskName;

	[SerializeField]
	private Button BtnCopyList;

	[SerializeField]
	private Button BtnEmail;

	[SerializeField]
	private Button BtnFriend;

	[SerializeField]
	private Button btnActivity;

	[SerializeField]
	private Button BtnRank;

	[SerializeField]
	private Button BtnSetting;

	[SerializeField]
	private Button BtnUserInfo;

	[SerializeField]
	private Button BtnHeroWareHouse;

	[SerializeField]
	private Button BtnDrawCard;

	[SerializeField]
	private Button BtnAnnouncement;

	[SerializeField]
	private Button BtnTask;

	[SerializeField]
	private Button BtnHomeLand;

	[SerializeField]
	private Button BtnShop;

	[SerializeField]
	private Button BtnGameGuide;

	[SerializeField]
	private Button BtnGuild;

	[SerializeField]
	private Button BtnTeachingManual;

	[SerializeField]
	private Button BtnPassport;

	[SerializeField]
	private Button BtnGameActivity;

	[SerializeField]
	private Button BtnActivityVersion;

	[SerializeField]
	private Button BtnActivityVersion2;

	[SerializeField]
	private GameObject taskNew;

	[SerializeField]
	private GameObject mailNew;

	[SerializeField]
	private GameObject oaNew;

	[SerializeField]
	private GameObject copyNew;

	[SerializeField]
	private GameObject achievementRedPoint;

	[SerializeField]
	private GameObject gameActivityRedPoint;

	[SerializeField]
	private GameObject gameNoteRedPoint;

	[SerializeField]
	private GameObject passportOpenObj;

	[SerializeField]
	private BoardHeroView boardHeroView;

	[SerializeField]
	private Button BtnChangeBoardHero;

	[SerializeField]
	private Button BtnBubbleFrameBattleEmote;

	[SerializeField]
	private Button BtnPreViewBack;

	[SerializeField]
	private ButtonLong BtnHideUI;

	[SerializeField]
	private Button BtnShowUI;

	[SerializeField]
	private ActivityScrollView activityScrollView;

	[SerializeField]
	private Button BtnOpenAchievement;

	[SerializeField]
	private Button BtnHeroSkinTl;

	[SerializeField]
	private Button BtnCampaign;

	[SerializeField]
	private TextMeshProUGUI campaignCountdown;

	[SerializeField]
	private float btnHidePressDuration;

	public string loadingSpineUiPath;

	private GameObject outerBg;

	private string outerBgAssetPath;

	[SerializeField]
	private TextMeshProUGUI userIdText;

	[SerializeField]
	private RectTransform moneyBarRoot;

	private MoneyView moneyView;

	private MainViewModel viewModel;

	private bool isChecking;

	private bool monthlyCardNotifyBinded;

	public List<CanvasGroup> cgList;

	private float _spinePlayPressTime;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<MainViewModel>();
		BindingSet<MainWindow, MainViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((MainWindow v) => ((UGuiWindow)v).OnDismissRequest).To((MainViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((MainWindow v) => v.OpenUguiWindow).To((MainViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((MainWindow v) => v.OnVisibleChanged).To((MainViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((MainWindow v) => v.OpenUguiWindow2).To((MainViewModel vm) => vm.OpenWindowRequest2);
		bindingSet.Bind(btnActivity).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenOpActivity");
		bindingSet.Bind(btnActivity.gameObject).For((GameObject v) => v.activeSelf).To((MainViewModel vm) => vm.ShowActivityBtn);
		if (BtnActivityVersion != null)
		{
			bindingSet.Bind(BtnActivityVersion.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => (int)vm.ShowActivityVersionType == 10);
		}
		if (BtnActivityVersion2 != null)
		{
			bindingSet.Bind(BtnActivityVersion2.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => (int)vm.ShowActivityVersionType == 19);
		}
		bindingSet.Bind(BtnAnnouncement).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenAnnouncement");
		bindingSet.Bind(BtnDrawCard).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenDrawCard");
		bindingSet.Bind(BtnFriend).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenFriend");
		bindingSet.Bind(BtnSetting).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenGameSetting");
		bindingSet.Bind(BtnHeroWareHouse).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenHeroWarehouse");
		bindingSet.Bind(BtnLevel).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenWorldMap");
		bindingSet.Bind(BtnEmail).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenMail");
		bindingSet.Bind(BtnRank).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenRank");
		bindingSet.Bind(BtnUserInfo).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenUserInfo");
		bindingSet.Bind(BtnWarehouse).For((ButtonState v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenWarehouse");
		bindingSet.Bind(BtnChangeBoardHero).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenBoardChange");
		bindingSet.Bind(BtnBubbleFrameBattleEmote).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenBubbleFrameBattleEmote");
		bindingSet.Bind(BtnShop).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenShop");
		bindingSet.Bind(BtnGameGuide).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenGameGuide");
		bindingSet.Bind(BtnPassport).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenPassport");
		bindingSet.Bind(BtnGameActivity).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenGameActivity");
		bindingSet.Bind(BtnContinueTask).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenTaskContinue");
		bindingSet.Bind(BtnCopyList).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenCopy");
		if (BtnActivityVersion != null)
		{
			bindingSet.Bind(BtnActivityVersion).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
				.CommandParameter("OpenActivityVersion");
		}
		if (BtnActivityVersion2 != null)
		{
			bindingSet.Bind(BtnActivityVersion2).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
				.CommandParameter("OpenActivityVersion2");
		}
		bindingSet.Bind(BtnHomeLand).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenHomeLand");
		bindingSet.Bind(BtnOpenAchievement).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenAchievement");
		bindingSet.Bind(BtnGuild).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenGuild");
		bindingSet.Bind(BtnHeroSkinTl).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenHeroSkinTl");
		bindingSet.Bind(BtnCampaign).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenCampaign");
		if ((UnityEngine.Object)(object)campaignCountdown != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(campaignCountdown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MainViewModel vm) => vm.CampaignOpenText);
			viewModel.StartCampaignTimer();
		}
		bindingSet.Bind(BtnTeachingManual).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("OpenTeachingManual");
		bindingSet.Bind(OuterRoot).For((RectTransform v) => v.anchoredPosition3D).To((MainViewModel vm) => vm.OuterBgPos);
		bindingSet.Bind(OuterRoot).For((RectTransform v) => v.localScale).To((MainViewModel vm) => vm.OuterBgScale);
		bindingSet.Bind<TextMeshProUGUI>(ContinueTaskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MainViewModel vm) => vm.TaskContinueText);
		bindingSet.Bind(mailNew).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.MailViewModel.HasNew);
		bindingSet.Bind(copyNew).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.CopyRed0.Red);
		bindingSet.Bind(achievementRedPoint).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.AchievementRedPoint);
		bindingSet.Bind(gameActivityRedPoint).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.GameActivityRedPoint);
		bindingSet.Bind(gameNoteRedPoint).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.GameNoteRedPoint);
		bindingSet.Bind(passportOpenObj).For((GameObject v) => v.activeSelf).ToExpression((MainViewModel vm) => vm.PassportOpenState);
		bindingSet.Bind(BtnTask).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OpenTaskCmd);
		bindingSet.Bind(taskNew).For((GameObject v) => v.activeSelf).To((MainViewModel vm) => vm.TaskRedData.HasNew);
		bindingSet.Bind().For((MainWindow v) => v.RefreshBoardBackground).To((MainViewModel vm) => vm.BoardBackgroundChanged);
		bindingSet.Bind(Inner.gameObject).For((GameObject v) => v.activeSelf).To((MainViewModel vm) => vm.ShowInner);
		bindingSet.Bind(BtnPreViewBack.gameObject).For((GameObject v) => v.activeSelf).To((MainViewModel vm) => vm.ShowBoardHeroPreviewBack);
		bindingSet.Bind(BtnPreViewBack).For((Button v) => v.onClick).To((MainViewModel vm) => vm.OptCmd)
			.CommandParameter("BoardHeroPreviewBack");
		bindingSet.Build();
		viewModel.InitParam();
		if (chatBarView != null && viewModel.ChatBar != null)
		{
			chatBarView.Init(viewModel.ChatBar);
		}
		boardHeroView.Init(viewModel.BoardHeroViewModel);
		roleInfoView.Init(viewModel.RoleViewModel.PlayerInfo);
		activityScrollView.Init(viewModel.ActivityScrollViewModel);
		((TMP_Text)userIdText).text = $"UID：{viewModel.RoleViewModel.PlayerInfo.Uid}";
		RefreshBoardBackground();
		InitRedPoints();
		BtnShowUI.onClick.AddListener(PlayShowUIAni);
		BtnHideUI.onClick.AddListener(PlayHideUIAni);
		BtnHideUI.onPress.AddListener(SpinePlayPress);
		BtnHideUI.onPointUp.AddListener(SpinePlayEndPress);
		AddMonthlyCardNotify();
	}

	public override bool CloseInversion()
	{
		if (viewModel != null && !viewModel.IsCloseView)
		{
			viewModel.Close();
			return true;
		}
		return base.CloseInversion();
	}

	private void PlayHideUIAni()
	{
		Animator obj = windowAnimator;
		if (obj != null)
		{
			obj.SetTrigger("hideUI");
		}
	}

	private void PlayShowUIAni()
	{
		Animator obj = windowAnimator;
		if (obj != null)
		{
			obj.SetTrigger("showUI");
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		AttachMoneyView();
		boardHeroView.Visibility = true;
		viewModel.InitTask();
		viewModel.OpenAchiWindow();
		viewModel.CheckReconnectMulti();
		viewModel.InitTimer();
	}

	private async UniTask CheckFirstPopUp()
	{
		if (!isChecking)
		{
			isChecking = true;
			await UniTask.WaitUntil(() => Visibility);
			await FirstOpenPopup();
			isChecking = false;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			CheckFirstPopUp();
		}
	}

	public override bool SetViewAlpha(int a)
	{
		bool num = base.SetViewAlpha(a);
		if (num)
		{
			gravitySensingView.UpdateEnable = a != 0;
			boardHeroView.isOnShow = a != 0;
			if (a == 0)
			{
				boardHeroView.ResetToIdle();
			}
			if (a != 0)
			{
				CheckFirstPopUp();
			}
		}
		return num;
	}

	private async Task FirstOpenPopup()
	{
		if (!viewModel.CanPopBanner)
		{
			return;
		}
		await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().CheckRefetch();
		List<object> cachedVm = UIWindowHelper.GetCachedVm();
		if (cachedVm.Count == 1 && cachedVm[0] is MainViewModel)
		{
			if (viewModel.CheckMonthlyCardOpen())
			{
				viewModel.FirstOpenMonthlyCard();
			}
			await UniTask.WaitUntil(delegate
			{
				MainViewModel mainViewModel = viewModel;
				return mainViewModel == null || !mainViewModel.FirstPopMonthlyCard;
			});
			if (viewModel != null)
			{
				viewModel.CheckOpenBanner(announceGuide);
				Singleton<ServiceSystem>.Instance.GetService<IGameNewsTipService>()?.OpenNewsTipWindow();
			}
		}
	}

	private void AddMonthlyCardNotify()
	{
		if (!monthlyCardNotifyBinded)
		{
			monthlyCardNotifyBinded = true;
			Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.BindMonthlyCardNotify(OnMonthlyCardNotify);
		}
	}

	private void RemoveMonthlyCardNotify()
	{
		if (monthlyCardNotifyBinded)
		{
			monthlyCardNotifyBinded = false;
			Singleton<ServiceSystem>.Instance?.GetService<IShopService>()?.RemoveMonthlyCardNotify(OnMonthlyCardNotify);
		}
	}

	private void OnMonthlyCardNotify(MonthlyCardPopUpNotify notify)
	{
		if (viewModel != null)
		{
			List<object> cachedVm = UIWindowHelper.GetCachedVm();
			if (cachedVm.Count == 1 && cachedVm[0] is MainViewModel && viewModel.CheckMonthlyCardOpen())
			{
				viewModel.FirstOpenMonthlyCard();
			}
		}
	}

	private void InitRedPoints()
	{
		btnActivity.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetRed() == true)
			.Invoke();
		if (BtnActivityVersion != null)
		{
			BtnActivityVersion.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(10)?.Red == true)
				.Invoke();
		}
		if (BtnActivityVersion2 != null)
		{
			BtnActivityVersion2.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(19)?.Red == true)
				.Invoke();
		}
		BtnHeroWareHouse.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroDestinyEnabled).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).HeroSeats.Count > 0)
			.Invoke();
		BtnFriend.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.FriendChatUnread).AddEnum(RedPointMessageEnum.FriendApplicationUnReply)
			.SetFuncOnMessage(delegate
			{
				RedPointService redPointService = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
				return redPointService.FriendApplyUnReply || redPointService.FriendsUnreadChat.Count > 0;
			})
			.Invoke();
		BtnAnnouncement.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.AnnouncementUnRead).SetFuncOnMessage((RedPointMessage message) => message?.State ?? (Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().GetUnReadList().Count > 0))
			.Invoke();
		BtnShop.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ShopRed).SetFuncOnMessage((RedPointMessage msg) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GetShopRedByShopPosition(ShopGoodItemData.ShopPosition.Shop))
			.Invoke();
		BtnHomeLand.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HomelandShopRefreshRed).AddEnum(RedPointMessageEnum.HomelandFriendShopRefreshRed)
			.AddEnum(RedPointMessageEnum.HomelandLevelUpgradeRed)
			.AddEnum(RedPointMessageEnum.HomelandFarmRed)
			.AddEnum(RedPointMessageEnum.HomelandSailRed)
			.SetFuncOnMessage(delegate
			{
				IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
				bool valueOrDefault = service?.GetHomeShopViewModel()?.GetHomeShopRefreshRed() == true;
				bool valueOrDefault2 = service?.GetHomeShopViewModel()?.GetFriendHomeShopRefreshRed() == true;
				bool valueOrDefault3 = service?.GetHomeShopViewModel()?.CheckFriendHomeShopOpened() == true;
				bool valueOrDefault4 = service?.GetVm()?.CheckCanUpgradeLevel() == true;
				bool valueOrDefault5 = service?.GetVm()?.CheckCanHarvestByType(2) == true;
				bool valueOrDefault6 = service?.GetVm()?.CheckCanHarvestByType(1) == true;
				return (valueOrDefault3 & valueOrDefault2) | valueOrDefault | valueOrDefault4 | valueOrDefault5 | valueOrDefault6;
			})
			.Invoke();
		BtnGuild.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildTaskComplete).AddEnum(RedPointMessageEnum.GuildActiveReward)
			.AddEnum(RedPointMessageEnum.GuildBuild)
			.AddEnum(RedPointMessageEnum.GuildApplicationUnread)
			.AddEnum(RedPointMessageEnum.ShopRed)
			.AddEnum(RedPointMessageEnum.GuildActivityUnread)
			.SetFuncOnMessage(delegate
			{
				RedPointService redPointService = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
				return redPointService.GuildTaskCanComplete || redPointService.GuildActiveRewardCanGet || redPointService.GuildCanBuild || redPointService.GuildApplicationUnRead || redPointService.MainShopReds.Contains(GuildDefinition.GetGuildMainShopId()) || redPointService.GuildActivityUnread;
			})
			.Invoke();
		BtnDrawCard.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.DrawCard).SetFuncOnMessage((RedPointMessage msg) => Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().CheckRedPoint())
			.Invoke();
		BtnPassport.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.Passport).SetFuncOnMessage(delegate
		{
			IPassportService service = Singleton<ServiceSystem>.Instance.GetService<IPassportService>();
			return service.GetPassportViewModel() != null && service.GetPassportViewModel().RedPoint;
		})
			.Invoke();
		BtnTeachingManual.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ServerRed).SetFuncOnMessage((RedPointMessage msg) => Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.GetServerRed(ServerRedType.Manual) ?? false)
			.Invoke();
		BtnBubbleFrameBattleEmote.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ServerRed).SetFuncOnMessage((RedPointMessage msg) => Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.GetServerRed(new List<ServerRedType>
		{
			ServerRedType.BattleEmoji,
			ServerRedType.HeroCardFrame,
			ServerRedType.ChatBubble,
			ServerRedType.Indicator
		}) ?? false)
			.Invoke();
	}

	public async void AttachMoneyView()
	{
		MoneyViewModel moneyVm = new MoneyViewModel(viewModel);
		moneyView = await OpenView<MoneyView>("Role/MoneyView", moneyVm, "MainWindow");
		moneyView.Init(moneyVm);
		moneyView.SetShow(new List<RoleMoneyEnum>
		{
			RoleMoneyEnum.Coin,
			RoleMoneyEnum.Diamond,
			RoleMoneyEnum.Energy
		});
		AddView(moneyView);
		moneyView.Transform.SetParent(moneyBarRoot);
		moneyView.Visibility = true;
	}

	private async void RefreshBoardBackground(object sender = null, InteractionEventArgs e = null)
	{
		if (!string.IsNullOrEmpty(viewModel.BoardBgAssetPath))
		{
			DisposeAll();
			outerBgAssetPath = viewModel.BoardBgAssetPath;
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(outerBgAssetPath), OuterRoot.transform);
			if (gameObject != null)
			{
				outerBg = gameObject;
			}
		}
	}

	protected override async Task<bool> CheckOpenWindow(OpenViewArg openViewArg, string path, ViewConfig? viewConfig, string entrance, Action callback)
	{
		if (openViewArg.UserData is ShopWindowViewModel)
		{
			await CheckOpenWindow(path, openViewArg.UserData, callback, openViewArg.UiGroupName, viewConfig, entrance);
			return true;
		}
		return false;
	}

	protected override void OnDestroy()
	{
		DisposeAll();
		base.OnDestroy();
	}

	private void DisposeAll()
	{
		if (outerBg != null)
		{
			UnityEngine.Object.Destroy(outerBg);
			outerBg = null;
		}
		RemoveMonthlyCardNotify();
	}

	protected override void OnDismissRequest(object sender, InteractionEventArgs args)
	{
		base.OnDismissRequest(sender, args);
		TDAHandler.Instance.SendViewEnd(pageId, (pageType == null) ? "" : pageType, (entrance == null) ? "default" : entrance);
	}

	public void HideLeftAndRight()
	{
		if (cgList != null)
		{
			for (int i = 0; i < cgList.Count; i++)
			{
				cgList[i].alpha = 0f;
			}
		}
	}

	public void PlayEnter()
	{
		Animator obj = windowAnimator;
		if (obj != null)
		{
			obj.Play("enter");
		}
	}

	protected async void OpenUguiWindow2(object sender, InteractionEventArgs args)
	{
		Action callback = null;
		try
		{
			callback = args.Callback;
			OpenViewArgTemp openViewArg = (OpenViewArgTemp)args.Context;
			ViewConfig? viewConfig = null;
			string path;
			if (openViewArg.Path == null)
			{
				ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
				if (viewConfigs == null)
				{
					throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
				}
				path = viewConfigs[0].ViewPath;
				viewConfig = viewConfigs[0];
			}
			else
			{
				ViewConfig[] viewConfigs2 = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewPath.Equals(openViewArg.Path));
				if (viewConfigs2 != null)
				{
					viewConfig = viewConfigs2[0];
				}
				path = openViewArg.Path;
			}
			if (openViewArg.IsOpenWindow)
			{
				await CheckOpenWindow(path, openViewArg.UserData, callback, openViewArg.UiGroupName, viewConfig, openViewArg.Entrance);
			}
			else
			{
				await CheckOpenView(openViewArg.ViewName, path, openViewArg.UserData, viewConfig, openViewArg.Entrance, callback);
			}
		}
		catch (Exception ex)
		{
			callback?.Invoke();
			Log.Error("打开界面发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void SpinePlayPress()
	{
		bool streamerMode = StreamerMode.GetStreamerMode();
		List<int> allValidSkins = SpinePlayViewModel.GetAllValidSkins();
		if (!streamerMode && allValidSkins != null && allValidSkins.Count > 0)
		{
			_spinePlayPressTime += Time.deltaTime;
			if (_spinePlayPressTime >= btnHidePressDuration)
			{
				BtnHideUI.enabled = false;
				BtnHideUI.enabled = true;
				_spinePlayPressTime = 0f;
				OnOpenSpinePlayClick();
			}
		}
	}

	private void SpinePlayEndPress()
	{
		_spinePlayPressTime = 0f;
	}

	private void OnOpenSpinePlayClick()
	{
		Capture(LoadingSpineWindow);
	}

	private async void LoadingSpineWindow(Sprite sprite)
	{
		LoadingSpineWindow loadingWindow = null;
		try
		{
			loadingWindow = await GameEntry.UI.OpenWindow<LoadingSpineWindow>(loadingSpineUiPath, "POPUP");
			if (loadingWindow == null)
			{
				throw new NotFoundException("Not found the loading window named \"" + loadingSpineUiPath + "\".");
			}
			int boardHeroId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData.BoardHeroId;
			int enterSkinId = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(boardHeroId)?.HeroSkinId ?? 0;
			loadingWindow.SetImage(sprite);
			loadingWindow.SetParentData(viewModel, enterSkinId);
			loadingWindow.Show();
			await UniTask.WaitUntil(() => loadingWindow.isActiveAndEnabled);
			loadingWindow.StartPlay();
		}
		catch (Exception ex)
		{
			if (loadingWindow != null)
			{
				loadingWindow.Dismiss();
			}
			Log.Error("打开Spine界面出错。 e : " + ex.Message);
		}
	}

	public void Capture(Action<Sprite> onDone)
	{
		StartCoroutine(CaptureCoroutine(onDone));
	}

	private IEnumerator CaptureCoroutine(Action<Sprite> onDone)
	{
		yield return null;
		yield return new WaitForEndOfFrame();
		Texture2D texture2D = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, mipChain: false);
		texture2D.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0, recalculateMipMaps: false);
		texture2D.Apply();
		Sprite obj = Sprite.Create(texture2D, new Rect(0f, 0f, texture2D.width, texture2D.height), new Vector2(0.5f, 0.5f));
		onDone?.Invoke(obj);
	}
}
