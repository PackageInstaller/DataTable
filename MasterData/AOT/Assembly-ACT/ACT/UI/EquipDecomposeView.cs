using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.UI.ItemDetail;
using ACT.UI.ItemDetail.Interface;
using ACT.UI.ItemDetail.Styles;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipDecomposeView : BaseUIView<EquipDecomposeViewInputController>
{
	public CommonScrollBagComponent m_EquipScrollView;

	public CommonItemDetail m_EquipDetailComp;

	public CommonNumberComponent SelectCount;

	public ActButton Filter;

	public ActButton Reverse;

	public ActButton m_QuickFill;

	public List<CommonCoinComponent> m_Dissolve;

	public ActButton m_DissolveButton;

	public GameObject m_EmptyTip;

	public InventoryFilterView InventoryFilterView;

	public BetterAnimation InventoryFilterAnimation;

	public BetterAnimation BottomAnimation;

	public GameObject GamepadTipsRoot;

	public Dictionary<EquipDecomposeViewControllerType, List<GameObject>> InventoryViewControlDownPromts;

	public Dictionary<EquipDecomposeViewControllerType, List<GameObject>> InventoryViewControlPromts;

	public Dictionary<EquipDecomposeViewControllerType, ViewControlLayer> InventoryViewControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	public TextMeshProUGUI GamepadSelectPromtText;

	public GameObject PromptY;

	private List<ItemUnifierProxy> m_oriEquips;

	private List<ItemUnifierProxy> m_Equips;

	private List<ItemUnifierProxy> m_GetItems;

	private Dictionary<FilterType, List<int>> filterDic;

	private int m_ClickedIndex;

	private EquipDecomposeViewData m_data;

	private EquipDecomposeViewControllerType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	private void Awake()
	{
		m_oriEquips = ListPool<ItemUnifierProxy>.Get();
		m_Equips = ListPool<ItemUnifierProxy>.Get();
		m_GetItems = ListPool<ItemUnifierProxy>.Get();
		filterDic = DictionaryPool<FilterType, List<int>>.Get();
		m_DissolveButton.SetBtnClick(DoDissolve, "event:/UI/Interface/Bag/Break_Click");
		Filter.SetBtnClick(OnClickFilterBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		m_QuickFill.SetBtnClick(QuickFill, "event:/UI/Interface/Bag/Below_Click");
		Reverse.SetBtnClick(OnReverse, "event:/UI/Interface/Bag/Below_Click");
		m_EquipDetailComp.TopStylePostProcess = null;
		CommonItemDetail equipDetailComp = m_EquipDetailComp;
		equipDetailComp.TopStylePostProcess = (Action<IStyle>)Delegate.Combine(equipDetailComp.TopStylePostProcess, (Action<IStyle>)((IStyle style) =>
		{
			if (style is CommonStyle commonStyle)
			{
				commonStyle.lockBtn.CanLock = null;
				EquipGemIsLockBtn lockBtn = commonStyle.lockBtn;
				lockBtn.CanLock = (Func<int, bool>)Delegate.Combine(lockBtn.CanLock, new Func<int, bool>(CanLockEquip));
			}
		}));
	}

	protected override void OnUnityDestroy()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(m_Equips);
		ListPool<ItemUnifierProxy>.Release(m_Equips);
		m_Equips = null;
		ItemUnifierProxy.ItemUnifierPool.Release(m_oriEquips);
		ListPool<ItemUnifierProxy>.Release(m_oriEquips);
		m_oriEquips = null;
		ItemUnifierProxy.ItemUnifierPool.Release(m_GetItems);
		ListPool<ItemUnifierProxy>.Release(m_GetItems);
		m_GetItems = null;
		DictionaryPool<FilterType, List<int>>.Release(filterDic);
		filterDic = null;
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Main);
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		CommonItemDetail equipDetailComp = m_EquipDetailComp;
		equipDetailComp.OnInputStateChanged = (Action)Delegate.Combine(equipDetailComp.OnInputStateChanged, new Action(OnItemDetailInputStateChanged));
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		CommonItemDetail equipDetailComp = m_EquipDetailComp;
		equipDetailComp.OnInputStateChanged = (Action)Delegate.Remove(equipDetailComp.OnInputStateChanged, new Action(OnItemDetailInputStateChanged));
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitEquips();
		InventoryFilterView.gameObject.SetActive(value: false);
	}

	private void InitEquips()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(m_oriEquips);
		foreach (Equip item in CharacterDependHelper.GetCurWorldAllEquip())
		{
			if (CanAddToBag(item))
			{
				m_oriEquips.Add(ItemUnifierProxy.ItemUnifierPool.Get(item));
			}
		}
		m_oriEquips.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.SortEquip(y.As<Equip>(), x.As<Equip>()));
		m_Equips = m_oriEquips;
		RefreshEquips();
		UpdateSelectedNumber();
		FillDissolveMaterials();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (BottomAnimation != null)
		{
			BottomAnimation.GetSequence("show")?.Play();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Break_Animation");
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		m_EquipScrollView.SelectedModels.Clear();
		base.UnInit();
		m_ClickedIndex = 0;
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void RefreshEquips()
	{
		m_EmptyTip.SetActive(m_Equips.Count == 0);
		UpdateEquipDetailPanel(null);
		if (m_Equips.Count == 0)
		{
			m_EquipScrollView.gameObject.SetActive(value: false);
			m_EquipScrollView.OnItemShow = null;
			m_EquipScrollView.OnItemSelect = null;
			m_EquipScrollView.OnItemUnSelect = null;
			m_EquipScrollView.SelectedModels.Clear();
			UpdateSelectedNumber();
			return;
		}
		m_EquipScrollView.gameObject.SetActive(value: true);
		m_EquipScrollView.Station = Station;
		m_EquipScrollView.OnItemShow = null;
		m_EquipScrollView.OnItemSelect = null;
		m_EquipScrollView.OnItemUnSelect = null;
		m_EquipScrollView.ItemSource = m_Equips;
		m_EquipScrollView.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
		m_EquipScrollView.ItemShowType = ItemUIComponentBase.InitType.EquipDissolveStyle;
		CommonScrollBagComponent equipScrollView = m_EquipScrollView;
		equipScrollView.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
			{
				l.IsHighLight = l.Index == m_ClickedIndex;
			}
		}));
		CommonScrollBagComponent equipScrollView2 = m_EquipScrollView;
		equipScrollView2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView2.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			Equip equip = l.ItemUnifier.As<Equip>();
			UpdateEquipDetailPanel(equip);
			if (m_EquipScrollView.SelectedModels.Count > RuntimeConfigs.data.game.equipRecycleLimit)
			{
				m_EquipScrollView.SelectedModels.Remove(l.ItemUnifier);
				GameUtility.OpenToolTip(41000063);
			}
			else if (equip.IsLock)
			{
				m_EquipScrollView.SelectedModels.Remove(l.ItemUnifier);
				GameUtility.OpenToolTip(41000065);
			}
			else
			{
				UpdateSelectedNumber();
				FillDissolveMaterials();
				m_ClickedIndex = l.Index;
				UpdateButtonStyle();
			}
		}));
		CommonScrollBagComponent equipScrollView3 = m_EquipScrollView;
		equipScrollView3.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(equipScrollView3.OnItemUnSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			UpdateSelectedNumber();
			FillDissolveMaterials();
			UpdateButtonStyle();
		}));
		UpdateButtonStyle();
		UpdateSelectedNumber();
		UpdateEquipDetailPanel(m_Equips[0].As<Equip>());
	}

	private void UpdateEquipDetailPanel(Equip target)
	{
		if (target == null)
		{
			m_EquipDetailComp.gameObject.SetActive(value: false);
			return;
		}
		m_EquipDetailComp.gameObject.SetActive(value: true);
		m_EquipDetailComp.Station = Station;
		m_EquipDetailComp.Context = target;
	}

	private bool CanAddToBag(Equip equip)
	{
		if (equip.WearCharacter != 0)
		{
			return false;
		}
		bool flag = false;
		foreach (GemSlot gemSlot in equip.GemSlots)
		{
			if (gemSlot.GemId != 0)
			{
				flag = true;
			}
		}
		return !flag;
	}

	private void UpdateSelectedNumber()
	{
		SelectCount.UpdateNumber(m_EquipScrollView.SelectedModels.Count, RuntimeConfigs.data.game.equipRecycleLimit);
	}

	private void FillDissolveMaterials()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(m_GetItems);
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			foreach (ItemKv item in CoreUtils.GetData(selectedModel.GetItemData(RuntimeConfigs.data.equipDatas).GetLevelMaterialId(selectedModel.As<Equip>().Level), RuntimeConfigs.data.equipMaterialDatas).RecyclingLv)
			{
				ItemUnifierProxy itemUnifierProxy = m_GetItems.Find((ItemUnifierProxy x) => x.Id == item.id);
				if (itemUnifierProxy != null)
				{
					itemUnifierProxy.Count += item.count;
				}
				else
				{
					m_GetItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
				}
			}
		}
		for (int num = 0; num < m_Dissolve.Count; num++)
		{
			if (num < m_GetItems.Count)
			{
				m_Dissolve[num].gameObject.SetActive(value: true);
				m_Dissolve[num].Refresh(new ItemKv(m_GetItems[num].Id, (int)m_GetItems[num].Count));
			}
			else
			{
				m_Dissolve[num].gameObject.SetActive(value: false);
			}
		}
	}

	private void ClearEquips()
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.IsChosen = false;
				itemUIComponentBase.UpdatePerformance();
			}
		}
		m_EquipScrollView.ClearSelectedModelWithoutNotify();
		UpdateSelectedNumber();
		FillDissolveMaterials();
		UpdateButtonStyle();
	}

	private void UpdateButtonStyle()
	{
		m_DissolveButton.Interactable(m_EquipScrollView.SelectedModels.Count > 0);
		PromptY.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && m_EquipScrollView.SelectedModels.Count > 0);
	}

	public void DoDissolve()
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.As<Equip>().Level >= 1)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
				{
					titleId = 0,
					commonId = 41000064,
					OnConfirm = () =>
					{
						OpenRecoveryPanel(m_EquipScrollView.SelectedModels.ToList());
					}
				});
				return;
			}
		}
		OpenRecoveryPanel(m_EquipScrollView.SelectedModels.ToList());
	}

	private void OpenRecoveryPanel(List<ItemUnifierProxy> itemUnifierProxies)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RECOVERYITEM, new RecoveryItemViewData
		{
			RecoveryItems = itemUnifierProxies,
			OnRecovery = () =>
			{
				ClearEquips();
				InitEquips();
				Model<InventoryModel>.Interface.UpdateItemCount();
			},
			IsEquipDecompose = true
		});
	}

	private bool CanLockEquip(int uid)
	{
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.As<Equip>().Uid == uid)
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CannotUnlock);
				return false;
			}
		}
		return true;
	}

	public void QuickFill()
	{
		if (m_EquipScrollView.SelectedModels.Count >= RuntimeConfigs.data.game.equipRecycleLimit || m_EquipScrollView.SelectedModels.Count >= m_Equips.Count)
		{
			return;
		}
		int num = m_EquipScrollView.SelectedModels.Count;
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>(m_Equips.Count);
		list.AddRange(m_Equips);
		list.Sort(Model<InventoryModel>.Interface.QuickFillItemSort);
		foreach (ItemUnifierProxy item in list)
		{
			if (!m_EquipScrollView.SelectedModels.Contains(item) && !item.As<Equip>().IsLock)
			{
				m_EquipScrollView.AddSelectedModelWithoutNotify(item);
				num++;
				if (num >= RuntimeConfigs.data.game.equipRecycleLimit)
				{
					break;
				}
			}
		}
		foreach (ItemUnifierProxy selectedModel in m_EquipScrollView.SelectedModels)
		{
			if (selectedModel.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.IsChosen = true;
				itemUIComponentBase.UpdatePerformance();
			}
		}
		UpdateSelectedNumber();
		UpdateButtonStyle();
		FillDissolveMaterials();
	}

	private void OnClickFilterBtnHandle()
	{
		InventoryFilterView.gameObject.SetActive(value: true);
		InventoryFilterView.RefreshUI(this, InventoryTab.Equip, MonoInventoryView.InventoryState.Decompose, filterDic);
		if (InventoryFilterAnimation != null)
		{
			InventoryFilterAnimation.GetSequence("Show")?.Play();
		}
		ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Filter);
	}

	public void OnFilter(Dictionary<FilterType, List<int>> filterDic)
	{
		m_Equips = Model<InventoryModel>.Interface.FilterItems(m_oriEquips, filterDic);
		for (int num = m_EquipScrollView.SelectedModels.Count - 1; num >= 0; num--)
		{
			if (!m_Equips.Contains(m_EquipScrollView.SelectedModels[num]))
			{
				m_EquipScrollView.SelectedModels.RemoveAt(num);
			}
		}
		RefreshEquips();
	}

	private void OnReverse()
	{
		m_Equips.Reverse();
		RefreshEquips();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		UpdateButtonStyle();
		ChangeEquipDecomeposeViewControl(GetInventoryViewControlType(), reFocus: true);
	}

	private EquipDecomposeViewControllerType GetInventoryViewControlType()
	{
		if (InventoryFilterView.gameObject.activeSelf)
		{
			return EquipDecomposeViewControllerType.Filter;
		}
		return EquipDecomposeViewControllerType.Main;
	}

	public async void ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType equipDecomposeViewControllerType, bool reFocus = false)
	{
		await UniTask.DelayFrame(2);
		EquipDecomposeViewControllerType controlType = ControlType;
		ControlType = equipDecomposeViewControllerType;
		UpdateSubControllerState(equipDecomposeViewControllerType);
		FocusControLayer(controlType, equipDecomposeViewControllerType, reFocus);
		UpdateControlDownPromts(equipDecomposeViewControllerType);
		UpdateControlPromts(controlType, equipDecomposeViewControllerType);
		if (equipDecomposeViewControllerType != EquipDecomposeViewControllerType.Main)
		{
			GamepadSelectPromtText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774);
		}
		else if (EventSystemHelper.CurrentSelected != null)
		{
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			component.SetIsOn(val: true);
			UpdateEquipDetailPanel(component.ItemUnifier.As<Equip>());
		}
	}

	private void FocusControLayer(EquipDecomposeViewControllerType lastControlType, EquipDecomposeViewControllerType curControlType, bool reFocus)
	{
		if (curControlType != EquipDecomposeViewControllerType.ItemDetail)
		{
			if (reFocus)
			{
				InventoryViewControlLayerDic[curControlType].ReFocus();
				return;
			}
			InventoryViewControlLayerDic[lastControlType].UnFocus();
			InventoryViewControlLayerDic[curControlType].Focus();
		}
	}

	private void UpdateControlDownPromts(EquipDecomposeViewControllerType controlType)
	{
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in InventoryViewControlDownPromts[controlType])
		{
			item.SetActive(value: true);
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
	}

	private void UpdateControlPromts(EquipDecomposeViewControllerType lastControlType, EquipDecomposeViewControllerType curControlType)
	{
		for (int i = 0; i < InventoryViewControlPromts[lastControlType].Count; i++)
		{
			InventoryViewControlPromts[lastControlType][i].SetActive(value: false);
		}
		for (int j = 0; j < InventoryViewControlPromts[curControlType].Count; j++)
		{
			InventoryViewControlPromts[curControlType][j].SetActive(value: true);
		}
	}

	private void UpdateSubControllerState(EquipDecomposeViewControllerType controlType)
	{
		switch (controlType)
		{
		case EquipDecomposeViewControllerType.ItemDetail:
			break;
		case EquipDecomposeViewControllerType.Main:
			if (!m_EquipDetailComp.IsFocused)
			{
				m_EquipDetailComp.FocusIn();
			}
			break;
		default:
			if (m_EquipDetailComp.IsFocused)
			{
				m_EquipDetailComp.FocusOut();
			}
			break;
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
		if (ControlType == EquipDecomposeViewControllerType.Main)
		{
			ScrollTargetToShow(EventSystemHelper.CurrentSelected.transform, 190f);
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			component.SetIsOn(val: true);
			UpdateEquipDetailPanel(component.ItemUnifier.As<Equip>());
			GamepadSelectPromtText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, component.IsChosen ? 14 : 774);
		}
	}

	private void ScrollTargetToShow(Transform target, float scrollToShowOffset)
	{
		LoopScrollRect componentInParent = target.GetComponentInParent<LoopScrollRect>();
		if (componentInParent != null)
		{
			TargetToShow(target, componentInParent.viewport, componentInParent.content, componentInParent.vertical, componentInParent.horizontal, scrollToShowOffset);
			componentInParent.UpdateBounds(updateItems: true);
		}
		ScrollRect componentInParent2 = target.GetComponentInParent<ScrollRect>();
		if (componentInParent2 != null)
		{
			TargetToShow(target, componentInParent2.viewport, componentInParent2.content, componentInParent2.vertical, componentInParent2.horizontal, scrollToShowOffset);
		}
	}

	private void TargetToShow(Transform target, RectTransform viewport, RectTransform content, bool vertical, bool horizontal, float showOffset)
	{
		RectTransform component = target.GetComponent<RectTransform>();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(viewport, RectTransformUtility.WorldToScreenPoint(null, target.position), null, out var localPoint);
		Vector2 zero = Vector2.zero;
		if (vertical)
		{
			float num = localPoint.y + component.rect.yMin;
			float num2 = localPoint.y + component.rect.yMax;
			if (num2 > viewport.rect.yMax)
			{
				zero.y = num2 - viewport.rect.yMax + showOffset;
			}
			else if (num < viewport.rect.yMin)
			{
				zero.y = num - viewport.rect.yMin - showOffset;
			}
		}
		if (horizontal)
		{
			float num3 = localPoint.x + component.rect.xMin;
			float num4 = localPoint.x + component.rect.xMax;
			if (num3 < viewport.rect.xMin)
			{
				zero.x = num3 - viewport.rect.xMin + showOffset;
			}
			else if (num4 > viewport.rect.xMax)
			{
				zero.x = num4 - viewport.rect.xMax - showOffset;
			}
		}
		content.anchoredPosition -= zero;
	}

	public void HandleConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnItemDetailInputStateChanged()
	{
		if (m_EquipDetailComp.InputState == ItemDetailGamePadInputState.Item_NoFocus)
		{
			EquipDecomposeViewControllerType equipDecomposeViewControllerType = ((ControlType == EquipDecomposeViewControllerType.ItemDetail) ? GetInventoryViewControlType() : ControlType);
			ChangeEquipDecomeposeViewControl(equipDecomposeViewControllerType, reFocus: true);
		}
		else
		{
			ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.ItemDetail);
		}
	}
}
