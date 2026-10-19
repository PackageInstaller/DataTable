using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Lumin.LoungeSystem;
using Lumin.LoungeSystem.UI;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class UI_GiveGiftView : BaseUIView<GiveGiftViewInputInputController>
{
	private UI_GiveGiftViewData m_data;

	[SerializeField]
	private CommonScrollBagComponent scrollBag;

	[SerializeField]
	private ActButton btn_SendGift;

	[SerializeField]
	private ActButton btn_DisableSendGift;

	[SerializeField]
	private TextMeshProUGUI _giftGivingTxt;

	[SerializeField]
	private TextMeshProUGUI _giftGivingLimitTxt;

	[SerializeField]
	private LocalizeStringEvent _giftGivingLimitTxtLocalize;

	[SerializeField]
	private FavorabilityProgressPreviewComponent _favorabilityProgressPreviewComponent;

	[SerializeField]
	private FavorabilityUpgradeGroup _favorabilityUpgradeGroup;

	[SerializeField]
	private LoungeConversation _loungeConversation;

	[SerializeField]
	private ActButton emptyClickArea;

	[SerializeField]
	private RectTransform giftListTitle;

	[SerializeField]
	private RectTransform giftListEmptyTips;

	[SerializeField]
	private ActButton btn_hide;

	[SerializeField]
	private GameObject btn_hideGO;

	[SerializeField]
	private CanvasGroup _giftGivingCanvasGroup;

	[SerializeField]
	private GameObject _upGradeRoot;

	[SerializeField]
	private BImage characterIcon;

	[SerializeField]
	private LocalizeStringEvent characterNameLocalize;

	[SerializeField]
	private ActButton showAllHideBtn;

	[SerializeField]
	private GameObject topGiftDetailGroup;

	[SerializeField]
	private GameObject notSelectGiftRoot;

	[SerializeField]
	private BImage giftImage;

	[SerializeField]
	private TextMeshProUGUI _giftNameTxt;

	[SerializeField]
	private TextMeshProUGUI _giftfavorabilityNameTxt;

	[SerializeField]
	private BImage giftFavorabilityIcon;

	[SerializeField]
	private ActButton btn_close;

	[SerializeField]
	private GameObject giftUIParticleRoot;

	[SerializeField]
	public GameObject prompBoard;

	[Tooltip("A键")]
	public OperateBtnPrompt operateBtnPromptA;

	[Tooltip("B键")]
	public OperateBtnPrompt operateBtnPromptB;

	[Tooltip("X键")]
	public OperateBtnPrompt operateBtnPromptX;

	[Tooltip("Y键")]
	public OperateBtnPrompt operateBtnPromptY;

	private int characterId;

	private List<ItemUnifierProxy> items = new List<ItemUnifierProxy>();

	private Dictionary<int, int> selectedGiftCountDict = new Dictionary<int, int>();

	private int curSelectedGiftCount;

	private int pointId;

	private const int GIVEGIFTSYSTEMOPENID = 10452;

	private bool isHideView;

	private int curSendGiftCount;

	private bool isDirty;

	private int _curSelectedGiftId;

	private bool _gamepadPromptInited;

	private int _hideViewFrame = -1;

	private int _lastGamepadFocusedGiftIndex = -1;

	private int _gamepadFocusRequestId;

	private bool _giftFeedbackActive;

	private readonly StringBuilder _giftLimitTextBuilder = new StringBuilder(32);

	private LoopScrollRect _giftLoopScrollRect;

	private GridLayoutGroup _giftGridLayoutGroup;

	private const int LocalizeIDA = 13;

	private const int LocalizeIDB = 606;

	public bool IsGamepadMode => MonoECS.instance.InputMode == DeviceInputMode.Gamepad;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SendGiftGotLikeability, OnRefreshView);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SendGiftGotLikeability, OnRefreshView);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as UI_GiveGiftViewData;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void Init()
	{
		base.Init();
		_lastGamepadFocusedGiftIndex = -1;
		_gamepadFocusRequestId++;
		characterId = LoungeUIScene.instance.PendingClickCharacterId;
		CacheGiftListComponents();
		SetUIInteractable(interactable: true);
		RefreshOther();
		RefreshGiftList(isShowAnimation: true);
		RefreshGiftGivingLimitTxt();
		RefreshBtn();
		RefreshGiftDetailPanel();
		Model<FavorabilityModel>.Interface.BeforeSendGiftFavorLevel = Model<FavorabilityModel>.Interface.CurLikeabilityLv;
		Model<FavorabilityModel>.Interface.BeforeSendGiftFavorValue = Model<FavorabilityModel>.Interface.CurLikeabilityExp;
		_favorabilityProgressPreviewComponent.InitFavorabilityUI(Station);
		btn_SendGift.SetBtnClick(SendGiftReq);
		emptyClickArea.SetBtnClick(EmptyClickArea);
		btn_hide.SetBtnClick(HideView);
		showAllHideBtn.SetBtnClick(ShowHideGameobject);
		btn_close.SetBtnClick(Close);
		emptyClickArea.gameObject.SetActive(value: false);
		_favorabilityUpgradeGroup.gameObject.SetActive(value: false);
		_loungeConversation.Init();
		btn_hideGO.gameObject.SetActive(value: true);
		showAllHideBtn.gameObject.SetActive(value: false);
		InitGamePadPromptBindings();
		SetGamePadTipsActive(IsGamepadMode);
		if (IsGamepadMode)
		{
			ScheduleFocusFirstGiftAfterListReady();
		}
	}

	private void RefreshOther()
	{
		SystemOpen data = CoreUtils.GetData(10452, RuntimeConfigs.data.systemOpens);
		_giftGivingTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.localNameId);
	}

	private void RefreshGiftDetailPanel()
	{
		bool flag = _curSelectedGiftId != 0;
		topGiftDetailGroup.SetActive(flag);
		notSelectGiftRoot.SetActive(!flag);
		if (!flag)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(_curSelectedGiftId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			Station.LoadItemIconAsync(data.iconAddress, giftImage).Forget();
			_giftNameTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal);
			characterId = LoungeUIScene.instance.PendingClickCharacterId;
			int giftPreference = (int)Model<FavorabilityModel>.Interface.GetGiftPreference(_curSelectedGiftId, characterId);
			Station.LoadImageAsync(177, giftPreference, giftFavorabilityIcon).Forget();
			giftUIParticleRoot.SetActive(giftPreference != 0);
			PresentFavorability data2 = CoreUtils.GetData(3 - giftPreference, RuntimeConfigs.data.presentFavorabilitys);
			if (data2 != null)
			{
				_giftfavorabilityNameTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data2.name);
			}
		}
	}

	private void HideView()
	{
		isHideView = true;
		_hideViewFrame = Time.frameCount;
		CacheGamepadFocusedGiftIndex();
		ClearGamepadGiftListSelection();
		_gamepadFocusRequestId++;
		_giftGivingCanvasGroup.gameObject.SetActive(value: false);
		_upGradeRoot.SetActive(value: false);
		btn_hideGO.gameObject.SetActive(value: false);
		showAllHideBtn.gameObject.SetActive(value: true);
		RefreshGamepadOperatePrompts();
		RefreshVisibleGiftGamepadRtPrompts();
	}

	private void ShowHideGameobject()
	{
		isHideView = false;
		_giftGivingCanvasGroup.gameObject.SetActive(value: true);
		_upGradeRoot.SetActive(value: true);
		showAllHideBtn.gameObject.SetActive(value: false);
		btn_hideGO.gameObject.SetActive(value: true);
		RefreshGamepadOperatePrompts();
		if (IsGamepadMode)
		{
			RestoreLastGamepadScrollSelection();
		}
	}

	private void EmptyClickArea()
	{
		if (!isHideView)
		{
			FinishGiftFeedback();
		}
	}

	private void FinishGiftFeedback()
	{
		_giftFeedbackActive = false;
		_giftGivingCanvasGroup.alpha = 1f;
		_favorabilityUpgradeGroup.StopAndHide();
		betterAnimation.GetSequence("TabShow")?.Play();
		_loungeConversation.Close();
		emptyClickArea.gameObject.SetActive(value: false);
		RefreshBtn();
		RefreshGamepadOperatePrompts();
		if (IsGamepadMode)
		{
			RefreshGamepadScrollSelection();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		if (IsGamepadMode)
		{
			SetGamePadTipsActive(active: true);
		}
	}

	private void RefreshGiftGivingLimitTxt()
	{
		(int, int) todaySendGiftCount = Model<FavorabilityModel>.Interface.GetTodaySendGiftCount();
		(curSendGiftCount, _) = todaySendGiftCount;
		SetGiftGivingLimitText(todaySendGiftCount.Item1, todaySendGiftCount.Item2);
	}

	private void SetGiftGivingLimitText(int currentCount, int maxCount)
	{
		_giftLimitTextBuilder.Clear();
		_giftLimitTextBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2348));
		_giftLimitTextBuilder.Append(currentCount);
		_giftLimitTextBuilder.Append('/');
		_giftLimitTextBuilder.Append(maxCount);
		_giftGivingLimitTxt.text = _giftLimitTextBuilder.ToString();
	}

	private void RefreshBtn()
	{
		int dailySentCharacterGiftCount = G.localPlayer.DailyData.DailySentCharacterGiftCount;
		int presentDailyMax = Model<FavorabilityModel>.Interface.GetPresentDailyMax();
		btn_SendGift.gameObject.SetActive(dailySentCharacterGiftCount < presentDailyMax);
		btn_DisableSendGift.gameObject.SetActive(dailySentCharacterGiftCount >= presentDailyMax);
		btn_SendGift.Interactable(selectedGiftCountDict.Count > 0);
		RefreshGamepadOperatePrompts();
	}

	private void RefreshGiftList(bool isShowAnimation)
	{
		scrollBag.Station = Station;
		scrollBag.ItemShowType = ItemUIComponentBase.InitType.FavorabilityGift;
		scrollBag.BeforeInstantiate = null;
		scrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		scrollBag.OnItemSelect = null;
		scrollBag.OnItemUnSelect = null;
		scrollBag.ResetPositionAfterUpdate = true;
		scrollBag.AnimName = (isShowAnimation ? "Show" : null);
		selectedGiftCountDict.Clear();
		scrollBag.SelectedModels.Clear();
		curSelectedGiftCount = 0;
		ItemUnifierProxy.ItemUnifierPool.Release(items);
		items = Model<FavorabilityModel>.Interface.GetGiftItemUnifier();
		Model<FavorabilityModel>.Interface.SortGiftsWithComparer(items);
		scrollBag.ItemSource = items;
		CommonScrollBagComponent commonScrollBagComponent = scrollBag;
		commonScrollBagComponent.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemSelect, new Action<ItemUIComponentBase>(OnGiftSelected));
		CommonScrollBagComponent commonScrollBagComponent2 = scrollBag;
		commonScrollBagComponent2.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent2.OnItemUnSelect, new Action<ItemUIComponentBase>(OnGiftUnSelected));
		bool flag = items != null && items.Count > 0;
		giftListTitle.gameObject.SetActive(flag);
		giftListEmptyTips.gameObject.SetActive(!flag);
	}

	private void OnGiftSelected(ItemUIComponentBase giftUI)
	{
		if ((object)giftUI == null)
		{
			return;
		}
		ItemUnifierProxy itemUnifier = giftUI.ItemUnifier;
		if (itemUnifier == null)
		{
			return;
		}
		_ = itemUnifier.Id;
		if (false)
		{
			return;
		}
		int num = (_curSelectedGiftId = giftUI.ItemUnifier.Id);
		selectedGiftCountDict.TryGetValue(num, out var value);
		int itemCount = G.localPlayer.Inventory.GetItemCount(num);
		int item = Model<FavorabilityModel>.Interface.GetTodaySendGiftCount().Item1;
		int presentDailyMax = Model<FavorabilityModel>.Interface.GetPresentDailyMax();
		if (item >= presentDailyMax)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TodaySendGiftCountMax);
			giftUI.IsChosen = value > 0;
			giftUI.showDetailPanel = false;
			giftUI.UpdatePerformance();
			return;
		}
		if (Model<FavorabilityModel>.Interface.GetCurrCharacterFavorabilityLevelIsMax(characterId))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterFavorMax);
			giftUI.IsChosen = value > 0;
			giftUI.showDetailPanel = false;
			giftUI.UpdatePerformance();
			return;
		}
		if (_favorabilityProgressPreviewComponent != null && _favorabilityProgressPreviewComponent.IsCurrentPreviewAtCap())
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterFavorMax);
			giftUI.IsChosen = value > 0;
			giftUI.showDetailPanel = false;
			giftUI.UpdatePerformance();
			return;
		}
		if (value <= 0)
		{
			curSelectedGiftCount++;
			if (curSelectedGiftCount + item > presentDailyMax)
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TodaySendGiftCountMax);
				curSelectedGiftCount--;
				giftUI.IsChosen = value > 0;
				giftUI.showDetailPanel = false;
				giftUI.UpdatePerformance();
				return;
			}
			selectedGiftCountDict[num] = 1;
			_favorabilityProgressPreviewComponent.SetSelectCount(num, 1);
			_favorabilityProgressPreviewComponent.UpdateFavorabilityUI(Station);
		}
		else
		{
			if (selectedGiftCountDict[num] >= itemCount)
			{
				return;
			}
			curSelectedGiftCount++;
			if (curSelectedGiftCount + item > presentDailyMax)
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TodaySendGiftCountMax);
				curSelectedGiftCount--;
				giftUI.IsChosen = value > 0;
				giftUI.showDetailPanel = false;
				giftUI.UpdatePerformance();
				return;
			}
			selectedGiftCountDict[num]++;
			_favorabilityProgressPreviewComponent.SetSelectCount(num, 1);
			_favorabilityProgressPreviewComponent.UpdateFavorabilityUI(Station);
		}
		RefreshSingleGiftCell(giftUI, num);
		RefreshBtn();
		RefreshPreviewGiftGivingLimitTxt();
		RefreshGiftDetailPanel();
	}

	private void OnGiftUnSelected(ItemUIComponentBase giftUI)
	{
		if ((object)giftUI == null)
		{
			return;
		}
		ItemUnifierProxy itemUnifier = giftUI.ItemUnifier;
		if (itemUnifier == null)
		{
			return;
		}
		_ = itemUnifier.Id;
		if (false)
		{
			return;
		}
		int id = giftUI.ItemUnifier.Id;
		bool flag = _curSelectedGiftId == id;
		if (selectedGiftCountDict.TryGetValue(id, out var value))
		{
			value--;
			selectedGiftCountDict[id] = value;
			curSelectedGiftCount--;
			if (curSelectedGiftCount < 0)
			{
				curSelectedGiftCount = 0;
			}
			_favorabilityProgressPreviewComponent.SetSelectCount(id, -1);
			_favorabilityProgressPreviewComponent.UpdateFavorabilityUI(Station);
			if (value <= 0)
			{
				selectedGiftCountDict.Remove(id);
				giftUI.IsHighLight = false;
				if (flag)
				{
					_curSelectedGiftId = 0;
				}
				for (int i = 0; i < scrollBag.SelectedModels.Count; i++)
				{
					ItemUnifierProxy itemUnifierProxy = scrollBag.SelectedModels[i];
					if (itemUnifierProxy != null && itemUnifierProxy.Id == id)
					{
						scrollBag.RemoveSelectedModelWithoutNotify(itemUnifierProxy);
						break;
					}
				}
			}
			RefreshSingleGiftCell(giftUI, id);
		}
		RefreshBtn();
		RefreshPreviewGiftGivingLimitTxt();
		RefreshGiftDetailPanel();
	}

	public void RefreshPreviewGiftGivingLimitTxt()
	{
		int num = curSendGiftCount + curSelectedGiftCount;
		if (num > RuntimeConfigs.data.game.presentDailyMax)
		{
			num = RuntimeConfigs.data.game.presentDailyMax;
		}
		SetGiftGivingLimitText(num, RuntimeConfigs.data.game.presentDailyMax);
	}

	private void RefreshSingleGiftCell(ItemUIComponentBase giftUI, int giftId)
	{
		if (giftUI is FavorabilityGiftUIComponent)
		{
			selectedGiftCountDict.TryGetValue(giftId, out var value);
			ItemUIComponentBase.ItemCountShowType itemCountShowType = ((value <= 0) ? ItemUIComponentBase.ItemCountShowType.OneSide : ItemUIComponentBase.ItemCountShowType.Both);
			giftUI.SetData(giftUI.ItemUnifier, value, ItemUIComponentBase.InitType.FavorabilityGift, itemCountShowType);
			giftUI.IsChosen = value > 0;
			giftUI.showDetailPanel = false;
			giftUI.UpdatePerformance();
			giftUI.gameObject.SetActive(value: true);
			RefreshVisibleGiftGamepadRtPrompts();
		}
	}

	private List<Item> GetSelectedGifts()
	{
		List<Item> list = new List<Item>(selectedGiftCountDict.Count);
		foreach (KeyValuePair<int, int> item in selectedGiftCountDict)
		{
			int key = item.Key;
			int value = item.Value;
			if (value > 0)
			{
				list.Add(new Item
				{
					Id = key,
					Count = value
				});
			}
		}
		return list;
	}

	private void SendGiftReq()
	{
		Model<FavorabilityModel>.Interface.BeforeSendGiftFavorLevel = Model<FavorabilityModel>.Interface.CurLikeabilityLv;
		Model<FavorabilityModel>.Interface.BeforeSendGiftFavorValue = Model<FavorabilityModel>.Interface.CurLikeabilityExp;
		int pendingClickCharacterId = LoungeUIScene.instance.PendingClickCharacterId;
		if (Model<FavorabilityModel>.Interface.GetCurrCharacterFavorabilityLevelIsMax(pendingClickCharacterId))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterFavorMax);
			ClearSelections();
			_favorabilityProgressPreviewComponent?.AfterSendGiftRefreshFavorabilityUI(Station);
			RefreshGiftGivingLimitTxt();
			RefreshBtn();
		}
		else
		{
			List<Item> selectedGifts = GetSelectedGifts();
			if (selectedGifts.Count == 0)
			{
				Debug.LogWarning("没有选中的礼物");
				return;
			}
			Singleton<LoungeSystemManager>.instance.GiveGift(pendingClickCharacterId, selectedGifts);
			SetUIInteractable(interactable: false);
		}
	}

	private void ClearSelections()
	{
		selectedGiftCountDict.Clear();
		scrollBag.ClearSelectedModelWithoutNotify();
		curSelectedGiftCount = 0;
	}

	private void CacheGiftListComponents()
	{
		if (!(scrollBag == null))
		{
			if ((object)_giftLoopScrollRect == null)
			{
				_giftLoopScrollRect = scrollBag.GetComponentInChildren<LoopScrollRect>();
			}
			if ((object)_giftGridLayoutGroup == null)
			{
				_giftGridLayoutGroup = scrollBag.GetComponentInChildren<GridLayoutGroup>();
			}
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		bool flag = mode == DeviceInputMode.Gamepad;
		SetGamePadTipsActive(flag);
		if (flag)
		{
			RefreshGamepadScrollSelection();
		}
	}

	private void InitGamePadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			ConfigurePrompt(operateBtnPromptA, "UI/Confirm", 13);
			ConfigurePrompt(operateBtnPromptB, "UI/Back", 606);
			ConfigurePrompt(operateBtnPromptX, "UI/UISpecial2", 0);
			ConfigurePrompt(operateBtnPromptY, "UI/UISpecial1", 0);
		}
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
		}
	}

	public void SetGamePadTipsActive(bool active)
	{
		bool flag = active && IsGamepadMode;
		prompBoard?.SetActive(flag);
		operateBtnPromptA?.SetVisible(flag);
		operateBtnPromptB?.SetVisible(flag);
		operateBtnPromptX?.SetVisible(flag);
		operateBtnPromptY?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptA?.RefreshIcon();
			operateBtnPromptB?.RefreshIcon();
			operateBtnPromptX?.RefreshIcon();
			operateBtnPromptY?.RefreshIcon();
		}
		RefreshGamepadOperatePrompts();
		RefreshVisibleGiftGamepadRtPrompts();
	}

	private void RefreshGamepadOperatePrompts()
	{
		if (IsGamepadMode)
		{
			if (isHideView)
			{
				prompBoard?.SetActive(value: false);
				operateBtnPromptA?.SetVisible(vis: false);
				operateBtnPromptB?.SetVisible(vis: false);
				operateBtnPromptX?.SetVisible(vis: false);
				operateBtnPromptY?.SetVisible(vis: false);
			}
			else
			{
				prompBoard?.SetActive(value: true);
				bool flag = IsGamepadInputBlocked();
				operateBtnPromptA?.SetVisible(!flag);
				operateBtnPromptB?.SetVisible(!flag);
				bool visible = !flag && ((btn_hideGO != null && btn_hideGO.activeSelf) || (showAllHideBtn != null && showAllHideBtn.gameObject.activeSelf));
				operateBtnPromptX?.SetVisible(visible);
				bool visible2 = !flag && btn_SendGift != null && btn_SendGift.gameObject.activeSelf && btn_SendGift.IsInteractable();
				operateBtnPromptY?.SetVisible(visible2);
				RefreshVisibleOperatePromptIcons();
			}
		}
	}

	private void RefreshVisibleOperatePromptIcons()
	{
		RefreshOperatePromptIconIfVisible(operateBtnPromptA);
		RefreshOperatePromptIconIfVisible(operateBtnPromptB);
		RefreshOperatePromptIconIfVisible(operateBtnPromptX);
		RefreshOperatePromptIconIfVisible(operateBtnPromptY);
	}

	private static void RefreshOperatePromptIconIfVisible(OperateBtnPrompt prompt)
	{
		if (prompt != null && prompt.CouldVisible())
		{
			prompt.RefreshIcon();
		}
	}

	private bool IsGamepadInputBlocked()
	{
		if (!isHideView)
		{
			if (emptyClickArea != null)
			{
				return emptyClickArea.gameObject.activeSelf;
			}
			return false;
		}
		return true;
	}

	private bool IsEmptyClickAreaActive()
	{
		if (emptyClickArea != null)
		{
			return emptyClickArea.gameObject.activeSelf;
		}
		return false;
	}

	public void ClearGamepadGiftListSelectionOnClose()
	{
		ClearGamepadGiftListSelection();
	}

	private void ClearGamepadGiftListSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ItemUIComponentBase componentInParent = currentSelected.GetComponentInParent<ItemUIComponentBase>();
			if (componentInParent != null && componentInParent.ItemType == ItemUIComponentBase.InitType.FavorabilityGift)
			{
				EventSystemHelper.SetSelectedGameObject(null);
			}
		}
	}

	private void ScheduleFocusFirstGiftAfterListReady()
	{
		if (!(scrollBag == null))
		{
			scrollBag.OnUpdateEnd = null;
			CommonScrollBagComponent commonScrollBagComponent = scrollBag;
			commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent.OnUpdateEnd, new Action(OnGiftListReadyFocusFirstForGamepad));
		}
	}

	private void OnGiftListReadyFocusFirstForGamepad()
	{
		scrollBag.OnUpdateEnd = null;
		if (IsGamepadMode)
		{
			ClearGamepadGiftListSelection();
			SelectGiftAtIndex(GetGamepadFocusFallbackIndex(), animateScroll: false);
		}
	}

	public void RefreshGamepadScrollSelection()
	{
		if (items == null || items.Count == 0 || scrollBag == null)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ItemUIComponentBase componentInParent = currentSelected.GetComponentInParent<ItemUIComponentBase>();
			if (componentInParent != null && componentInParent.ItemType == ItemUIComponentBase.InitType.FavorabilityGift && componentInParent.transform.IsChildOf(scrollBag.transform) && componentInParent.Index >= 0 && componentInParent.Index < items.Count)
			{
				_lastGamepadFocusedGiftIndex = componentInParent.Index;
				return;
			}
		}
		SelectGiftAtIndex(GetGamepadFocusFallbackIndex(), animateScroll: false);
	}

	public void TryAddFocusedGiftByGamepad()
	{
		if (IsGamepadMode && !IsGamepadInputBlocked())
		{
			ItemUIComponentBase itemUIComponentBase = ResolveFocusedGiftCell();
			if (itemUIComponentBase == null)
			{
				RefreshGamepadScrollSelection();
				itemUIComponentBase = ResolveFocusedGiftCell();
			}
			if (!(itemUIComponentBase == null))
			{
				SubmitGamepadTarget(itemUIComponentBase.gameObject, selectTarget: true);
				RefreshVisibleGiftGamepadRtPrompts();
				RefreshGamepadOperatePrompts();
			}
		}
	}

	public void TryCloseByGamepad()
	{
		if (IsGamepadMode && !IsGamepadInputBlocked())
		{
			SubmitGamepadButton(btn_close);
		}
	}

	public void TryToggleHideViewByGamepad()
	{
		if (IsGamepadMode && !IsGamepadInputBlocked())
		{
			if (showAllHideBtn != null && showAllHideBtn.gameObject.activeSelf)
			{
				SubmitGamepadButton(showAllHideBtn);
			}
			else if (btn_hideGO != null && btn_hideGO.activeSelf)
			{
				SubmitGamepadButton(btn_hide);
			}
		}
	}

	public void TryHandlePressAnyKeyByGamepad()
	{
		if (!IsGamepadMode)
		{
			return;
		}
		if (isHideView)
		{
			if (Time.frameCount != _hideViewFrame)
			{
				SubmitGamepadButton(showAllHideBtn);
			}
		}
		else if (IsEmptyClickAreaActive())
		{
			SubmitGamepadButton(emptyClickArea);
		}
	}

	public void TrySendGiftByGamepad()
	{
		if (IsGamepadMode && !IsGamepadInputBlocked())
		{
			if (btn_SendGift != null && btn_SendGift.gameObject.activeSelf && btn_SendGift.IsInteractable())
			{
				SubmitGamepadButton(btn_SendGift);
			}
			else if (btn_DisableSendGift != null && btn_DisableSendGift.gameObject.activeSelf)
			{
				SubmitGamepadButton(btn_DisableSendGift);
			}
		}
	}

	private static void SubmitGamepadTarget(GameObject target, bool selectTarget = false)
	{
		if (!(target == null) && target.activeInHierarchy)
		{
			if (selectTarget && EventSystemHelper.Available && EventSystemHelper.CurrentSelected != target)
			{
				EventSystemHelper.SetSelectedGameObject(target);
			}
			EventSystemHelper.Click(target);
		}
	}

	private static void SubmitGamepadButton(ActButton button)
	{
		SubmitGamepadTarget(button?.gameObject);
	}

	public void ExecuteGamepadNavigate(MoveDirection direction)
	{
		if (!IsGamepadInputBlocked())
		{
			switch (direction)
			{
			case MoveDirection.Up:
				MoveGiftSelectionVertical(-1);
				break;
			case MoveDirection.Down:
				MoveGiftSelectionVertical(1);
				break;
			case MoveDirection.Left:
				MoveGiftSelectionHorizontal(-1);
				break;
			case MoveDirection.Right:
				MoveGiftSelectionHorizontal(1);
				break;
			}
		}
	}

	private int GetGiftColumnCount()
	{
		if (scrollBag == null)
		{
			return 1;
		}
		CacheGiftListComponents();
		LoopScrollRect giftLoopScrollRect = _giftLoopScrollRect;
		if (giftLoopScrollRect != null && giftLoopScrollRect.contentConstraintCount > 0)
		{
			return giftLoopScrollRect.contentConstraintCount;
		}
		GridLayoutGroup giftGridLayoutGroup = _giftGridLayoutGroup;
		if (giftGridLayoutGroup != null && giftGridLayoutGroup.constraint == GridLayoutGroup.Constraint.FixedColumnCount)
		{
			return Mathf.Max(1, giftGridLayoutGroup.constraintCount);
		}
		return 1;
	}

	private bool TryGetCurrentGiftIndex(out int currentIndex)
	{
		currentIndex = -1;
		if (items == null || items.Count == 0)
		{
			return false;
		}
		ItemUIComponentBase itemUIComponentBase = ResolveFocusedGiftCell();
		if (itemUIComponentBase != null && itemUIComponentBase.Index >= 0 && itemUIComponentBase.Index < items.Count)
		{
			currentIndex = itemUIComponentBase.Index;
			_lastGamepadFocusedGiftIndex = currentIndex;
			return true;
		}
		currentIndex = GetGamepadFocusFallbackIndex();
		return currentIndex >= 0;
	}

	private void MoveGiftSelectionHorizontal(int direction)
	{
		if (!TryGetCurrentGiftIndex(out var currentIndex))
		{
			return;
		}
		int num = currentIndex + direction;
		if (num >= 0 && num < items.Count)
		{
			int giftColumnCount = GetGiftColumnCount();
			if (giftColumnCount <= 0 || currentIndex / giftColumnCount == num / giftColumnCount)
			{
				SelectGiftAtIndex(num);
			}
		}
	}

	private void MoveGiftSelectionVertical(int direction)
	{
		if (!TryGetCurrentGiftIndex(out var currentIndex))
		{
			return;
		}
		int giftColumnCount = GetGiftColumnCount();
		if (giftColumnCount <= 0)
		{
			return;
		}
		int count = items.Count;
		int num = currentIndex / giftColumnCount;
		int num2 = currentIndex % giftColumnCount;
		if (direction > 0)
		{
			int num3 = (num + 1) * giftColumnCount;
			if (num3 < count)
			{
				int b = Mathf.Min(num3 + giftColumnCount - 1, count - 1);
				int num4 = Mathf.Min(num3 + num2, b);
				if (num4 != currentIndex)
				{
					SelectGiftAtIndex(num4);
				}
			}
			return;
		}
		int num5 = num - 1;
		if (num5 >= 0)
		{
			int num6 = num5 * giftColumnCount;
			int num7 = Mathf.Min(num6 + giftColumnCount - 1, count - 1) - num6 + 1;
			int num8 = Mathf.Min(num2, num7 - 1);
			int num9 = num6 + num8;
			if (num9 >= 0 && num9 < count && num9 != currentIndex)
			{
				SelectGiftAtIndex(num9);
			}
		}
	}

	private bool IsGiftIndexInVisibleWindow(int index)
	{
		CacheGiftListComponents();
		LoopScrollRect giftLoopScrollRect = _giftLoopScrollRect;
		if (giftLoopScrollRect == null)
		{
			return true;
		}
		if (index >= giftLoopScrollRect.ItemIndexStart)
		{
			return index < giftLoopScrollRect.ItemIndexEnd;
		}
		return false;
	}

	private void SelectGiftAtIndex(int index, bool animateScroll = true)
	{
		if (scrollBag == null || items == null || index < 0 || index >= items.Count)
		{
			return;
		}
		_lastGamepadFocusedGiftIndex = index;
		int focusRequestId = ++_gamepadFocusRequestId;
		CacheGiftListComponents();
		LoopScrollRect giftLoopScrollRect = _giftLoopScrollRect;
		if (giftLoopScrollRect != null && !IsGiftIndexInVisibleWindow(index))
		{
			if (animateScroll)
			{
				giftLoopScrollRect.ScrollToCellWithinTime(index, 0.15f);
			}
			else
			{
				giftLoopScrollRect.ScrollToCell(index, 0f);
			}
		}
		else if ((giftLoopScrollRect != null) & animateScroll)
		{
			giftLoopScrollRect.ScrollToCellWithinTime(index, 0.15f);
		}
		FocusGiftCellAtIndex(index);
		if (scrollBag.GetItem(index) == null)
		{
			FocusGiftCellAfterScrollAsync(index, focusRequestId).Forget();
		}
	}

	private async UniTaskVoid FocusGiftCellAfterScrollAsync(int index, int focusRequestId)
	{
		for (int i = 0; i < 30; i++)
		{
			await UniTask.Yield();
			if (scrollBag == null || isHideView || focusRequestId != _gamepadFocusRequestId)
			{
				break;
			}
			if (scrollBag.GetItem(index) != null)
			{
				FocusGiftCellAtIndex(index);
				break;
			}
		}
	}

	private void FocusGiftCellAtIndex(int index)
	{
		ItemUIComponentBase item = scrollBag.GetItem(index);
		if (!(item == null))
		{
			_lastGamepadFocusedGiftIndex = index;
			EventSystemHelper.SetSelectedGameObject(item.gameObject);
			RefreshVisibleGiftGamepadRtPrompts();
		}
	}

	private void RestoreLastGamepadScrollSelection()
	{
		SelectGiftAtIndex(GetGamepadFocusFallbackIndex(), animateScroll: false);
	}

	private void CacheGamepadFocusedGiftIndex()
	{
		ItemUIComponentBase eventSystemFocusedGiftCell = GetEventSystemFocusedGiftCell();
		if (eventSystemFocusedGiftCell != null && eventSystemFocusedGiftCell.Index >= 0 && items != null && eventSystemFocusedGiftCell.Index < items.Count)
		{
			_lastGamepadFocusedGiftIndex = eventSystemFocusedGiftCell.Index;
		}
	}

	private int GetGamepadFocusFallbackIndex()
	{
		if (items == null || items.Count == 0)
		{
			return -1;
		}
		if (_lastGamepadFocusedGiftIndex < 0 || _lastGamepadFocusedGiftIndex >= items.Count)
		{
			return 0;
		}
		return _lastGamepadFocusedGiftIndex;
	}

	public void RefreshVisibleGiftGamepadRtPrompts()
	{
		if (scrollBag == null)
		{
			return;
		}
		ItemUIComponentBase focusedGiftCell = ((isHideView || !IsGamepadMode) ? null : GetEventSystemFocusedGiftCell());
		CacheGiftListComponents();
		LoopScrollRect giftLoopScrollRect = _giftLoopScrollRect;
		if (giftLoopScrollRect == null)
		{
			int num = 0;
			while (items != null && num < items.Count)
			{
				if (scrollBag.GetItem(num) is FavorabilityGiftUIComponent favorabilityGiftUIComponent)
				{
					favorabilityGiftUIComponent.ApplyGamepadReducePrompt(focusedGiftCell);
				}
				num++;
			}
			return;
		}
		for (int i = giftLoopScrollRect.ItemIndexStart; i < giftLoopScrollRect.ItemIndexEnd; i++)
		{
			if (scrollBag.GetItem(i) is FavorabilityGiftUIComponent favorabilityGiftUIComponent2)
			{
				favorabilityGiftUIComponent2.ApplyGamepadReducePrompt(focusedGiftCell);
			}
		}
	}

	public void TryReduceFocusedGiftByGamepad()
	{
		if (!IsGamepadMode || IsGamepadInputBlocked())
		{
			return;
		}
		ItemUIComponentBase itemUIComponentBase = ResolveFocusedGiftCell();
		if (itemUIComponentBase == null || !itemUIComponentBase.IsChosen)
		{
			return;
		}
		ItemUnifierProxy itemUnifier = itemUIComponentBase.ItemUnifier;
		if (itemUnifier == null)
		{
			return;
		}
		_ = itemUnifier.Id;
		if (false)
		{
			return;
		}
		int id = itemUIComponentBase.ItemUnifier.Id;
		if (selectedGiftCountDict.TryGetValue(id, out var value) && value > 0)
		{
			if (itemUIComponentBase is FavorabilityGiftUIComponent favorabilityGiftUIComponent && favorabilityGiftUIComponent.TrySubmitReduceButton())
			{
				RefreshVisibleGiftGamepadRtPrompts();
				RefreshGamepadOperatePrompts();
			}
			else
			{
				itemUIComponentBase.OnInvertClick();
			}
		}
	}

	private ItemUIComponentBase GetEventSystemFocusedGiftCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return null;
		}
		ItemUIComponentBase componentInParent = currentSelected.GetComponentInParent<ItemUIComponentBase>();
		if (componentInParent != null && componentInParent.ItemType == ItemUIComponentBase.InitType.FavorabilityGift)
		{
			return componentInParent;
		}
		return null;
	}

	public ItemUIComponentBase ResolveFocusedGiftCell()
	{
		ItemUIComponentBase eventSystemFocusedGiftCell = GetEventSystemFocusedGiftCell();
		if (eventSystemFocusedGiftCell != null)
		{
			return eventSystemFocusedGiftCell;
		}
		if (_curSelectedGiftId == 0 || !selectedGiftCountDict.ContainsKey(_curSelectedGiftId))
		{
			return null;
		}
		for (int i = 0; i < items.Count; i++)
		{
			if (items[i].Id == _curSelectedGiftId)
			{
				return scrollBag.GetItem(i);
			}
		}
		return null;
	}

	private void SetUIInteractable(bool interactable)
	{
		if (btn_SendGift != null)
		{
			btn_SendGift.Interactable(interactable);
		}
		if (scrollBag != null)
		{
			scrollBag.enabled = interactable;
		}
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		RefreshGiftList(isShowAnimation: false);
		RefreshGiftGivingLimitTxt();
		RefreshBtn();
		_favorabilityProgressPreviewComponent.AfterSendGiftRefreshFavorabilityUI(Station);
		_giftFeedbackActive = true;
		_giftGivingCanvasGroup.alpha = 0f;
		_favorabilityUpgradeGroup.UpdateView();
		_loungeConversation.Show(characterId, LoungeConversationType.ReceiveGiftType, OnLoungeConversationClose);
		emptyClickArea.gameObject.SetActive(value: true);
		RefreshGamepadOperatePrompts();
		ClearSelections();
		SetUIInteractable(interactable: true);
	}

	private void OnLoungeConversationClose()
	{
		if (_giftFeedbackActive)
		{
			_giftGivingCanvasGroup.alpha = 0f;
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		ClearGamepadGiftListSelectionOnClose();
		SetGamePadTipsActive(active: false);
		Model<FavorabilityModel>.Interface.GotLikeability = 0;
		isHideView = false;
		_giftFeedbackActive = false;
		_lastGamepadFocusedGiftIndex = -1;
		_gamepadFocusRequestId++;
		ItemUnifierProxy.ItemUnifierPool.Release(items);
		_loungeConversation.UnInit();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GiveGiftClose, null);
		_curSelectedGiftId = 0;
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
