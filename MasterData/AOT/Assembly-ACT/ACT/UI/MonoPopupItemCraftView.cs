using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoPopupItemCraftView : BaseUIView<PopupItemCraftViewInputController>
{
	public enum CraftType
	{
		Single,
		Multiple
	}

	public class SingleCraftCostMaterial
	{
		public int id;

		public int possessNum;

		public int materialId;

		public int materialCostCount;

		public int costNumber;

		public int value;
	}

	public class MultipleCraftCostMaterial
	{
		public int id;

		public int possessNum;

		public int materialCostCount;
	}

	public CommonScrollBagComponent ScrollRect;

	public GameObject GoPopupItemCraftPanel;

	public GameObject TextUnSelectDec;

	public LocalizeStringEvent targetNameLocalize;

	public GameObject possessNumTitle;

	public GameObject needNumTitle;

	public TextMeshProUGUI targetPossessCount;

	public BImage targetImage;

	public ActButton BtnOpenDetail;

	public StartList targetQualityStarList;

	public TextMeshProUGUI craftNumText;

	public Image ItemQuality;

	public TextMeshProUGUI possessNumText;

	public TextMeshProUGUI targetCraftNumText;

	public LimitedSlider craftNumSlider;

	public TextMeshProUGUI maxCraftNumText;

	public TextMeshProUGUI minCraftNumText;

	public ActButton BtnAdd;

	public ActButton BtnRemove;

	public List<ItemUIComponentBase> materialItemUIComponentLinkList;

	public GameObject BgMaterItem;

	public TextMeshProUGUI extraCraftNumText;

	public GameObject craftMarkNormal;

	public GameObject craftMarkExtra;

	public CommonCoinComponent coinComponent;

	public CommonCoinComponent topCoinComponent;

	public GameObject singleCraftRoot;

	public GameObject multipleCraftRoot;

	public GameObject NextLevelMaterialRoot;

	public GameObject materialCellPrefab;

	public ActButton confirmBtn;

	public GameObject confirmBtnPrompt;

	public GameObject GoNotEnough;

	public ViewControlLayer gridControlLayer;

	public ViewControlLayer rightControlLayer;

	private PopupItemCraftData m_data;

	private ItemUIComponentBase m_LastChosen;

	public Color normalColor;

	public Color lackColor;

	public List<Color> QualityColorList = new List<Color>();

	public GamePadTipsComp gamePadGroup;

	private CraftType craftType;

	private List<SingleCraftCostMaterial> sortcraftCostMaterialLinkList = new List<SingleCraftCostMaterial>();

	private List<MultipleCraftCostMaterial> sortmultipleCraftCostMaterialList = new List<MultipleCraftCostMaterial>();

	private List<SingleCraftCostMaterial> craftCostMaterialLinkList = new List<SingleCraftCostMaterial>();

	private List<MultipleCraftCostMaterial> multipleCraftCostMaterialList = new List<MultipleCraftCostMaterial>();

	private List<ItemUIComponentBase> multipleCraftMaterialCellList = new List<ItemUIComponentBase>();

	private Dictionary<int, int> everyMaterialCostNum = new Dictionary<int, int>();

	private ItemData targetItemData;

	private int targetValue;

	private int targetItemCraftNum;

	private int minCraftNum;

	private int maxCraftNum;

	private int costCoin;

	private List<ItemData> ItemCraft = new List<ItemData>();

	private List<Item> Items = new List<Item>();

	private int SelectItemid;

	private bool canCraft = true;

	private int m_CraftRequestVersion;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public override async UniTask PreInit()
	{
		m_data = uiViewData as PopupItemCraftData;
		await base.PreInit();
		SelectItemid = 0;
		m_LastChosen = null;
		if (m_data != null)
		{
			SelectItemid = m_data.itemId;
			targetItemCraftNum = m_data.targetCraftNum;
		}
		else
		{
			targetItemCraftNum = -1;
		}
		BtnAdd.SetBtnClick(ClickAddBtn);
		BtnRemove.SetBtnClick(ClickMinusBtn);
		BtnOpenDetail.SetBtnClick(ShowDetailPanel);
		confirmBtn.SetBtnClick(Craft);
		GetAssistData();
	}

	protected override void Init()
	{
		base.Init();
		CloseCraftPanel(null);
		OpenBag();
		RefreshCoinNum();
		OnGamePadInit();
		ReBindBtnPrompt();
		if (SelectItemid == 0)
		{
			StartCoroutine(SelectFirstItemNextFrame());
		}
		else
		{
			StartCoroutine(FocusSelectedItemNextFrame());
		}
	}

	protected override void ReInit()
	{
		base.ReInit();
		if (m_data != null)
		{
			SelectItemid = m_data.itemId;
			targetItemCraftNum = m_data.targetCraftNum;
		}
		else
		{
			targetItemCraftNum = -1;
		}
		if (SelectItemid == 0)
		{
			StartCoroutine(SelectFirstItemNextFrame());
		}
		else
		{
			StartCoroutine(FocusSelectedItemNextFrame());
		}
	}

	protected override void UnInit()
	{
		StopAllCoroutines();
		ReleaseCraftListData();
		base.UnInit();
	}

	private void ReleaseCraftListData()
	{
		if (ScrollRect != null)
		{
			ScrollRect.OnItemShow = null;
			ScrollRect.OnItemSelect = null;
			ScrollRect.OnItemUnSelect = null;
			ScrollRect.ClearBag();
			if (ScrollRect.ItemSource is List<ItemUnifierProxy> items)
			{
				ItemUnifierProxy.ItemUnifierPool.Release(items);
			}
		}
		Items.Clear();
		ItemCraft.Clear();
		m_LastChosen = null;
		targetItemData = null;
		canCraft = true;
		m_CraftRequestVersion++;
	}

	private IEnumerator SelectFirstItemNextFrame()
	{
		yield return null;
		LoopScrollRect componentInChildren = ScrollRect.GetComponentInChildren<LoopScrollRect>();
		if (!(componentInChildren == null))
		{
			Component component = componentInChildren.GetItem(0) as Component;
			if (!(component == null))
			{
				gridControlLayer?.Focus();
				gridControlLayer?.SetDefaultSelect(component.gameObject.GetComponent<ACT.ViewControl.SelectableEx>());
				ExecuteEvents.Execute(component.gameObject, new PointerEventData(EventSystemHelper.Shared), ExecuteEvents.submitHandler);
			}
		}
	}

	private IEnumerator FocusSelectedItemNextFrame()
	{
		yield return null;
		LoopScrollRect componentInChildren = ScrollRect.GetComponentInChildren<LoopScrollRect>();
		if (!(componentInChildren == null))
		{
			int itemIndex = GetItemIndex(SelectItemid);
			Component component = componentInChildren.GetItem(itemIndex) as Component;
			if (!(component == null))
			{
				gridControlLayer?.SetDefaultSelect(component.gameObject.GetComponent<ACT.ViewControl.SelectableEx>());
				gridControlLayer?.Focus();
			}
		}
	}

	private void CloseCraftPanel(ILoopScrollDataSource iLoopSource)
	{
		GoPopupItemCraftPanel.SetActive(value: false);
		TextUnSelectDec.SetActive(value: true);
	}

	public void RefreshCoinNum()
	{
	}

	public void RefreshCostCoinNum(int costNum)
	{
		coinComponent.Init(costNum);
	}

	private void GetAssistData(bool isneedSort = true)
	{
		if (isneedSort)
		{
			ItemCraft = Model<CraftModel>.Interface.ItemCraftDic.Values.ToList();
			ItemCraft.Sort(ListSort);
		}
		Items.Clear();
		for (int i = 0; i < ItemCraft.Count; i++)
		{
			Item item = new Item();
			item.Id = ItemCraft[i].id;
			item.Count = G.localPlayer.GetCountById(ItemCraft[i].id);
			Items.Add(item);
		}
	}

	private int ListSort(ItemData x, ItemData y)
	{
		bool flag = CheckIsCanCraft(x.id) > 0;
		bool flag2 = CheckIsCanCraft(y.id) > 0;
		int num = 0;
		if (flag && !flag2)
		{
			return -1;
		}
		if (!flag & flag2)
		{
			return 1;
		}
		int id = x.id;
		return id.CompareTo(y.id);
	}

	private void ShowDetailPanel()
	{
		if (targetItemData != null)
		{
			ItemUnifierProxy uiData = ItemUnifierProxy.ItemUnifierPool.Get<Item>(targetItemData.id, G.localPlayer.Inventory.GetItemCount(targetItemData.id));
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, uiData);
		}
	}

	public async void OpenBag()
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		ItemUnifierProxy.ItemUnifierPool.GetList(Items, list);
		ScrollRect.ClearBag();
		ScrollRect.ItemSource = list;
		ScrollRect.OnItemShow = null;
		CommonScrollBagComponent scrollRect = ScrollRect;
		scrollRect.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(scrollRect.OnItemShow, new Action<ItemUIComponentBase>(ItemInit));
		CommonScrollBagComponent scrollRect2 = ScrollRect;
		scrollRect2.OnItemUnSelect = (Action<ItemUIComponentBase>)Delegate.Combine(scrollRect2.OnItemUnSelect, new Action<ItemUIComponentBase>(CloseCraftPanel));
		ScrollRect.OnItemSelect = null;
		CommonScrollBagComponent scrollRect3 = ScrollRect;
		scrollRect3.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(scrollRect3.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			targetItemCraftNum = -1;
			RefreshRightPanel(l);
		}));
		ScrollRect.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		if (SelectItemid != 0)
		{
			ScrollRect.SelectedModels.Add(list.Find((ItemUnifierProxy x) => x.Id == SelectItemid));
			ScrollRect.ScrollToIndex(GetItemIndex(SelectItemid));
		}
	}

	private int GetItemIndex(int itemid)
	{
		return ItemCraft.FindIndex((ItemData x) => x.id == itemid);
	}

	public void ItemInit(ILoopScrollDataSource iLoopSource)
	{
		if (iLoopSource is ItemUIComponentBase itemUIComponentBase)
		{
			itemUIComponentBase.IsGray = CheckIsCanCraft(itemUIComponentBase.ItemUnifier.Id) <= 0;
		}
	}

	public void RefreshRightPanel(ItemUIComponentBase itemCell)
	{
		int id;
		if (itemCell != null && itemCell.ItemUnifier != null)
		{
			if (m_LastChosen != null && m_LastChosen != itemCell)
			{
				m_LastChosen.IsChosen = false;
			}
			m_LastChosen = itemCell;
			itemCell.IsChosen = true;
			id = itemCell.ItemUnifier.Id;
		}
		else
		{
			if (targetItemData == null)
			{
				return;
			}
			id = targetItemData.id;
		}
		if (RuntimeConfigs.data?.itemDatas != null && RuntimeConfigs.data.itemDatas.TryGetValue(id, out targetItemData) && targetItemData?.itemCrafting != null && targetItemData.itemCrafting.Count != 0)
		{
			GoPopupItemCraftPanel.SetActive(value: true);
			TextUnSelectDec.SetActive(value: false);
			craftType = ((targetItemData.itemCrafting.Count > 2) ? CraftType.Multiple : CraftType.Single);
			targetNameLocalize.StringReference.TableEntryReference = targetItemData.nameLocal;
			targetPossessCount.text = G.localPlayer.Inventory.GetItemCount(targetItemData.id).ToString();
			Station.LoadItemIcon(targetItemData.id, targetImage);
			targetQualityStarList.QualityInit(targetItemData.quality);
			ItemQuality.color = QualityColorList[targetItemData.quality - 1];
			if (craftType == CraftType.Single)
			{
				craftNumSlider.onValueChanged.RemoveAllListeners();
				singleCraftRoot.SetActive(value: true);
				multipleCraftRoot.SetActive(value: false);
				GetSingleCraftLink();
				GetSingleCraftValue();
				GetSingleMaxCraftNum();
				GetSingleCraftMaterialCost(targetItemCraftNum);
				craftNumSlider.onValueChanged.AddListener(GetSingleCraftMaterialCost);
			}
			else if (craftType == CraftType.Multiple)
			{
				craftNumSlider.onValueChanged.RemoveAllListeners();
				singleCraftRoot.SetActive(value: false);
				multipleCraftRoot.SetActive(value: true);
				GetMultipleCraftCostMaterial();
				GetMultipleMaxCraftNum();
				CreateMultipleCraftMaterialCell();
				GetMultipleCraftMaterialCost(targetItemCraftNum);
				craftNumSlider.onValueChanged.AddListener(GetMultipleCraftMaterialCost);
			}
			canCraft = true;
		}
	}

	protected override async void PlayOpenAnimation()
	{
		OpenEffectFinishNew();
	}

	protected override async void PlayCloseAnimation()
	{
		CloseEffectFinishNew();
	}

	private void GetSingleCraftLink()
	{
		craftCostMaterialLinkList.Clear();
		List<ItemKv> itemCrafting = targetItemData.itemCrafting;
		ItemData itemData = targetItemData;
		while (itemCrafting != null && itemCrafting.Count > 0)
		{
			craftCostMaterialLinkList.Add(new SingleCraftCostMaterial
			{
				id = itemData.id,
				materialId = itemCrafting[1].id,
				possessNum = G.localPlayer.Inventory.GetItemCount(itemCrafting[1].id),
				materialCostCount = itemCrafting[1].count,
				costNumber = itemCrafting[0].count
			});
			itemData = RuntimeConfigs.data.itemDatas[itemCrafting[1].id];
			itemCrafting = RuntimeConfigs.data.itemDatas[itemCrafting[1].id].itemCrafting;
		}
		if (craftCostMaterialLinkList.Count == 1)
		{
			craftMarkNormal.SetActive(value: false);
			craftMarkExtra.SetActive(value: false);
			extraCraftNumText.gameObject.SetActive(value: false);
		}
	}

	private void GetSingleCraftValue()
	{
		for (int num = craftCostMaterialLinkList.Count - 1; num >= 0; num--)
		{
			if (num == craftCostMaterialLinkList.Count - 1)
			{
				craftCostMaterialLinkList[num].value = 1;
			}
			else
			{
				craftCostMaterialLinkList[num].value = craftCostMaterialLinkList[num + 1].value * craftCostMaterialLinkList[num + 1].materialCostCount;
			}
		}
		targetValue = craftCostMaterialLinkList[0].value * craftCostMaterialLinkList[0].materialCostCount;
	}

	private void GetSingleMaxCraftNum()
	{
		int num = 0;
		foreach (SingleCraftCostMaterial craftCostMaterialLink in craftCostMaterialLinkList)
		{
			num += craftCostMaterialLink.possessNum * craftCostMaterialLink.value;
		}
		craftNumSlider.maxValue = 0f;
		craftNumSlider.minValue = 0f;
		maxCraftNum = num / targetValue;
		minCraftNum = 1;
		targetItemCraftNum = Mathf.Max(minCraftNum, targetItemCraftNum);
		int num2 = Mathf.Max(maxCraftNum, 1);
		craftNumSlider.maxValue = maxCraftNum;
		craftNumSlider.minValue = minCraftNum;
		craftNumSlider.limit = num2;
		craftNumSlider.value = targetItemCraftNum;
		maxCraftNumText.text = num2.FastToString();
		minCraftNumText.text = minCraftNum.FastToString();
	}

	private int CheckSingle(int itemid)
	{
		ItemData itemData = RuntimeConfigs.data.itemDatas[itemid];
		sortcraftCostMaterialLinkList.Clear();
		List<ItemKv> itemCrafting = itemData.itemCrafting;
		ItemData itemData2 = itemData;
		int num = 0;
		while (itemCrafting != null && itemCrafting.Count > 0)
		{
			sortcraftCostMaterialLinkList.Add(new SingleCraftCostMaterial
			{
				id = itemData2.id,
				materialId = itemCrafting[1].id,
				possessNum = G.localPlayer.Inventory.GetItemCount(itemCrafting[1].id),
				materialCostCount = itemCrafting[1].count,
				costNumber = itemCrafting[0].count
			});
			itemData2 = RuntimeConfigs.data.itemDatas[itemCrafting[1].id];
			itemCrafting = RuntimeConfigs.data.itemDatas[itemCrafting[1].id].itemCrafting;
		}
		for (int num2 = sortcraftCostMaterialLinkList.Count - 1; num2 >= 0; num2--)
		{
			if (num2 == sortcraftCostMaterialLinkList.Count - 1)
			{
				sortcraftCostMaterialLinkList[num2].value = 1;
			}
			else
			{
				sortcraftCostMaterialLinkList[num2].value = sortcraftCostMaterialLinkList[num2 + 1].value * sortcraftCostMaterialLinkList[num2 + 1].materialCostCount;
			}
		}
		num = sortcraftCostMaterialLinkList[0].value * sortcraftCostMaterialLinkList[0].materialCostCount;
		int num3 = 0;
		foreach (SingleCraftCostMaterial sortcraftCostMaterialLink in sortcraftCostMaterialLinkList)
		{
			num3 += sortcraftCostMaterialLink.possessNum * sortcraftCostMaterialLink.value;
		}
		return num3 / num;
	}

	private int CheckMultiple(int itemid)
	{
		ItemData itemData = RuntimeConfigs.data.itemDatas[itemid];
		sortmultipleCraftCostMaterialList.Clear();
		for (int i = 0; i < itemData.itemCrafting.Count; i++)
		{
			if (i > 0)
			{
				sortmultipleCraftCostMaterialList.Add(new MultipleCraftCostMaterial
				{
					id = itemData.itemCrafting[i].id,
					possessNum = G.localPlayer.Inventory.GetItemCount(itemData.itemCrafting[i].id),
					materialCostCount = itemData.itemCrafting[i].count
				});
			}
		}
		int[] array = new int[sortmultipleCraftCostMaterialList.Count];
		for (int j = 0; j < sortmultipleCraftCostMaterialList.Count; j++)
		{
			array[j] = sortmultipleCraftCostMaterialList[j].possessNum / sortmultipleCraftCostMaterialList[j].materialCostCount;
		}
		return Mathf.Min(array);
	}

	private int CheckIsCanCraft(int itemid)
	{
		if (RuntimeConfigs.data.itemDatas[itemid].itemCrafting.Count <= 2 && 0 == 0)
		{
			return CheckSingle(itemid);
		}
		return CheckMultiple(itemid);
	}

	public void GetSingleCraftMaterialCost(float value)
	{
		targetItemCraftNum = (int)value;
		craftNumText.SetText("{0:0}", (int)value);
		int num = targetItemCraftNum * targetValue;
		everyMaterialCostNum.Clear();
		foreach (SingleCraftCostMaterial craftCostMaterialLink in craftCostMaterialLinkList)
		{
			everyMaterialCostNum.Add(craftCostMaterialLink.materialId, 0);
		}
		foreach (SingleCraftCostMaterial craftCostMaterialLink2 in craftCostMaterialLinkList)
		{
			if (craftCostMaterialLink2.possessNum * craftCostMaterialLink2.value >= num)
			{
				everyMaterialCostNum[craftCostMaterialLink2.materialId] = num / craftCostMaterialLink2.value;
				break;
			}
			everyMaterialCostNum[craftCostMaterialLink2.materialId] = craftCostMaterialLink2.possessNum;
			num -= craftCostMaterialLink2.possessNum * craftCostMaterialLink2.value;
		}
		costCoin = 0;
		foreach (int materialId in everyMaterialCostNum.Keys)
		{
			if (materialId == targetItemData.itemCrafting[1].id)
			{
				costCoin += targetItemCraftNum * targetItemData.itemCrafting[0].count;
				continue;
			}
			costCoin += everyMaterialCostNum[materialId] / craftCostMaterialLinkList.Find((SingleCraftCostMaterial _) => _.materialId == materialId).materialCostCount * craftCostMaterialLinkList.Find((SingleCraftCostMaterial _) => _.materialId == materialId).costNumber;
		}
		coinComponent.Station = Station;
		RefreshCostCoinNum(costCoin);
		UpdateSingleCraftCostMaterialShow();
	}

	private void UpdateSingleCraftCostMaterialShow()
	{
		if (maxCraftNum == 0)
		{
			for (int i = 0; i < materialItemUIComponentLinkList.Count; i++)
			{
				if (craftCostMaterialLinkList.Count > i)
				{
					materialItemUIComponentLinkList[i].gameObject.SetActive(value: true);
					Item item = new Item
					{
						Id = craftCostMaterialLinkList[i].materialId,
						Count = craftCostMaterialLinkList[i].materialCostCount
					};
					materialItemUIComponentLinkList[i].SetData(item, craftCostMaterialLinkList[i].possessNum, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
					materialItemUIComponentLinkList[i].UpdatePerformance();
				}
				else
				{
					materialItemUIComponentLinkList[i].gameObject.SetActive(value: false);
				}
			}
			craftMarkNormal.SetActive(craftCostMaterialLinkList.Count >= 2);
			craftMarkExtra.SetActive(value: false);
			extraCraftNumText.gameObject.SetActive(value: false);
		}
		else
		{
			for (int j = 0; j < materialItemUIComponentLinkList.Count; j++)
			{
				if (craftCostMaterialLinkList.Count > j)
				{
					materialItemUIComponentLinkList[j].gameObject.SetActive(value: true);
					if (j == 0)
					{
						Item item2 = new Item
						{
							Id = craftCostMaterialLinkList[j].materialId,
							Count = targetItemCraftNum * craftCostMaterialLinkList[j].materialCostCount
						};
						int num = targetItemCraftNum * craftCostMaterialLinkList[j].materialCostCount - craftCostMaterialLinkList[j].possessNum;
						if (num > 0)
						{
							extraCraftNumText.gameObject.SetActive(value: true);
							extraCraftNumText.SetText("+{0:0}", num);
							craftMarkNormal.SetActive(value: false);
							materialItemUIComponentLinkList[j].SetNumColor("#C5FF60");
						}
						else
						{
							extraCraftNumText.gameObject.SetActive(value: false);
							craftMarkExtra.SetActive(value: false);
							materialItemUIComponentLinkList[j].SetNumColor("#FFFFFF");
						}
						NextLevelMaterialRoot.SetActive(num > 0);
						craftMarkNormal.SetActive(num > 0);
						int num2 = ((num > 0) ? (craftCostMaterialLinkList[j].possessNum + num) : craftCostMaterialLinkList[j].possessNum);
						materialItemUIComponentLinkList[j].SetData(item2, num2, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
						materialItemUIComponentLinkList[j].UpdatePerformance();
					}
					else
					{
						Item item3 = new Item
						{
							Id = craftCostMaterialLinkList[j].materialId,
							Count = everyMaterialCostNum[craftCostMaterialLinkList[j].materialId]
						};
						materialItemUIComponentLinkList[j].SetData(item3, craftCostMaterialLinkList[j].possessNum, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
						materialItemUIComponentLinkList[j].UpdatePerformance();
					}
				}
				else
				{
					materialItemUIComponentLinkList[j].gameObject.SetActive(value: false);
				}
			}
		}
		BgMaterItem.SetActive(craftCostMaterialLinkList.Count >= 2);
		CheckCanCraft();
	}

	private void GetMultipleCraftCostMaterial()
	{
		multipleCraftCostMaterialList.Clear();
		for (int i = 0; i < targetItemData.itemCrafting.Count; i++)
		{
			if (i > 0)
			{
				multipleCraftCostMaterialList.Add(new MultipleCraftCostMaterial
				{
					id = targetItemData.itemCrafting[i].id,
					possessNum = G.localPlayer.Inventory.GetItemCount(targetItemData.itemCrafting[i].id),
					materialCostCount = targetItemData.itemCrafting[i].count
				});
			}
		}
	}

	private void GetMultipleMaxCraftNum()
	{
		int[] array = new int[multipleCraftCostMaterialList.Count];
		for (int i = 0; i < multipleCraftCostMaterialList.Count; i++)
		{
			array[i] = multipleCraftCostMaterialList[i].possessNum / multipleCraftCostMaterialList[i].materialCostCount;
		}
		maxCraftNum = Mathf.Min(array);
		minCraftNum = 1;
		targetItemCraftNum = minCraftNum;
		int num = Mathf.Max(maxCraftNum, 1);
		craftNumSlider.maxValue = num;
		craftNumSlider.minValue = minCraftNum;
		craftNumSlider.limit = num;
		craftNumSlider.value = minCraftNum;
		maxCraftNumText.SetText("{0:0}", num);
		minCraftNumText.SetText("{0:0}", minCraftNum);
	}

	private void CreateMultipleCraftMaterialCell()
	{
		for (int i = 0; i < multipleCraftRoot.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(multipleCraftRoot.transform.GetChild(i).gameObject);
		}
		multipleCraftMaterialCellList.Clear();
		foreach (MultipleCraftCostMaterial multipleCraftCostMaterial in multipleCraftCostMaterialList)
		{
			ItemUIComponentBase component = UnityEngine.Object.Instantiate(materialCellPrefab, multipleCraftRoot.transform).GetComponent<ItemUIComponentBase>();
			Item item = new Item
			{
				Id = multipleCraftCostMaterial.id,
				Count = targetItemCraftNum * multipleCraftCostMaterial.materialCostCount
			};
			component.SetData(item, multipleCraftCostMaterial.possessNum, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
			component.UpdatePerformance();
			component.gameObject.SetActive(value: true);
			multipleCraftMaterialCellList.Add(component);
		}
	}

	public void GetMultipleCraftMaterialCost(float value)
	{
		targetItemCraftNum = (int)value;
		craftNumText.SetText("{0:0}", (int)value);
		everyMaterialCostNum.Clear();
		foreach (MultipleCraftCostMaterial multipleCraftCostMaterial in multipleCraftCostMaterialList)
		{
			everyMaterialCostNum.Add(multipleCraftCostMaterial.id, targetItemCraftNum * multipleCraftCostMaterial.materialCostCount);
		}
		costCoin = targetItemCraftNum * targetItemData.itemCrafting[0].count;
		RefreshCostCoinNum(costCoin);
		UpdateMultipleCraftCostMaterialShow();
	}

	private void UpdateMultipleCraftCostMaterialShow()
	{
		for (int i = 0; i < multipleCraftCostMaterialList.Count; i++)
		{
			ItemUIComponentBase itemUIComponentBase = multipleCraftMaterialCellList[i];
			Item item = new Item
			{
				Id = multipleCraftCostMaterialList[i].id,
				Count = targetItemCraftNum * multipleCraftCostMaterialList[i].materialCostCount
			};
			itemUIComponentBase.SetData(item, multipleCraftCostMaterialList[i].possessNum, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
			itemUIComponentBase.UpdatePerformance();
		}
		CheckCanCraft();
	}

	public void ClickAddBtn()
	{
		if (craftNumSlider.interactable)
		{
			craftNumSlider.value++;
		}
	}

	public void ClickMinusBtn()
	{
		if (craftNumSlider.interactable)
		{
			craftNumSlider.value--;
		}
	}

	public void FocusBtnOpenDetail()
	{
		if (GoPopupItemCraftPanel.activeSelf)
		{
			EventSystemHelper.SetSelectedGameObject(BtnOpenDetail.gameObject);
		}
	}

	private void CheckCanCraft()
	{
		bool num = targetItemCraftNum <= 0 || maxCraftNum <= 0;
		bool flag = G.detailUserInfo.Attributes[2] < costCoin;
		if (num | flag)
		{
			confirmBtn.interactable = false;
			craftNumSlider.interactable = false;
			craftNumSlider.minValue = 1f;
			craftNumSlider.maxValue = 1f;
			craftNumSlider.limit = 1f;
			craftNumSlider.value = 1f;
		}
		else if (maxCraftNum <= 1)
		{
			confirmBtn.interactable = true;
			craftNumSlider.interactable = false;
			craftNumSlider.minValue = 1f;
			craftNumSlider.maxValue = 1f;
			craftNumSlider.limit = 1f;
			craftNumSlider.value = 1f;
		}
		else
		{
			confirmBtn.interactable = true;
			craftNumSlider.interactable = true;
			craftNumSlider.minValue = minCraftNum;
			craftNumSlider.maxValue = maxCraftNum;
			craftNumSlider.limit = maxCraftNum;
		}
		UpdateConfirmBtnPrompt();
	}

	private void UpdateConfirmBtnPrompt()
	{
		confirmBtnPrompt.SetActive(confirmBtn.interactable && confirmBtn.gameObject.activeInHierarchy);
	}

	public void Craft()
	{
		if (!canCraft)
		{
			return;
		}
		if (targetItemData == null || targetItemCraftNum <= 0 || maxCraftNum <= 0 || G.detailUserInfo.Attributes[2] < costCoin || G.localPlayer.Inventory.GetItemCount(targetItemData.id) + targetItemCraftNum > RuntimeConfigs.data.itemDatas[targetItemData.id].stackLimit)
		{
			GameUtility.OpenToolTip(924);
			return;
		}
		canCraft = false;
		Item item = new Item
		{
			Id = targetItemData.id,
			Count = targetItemCraftNum
		};
		int craftedItemId = item.Id;
		int requestVersion = m_CraftRequestVersion;
		G.service.ComposeItem(item, (bool result) =>
		{
			if (!result)
			{
				if (this != null && requestVersion == m_CraftRequestVersion)
				{
					canCraft = true;
				}
			}
			else
			{
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(new List<Item> { item }), notSort: false, () =>
				{
				});
				if (!(this == null) && requestVersion == m_CraftRequestVersion)
				{
					if (!isActiveAndEnabled)
					{
						canCraft = true;
					}
					else
					{
						SelectItemid = craftedItemId;
						RefreshBagItemList();
						canCraft = true;
						targetItemCraftNum = -1;
						RefreshRightPanel(ResolveCraftCell(craftedItemId));
					}
				}
			}
		});
	}

	private ItemUIComponentBase ResolveCraftCell(int itemId)
	{
		if (m_LastChosen != null && m_LastChosen.ItemUnifier != null && m_LastChosen.ItemUnifier.Id == itemId)
		{
			return m_LastChosen;
		}
		if (ScrollRect == null)
		{
			return null;
		}
		int itemIndex = GetItemIndex(itemId);
		if (itemIndex < 0)
		{
			return null;
		}
		ItemUIComponentBase item = ScrollRect.GetItem(itemIndex);
		if (item == null || item.ItemUnifier == null || item.ItemUnifier.Id != itemId)
		{
			return null;
		}
		return item;
	}

	private void RefreshBagItemList()
	{
		GetAssistData(isneedSort: false);
		List<ItemUnifierProxy> output = ScrollRect.ItemSource as List<ItemUnifierProxy>;
		ItemUnifierProxy.ItemUnifierPool.GetReplaceList(Items, output);
		ScrollRect.RefreshDatas();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		BtnAdd.gameObject.SetActive(type != DeviceInputMode.Gamepad);
		BtnRemove.gameObject.SetActive(type != DeviceInputMode.Gamepad);
	}
}
