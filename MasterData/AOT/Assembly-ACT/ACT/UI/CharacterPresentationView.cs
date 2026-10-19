using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterPresentationView : BaseUIView<CharacterPresentationViewInputController>
{
	private CharacterPresentationViewData m_data;

	public GameObject UIRoot;

	public GameObject EmptyRoot;

	public ActButton BtnClose;

	public ActButton BtnHideUI;

	public List<CharacterPresentationItem> Items = new List<CharacterPresentationItem>();

	public ActButton BtnEdit;

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

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public ViewControlLayer MoreDropdownViewControlLayer;

	public GamePadTipsComp gamePadTipsComp;

	public List<GameObject> gamepadTips;

	private bool isHide;

	private int _selectedIndex = -1;

	private const int RenameAndSignatureLockTipId = 41000212;

	public bool IsHide => isHide;

	public bool IsMoreDropdownOpen => MoreDropdownPanel.activeSelf;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		await Singleton<UISceneManager>.instance.LoadScene<CharacterPresentationViewScene>(GameLoader.meta.characterPresentationViewSceneReferenceAssetID.GUID);
	}

	protected override void Init()
	{
		base.Init();
		isHide = false;
		InitPanel();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ProfileDecoration/RoleShowcaseOpen");
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Show");
		if (animationBuilder == null)
		{
			OpenEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Hide");
		if (animationBuilder == null)
		{
			CloseEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChangeShowCharacter, OnChangeShowCharacter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ChangeAvatar, OnChangeAvatar);
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

	private void OnChangeShowCharacter(BaseEventContent obj)
	{
		RefreshPanel();
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 1054 })
		{
			RefreshAccountDecorationSystemUnlockState();
		}
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<CharacterPresentationViewScene>();
	}

	protected override void OnMoveToHide()
	{
		Singleton<UISceneManager>.instance.CloseScene<CharacterPresentationViewScene>();
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		Singleton<UISceneManager>.instance.GetScene<CharacterPresentationViewScene>().ResetCharcterAni();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<CharacterPresentationViewScene>();
	}

	public void ShowCharacter(int characterId, ICharacterSource characterSource = null, int skinId = 0)
	{
		CharacterPresentationViewScene.Default?.ShowCharacterModel(characterId, characterSource, skinId);
	}

	public void ChangeCharacter(int characterId, ICharacterSource characterSource = null, int skinId = 0)
	{
		CharacterPresentationViewScene.Default?.ChangeCharacterModel(characterId, characterSource, skinId);
	}

	private void InitPanel()
	{
		InitButtons();
		InitItems();
		CloseMoreDropdown();
		InitRedDots();
		RefreshUserInfo();
		RefreshAccountDecorationDisplay();
		RefreshAccountDecorationSystemUnlockState();
		RefreshPanel();
	}

	private void InitItems()
	{
		for (int i = 0; i < Items.Count; i++)
		{
			Items[i].Init(i, OnClickItem);
		}
	}

	private void RefreshPanel()
	{
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		int num = -1;
		if (repeatedField != null)
		{
			for (int i = 0; i < repeatedField.Count; i++)
			{
				if (repeatedField[i] > 0)
				{
					num = i;
					break;
				}
			}
		}
		bool flag = num >= 0;
		if (EmptyRoot != null)
		{
			EmptyRoot.SetActive(!flag);
		}
		RefreshItems();
		if (flag)
		{
			SelectItem(num);
			return;
		}
		CharacterPresentationViewScene.Default?.ClearCharacterModel();
		_selectedIndex = -1;
		RefreshSelection();
	}

	private void SelectItem(int index)
	{
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		if (repeatedField != null && index >= 0 && index < repeatedField.Count)
		{
			int num = repeatedField[index];
			if (num > 0)
			{
				_selectedIndex = index;
				RefreshSelection();
				ShowCharacter(num, null, CharacterSkinRuntimeUtility.ResolveSkinId(num));
				CharacterPresentationViewScene.Default?.SetSceneState(CharacterPresentationViewScene.SceneState.Over);
			}
		}
	}

	private void RefreshSelection()
	{
		for (int i = 0; i < Items.Count; i++)
		{
			Items[i].SetSelected(i == _selectedIndex);
		}
	}

	public void SwitchItemUp()
	{
		if (!isHide)
		{
			MoveSelection(-1);
		}
	}

	public void SwitchItemDown()
	{
		if (!isHide)
		{
			MoveSelection(1);
		}
	}

	private void MoveSelection(int dir)
	{
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		if (repeatedField == null || repeatedField.Count == 0)
		{
			return;
		}
		int count = repeatedField.Count;
		if (_selectedIndex < 0)
		{
			for (int i = 0; i < count; i++)
			{
				if (repeatedField[i] > 0)
				{
					SelectItem(i);
					break;
				}
			}
			return;
		}
		for (int j = 1; j <= count; j++)
		{
			int num = ((_selectedIndex + dir * j) % count + count) % count;
			if (num != _selectedIndex && repeatedField[num] > 0)
			{
				SelectItem(num);
				break;
			}
		}
	}

	private void RefreshItems()
	{
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		for (int i = 0; i < Items.Count; i++)
		{
			int num = ((repeatedField != null && i < repeatedField.Count) ? repeatedField[i] : 0);
			if (num > 0)
			{
				Items[i].SetCharacter(num, Station);
			}
			else
			{
				Items[i].SetEmpty();
			}
		}
	}

	private void OnClickItem(int index)
	{
		RepeatedField<int> repeatedField = G.localPlayer?.Profile?.EscInfo?.ShowCharacterIds;
		if (((repeatedField != null && index >= 0 && index < repeatedField.Count && repeatedField[index] != 0) ? 1 : 0) > (false ? 1 : 0))
		{
			if (index != _selectedIndex)
			{
				SelectItem(index);
			}
		}
		else
		{
			OpenQuickView();
		}
	}

	private void InitButtons()
	{
		CopyUID.SetBtnClick(OnClickCopyUIDButtonHandle);
		btn_edit_name.SetBtnClick(OnClickRenameButtonHandle);
		ChangeSignature.SetBtnClick(OnClickChangeSignatureButtonHandle);
		ChangeHead.SetBtnClick(OnClickChangeHeadButtonHandle);
		Btn_WorldLevelAndPlayerLevelTips.SetBtnClick(OpenWorldLevelAndPlayerLevelTips);
		btn_more.SetBtnClick(OnClickMoreButtonHandle);
		btn_more_dropdown_mask.SetBtnClick(CloseMoreDropdown);
		btn_personalize.SetBtnClick(OnClickMorePersonalizeButtonHandle);
		btn_rename.SetBtnClick(OnClickMoreRenameButtonHandle);
		btn_signature.SetBtnClick(OnClickMoreSignatureButtonHandle);
		btn_show_character.SetBtnClick(OnClickMoreShowCharacterButtonHandle);
		BtnClose.SetBtnClick(Close);
		BtnHideUI.SetBtnClick(OnHideUI);
		BtnEdit.SetBtnClick(OpenQuickView);
	}

	public void OpenQuickView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHARACTERQUICKSELECT);
	}

	private void OnHideUI()
	{
		isHide = !isHide;
		ApplyHideState();
	}

	public void CancelHideUI()
	{
		if (isHide)
		{
			isHide = false;
			ApplyHideState();
		}
	}

	private void ApplyHideState()
	{
		UIRoot.SetActive(!isHide);
		if (isHide)
		{
			ForceCloseMoreDropdown();
			ViewControlLayer?.UnFocus();
			MoreDropdownViewControlLayer?.UnFocus();
		}
		else if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			CharacterPresentationViewInputController controller = GetController();
			if (controller != null)
			{
				controller.ViewControlType = CharacterPresentationViewControlType.Main;
			}
			ChangeViewControlType(CharacterPresentationViewControlType.Main);
		}
	}

	private void ForceCloseMoreDropdown()
	{
		CharacterPresentationViewInputController controller = GetController();
		if (controller != null)
		{
			controller.ViewControlType = CharacterPresentationViewControlType.Main;
		}
		btn_more_dropdown_mask.gameObject.SetActive(value: false);
		MoreDropdownPanel.SetActive(value: false);
	}

	public void ToggleHideUI()
	{
		BtnHideUI.OnSubmit(null);
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

	private void OnClickRenameButtonHandle()
	{
		if (!TryShowSystemLockTip(SystemType.Rename) && IsAccountDecorationUnlocked())
		{
			OpenChangeNameView();
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
	}

	private void OpenMoreDropdown()
	{
		MoreDropdownPanel.SetActive(value: true);
		btn_more_dropdown_mask.gameObject.SetActive(value: true);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			CharacterPresentationViewInputController controller = GetController();
			if (controller != null)
			{
				controller.ViewControlType = CharacterPresentationViewControlType.MoreDropdown;
			}
			ChangeViewControlType(CharacterPresentationViewControlType.MoreDropdown);
		}
	}

	public void CloseMoreDropdown()
	{
		CharacterPresentationViewInputController controller = GetController();
		bool num = controller != null && controller.ViewControlType == CharacterPresentationViewControlType.MoreDropdown && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		btn_more_dropdown_mask.gameObject.SetActive(value: false);
		MoreDropdownPanel.SetActive(value: false);
		if (num)
		{
			controller.ViewControlType = CharacterPresentationViewControlType.Main;
			ViewControlLayer.SetDefaultSelect(btn_more.GetComponent<ACT.ViewControl.SelectableEx>());
			ChangeViewControlType(CharacterPresentationViewControlType.Main);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (!isHide)
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
	}

	public void ChangeViewControlType(CharacterPresentationViewControlType controlType)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			switch (controlType)
			{
			case CharacterPresentationViewControlType.Main:
				MoreDropdownViewControlLayer?.UnFocus();
				ViewControlLayer?.ReFocus();
				break;
			case CharacterPresentationViewControlType.MoreDropdown:
				ViewControlLayer?.UnFocus();
				MoreDropdownViewControlLayer?.SetDefaultSelect(btn_personalize.GetComponent<ACT.ViewControl.SelectableEx>());
				MoreDropdownViewControlLayer?.ReFocus();
				break;
			}
		}
	}

	private void OpenWorldLevelAndPlayerLevelTips()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.WorldLevelExplanationClick);
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, new MonoJourneyTracesViewData
		{
			tabIndex = 0
		}).Forget();
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

	private void InitRedDots()
	{
		moreRedDot?.InitRedDot(RedDotPathDefine.EscMore, moreRedDot.redDotType);
		personalizeRedDot?.InitRedDot(RedDotPathDefine.AccountDecoration, personalizeRedDot.redDotType);
	}

	private void InitWorldLevelRedDot()
	{
		if (!(worldLevelRedDotItem == null))
		{
			if (worldLevelRedDotItem.displayAction == null)
			{
				worldLevelRedDotItem.displayAction = new SelfNodeActive();
			}
			worldLevelRedDotItem.InitRedDot(RedDotPathDefine.SystemGuide, worldLevelRedDotItem.redDotType);
		}
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
		}
		UID.text = $"UID  {briefUserInfo.AccountId}";
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
		WorldLevelText.SetText("{0:0}", Model<WorldLevelModel>.Interface.GetCurWorldLevel());
		Btn_WorldLevelAndPlayerLevelTips.gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide));
		RefreshAccountDecorationDisplay();
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
		}
		else
		{
			SetBImageActive(_titleImage, active: false);
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

	protected override void UnInit()
	{
		base.UnInit();
		HeadFrame?.UnLoad();
		HeadFrameUpper?.UnLoad();
		ViewControlLayer?.UnFocus();
		MoreDropdownViewControlLayer?.UnFocus();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChangeShowCharacter, OnChangeShowCharacter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
	}
}
