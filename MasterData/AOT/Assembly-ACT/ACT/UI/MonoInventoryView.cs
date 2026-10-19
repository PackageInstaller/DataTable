using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.UI.ItemDetail;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoInventoryView : BaseUIView<InventoryViewInputController>
{
	public enum InventoryState
	{
		Normal,
		Decompose,
		Recovery
	}

	public TextMeshProUGUI Title;

	public CommonNumberComponent Capacity;

	public ActToggleGroup ActToggleGroup;

	public List<LocalizeStringEvent> normalTabName;

	public List<LocalizeStringEvent> selectTabName;

	public Canvas ScrollBagCanvas;

	public CommonScrollBagComponent CommonScrollBagComponent;

	public EquipUIComponent EquipUIComponent;

	public GemUIComponent GemUIComponent;

	public BloodBottleUIComponent BloodBottleUIComponent;

	public BloodBottleMaterialUIComponent BloodBottleMatUIComponent;

	public NormalItemUIComponent ItemUIComponent;

	public GameObject Nothing;

	public ActButton Filter;

	public ActButton Sort;

	public ActButton Reverse;

	public ActButton Decompose;

	public ActButton Recovery;

	public CommonItemDetail CommonItemDetail;

	public ActButton triggerCellBtn;

	public LocalizeStringEvent triggerCellBtnStr;

	public Canvas SubViewCanvas;

	public InventoryRecoveryView InventoryRecoveryView;

	public BetterAnimation InventoryRecoveryAnimation;

	public InventoryFilterView InventoryFilterView;

	public BetterAnimation InventoryFilterAnimation;

	public InventorySortView InventorySortView;

	public BetterAnimation InventorySortAnimation;

	public Canvas PromptCanvas;

	public GameObject GamepadTipsRoot;

	public Dictionary<InventoryViewControlType, List<GameObject>> InventoryViewControlDownPromts;

	public Dictionary<InventoryViewControlType, List<GameObject>> InventoryViewControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<InventoryViewControlType, ViewControlLayer> InventoryViewControlLayerDic;

	public GameObject MenuPrompt;

	public GameObject LBPrompt;

	public GameObject RBPrompt;

	public TextMeshProUGUI GamepadSelectPromtText;

	public float MainScrollToShowOffset = 190f;

	public float FilterScrollToShowOffset = 52f;

	public float SortScrollToShowOffset = 52f;

	[SerializeField]
	private InventoryFilterComp _inventoryFilterComp;

	private InventoryState inventoryState;

	private InventoryTab inventoryTab;

	private List<int> bagTabIDs;

	private List<ItemUnifierProxy> oriItems;

	private List<ItemUnifierProxy> curDisplayItems;

	private Dictionary<FilterType, List<int>> curFilterDic;

	private List<ItemUnifierProxy> lookRedpointItems;

	private int _selectItemId = -1;

	private Dictionary<InventoryTab, Dictionary<FilterType, List<int>>> recoveryFilterDic;

	private Dictionary<SortType, List<int>> recoverySortDic;

	private Dictionary<InventoryTab, List<ItemUnifierProxy>> recoverySelectItemDic;

	private ViewControlLayer CurrentViewControlLayer;

	private const int Use = 2465;

	private const int GoToBottleView = 2666;

	public InventoryState CurInventoryState
	{
		get
		{
			return inventoryState;
		}
		set
		{
			inventoryState = value;
			UpdateFilterDic();
		}
	}

	private InventoryViewControlType ControlType
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

	public bool IsAllowToMenu
	{
		get
		{
			if (inventoryTab != InventoryTab.Equip)
			{
				return inventoryTab == InventoryTab.Disk;
			}
			return true;
		}
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		ChangeInventoryViewControl(InventoryViewControlType.Main);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("BagShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Open");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("BagHide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Filter.SetBtnClick(OnClickFilterBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		Sort.SetBtnClick(OnClickSortBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		Reverse.SetBtnClick(OnClickReverseBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		Decompose.SetBtnClick(OnClickDecomposeBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		Recovery.SetBtnClick(OnClickRecovreryBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RefreshBagMiddle, RefreshMiddle);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemChangeEnd, RefreshMiddle);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterDependChange, RefreshMiddle);
		Model<InventoryModel>.Interface.ItemCountChange += InterfaceOnItemCountChange;
		CommonItemDetail commonItemDetail = CommonItemDetail;
		commonItemDetail.OnInputStateChanged = (Action)Delegate.Combine(commonItemDetail.OnInputStateChanged, new Action(OnItemDetailInputStateChanged));
	}

	private void InterfaceOnItemCountChange()
	{
		int count = Model<InventoryModel>.Interface.GetItemListByInventoryTab(inventoryTab).Count;
		int capacity = RuntimeConfigs.data.bags[(int)inventoryTab].capacity;
		Capacity.UpdateNumber(count, capacity);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RefreshBagMiddle, RefreshMiddle);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemChangeEnd, RefreshMiddle);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterDependChange, RefreshMiddle);
		Model<InventoryModel>.Interface.ItemCountChange -= InterfaceOnItemCountChange;
		CommonItemDetail commonItemDetail = CommonItemDetail;
		commonItemDetail.OnInputStateChanged = (Action)Delegate.Remove(commonItemDetail.OnInputStateChanged, new Action(OnItemDetailInputStateChanged));
	}

	protected override void Init()
	{
		base.Init();
		recoverySelectItemDic = DictionaryPool<InventoryTab, List<ItemUnifierProxy>>.Get();
		lookRedpointItems = ListPool<ItemUnifierProxy>.Get();
		bagTabIDs = RuntimeConfigs.data.bags.Keys.ToList();
		InitTabToggle();
		CurInventoryState = InventoryState.Normal;
		InventoryRecoveryView.gameObject.SetActive(value: false);
		InventoryFilterView.gameObject.SetActive(value: false);
		InventorySortView.gameObject.SetActive(value: false);
		ScrollBagCanvas.sortingLayerID = ContentCanvas.sortingLayerID;
		ScrollBagCanvas.sortingOrder = 1;
		SubViewCanvas.sortingLayerID = ContentCanvas.sortingLayerID;
		SubViewCanvas.sortingOrder = 2;
		PromptCanvas.sortingLayerID = ContentCanvas.sortingLayerID;
		PromptCanvas.sortingOrder = 3;
	}

	protected override void ReInit()
	{
		base.ReInit();
		inventoryTab = InventoryTab.None;
		InitTabToggle();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (lookRedpointItems.Count > 0)
		{
			Model<InventoryModel>.Interface.SetItemsRedDotState(inventoryTab, lookRedpointItems);
			lookRedpointItems.Clear();
		}
		DictionaryPool<InventoryTab, List<ItemUnifierProxy>>.Release(recoverySelectItemDic);
		recoverySelectItemDic.Clear();
		ListPool<ItemUnifierProxy>.Release(lookRedpointItems);
		inventoryTab = InventoryTab.None;
	}

	public void OnClickFilterBtnHandle()
	{
		InventoryFilterView.gameObject.SetActive(value: true);
		InventoryFilterView.RefreshUI(this, inventoryTab, inventoryState, curFilterDic);
		if (InventoryFilterAnimation != null)
		{
			InventoryFilterAnimation.GetSequence("Show")?.Play();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Window_Open");
		if (ControlType == InventoryViewControlType.Menu)
		{
			ChangeInventoryViewControl(InventoryViewControlType.Filter);
		}
	}

	public void OnClickSortBtnHandle()
	{
		InventorySortView.gameObject.SetActive(value: true);
		Dictionary<SortType, List<int>> dictionary = null;
		dictionary = ((inventoryState != InventoryState.Normal) ? recoverySortDic : Model<InventoryModel>.Interface.GetEquipSorts());
		InventorySortView.RefreshUI(this, dictionary);
		if (InventorySortAnimation != null)
		{
			InventorySortAnimation.GetSequence("show")?.Play();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Window_Open");
		if (GetController().ControlType == InventoryViewControlType.Menu)
		{
			ChangeInventoryViewControl(InventoryViewControlType.Sort);
		}
	}

	public void OnClickReverseBtnHandle()
	{
		Model<InventoryModel>.Interface.SetGemSortReverse();
		RefreshMiddle();
		if (inventoryState == InventoryState.Normal)
		{
			ChangeInventoryViewControl(InventoryViewControlType.Main);
		}
		else if (inventoryState == InventoryState.Recovery)
		{
			ChangeInventoryViewControl(InventoryViewControlType.Recovery);
		}
	}

	private void OnClickDecomposeBtnHandle()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPDECOMPOSE);
	}

	public void OnClickRecovreryBtnHandle()
	{
		recoveryFilterDic = new Dictionary<InventoryTab, Dictionary<FilterType, List<int>>>();
		recoveryFilterDic.Add(InventoryTab.Equip, DictionaryPool<FilterType, List<int>>.Get());
		recoveryFilterDic.Add(InventoryTab.Disk, DictionaryPool<FilterType, List<int>>.Get());
		recoverySortDic = DictionaryPool<SortType, List<int>>.Get();
		recoverySortDic.Add(SortType.Assist, ListPool<int>.Get());
		recoverySortDic.Add(SortType.SortRule, ListPool<int>.Get());
		recoverySortDic[SortType.Assist].Add(0);
		recoverySortDic[SortType.SortRule].Add(0);
		CurInventoryState = InventoryState.Recovery;
		curDisplayItems = oriItems;
		SortItemList(curDisplayItems);
		RefreshMiddle(curDisplayItems);
		_inventoryFilterComp.RefreshComp(null);
		InventoryRecoveryView.gameObject.SetActive(value: true);
		InventoryRecoveryView.RefreshUI(this);
		OnRecoveryItemChange();
		if (InventoryRecoveryAnimation != null)
		{
			InventoryRecoveryAnimation.GetSequence("show")?.Play();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Delete_Animation");
	}

	private void UpdateFilterDic()
	{
		if (inventoryState == InventoryState.Normal)
		{
			if (inventoryTab == InventoryTab.Equip)
			{
				curFilterDic = Model<InventoryModel>.Interface.GetEquipFilters();
			}
			else if (inventoryTab == InventoryTab.Disk)
			{
				curFilterDic = Model<InventoryModel>.Interface.GetGemFilters();
			}
			else
			{
				curFilterDic = DictionaryPool<FilterType, List<int>>.Get();
			}
		}
		else if (inventoryState == InventoryState.Recovery)
		{
			if (inventoryTab == InventoryTab.Equip || inventoryTab == InventoryTab.Disk)
			{
				curFilterDic = recoveryFilterDic[inventoryTab];
			}
			else
			{
				curFilterDic = DictionaryPool<FilterType, List<int>>.Get();
			}
		}
	}

	private void InitTabToggle()
	{
		int num = (int)((uiViewData == null) ? Model<InventoryModel>.Interface.InventoryTab : (uiViewData as MonoInventoryData).inventoryTab);
		if (!RuntimeConfigs.data.bags.TryGetValue(num, out var _))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"背包配置表中未找到页签ID为{num}的配置!");
			}
			return;
		}
		_selectItemId = ((uiViewData == null) ? (-1) : (uiViewData as MonoInventoryData).ItemId);
		ActToggleGroup.SetAllToggleOff();
		int selectIndex = CoreUtils.GetData(num, RuntimeConfigs.data.bags).Sequence - 1;
		ActToggleGroup.Init(selectIndex);
		for (int i = 0; i < normalTabName.Count; i++)
		{
			Bag data = CoreUtils.GetData(i + 1, RuntimeConfigs.data.bags);
			if (data != null)
			{
				normalTabName[i].StringReference.TableReference = "shortcommon";
				normalTabName[i].StringReference.TableEntryReference = data.name;
				selectTabName[i].StringReference.TableReference = "shortcommon";
				selectTabName[i].StringReference.TableEntryReference = data.name;
			}
		}
	}

	public void OnChangeBagTab(int inventoryTab)
	{
		InventoryTab inventoryTab2 = this.inventoryTab;
		InventoryTab inventoryTabBySequence = Model<InventoryModel>.Interface.GetInventoryTabBySequence(inventoryTab);
		if (this.inventoryTab == inventoryTabBySequence)
		{
			return;
		}
		this.inventoryTab = inventoryTabBySequence;
		Model<InventoryModel>.Interface.UpdateInventoryTab(inventoryTabBySequence);
		oriItems = Model<InventoryModel>.Interface.GetItemListByInventoryTab(this.inventoryTab);
		UpdateFilterDic();
		curDisplayItems = oriItems;
		curDisplayItems = GetFilterItems();
		RefreshMiddle(curDisplayItems, _selectItemId);
		if (_selectItemId > 0)
		{
			_selectItemId = -1;
		}
		bool itemsIsAllDisabled = Model<InventoryModel>.Interface.GetItemsIsAllDisabled(curDisplayItems);
		if (inventoryState == InventoryState.Recovery)
		{
			InventoryRecoveryView.gameObject.SetActive(!itemsIsAllDisabled);
			if (!itemsIsAllDisabled)
			{
				InventoryRecoveryView.OnChangeInventoryTab(this.inventoryTab);
			}
		}
		if (inventoryState == InventoryState.Normal)
		{
			switch (this.inventoryTab)
			{
			case InventoryTab.Equip:
				_inventoryFilterComp.RefreshComp(Model<InventoryModel>.Interface.GetEquipFilters());
				break;
			case InventoryTab.Disk:
				_inventoryFilterComp.RefreshComp(Model<InventoryModel>.Interface.GetGemFilters());
				break;
			default:
				_inventoryFilterComp.RefreshComp(null);
				break;
			}
		}
		else
		{
			_inventoryFilterComp.RefreshComp(null);
		}
		Filter.gameObject.SetActive(this.inventoryTab == InventoryTab.Equip || this.inventoryTab == InventoryTab.Disk);
		Sort.gameObject.SetActive(this.inventoryTab == InventoryTab.Equip);
		Reverse.gameObject.SetActive(this.inventoryTab == InventoryTab.Disk);
		Decompose.gameObject.SetActive(this.inventoryTab == InventoryTab.Equip);
		Recovery.gameObject.SetActive(!itemsIsAllDisabled);
		Bag bag = RuntimeConfigs.data.bags[(int)inventoryTabBySequence];
		Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, bag.name);
		Capacity.UpdateNumber(oriItems.Count, bag.capacity);
		if (lookRedpointItems.Count > 0)
		{
			Model<InventoryModel>.Interface.SetItemsRedDotState(inventoryTab2, lookRedpointItems);
			lookRedpointItems.Clear();
		}
	}

	private void RefreshMiddle(List<ItemUnifierProxy> items, int selectItemId = 0)
	{
		CommonScrollBagComponent.Station = Station;
		CommonScrollBagComponent.BeforeInstantiate = null;
		CommonScrollBagComponent.SelectMode = ((inventoryState != InventoryState.Normal) ? CommonScrollBagComponent.SelectModeType.MultipleUnique : CommonScrollBagComponent.SelectModeType.Single);
		CommonScrollBagComponent.SelectedModels?.Clear();
		CommonScrollBagComponent.OnItemSelect = null;
		CommonScrollBagComponent.OnItemUnSelect = null;
		CommonScrollBagComponent.ResetPositionAfterUpdate = true;
		if (inventoryTab == InventoryTab.Equip)
		{
			CommonScrollBagComponent.BindTemplate(EquipUIComponent.gameObject);
		}
		else if (inventoryTab == InventoryTab.Disk)
		{
			CommonScrollBagComponent.BindTemplate(GemUIComponent.gameObject);
		}
		else if (inventoryTab == InventoryTab.HealingPotion)
		{
			CommonScrollBagComponent commonScrollBagComponent = CommonScrollBagComponent;
			commonScrollBagComponent.BeforeInstantiate = (Action<int>)Delegate.Combine(commonScrollBagComponent.BeforeInstantiate, (Action<int>)((int index) =>
			{
				IBagItem source = items[index].Source;
				if (!(source is BloodBottleData))
				{
					if (source is BloodBottleMaterial)
					{
						CommonScrollBagComponent.BindTemplate(BloodBottleMatUIComponent.gameObject);
					}
					else
					{
						CommonScrollBagComponent.BindTemplate(ItemUIComponent.gameObject);
					}
				}
				else
				{
					CommonScrollBagComponent.BindTemplate(BloodBottleUIComponent.gameObject);
				}
			}));
		}
		else
		{
			CommonScrollBagComponent.BindTemplate(ItemUIComponent.gameObject);
		}
		CommonScrollBagComponent.ClearBag();
		CommonScrollBagComponent.ItemSource = items;
		CommonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		CommonScrollBagComponent commonScrollBagComponent2 = CommonScrollBagComponent;
		commonScrollBagComponent2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent2.OnItemSelect, new Action<ItemUIComponentBase>(OnItemSelect));
		CommonScrollBagComponent commonScrollBagComponent3 = CommonScrollBagComponent;
		commonScrollBagComponent3.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent3.OnItemUnSelect, new Action<ItemUIComponentBase>(OnItemUnSelect));
		Nothing.SetActive(value: false);
		if (items.Count <= 0)
		{
			Nothing.SetActive(value: true);
			CommonItemDetail.gameObject.SetActive(value: false);
			triggerCellBtn?.gameObject.SetActive(value: false);
			triggerCellBtn?.OnClick.RemoveAllListeners();
			return;
		}
		ItemUnifierProxy itemUnifierProxy = null;
		itemUnifierProxy = ((selectItemId > 0) ? items.Find((ItemUnifierProxy item) => item.Id == selectItemId) : items.FirstOrDefault());
		CommonItemDetail.gameObject.SetActive(value: true);
		if (inventoryState == InventoryState.Normal)
		{
			CommonScrollBagComponent.SelectedModels.Add(itemUnifierProxy);
			CommonScrollBagComponent.OnItemShow = null;
			CommonScrollBagComponent commonScrollBagComponent4 = CommonScrollBagComponent;
			commonScrollBagComponent4.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent4.OnItemShow, new Action<ItemUIComponentBase>(OnItemShow));
			CommonItemDetail.Context = itemUnifierProxy;
		}
		else
		{
			if (inventoryState != InventoryState.Recovery)
			{
				return;
			}
			CommonItemDetail.Context = itemUnifierProxy;
			CommonScrollBagComponent.OnItemShow = null;
			CommonScrollBagComponent commonScrollBagComponent5 = CommonScrollBagComponent;
			commonScrollBagComponent5.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent5.OnItemShow, new Action<ItemUIComponentBase>(OnItemShow));
			if (!recoverySelectItemDic.TryGetValue(inventoryTab, out var _))
			{
				recoverySelectItemDic.Add(inventoryTab, ListPool<ItemUnifierProxy>.Get());
			}
			for (int num = 0; num < recoverySelectItemDic[inventoryTab].Count; num++)
			{
				ItemUnifierProxy itemUnifierProxy2 = FindItemUnifierProxy(items, recoverySelectItemDic[inventoryTab][num].Id);
				if (itemUnifierProxy2 != null)
				{
					CommonScrollBagComponent.AddSelectedModelWithoutNotify(itemUnifierProxy2);
				}
			}
		}
	}

	private void OnItemSelect(ItemUIComponentBase itemUIComponentBase)
	{
		if (Model<InventoryModel>.Interface.GetItemRedDotState(itemUIComponentBase.ItemUnifier))
		{
			Model<InventoryModel>.Interface.SetItemRedDotState(inventoryTab, itemUIComponentBase.ItemUnifier);
		}
		if (inventoryState == InventoryState.Normal)
		{
			RefreshItemUse(itemUIComponentBase);
			CommonItemDetail.Context = itemUIComponentBase.ItemUnifier;
			return;
		}
		triggerCellBtn?.gameObject.SetActive(value: false);
		triggerCellBtn?.OnClick.RemoveAllListeners();
		CommonItemDetail.gameObject.SetActive(value: true);
		CommonItemDetail.Context = itemUIComponentBase.ItemUnifier;
		Model<InventoryModel>.Interface.OnItemSelectedChangeAction(itemUIComponentBase, selected: true);
		if (itemUIComponentBase.IsDisabled)
		{
			return;
		}
		int num = 0;
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item in recoverySelectItemDic)
		{
			num += item.Value.Count;
		}
		ItemUnifierProxy itemUnifierProxy = FindItemUnifierProxy(recoverySelectItemDic[inventoryTab], itemUIComponentBase.ItemUnifier.Id);
		if (num >= RuntimeConfigs.data.game.BagRecycleLimit && itemUnifierProxy == null)
		{
			CommonScrollBagComponent.SelectedModels.Remove(itemUIComponentBase.ItemUnifier);
			GameUtility.OpenToolTip(41000063);
		}
		else if (itemUnifierProxy == null)
		{
			recoverySelectItemDic[inventoryTab].Add(itemUIComponentBase.ItemUnifier);
			OnRecoveryItemChange();
		}
	}

	private void RefreshItemUse(ItemUIComponentBase itemUIComponentBase)
	{
		bool canBeUse = itemUIComponentBase.ItemUnifier.ItemData.canBeUse;
		bool flag = CoreUtils.GetData(itemUIComponentBase.ItemUnifier.ItemData.type, RuntimeConfigs.data.itemTypes).actionType != 0;
		bool flag2 = itemUIComponentBase.ItemUnifier.Source is Item item && item.IsDisuse();
		bool flag3 = (canBeUse | flag) && !flag2;
		triggerCellBtn?.gameObject.SetActive(flag3);
		triggerCellBtn?.Interactable(flag3);
		if (flag3)
		{
			RegisterTriggerBtnOnClickEvt(itemUIComponentBase);
		}
	}

	private void OnItemUnSelect(ItemUIComponentBase itemUIComponentBase)
	{
		if (inventoryState == InventoryState.Recovery)
		{
			ItemUnifierProxy itemUnifierProxy = FindItemUnifierProxy(recoverySelectItemDic[inventoryTab], itemUIComponentBase.ItemUnifier.Id);
			if (itemUnifierProxy != null)
			{
				Model<InventoryModel>.Interface.OnItemSelectedChangeAction(itemUIComponentBase, selected: false);
				recoverySelectItemDic[inventoryTab].Remove(itemUnifierProxy);
				OnRecoveryItemChange();
			}
		}
	}

	private void OnItemShow(ItemUIComponentBase itemUIComponentBase)
	{
		bool flag = Model<InventoryModel>.Interface.IsPreciousTab(inventoryTab);
		if (Model<InventoryModel>.Interface.GetItemRedDotState(itemUIComponentBase.ItemUnifier) && !flag)
		{
			lookRedpointItems.Add(itemUIComponentBase.ItemUnifier);
		}
		string itemRedDotPath = Model<InventoryModel>.Interface.GetItemRedDotPath(inventoryTab, itemUIComponentBase.ItemUnifier);
		itemUIComponentBase.RedDotType = ((!flag) ? RedDotType.New : RedDotType.Dot);
		itemUIComponentBase.RedPointPath = itemRedDotPath;
		if (inventoryState != InventoryState.Recovery)
		{
			itemUIComponentBase.IsDisabled = false;
		}
		else
		{
			itemUIComponentBase.IsDisabled = Model<InventoryModel>.Interface.GetItemIsDisabled(itemUIComponentBase.ItemUnifier);
		}
	}

	private ItemUnifierProxy FindItemUnifierProxy(List<ItemUnifierProxy> itemUnifierProxies, int id)
	{
		for (int i = 0; i < itemUnifierProxies.Count; i++)
		{
			if (itemUnifierProxies[i].Id == id)
			{
				return itemUnifierProxies[i];
			}
		}
		return null;
	}

	private List<ItemUnifierProxy> GetFilterItems()
	{
		List<ItemUnifierProxy> result = null;
		if (inventoryState == InventoryState.Normal)
		{
			if (inventoryTab == InventoryTab.Equip)
			{
				result = Model<InventoryModel>.Interface.FilterItems(curDisplayItems, Model<InventoryModel>.Interface.GetEquipFilters());
			}
			else
			{
				result = ((inventoryTab != InventoryTab.Disk) ? curDisplayItems : Model<InventoryModel>.Interface.FilterItems(curDisplayItems, Model<InventoryModel>.Interface.GetGemFilters()));
			}
		}
		else if (inventoryState == InventoryState.Recovery)
		{
			result = Model<InventoryModel>.Interface.FilterItems(curDisplayItems, curFilterDic);
		}
		return result;
	}

	public void OnFilter(Dictionary<FilterType, List<int>> filterDic)
	{
		if (inventoryState == InventoryState.Normal)
		{
			curDisplayItems = Model<InventoryModel>.Interface.FilterItems(oriItems, filterDic);
			SortItemList(curDisplayItems);
		}
		else if (inventoryState == InventoryState.Recovery)
		{
			curDisplayItems = Model<InventoryModel>.Interface.FilterItems(oriItems, filterDic);
			SortItemList(curDisplayItems);
			if (recoverySelectItemDic.Count != 0)
			{
				foreach (ItemUnifierProxy item in recoverySelectItemDic[inventoryTab])
				{
					if (!curDisplayItems.Contains(item))
					{
						curDisplayItems.Add(item);
					}
				}
				curDisplayItems.Sort((ItemUnifierProxy l, ItemUnifierProxy r) =>
				{
					bool value = recoverySelectItemDic[inventoryTab].Contains(l);
					return recoverySelectItemDic[inventoryTab].Contains(r).CompareTo(value);
				});
			}
		}
		RefreshMiddle(curDisplayItems);
	}

	private void SortItemList(List<ItemUnifierProxy> itemUnifierProxies)
	{
		if (inventoryTab == InventoryTab.Equip)
		{
			if (inventoryState == InventoryState.Normal)
			{
				Model<InventoryModel>.Interface.SortItemList(itemUnifierProxies, Model<InventoryModel>.Interface.GetEquipSorts());
			}
			else if (inventoryState == InventoryState.Recovery)
			{
				Model<InventoryModel>.Interface.SortItemList(itemUnifierProxies, recoverySortDic);
			}
		}
	}

	public void OnSort(Dictionary<SortType, List<int>> sortDic)
	{
		Model<InventoryModel>.Interface.SortItemList(curDisplayItems, sortDic);
		RefreshMiddle(curDisplayItems);
	}

	public void OnCloseRecovery()
	{
		CurInventoryState = InventoryState.Normal;
		InventoryRecoveryView.gameObject.SetActive(value: false);
		InventoryFilterView.gameObject.SetActive(value: false);
		InventorySortView.gameObject.SetActive(value: false);
		foreach (KeyValuePair<InventoryTab, Dictionary<FilterType, List<int>>> item in recoveryFilterDic)
		{
			DictionaryPool<FilterType, List<int>>.Release(item.Value);
		}
		recoveryFilterDic.Clear();
		foreach (KeyValuePair<SortType, List<int>> item2 in recoverySortDic)
		{
			ListPool<int>.Release(item2.Value);
		}
		recoverySortDic.Clear();
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item3 in recoverySelectItemDic)
		{
			item3.Value.Clear();
		}
		curDisplayItems = oriItems;
		curDisplayItems = GetFilterItems();
		SortItemList(curDisplayItems);
		RefreshMiddle(curDisplayItems);
		switch (inventoryTab)
		{
		case InventoryTab.Equip:
			_inventoryFilterComp.RefreshComp(Model<InventoryModel>.Interface.GetEquipFilters());
			break;
		case InventoryTab.Disk:
			_inventoryFilterComp.RefreshComp(Model<InventoryModel>.Interface.GetGemFilters());
			break;
		default:
			_inventoryFilterComp.RefreshComp(null);
			break;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Window_Close");
	}

	private void OnRecoveryItemChange()
	{
		List<ItemUnifierProxy> list = ListPool<ItemUnifierProxy>.Get();
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item in recoverySelectItemDic)
		{
			list.AddRange(item.Value);
		}
		InventoryRecoveryView.OnRecoveryItemChange(list);
	}

	public void OnRecovery()
	{
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item in recoverySelectItemDic)
		{
			item.Value.Clear();
		}
		oriItems = Model<InventoryModel>.Interface.GetItemListByInventoryTab(inventoryTab);
		curDisplayItems = oriItems;
		RefreshMiddle(curDisplayItems);
		Bag data = CoreUtils.GetData((int)inventoryTab, RuntimeConfigs.data.bags);
		Capacity.UpdateNumber(oriItems.Count, data.capacity);
	}

	public void OnQuickFill()
	{
		List<ItemUnifierProxy> list = CommonScrollBagComponent.ItemSource.ToList();
		list.Sort(Model<InventoryModel>.Interface.QuickFillItemSort);
		int num = 0;
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item in recoverySelectItemDic)
		{
			num += item.Value.Count;
		}
		List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
		foreach (ItemUnifierProxy item2 in list)
		{
			if (!Model<InventoryModel>.Interface.GetItemIsDisabled(item2) && !CommonScrollBagComponent.SelectedModels.Contains(item2))
			{
				list2.Add(item2);
			}
		}
		int num2 = Mathf.Min(RuntimeConfigs.data.game.BagRecycleLimit - num, list2.Count);
		for (int i = 0; i < num2; i++)
		{
			CommonScrollBagComponent.AddSelectedModelWithoutNotify(list2[i]);
			recoverySelectItemDic[inventoryTab].Add(list2[i]);
		}
		foreach (ItemUnifierProxy selectedModel in CommonScrollBagComponent.SelectedModels)
		{
			if (selectedModel.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.IsChosen = true;
				itemUIComponentBase.UpdatePerformance();
			}
		}
		ListPool<ItemUnifierProxy>.Release(list2);
		OnRecoveryItemChange();
	}

	public bool GetIsHasFillDisuse()
	{
		if (Model<InventoryModel>.Interface.GetDisuseItems(curDisplayItems).Count > 0)
		{
			return true;
		}
		return false;
	}

	public void OnQuickFillDisuse()
	{
		List<ItemUnifierProxy> list = CommonScrollBagComponent.ItemSource.ToList();
		int num = 0;
		foreach (KeyValuePair<InventoryTab, List<ItemUnifierProxy>> item2 in recoverySelectItemDic)
		{
			num += item2.Value.Count;
		}
		List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
		foreach (ItemUnifierProxy item3 in list)
		{
			ItemUIComponentBase itemUIComponentBase = (ItemUIComponentBase)item3.Context;
			if (!(itemUIComponentBase == null) && !(itemUIComponentBase == null) && !itemUIComponentBase.IsDisabled && !itemUIComponentBase.IsChosen && item3.Source is Item item && item.IsDisuse())
			{
				list2.Add(item3);
			}
		}
		int num2 = Mathf.Min(RuntimeConfigs.data.game.BagRecycleLimit - num, list2.Count);
		for (int i = 0; i < num2; i++)
		{
			CommonScrollBagComponent.AddSelectedModelWithoutNotify(list2[i]);
			recoverySelectItemDic[inventoryTab].Add(list2[i]);
		}
		foreach (ItemUnifierProxy selectedModel in CommonScrollBagComponent.SelectedModels)
		{
			if (selectedModel.Context is ItemUIComponentBase itemUIComponentBase2)
			{
				itemUIComponentBase2.IsChosen = true;
				itemUIComponentBase2.UpdatePerformance();
			}
		}
		ListPool<ItemUnifierProxy>.Release(list2);
		OnRecoveryItemChange();
	}

	public InventoryTab GetCurrentTab()
	{
		return inventoryTab;
	}

	private void RegisterTriggerBtnOnClickEvt(ItemUIComponentBase itemUIComponentBase)
	{
		if (CoreUtils.GetData(itemUIComponentBase.ItemUnifier.ItemData.type, RuntimeConfigs.data.itemTypes).actionType != 0)
		{
			LuminItemType type = (LuminItemType)itemUIComponentBase.ItemUnifier.ItemData.type;
			switch (type)
			{
			case LuminItemType.LittleItem:
			{
				BloodBottleData curSelectedBottle = Model<BloodBottleModel>.Interface.GetBloodBottleByItemId(itemUIComponentBase.ItemUnifier.ItemData.id);
				if (curSelectedBottle != null)
				{
					triggerCellBtn?.Interactable(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.BloodBottleCultivate));
					triggerCellBtn?.SetBtnClick(() =>
					{
						Singleton<BloodBottleHandler>.instance.JumpToBottleView(curSelectedBottle.uid, needFuzzy: true);
					});
					triggerCellBtn?.OnUnInteractableClick.RemoveAllListeners();
					triggerCellBtn?.OnUnInteractableClick.AddListener(() =>
					{
						Singleton<BloodBottleHandler>.instance.JumpToBottleView(curSelectedBottle.uid, needFuzzy: true);
					});
				}
				break;
			}
			case LuminItemType.Additive:
				triggerCellBtn?.Interactable(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.BloodBottleCultivate));
				triggerCellBtn?.SetBtnClick(() =>
				{
					Singleton<BloodBottleHandler>.instance.MaterialJumpToBottleView(itemUIComponentBase.ItemUnifier.ItemData.id, needFuzzy: true);
				});
				triggerCellBtn?.OnUnInteractableClick.RemoveAllListeners();
				triggerCellBtn?.OnUnInteractableClick.AddListener(() =>
				{
					Singleton<BloodBottleHandler>.instance.MaterialJumpToBottleView(itemUIComponentBase.ItemUnifier.ItemData.id, needFuzzy: true);
				});
				break;
			}
			triggerCellBtnStr?.SetReference(LocalizeTable.Common, 2666);
			return;
		}
		ItemUseType useType = (ItemUseType)itemUIComponentBase.ItemUnifier.ItemData.useType;
		triggerCellBtnStr?.SetReference(LocalizeTable.Common, 2465);
		switch (useType)
		{
		case ItemUseType.Collection:
			SendUseItem(itemUIComponentBase);
			break;
		case ItemUseType.BagChest:
		{
			IBagItem source = itemUIComponentBase.ItemUnifier.Source;
			GiftPackage giftPackage = source as GiftPackage;
			if (giftPackage == null)
			{
				break;
			}
			bool openPrecondition = giftPackage.GetOpenPrecondition();
			triggerCellBtn?.Interactable(openPrecondition);
			triggerCellBtn?.SetBtnClick(() =>
			{
				switch (giftPackage.type)
				{
				case GiftPackageType.Random:
				case GiftPackageType.Inherent:
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_USEITEM, new MonoUseItemView.UseItemData
					{
						Item = new Item
						{
							Id = giftPackage.GetId(),
							Count = giftPackage.GetCount()
						},
						limitMin = 1,
						limitMax = giftPackage.GetCount(),
						confirmClick = (int useCount) =>
						{
							Model<GiftPackageModel>.Interface.SendRewardRandomOrInherentGiftPackage(giftPackage, useCount, RefreshMiddle);
						}
					});
					break;
				case GiftPackageType.SelfSelect:
				{
					if (RuntimeConfigs.data.bagChests.TryGetValue(giftPackage.GetId(), out var value))
					{
						List<ItemKv> selectableRewardPool = value.selectableRewardPool;
						if (selectableRewardPool == null || selectableRewardPool.Count <= 0)
						{
							if (LuminApplication.LogEnabled)
							{
								Debug.LogError($"id为{giftPackage.GetId()}的自选宝箱的自选池表数据为空，检查表");
							}
						}
						else
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPMULTIBOX, new PopupMultiBoxViewData
							{
								selectedGiftPackage = giftPackage,
								rewardItemData = selectableRewardPool,
								onConfirmAction = RefreshMiddle
							});
						}
					}
					break;
				}
				}
			});
			break;
		}
		case ItemUseType.MonthlyPass:
			SendUseItem(itemUIComponentBase, 1, requestMonthlyPassFacePush: true);
			break;
		case ItemUseType.BattlePass:
			SendUseItem(itemUIComponentBase, 1);
			break;
		default:
			SendUseItem(itemUIComponentBase);
			break;
		}
	}

	private void RefreshMiddle(BaseEventContent obj)
	{
		if (!(obj is CharacterDependChangeEvt { remove: false }))
		{
			RefreshMiddle();
		}
	}

	private void SendUseItem(ItemUIComponentBase itemUIComponentBase, int maxUseCount = 0, bool requestMonthlyPassFacePush = false)
	{
		int id = itemUIComponentBase.ItemUnifier.Id;
		int uid = itemUIComponentBase.ItemUnifier.Uid;
		int count = (int)itemUIComponentBase.ItemUnifier.Count;
		long expireTime = ((itemUIComponentBase.ItemUnifier.Source is Item item) ? item.ExpireTime : 0);
		triggerCellBtn?.Interactable(active: true);
		triggerCellBtn?.SetBtnClick(() =>
		{
			if (!(itemUIComponentBase.ItemUnifier.Source is Item item2) || !item2.IsDisuse())
			{
				if (itemUIComponentBase.ItemUnifier.Source is Item { itemType: 23 } item3)
				{
					ItemData itemData = RuntimeConfigs.data.itemDatas[96];
					if (Model<InventoryModel>.Interface.CheckPowerIsUseLimit(itemUIComponentBase))
					{
						List<string> list = new List<string>();
						int stackLimit = itemData.stackLimit;
						list.Add(stackLimit.ToString());
						GameUtility.OpenToolTip(2152, "Common", list);
						return;
					}
					ItemData itemData2 = RuntimeConfigs.data.itemDatas[item3.Id];
					Collection collection = RuntimeConfigs.data.collections[itemData2.Use];
					maxUseCount = (itemData.stackLimit - Model<PowerModel>.Interface.PowerCount) / collection.certain[0].count;
					maxUseCount = Mathf.Min(maxUseCount, count);
				}
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_USEITEM, new MonoUseItemView.UseItemData
				{
					Item = new Item
					{
						Id = id,
						Count = count,
						Uid = itemUIComponentBase.ItemUnifier.Uid,
						ExpireTime = expireTime
					},
					limitMin = 1,
					limitMax = ((maxUseCount == 0) ? count : maxUseCount),
					confirmClick = (int useCount) =>
					{
						bool isMonthlyPassItem = requestMonthlyPassFacePush;
						bool shouldOpenMonthlyPassFacePush = isMonthlyPassItem && !HasActiveMonthlyPass();
						if (isMonthlyPassItem && Model<FacePushModel>.HasInstance())
						{
							Model<FacePushModel>.Interface.PrepareMonthlyPassItemFacePush(shouldOpenMonthlyPassFacePush);
						}
						G.service.UseItem(id, uid, useCount, 0, (bool isTrue, RepeatedField<Item> _, RepeatedField<UniversalItem> items) =>
						{
							if (isTrue)
							{
								if (shouldOpenMonthlyPassFacePush)
								{
									if (Model<FacePushModel>.HasInstance())
									{
										Model<FacePushModel>.Interface.NotifyMonthlyPassItemUseSucceeded();
									}
								}
								else if (!isMonthlyPassItem)
								{
									GameUtility.OpenPopReward(items);
								}
								Singleton<EventManager>.instance.EventDispatch(ClientEvent.Power_Refresh, null);
								RefreshMiddle();
							}
							else if (isMonthlyPassItem && Model<FacePushModel>.HasInstance())
							{
								Model<FacePushModel>.Interface.ClearMonthlyPassItemFacePush();
							}
						});
					}
				});
			}
		});
	}

	private static bool HasActiveMonthlyPass()
	{
		if (Model<ShopModel>.HasInstance())
		{
			Dictionary<int, MonthlyPassEntry> monthlyPassData = Model<ShopModel>.Interface.MonthlyPassData;
			if (monthlyPassData != null && monthlyPassData.Count > 0)
			{
				foreach (KeyValuePair<int, MonthlyPassEntry> monthlyPassDatum in Model<ShopModel>.Interface.MonthlyPassData)
				{
					MonthlyPassEntry value = monthlyPassDatum.Value;
					if (value != null && Model<ShopModel>.Interface.MonthlyPassValid(value.PassId))
					{
						return true;
					}
				}
				return false;
			}
		}
		return false;
	}

	private void RefreshMiddle()
	{
		oriItems = Model<InventoryModel>.Interface.GetItemListByInventoryTab(inventoryTab);
		UpdateFilterDic();
		curDisplayItems = oriItems;
		curDisplayItems = GetFilterItems();
		SortItemList(curDisplayItems);
		RefreshMiddle(curDisplayItems);
	}

	protected override void OnInputDeviceChange(DeviceInputMode inputMode)
	{
		GamepadTipsRoot.SetActive(inputMode == DeviceInputMode.Gamepad);
		LBPrompt.SetActive(inputMode == DeviceInputMode.Gamepad);
		RBPrompt.SetActive(inputMode == DeviceInputMode.Gamepad);
		ChangeInventoryViewControl(GetInventoryViewControlType(), reFocus: true);
	}

	public InventoryViewControlType GetInventoryViewControlType()
	{
		if (InventoryFilterView.gameObject.activeSelf)
		{
			return InventoryViewControlType.Filter;
		}
		if (InventorySortView.gameObject.activeSelf)
		{
			return InventoryViewControlType.Sort;
		}
		if (InventoryRecoveryView.gameObject.activeSelf)
		{
			return InventoryViewControlType.Recovery;
		}
		if (ControlType == InventoryViewControlType.Resources)
		{
			return InventoryViewControlType.Resources;
		}
		if (ControlType == InventoryViewControlType.Menu)
		{
			return InventoryViewControlType.Menu;
		}
		return InventoryViewControlType.Main;
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
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
		if (EventSystemHelper.CurrentSelected == null)
		{
			return;
		}
		if (ControlType == InventoryViewControlType.Main)
		{
			HandleConfirm();
			ScrollTargetToShow(EventSystemHelper.CurrentSelected.transform, MainScrollToShowOffset);
		}
		else if (ControlType == InventoryViewControlType.Recovery)
		{
			ScrollTargetToShow(EventSystemHelper.CurrentSelected.transform, MainScrollToShowOffset);
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			component.SetIsOn(val: true);
			CommonItemDetail.gameObject.SetActive(value: true);
			CommonItemDetail.Context = component.ItemUnifier;
			GamepadSelectPromtText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, component.IsChosen ? 14 : 774);
			Model<InventoryModel>.Interface.OnItemSelectedChangeAction(component, component.IsChosen);
		}
		else if (ControlType == InventoryViewControlType.Filter)
		{
			ScrollTargetToShow(EventSystemHelper.CurrentSelected.transform, FilterScrollToShowOffset);
		}
		else if (ControlType == InventoryViewControlType.Sort)
		{
			if (EventSystemHelper.CurrentSelected.GetComponent<InventorySortCell>().Index == 0)
			{
				InventorySortView.PropertyParent.parent.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
			}
			else
			{
				ScrollTargetToShow(EventSystemHelper.CurrentSelected.transform, SortScrollToShowOffset);
			}
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

	public async void ChangeInventoryViewControl(InventoryViewControlType inventoryViewControlType, bool reFocus = false)
	{
		if (inventoryViewControlType != InventoryViewControlType.Menu || IsAllowToMenu)
		{
			await UniTask.DelayFrame(2);
			InventoryViewControlType controlType = ControlType;
			ControlType = inventoryViewControlType;
			UpdateSubControllerState(inventoryViewControlType);
			FocusControLayer(controlType, inventoryViewControlType, reFocus);
			UpdateControlDownPromts(inventoryViewControlType);
			UpdateControlPromts(controlType, inventoryViewControlType);
			if (inventoryViewControlType != InventoryViewControlType.Recovery)
			{
				GamepadSelectPromtText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774);
			}
			if (inventoryViewControlType == InventoryViewControlType.Main)
			{
				MenuPrompt.SetActive(IsAllowToMenu);
			}
		}
	}

	private void FocusControLayer(InventoryViewControlType lastControlType, InventoryViewControlType curControlType, bool reFocus)
	{
		switch (curControlType)
		{
		case InventoryViewControlType.ItemDetail:
			return;
		case InventoryViewControlType.Main:
			if (CommonScrollBagComponent.SelectedModels.Count > 0)
			{
				ItemUIComponentBase itemUIComponentBase = CommonScrollBagComponent.SelectedModels[0].Context as ItemUIComponentBase;
				if (itemUIComponentBase != null)
				{
					InventoryViewControlLayerDic[curControlType].DefaultSelect = itemUIComponentBase.GetComponent<ACT.ViewControl.SelectableEx>();
				}
			}
			break;
		}
		if ((lastControlType == curControlType) | reFocus)
		{
			InventoryViewControlLayerDic[curControlType].ReFocus();
			return;
		}
		InventoryViewControlLayerDic[lastControlType].UnFocus();
		InventoryViewControlLayerDic[curControlType].Focus();
	}

	private void UpdateControlDownPromts(InventoryViewControlType controlType)
	{
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in InventoryViewControlDownPromts[controlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
	}

	private void UpdateControlPromts(InventoryViewControlType lastControlType, InventoryViewControlType curControlType)
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

	private void UpdateSubControllerState(InventoryViewControlType controlType)
	{
		switch (controlType)
		{
		case InventoryViewControlType.ItemDetail:
			break;
		case InventoryViewControlType.Main:
		case InventoryViewControlType.Recovery:
			if (!CommonItemDetail.IsFocused)
			{
				CommonItemDetail.FocusIn();
			}
			break;
		default:
			if (CommonItemDetail.IsFocused)
			{
				CommonItemDetail.FocusOut();
			}
			break;
		}
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

	public async void OnUpInventoryTab()
	{
		int num = (int)inventoryTab;
		if (num > 1)
		{
			ActToggleGroup.GetToggleByIndex(num - 2).SetIsOn(val: true);
			MenuPrompt.SetActive(IsAllowToMenu);
			await UniTask.DelayFrame(2);
			InventoryViewControlLayerDic[ControlType].UnFocus();
			InventoryViewControlLayerDic[ControlType].Focus();
		}
	}

	public async void OnDownInventoryTab()
	{
		int num = (int)inventoryTab;
		if (num < 6)
		{
			ActToggleGroup.GetToggleByIndex(num).SetIsOn(val: true);
			MenuPrompt.SetActive(IsAllowToMenu);
			await UniTask.DelayFrame(2);
			InventoryViewControlLayerDic[ControlType].UnFocus();
			InventoryViewControlLayerDic[ControlType].Focus();
		}
	}

	public void OnItemDetailInputStateChanged()
	{
		if (CommonItemDetail.InputState == ItemDetailGamePadInputState.Item_NoFocus)
		{
			InventoryViewControlType inventoryViewControlType = ((ControlType == InventoryViewControlType.ItemDetail) ? GetInventoryViewControlType() : ControlType);
			ChangeInventoryViewControl(inventoryViewControlType, reFocus: true);
		}
		else
		{
			ChangeInventoryViewControl(InventoryViewControlType.ItemDetail);
		}
	}
}
