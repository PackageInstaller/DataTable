using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.UI.AOT;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.WaitSort;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using bamboosdk;

namespace ACT;

public class MonoEscView : BaseUIView<MonoEscViewInputController>
{
	private const string ShowAnimationName = "Show";

	private const string HideAnimationName = "Hide";

	public ActButton Return;

	public LoopScrollRect LoopScrollRect;

	public LoopVerticalScrollRect _billboardScrollRect;

	public LoopScrollBillboard _loopScrollBillboard;

	public TextMeshProUGUI UID;

	public ActButton CopyUID;

	public TextMeshProUGUI Title;

	[SerializeField]
	[Header("称号图片")]
	private BImage _titleImage;

	public TextMeshProUGUI NickName;

	public ActButton btn_edit_name;

	public TextMeshProUGUI AdvantureLevel;

	public GameObject AdvantureExp;

	public TextMeshProUGUI AdvantureRemainExp;

	public TextMeshProUGUI AdvantureTotalExp;

	public GameObject AdvantureMax;

	public Image AdvantureExpFill;

	[SerializeField]
	public TextMeshProUGUI WorldLevelText;

	[SerializeField]
	public TextMeshProUGUI WorldLevelValue;

	[SerializeField]
	public ActButton Btn_WorldLevelAndPlayerLevelTips;

	[SerializeField]
	private RedDotItem worldLevelRedDotItem;

	public ActButton ChangeSignature;

	public TextMeshProUGUI Signature;

	public ActButton ChangeHead;

	public BImage HeadFrame;

	public BImage HeadFrameUpper;

	[SerializeField]
	[Header("头像")]
	private BImage _headImage;

	public ActButton btn_more;

	[SerializeField]
	[Header("更多按钮红点")]
	private RedDotItem moreRedDot;

	public GameObject MoreDropdownPanel;

	public ActButton btn_more_dropdown_mask;

	public ActButton btn_personalize;

	[SerializeField]
	[Header("个性装饰入口红点")]
	private RedDotItem personalizeRedDot;

	public ActButton btn_rename;

	public ActButton btn_signature;

	public ActButton btn_show_character;

	public ActButton Exit;

	public ActButton Announcement;

	public ActButton Feedback;

	public ActButton Mail;

	public ActButton Setting;

	public GameObject ExitPanel;

	public ActButton ContinueGame;

	public ActButton ExitLoginView;

	public ActButton ExitGame;

	public List<SystemUnlockActive> SystemUnlockActives;

	public List<RedDotItem> RedDotItems;

	public GameObject EscItemTheme1;

	public GameObject EscItemTheme2;

	private List<EscSystem> _escSystems;

	private Coroutine _playItemAnimationCoroutine;

	public ViewControlLayer ViewControlLayer;

	public ViewControlLayer MoreDropdownViewControlLayer;

	public ViewControlLayer ExitViewControlLayer;

	public GameObject GamepadTipsRoot;

	public Dictionary<EscViewControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<EscViewControlType, List<GameObject>> ControlPromts;

	public Dictionary<EscViewControlType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	private const int RenameAndSignatureLockTipId = 41000212;

	private List<BubbleSystem> bubbleSystems;

	public StringBuilder sb { get; private set; }

	public bool IsInExitPanel { get; private set; }

	public bool IsMoreDropdownOpen => MoreDropdownPanel.activeSelf;

	private EscViewControlType ControlType
	{
		get
		{
			return GetController().EscViewControlType;
		}
		set
		{
			GetController().EscViewControlType = value;
		}
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ChangeAvatar, OnChangeAvatar);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayerWorldLevel_Change, OnChangePlayerWorldLevel);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayLevel_Change, OnChangePlayerLevel);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_SelectEscSystemId, OnSelectEscSystemId);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		AnnouncementRedDot.OnRedDotChanged = (Action)Delegate.Combine(AnnouncementRedDot.OnRedDotChanged, new Action(OnAnnouncementRedDotChanged));
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		Model<BattlePassModel>.Interface.TimeUpdateAction += BattlePassTimeUpdateAction;
		Return.SetBtnClick(Close, "event:/UI/Common/Return_Click");
		CopyUID.SetBtnClick(OnClickCopyUIDButtonHandle);
		ChangeSignature.SetBtnClick(OnClickChangeSignatureButtonHandle);
		ChangeHead.SetBtnClick(OnClickChangeHeadButtonHandle);
		btn_more.SetBtnClick(OnClickMoreButtonHandle);
		btn_more_dropdown_mask.SetBtnClick(CloseMoreDropdown);
		btn_personalize.SetBtnClick(OnClickMorePersonalizeButtonHandle);
		btn_rename.SetBtnClick(OnClickMoreRenameButtonHandle);
		btn_signature.SetBtnClick(OnClickMoreSignatureButtonHandle);
		btn_show_character.SetBtnClick(OnClickMoreShowCharacterButtonHandle);
		btn_edit_name.SetBtnClick(OnClickMoreRenameButtonHandle);
		Exit.SetBtnClick(OnClickExitButtonHandle);
		Announcement.SetBtnClick(OpenAnnouncement);
		Feedback.SetBtnClick(OpenFeedback);
		Mail.SetBtnClick(OpenMailBox);
		Setting.SetBtnClick(OpenSettingUI);
		ContinueGame.SetBtnClick(CloseExitPanel);
		ExitLoginView.SetBtnClick(ExitToLogin);
		ExitGame.SetBtnClick(OnClickExitGame);
		Btn_WorldLevelAndPlayerLevelTips.SetBtnClick(OpenWorldLevelAndPlayerLevelTips);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ChangeAvatar, OnChangeAvatar);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayerWorldLevel_Change, OnChangePlayerWorldLevel);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayLevel_Change, OnChangePlayerLevel);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_SelectEscSystemId, OnSelectEscSystemId);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		AnnouncementRedDot.OnRedDotChanged = (Action)Delegate.Remove(AnnouncementRedDot.OnRedDotChanged, new Action(OnAnnouncementRedDotChanged));
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
		Model<BattlePassModel>.Interface.TimeUpdateAction -= BattlePassTimeUpdateAction;
	}

	protected override void PlayOpenAnimation()
	{
		PlayShowAnimation(completeOpenEffect: true);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ESC/Open");
	}

	protected override void PlayCloseAnimation()
	{
		PlayHideAnimation(completeCloseEffect: true);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ESC/Close");
	}

	protected override async UniTask PlayPushStackAsync(CancellationToken token)
	{
		await base.PlayPushStackAsync(token);
	}

	protected override async UniTask PlayPopStackAsync(CancellationToken token)
	{
		await base.PlayPopStackAsync(token);
	}

	private AnimationBuilder PlayShowAnimation(bool completeOpenEffect)
	{
		base.PlayOpenAnimation();
		AnimationBuilder sequence = betterAnimation.GetSequence("Show");
		if (completeOpenEffect)
		{
			sequence.OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			});
		}
		sequence.Play();
		StopItemAnimationCoroutine();
		_playItemAnimationCoroutine = StartCoroutine(PlayItemAnimation());
		return sequence;
	}

	private AnimationBuilder PlayHideAnimation(bool completeCloseEffect)
	{
		base.PlayCloseAnimation();
		AnimationBuilder sequence = betterAnimation.GetSequence("Hide");
		if (completeCloseEffect)
		{
			sequence.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			});
		}
		sequence.Play();
		StopItemAnimationCoroutine();
		return sequence;
	}

	protected override void Init()
	{
		base.Init();
		OnAnnouncementRedDotChanged();
		LoopScrollRect.BeforeItemGet.AddListener(BeforeEscItemInstance);
		sb = new StringBuilder();
		CloseMoreDropdown();
		RefreshScrollView();
		RefreshUserInfo();
		RefreshAccountDecorationSystemUnlockState();
		LoopScrollRect.content.GetComponent<GridLayoutGroup>().constraint = GridLayoutGroup.Constraint.Flexible;
		foreach (SystemUnlockActive systemUnlockActive in SystemUnlockActives)
		{
			systemUnlockActive.Refresh();
		}
		moreRedDot?.InitRedDot(RedDotPathDefine.EscMore, moreRedDot.redDotType);
		personalizeRedDot?.InitRedDot(RedDotPathDefine.AccountDecoration, personalizeRedDot.redDotType);
		InitWorldLevelRedDot();
		RefreshBottomRedDot();
		HideWeGameExitToLoginButton();
		RefreshBillBoard();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ChangeEscViewControlType(EscViewControlType.Main);
		}
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		CloseMoreDropdown();
		RefreshAccountDecorationDisplay();
		LoopScrollRect.RefreshCells();
		RefreshBottomRedDot();
		OnControllerStatusChange(MonoECS.instance.InputMode);
		RefreshBillBoard();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		OnControllerStatusChange(MonoECS.instance.InputMode);
	}

	protected override void UnInit()
	{
		base.UnInit();
		StopItemAnimationCoroutine();
		LoopScrollRect.BeforeItemGet.RemoveListener(BeforeEscItemInstance);
		LoopScrollRect.ClearCellsPool();
		CloseMoreDropdown();
		HeadFrame.UnLoad();
		HeadFrameUpper?.UnLoad();
		_escSystems.Clear();
		_escSystems = null;
		ControlLayerDic[ControlType].SetDefaultSelect(null);
		ControlLayerDic[ControlType].UnFocus();
	}

	private void BattlePassTimeUpdateAction()
	{
		RefreshScrollView();
	}

	private void OnChangeAvatar(BaseEventContent obj)
	{
		if (!(obj is AccountDecorationChangedEvt { ChangeType: var changeType } accountDecorationChangedEvt))
		{
			return;
		}
		switch (changeType)
		{
		case AccountDecorationChangeType.None:
			return;
		case AccountDecorationChangeType.Avatar:
			RefreshAccountDecorationDisplay(AccountDecorationChangeType.Avatar);
			return;
		case AccountDecorationChangeType.AvatarFrame:
			RefreshAccountDecorationDisplay(AccountDecorationChangeType.AvatarFrame);
			return;
		case AccountDecorationChangeType.Title:
			RefreshAccountDecorationDisplay(AccountDecorationChangeType.Title);
			return;
		case AccountDecorationChangeType.Nickname:
			RefreshNickname();
			return;
		case AccountDecorationChangeType.Signature:
			RefreshSignature();
			return;
		}
		RefreshAccountDecorationDisplay(accountDecorationChangedEvt.ChangeType);
		if ((accountDecorationChangedEvt.ChangeType & AccountDecorationChangeType.Nickname) != 0)
		{
			RefreshNickname();
		}
		if ((accountDecorationChangedEvt.ChangeType & AccountDecorationChangeType.Signature) != 0)
		{
			RefreshSignature();
		}
	}

	private void RefreshNickname()
	{
		BriefUserInfo briefUserInfo = G.detailUserInfo?.Brief;
		if (briefUserInfo != null)
		{
			NickName.text = briefUserInfo.Nickname;
		}
	}

	private void RefreshSignature()
	{
		string text = G.localPlayer?.Profile?.EscInfo?.Signature;
		Signature.text = (string.IsNullOrEmpty(text) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1847) : text);
	}

	private void OnChangePlayerWorldLevel(BaseEventContent obj)
	{
		RefreshUserInfo();
	}

	private void OnChangePlayerLevel(BaseEventContent obj)
	{
		RefreshUserInfo();
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 1054 })
		{
			RefreshAccountDecorationSystemUnlockState();
		}
	}

	public void OnClickCopyUIDButtonHandle()
	{
		GUIUtility.systemCopyBuffer = G.detailUserInfo.Brief.AccountId.ToString();
		GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2301));
	}

	private void OnClickChangeSignatureButtonHandle()
	{
		if (!TryShowSystemLockTip(SystemType.ChangeSignature) && IsAccountDecorationUnlocked())
		{
			OpenChangeSignatureView();
		}
	}

	private void OnClickChangeHeadButtonHandle()
	{
		if (IsAccountDecorationUnlocked())
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPACCOUNTDEACORATION).Forget();
		}
	}

	private void OnClickMoreButtonHandle()
	{
		if (IsAccountDecorationUnlocked())
		{
			if (IsMoreDropdownOpen)
			{
				CloseMoreDropdown();
			}
			else
			{
				OpenMoreDropdown();
			}
		}
	}

	private void OnClickMorePersonalizeButtonHandle()
	{
		Debug.Log("OnClickMorePersonalizeButtonHandle");
		CloseMoreDropdown();
		OnClickChangeHeadButtonHandle();
	}

	public void OnClickMoreRenameButtonHandle()
	{
		CloseMoreDropdown();
		if (!TryShowSystemLockTip(SystemType.Rename) && IsAccountDecorationUnlocked())
		{
			OpenChangeNameView();
		}
	}

	private void OnClickMoreSignatureButtonHandle()
	{
		CloseMoreDropdown();
		OnClickChangeSignatureButtonHandle();
	}

	private void OnClickMoreShowCharacterButtonHandle()
	{
		CloseMoreDropdown();
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERPRESENTATION);
	}

	private void OpenMoreDropdown()
	{
		MoreDropdownPanel.SetActive(value: true);
		btn_more_dropdown_mask.gameObject.SetActive(value: true);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ChangeEscViewControlType(EscViewControlType.MoreDropdown);
		}
	}

	public void CloseMoreDropdown()
	{
		MonoEscViewInputController controller = GetController();
		int num;
		if (controller != null)
		{
			num = ((controller.EscViewControlType == EscViewControlType.MoreDropdown) ? 1 : 0);
			if (num != 0)
			{
				controller.EscViewControlType = EscViewControlType.Main;
				MoreDropdownViewControlLayer?.UnFocus();
			}
		}
		else
		{
			num = 0;
		}
		btn_more_dropdown_mask.gameObject.SetActive(value: false);
		MoreDropdownPanel.SetActive(value: false);
		if (num != 0 && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ViewControlLayer.SetDefaultSelect(btn_more.GetComponent<ACT.ViewControl.SelectableEx>());
			ChangeEscViewControlType(EscViewControlType.Main);
		}
	}

	private void OpenAdjustWorldLevel()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPADJUSTWORLDLEVEL).Forget();
	}

	public async void OnClickExitButtonHandle()
	{
		if (UIController.State != UIState.Opened)
		{
			return;
		}
		if (MonoECS.instance.ispc)
		{
			ExitPanel.SetActive(value: true);
			IsInExitPanel = true;
			ChangeEscViewControlType(EscViewControlType.Exit);
			return;
		}
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			texts = new string[1] { "确定退出游戏？" },
			OnConfirm = () =>
			{
				QuitGameChoice evt = EventTrackSolver.Instance.GetEvt<QuitGameChoice>();
				evt.type = 3;
				EventTrackSolver.Instance.Dispatch(evt);
				MonoECS.instance.DestroyWorld().Forget();
			},
			OnCancel = () =>
			{
				QuitGameChoice evt = EventTrackSolver.Instance.GetEvt<QuitGameChoice>();
				evt.type = 1;
				EventTrackSolver.Instance.Dispatch(evt);
			}
		});
	}

	public void OpenSettingUI()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SETTINGS);
		ACT.EventTrack.SystemOpen evt = EventTrackSolver.Instance.GetEvt<ACT.EventTrack.SystemOpen>();
		evt.id = 1035;
		evt.type = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void OpenMailBox()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MAILBOXPANEL);
		ACT.EventTrack.SystemOpen evt = EventTrackSolver.Instance.GetEvt<ACT.EventTrack.SystemOpen>();
		evt.id = 7004;
		evt.type = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void OpenAnnouncement()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ANNOUNCEMENT);
		ACT.EventTrack.SystemOpen evt = EventTrackSolver.Instance.GetEvt<ACT.EventTrack.SystemOpen>();
		evt.id = 7003;
		evt.type = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void OpenFeedback()
	{
		Application.OpenURL(UrlUtility.FeedbackUrl);
	}

	public void CloseExitPanel()
	{
		QuitGameChoice evt = EventTrackSolver.Instance.GetEvt<QuitGameChoice>();
		evt.type = 1;
		EventTrackSolver.Instance.Dispatch(evt);
		CloseMoreDropdown();
		ExitPanel.SetActive(value: false);
		IsInExitPanel = false;
		ChangeEscViewControlType(EscViewControlType.Main);
	}

	private void HideWeGameExitToLoginButton()
	{
		if (LuminApplication.IsWeGameChannel)
		{
			ExitLoginView.gameObject.SetActive(value: false);
		}
	}

	private async void ExitToLogin()
	{
		if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
		{
			QuitGameChoice evt = EventTrackSolver.Instance.GetEvt<QuitGameChoice>();
			evt.type = 2;
			EventTrackSolver.Instance.Dispatch(evt);
			await MonoECS.instance.DestroyWorld();
		}
	}

	private void OnClickExitGame()
	{
		QuitGameChoice evt = EventTrackSolver.Instance.GetEvt<QuitGameChoice>();
		evt.type = 3;
		EventTrackSolver.Instance.Dispatch(evt);
		Application.Quit();
	}

	private void OpenWorldLevelAndPlayerLevelTips()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.WorldLevelExplanationClick);
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, new MonoJourneyTracesViewData
		{
			tabIndex = 0
		}).Forget();
	}

	private void RefreshUserInfo()
	{
		BriefUserInfo briefUserInfo = G.detailUserInfo?.Brief;
		if (briefUserInfo == null)
		{
			UID.text = "UID  0";
			NickName.text = "本地游戏";
			string text = G.localPlayer?.Profile?.EscInfo?.Signature;
			Signature.text = (string.IsNullOrEmpty(text) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1847) : text);
			RefreshAccountDecorationDisplay();
			_ = LuminApplication.LogEnabled;
			return;
		}
		UID.text = $"UID  {briefUserInfo.AccountId}";
		Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1865);
		NickName.text = briefUserInfo.Nickname;
		AdvantureLevel.SetText("{0:0}", SystemUnlockManager.playerLevel);
		AdvantureExp.SetActive(SystemUnlockManager.playerLevel < RuntimeConfigs.data.game.playerMaxLevel);
		AdvantureMax.SetActive(SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.playerMaxLevel);
		string text2 = G.localPlayer?.Profile?.EscInfo?.Signature;
		Signature.text = (string.IsNullOrEmpty(text2) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1847) : text2);
		long num = G.detailUserInfo.Attributes[93];
		AdvantureRemainExp.text = num.ToString();
		PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[Mathf.Max(SystemUnlockManager.playerLevel, 1)];
		AdvantureTotalExp.SetText("{0:0}", playerLevelData.xpEachLv);
		float num2 = Mathf.Clamp01(1f * (float)num / (float)playerLevelData.xpEachLv);
		if (num2 > 0f && num2 < 1f)
		{
			num2 = Mathf.Clamp(num2, 0.01f, 0.99f);
		}
		AdvantureExpFill.fillAmount = num2;
		ColorUtility.TryParseHtmlString((num >= playerLevelData.xpEachLv) ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.White), out var color);
		AdvantureRemainExp.color = color;
		WorldLevelText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2176);
		WorldLevelValue.SetText("{0:0}", Model<WorldLevelModel>.Interface.GetCurWorldLevel());
		Btn_WorldLevelAndPlayerLevelTips.gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide));
		RefreshAccountDecorationDisplay();
	}

	private void OpenChangeNameView()
	{
		if (IsAccountDecorationUnlocked())
		{
			string text = G.detailUserInfo?.Brief?.Nickname;
			if (string.IsNullOrEmpty(text))
			{
				text = NickName.text;
			}
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPACCOUNTDECORATIONCHANGENAMEVIEW, new ChangeNameViewData
			{
				currentValue = (text ?? string.Empty),
				allowSameValue = false
			}).Forget();
		}
	}

	private void OpenChangeSignatureView()
	{
		if (IsAccountDecorationUnlocked())
		{
			string text = G.localPlayer?.Profile?.EscInfo?.Signature;
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPCHANGENAMESIGNATURE, new ChangeSignatureViewData
			{
				currentValue = (text ?? string.Empty),
				allowSameValue = false
			}).Forget();
		}
	}

	private static bool IsAccountDecorationUnlocked()
	{
		return Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.AccountDecoration);
	}

	private static bool TryShowSystemLockTip(SystemType systemType)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(systemType))
		{
			return false;
		}
		GameUtility.OpenToolTip(41000212);
		return true;
	}

	private void RefreshAccountDecorationSystemUnlockState()
	{
		bool flag = IsAccountDecorationUnlocked();
		if (!flag)
		{
			CloseMoreDropdown();
		}
		btn_more.gameObject.SetActive(flag);
		btn_edit_name.gameObject.SetActive(flag);
	}

	private void RefreshAccountDecorationDisplay()
	{
		int curAvatarId = G.localPlayer.Profile.EscInfo.CurAvatarId;
		if (RuntimeConfigs.data.MtyAvatars.TryGetValue(curAvatarId, out var value))
		{
			Station.LoadImage(241, value.iconID, _headImage);
		}
		int curAvatarFrameId = G.localPlayer.Profile.EscInfo.CurAvatarFrameId;
		if (HeadFrame != null)
		{
			if (curAvatarFrameId > 0 && RuntimeConfigs.data.Frames.TryGetValue(curAvatarFrameId, out var value2))
			{
				SetBImageActive(HeadFrame, active: true);
				Station.LoadImage(144, value2.iconID, HeadFrame);
				SetBImageActive(HeadFrameUpper, active: true);
				if (HeadFrameUpper != null)
				{
					Station.LoadImage(243, value2.iconID, HeadFrameUpper);
				}
			}
			else
			{
				SetBImageActive(HeadFrame, active: false);
				SetBImageActive(HeadFrameUpper, active: false);
			}
		}
		int curTitleId = G.localPlayer.Profile.EscInfo.CurTitleId;
		if (curTitleId > 0 && RuntimeConfigs.data.Titles.TryGetValue(curTitleId, out var value3))
		{
			if (_titleImage != null)
			{
				SetBImageActive(_titleImage, active: true);
				Station.LoadImage(242, value3.iconID, _titleImage);
			}
			Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value3.name);
		}
		else
		{
			SetBImageActive(_titleImage, active: false);
			Title.text = string.Empty;
		}
	}

	private void RefreshAccountDecorationDisplay(AccountDecorationChangeType changeType)
	{
		if ((changeType & AccountDecorationChangeType.Avatar) != 0)
		{
			int curAvatarId = G.localPlayer.Profile.EscInfo.CurAvatarId;
			if (RuntimeConfigs.data.MtyAvatars.TryGetValue(curAvatarId, out var value))
			{
				Station.LoadImage(241, value.iconID, _headImage);
			}
		}
		if ((changeType & AccountDecorationChangeType.AvatarFrame) != 0 && HeadFrame != null)
		{
			int curAvatarFrameId = G.localPlayer.Profile.EscInfo.CurAvatarFrameId;
			if (curAvatarFrameId > 0 && RuntimeConfigs.data.Frames.TryGetValue(curAvatarFrameId, out var value2))
			{
				SetBImageActive(HeadFrame, active: true);
				Station.LoadImage(144, value2.iconID, HeadFrame);
				SetBImageActive(HeadFrameUpper, active: true);
				if (HeadFrameUpper != null)
				{
					Station.LoadImage(243, value2.iconID, HeadFrameUpper);
				}
			}
			else
			{
				SetBImageActive(HeadFrame, active: false);
				SetBImageActive(HeadFrameUpper, active: false);
			}
		}
		if ((changeType & AccountDecorationChangeType.Title) == 0)
		{
			return;
		}
		int curTitleId = G.localPlayer.Profile.EscInfo.CurTitleId;
		if (curTitleId > 0 && RuntimeConfigs.data.Titles.TryGetValue(curTitleId, out var value3))
		{
			if (_titleImage != null)
			{
				SetBImageActive(_titleImage, active: true);
				Station.LoadImage(242, value3.iconID, _titleImage);
			}
			Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value3.name);
		}
		else
		{
			SetBImageActive(_titleImage, active: false);
			Title.text = string.Empty;
		}
	}

	private static void SetBImageActive(BImage image, bool active)
	{
		if (image != null)
		{
			if (image.icon != null)
			{
				image.icon.gameObject.SetActive(active);
			}
			if (image.rawIcon != null)
			{
				image.rawIcon.gameObject.SetActive(active);
			}
		}
	}

	public override void Close()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Esc_Close);
		base.Close();
	}

	private void RefreshScrollView()
	{
		_escSystems = BuildDisplayList();
		_escSystems.Sort(Sort);
		LoopScrollRect.ClearCellsPool();
		LoopScrollRect.totalCount = _escSystems.Count;
		LoopScrollRect.RefillCells();
		if (Model<EscModel>.Interface.EscSelectSystemId > 0)
		{
			int id = _escSystems.FindIndex((EscSystem system) => system.id == Model<EscModel>.Interface.EscSelectSystemId);
			ILoopScrollDataSource item = LoopScrollRect.GetItem(id);
			if (item != null && item is MonoEscItem monoEscItem)
			{
				ViewControlLayer.UnFocus();
				ACT.ViewControl.SelectableEx componentInChildren = monoEscItem.GetComponentInChildren<ACT.ViewControl.SelectableEx>();
				ViewControlLayer.DefaultSelect = componentInChildren;
			}
			Model<EscModel>.Interface.SetEscSelectSystemId(0);
		}
	}

	private List<EscSystem> BuildDisplayList()
	{
		List<EscSystem> list = new List<EscSystem>();
		foreach (EscSystem value in RuntimeConfigs.data.escSystems.Values)
		{
			if (ShouldShowSystem(value.id))
			{
				list.Add(value);
			}
		}
		return list;
	}

	private bool ShouldShowSystem(int systemId)
	{
		if (Singleton<SystemBlockManager>.instance.IsBlocked(systemId))
		{
			return false;
		}
		if (systemId == 1044)
		{
			return Model<BattlePassModel>.Interface.EscCanShow;
		}
		return true;
	}

	private int Sort(EscSystem left, EscSystem right)
	{
		return left.rank - right.rank;
	}

	public EscSystem GetEscSystemByIndex(int index)
	{
		return _escSystems[index];
	}

	private IEnumerator PlayItemAnimation()
	{
		IReadOnlyList<RectTransform> children = LoopScrollRect.Children;
		if (children == null)
		{
			_playItemAnimationCoroutine = null;
			yield break;
		}
		for (int i = 0; i < children.Count; i++)
		{
			RectTransform rectTransform = children[i];
			if (rectTransform == null)
			{
				continue;
			}
			for (int j = 0; j < rectTransform.childCount; j++)
			{
				CanvasGroup component = rectTransform.GetChild(j).GetComponent<CanvasGroup>();
				if (component != null)
				{
					component.alpha = 0f;
				}
			}
		}
		yield return new WaitForSeconds(0.1f);
		GridLayoutGroup component2 = LoopScrollRect.content.GetComponent<GridLayoutGroup>();
		int columnCount = (int)((LoopScrollRect.content.rect.width - (float)component2.padding.left - (float)component2.padding.right + component2.spacing.x) / (component2.cellSize.x + component2.spacing.x));
		columnCount = Mathf.Max(1, columnCount);
		children = LoopScrollRect.Children;
		if (children == null)
		{
			_playItemAnimationCoroutine = null;
			yield break;
		}
		for (int k = 0; k < children.Count; k++)
		{
			RectTransform rectTransform2 = children[k];
			if (!(rectTransform2 == null))
			{
				MonoEscItem component3 = rectTransform2.GetComponent<MonoEscItem>();
				if (component3 != null)
				{
					component3.PlayAnimation();
				}
				if ((k + 1) % columnCount == 0)
				{
					yield return new WaitForSeconds(0.02f);
				}
			}
		}
		_playItemAnimationCoroutine = null;
	}

	private void StopItemAnimationCoroutine()
	{
		if (_playItemAnimationCoroutine != null)
		{
			StopCoroutine(_playItemAnimationCoroutine);
			_playItemAnimationCoroutine = null;
		}
		ResetItemCanvasGroupAlpha();
	}

	private void ResetItemCanvasGroupAlpha()
	{
		if (LoopScrollRect == null)
		{
			return;
		}
		IReadOnlyList<RectTransform> children = LoopScrollRect.Children;
		if (children == null)
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			RectTransform rectTransform = children[i];
			if (rectTransform == null)
			{
				continue;
			}
			for (int j = 0; j < rectTransform.childCount; j++)
			{
				CanvasGroup component = rectTransform.GetChild(j).GetComponent<CanvasGroup>();
				if (component != null)
				{
					component.alpha = 1f;
				}
			}
		}
	}

	private void BeforeEscItemInstance(int index)
	{
		if (_escSystems[index].Theme == 0)
		{
			LoopScrollRect.item = EscItemTheme1;
		}
		else if (_escSystems[index].Theme == 1)
		{
			LoopScrollRect.item = EscItemTheme2;
		}
	}

	private void RefreshBottomRedDot()
	{
		foreach (RedDotItem redDotItem in RedDotItems)
		{
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
	}

	private void InitWorldLevelRedDot()
	{
		if (!(worldLevelRedDotItem == null))
		{
			if (worldLevelRedDotItem.displayAction == null)
			{
				worldLevelRedDotItem.displayAction = new SelfNodeActive();
			}
			worldLevelRedDotItem.InitRedDot(RedDotPathDefine.WorldLevelTab, worldLevelRedDotItem.redDotType);
		}
	}

	private void OnSelectEscSystemId(BaseEventContent content)
	{
		if (Model<EscModel>.Interface.EscSelectSystemId > 0)
		{
			int id = _escSystems.FindIndex((EscSystem system) => system.id == Model<EscModel>.Interface.EscSelectSystemId);
			ILoopScrollDataSource item = LoopScrollRect.GetItem(id);
			if (item != null && item is MonoEscItem monoEscItem)
			{
				ACT.ViewControl.SelectableEx componentInChildren = monoEscItem.GetComponentInChildren<ACT.ViewControl.SelectableEx>();
				ViewControlLayer.UnFocus();
				ViewControlLayer.DefaultSelect = componentInChildren;
				ViewControlLayer.Focus();
			}
		}
	}

	private void OnAnnouncementRedDotChanged()
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Announcement, !AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: true, includeTimeline: true, AnnouncementPlace.HCLR));
	}

	private void RefreshBillBoard()
	{
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Bubble);
		bool flag2 = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Shop);
		_billboardScrollRect.gameObject.SetActive(flag2 & flag);
		if (!flag2 || !flag)
		{
			return;
		}
		bubbleSystems = Model<EscModel>.Interface.GetBubbleSystems();
		if (bubbleSystems == null || bubbleSystems.Count <= 0)
		{
			_billboardScrollRect.gameObject.SetActive(value: false);
			return;
		}
		_billboardScrollRect.OnItemShow.RemoveAllListeners();
		_billboardScrollRect.OnItemShow.AddListener(OnBillboardItemShow);
		_billboardScrollRect.totalCount = ((bubbleSystems.Count <= 1) ? 1 : (-1));
		_billboardScrollRect.RefreshCells();
		_billboardScrollRect.ScrollToCell(0, 0f);
		if (bubbleSystems.Count > 1)
		{
			_loopScrollBillboard.NotifyDataReady();
		}
	}

	private void OnBillboardItemShow(ILoopScrollDataSource loopScrollDataSource)
	{
		if (loopScrollDataSource is EscShopBubbleItem escShopBubbleItem)
		{
			int index = (escShopBubbleItem.index % bubbleSystems.Count + bubbleSystems.Count) % bubbleSystems.Count;
			escShopBubbleItem.Refresh(bubbleSystems[index], Station);
		}
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		GamepadTipsRoot.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
		if (deviceInputMode == DeviceInputMode.Gamepad && ActiveInShowRoot)
		{
			IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
			if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_ESC)
			{
				ChangeEscViewControlType(GetController().EscViewControlType);
			}
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
	}

	public void ChangeEscViewControlType(EscViewControlType escViewControlType)
	{
		EscViewControlType controlType = ControlType;
		ControlType = escViewControlType;
		ControlLayerDic[escViewControlType].ReFocus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[escViewControlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType].Count; j++)
		{
			ControlPromts[controlType][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[escViewControlType].Count; k++)
		{
			ControlPromts[escViewControlType][k].SetActive(value: true);
		}
	}
}
