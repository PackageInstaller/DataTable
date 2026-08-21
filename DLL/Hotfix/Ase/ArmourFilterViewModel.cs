using System;
using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ArmourFilterViewModel : OptionBase
{
	private readonly SimpleCommand<string> optCommand;

	private readonly InteractionRequest<string> optRequest;

	private readonly KnapsackDefinition.WarehouseScreenType screenType;

	private readonly EquipmentEnum equipmentEnum;

	private readonly List<ReportItemViewModel> filterTypes = new List<ReportItemViewModel>();

	private readonly Dictionary<int, List<ArmourFilterOptionViewModel>> filterOptionViewModelsByTypeId = new Dictionary<int, List<ArmourFilterOptionViewModel>>();

	private readonly Dictionary<int, HashSet<int>> defaultSelectedMatchIdsByTypeId = new Dictionary<int, HashSet<int>>();

	private readonly Dictionary<int, EquipmentFilterLogic> filterLogicByTypeId = new Dictionary<int, EquipmentFilterLogic>();

	private readonly Dictionary<int, List<int>> selectedMatchIdsByTypeId = new Dictionary<int, List<int>>();

	private readonly List<int> selectedFilterIds = new List<int>();

	private List<KnapsackItemViewModel> armourItems = new List<KnapsackItemViewModel>();

	private readonly List<ArmourItemData> armourItemDataList = new List<ArmourItemData>();

	private readonly Dictionary<long, ArmourItemData> selectedDecomposeByUid = new Dictionary<long, ArmourItemData>();

	private List<PropData> decomposeProducts = new List<PropData>();

	private InteractionRequest refreshDecomposeProducts = new InteractionRequest();

	private int selectedCount;

	private string selectedCountText;

	private readonly ArmourPopupViewModel armourPopupViewModel;

	private readonly RockPopupViewModel rockPopupViewModel;

	private long curSelectArmourUid;

	private bool hasFilterSelected;

	private bool isPreferenceEditing;

	private List<int> preferenceEditSnapshotFilterIds;

	private EntryItemData armourEntryItemData;

	private EntryItemData filterEntryItemData;

	private int scrollToArmourIndex = -1;

	private List<long> armourBlockList = new List<long>();

	private readonly ArmourFilterSubViewModel filterSubViewModel;

	private const int MaxDecomposeSelectCount = 1000;

	private static readonly List<ArmourFilterOptionViewModel> EmptyOptionList = new List<ArmourFilterOptionViewModel>();

	public List<ReportItemViewModel> FilterTypes => filterTypes;

	public Dictionary<int, List<ArmourFilterOptionViewModel>> FilterOptionViewModels => filterOptionViewModelsByTypeId;

	public Dictionary<int, List<int>> FilterOptions => selectedMatchIdsByTypeId;

	public List<int> SelectedFilterIds => selectedFilterIds;

	public List<KnapsackItemViewModel> ArmourItems => armourItems;

	public List<ArmourItemData> ArmourItemDataList => armourItemDataList;

	public ArmourPopupViewModel ArmourPopupViewModel => armourPopupViewModel;

	public RockPopupViewModel RockPopupViewModel => rockPopupViewModel;

	public EquipmentEnum EquipmentEnum => equipmentEnum;

	public List<PropData> DecomposeProducts => decomposeProducts;

	public InteractionRequest RefreshDecomposeProducts => refreshDecomposeProducts;

	public EntryItemData ArmourEntryItemData => armourEntryItemData;

	public EntryItemData FilterEntryItemData => filterEntryItemData;

	public int ScrollToArmourIndex => scrollToArmourIndex;

	public int SelectedCount
	{
		get
		{
			return selectedCount;
		}
		private set
		{
			Set(ref selectedCount, value, "SelectedCount");
		}
	}

	public string SelectedCountText
	{
		get
		{
			return selectedCountText;
		}
		private set
		{
			Set(ref selectedCountText, value, "SelectedCountText");
		}
	}

	public bool HasFilterSelected
	{
		get
		{
			return hasFilterSelected;
		}
		private set
		{
			Set(ref hasFilterSelected, value, "HasFilterSelected");
		}
	}

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public ArmourFilterSubViewModel FilterSubViewModel => filterSubViewModel;

	public ArmourFilterViewModel(KnapsackDefinition.WarehouseScreenType screenType = KnapsackDefinition.WarehouseScreenType.Rarity, EquipmentEnum equipmentEnum = EquipmentEnum.Armour)
	{
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		this.screenType = screenType;
		this.equipmentEnum = equipmentEnum;
		SelectedCount = 0;
		SelectedCountText = $"{SelectedCount}/{1000}";
		InitFilterGroupsFromTable();
		ApplySelectionToOptions(null, updateCommitted: true);
		armourPopupViewModel = new ArmourPopupViewModel(this, showHeroInfo: true, -81f, 12f, showOutsideMask: false);
		rockPopupViewModel = new RockPopupViewModel(this, new Vector2(-81f, 12f), showOutsideMask: false);
		filterSubViewModel = new ArmourFilterSubViewModel(this);
	}

	public ArmourFilterViewModel()
	{
	}

	public ArmourFilterViewModel(OptionBase parent, List<KnapsackItemViewModel> armourItems, List<int> serverSelectedFilterIds, KnapsackDefinition.WarehouseScreenType screenType = KnapsackDefinition.WarehouseScreenType.Rarity, EquipmentEnum equipmentEnum = EquipmentEnum.Armour)
		: this(screenType, equipmentEnum)
	{
		base.parent = parent;
		RefreshArmourItems(armourItems);
		ApplySelectionToOptions(serverSelectedFilterIds, updateCommitted: true);
	}

	public void RefreshArmourItems(List<KnapsackItemViewModel> items)
	{
		HashSet<long> selectedDecomposeUids = GetSelectedDecomposeUids();
		armourItems = items ?? new List<KnapsackItemViewModel>();
		for (int i = 0; i < armourItems.Count; i++)
		{
			if (armourItems[i] is ArmourItemData armourItemData)
			{
				armourItemData.SetParent(this);
			}
		}
		RebuildArmourItemDataList();
		RestoreDecomposeSelect(selectedDecomposeUids);
		EnsureDefaultSelectedArmour();
		UpdateDecomposeProducts();
		optRequest.Raise("RefreshArmourList");
	}

	public void SetBlockList(List<long> list)
	{
		armourBlockList = list;
	}

	public void RefreshSelectionFromServer(List<int> serverSelectedFilterIds)
	{
		ApplySelectionToOptions(serverSelectedFilterIds, updateCommitted: true);
		optRequest.Raise("RefreshFilterList");
	}

	public void ApplyFilterViewSelection(List<int> filterIds)
	{
		ApplySelectionToOptions(filterIds ?? new List<int>(), updateCommitted: true);
		optRequest.Raise("RefreshFilterList");
		optRequest.Raise("RefreshArmourList");
		SavePreferencesToService();
	}

	public List<KnapsackItemViewModel> GetDecomposeCandidates()
	{
		List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
		for (int i = 0; i < armourItems.Count; i++)
		{
			if (armourItems[i]?.PropDataBase is ArmourData armourData && armourData.GetOwnerId() <= 0 && armourData.CanDecompose() && IsMatchSelectedFilters(armourData))
			{
				list.Add(armourItems[i]);
			}
		}
		return list;
	}

	private bool IsMatchSelectedFilters(ArmourData armourData)
	{
		if (armourData == null)
		{
			return false;
		}
		if (!HasAnyFilterSelection())
		{
			return true;
		}
		foreach (KeyValuePair<int, List<int>> item in selectedMatchIdsByTypeId)
		{
			int key = item.Key;
			List<int> value = item.Value;
			if (value == null || value.Count <= 0)
			{
				continue;
			}
			bool flag = false;
			EquipmentFilterLogic filterLogic = GetFilterLogic(key);
			for (int i = 0; i < value.Count; i++)
			{
				if (IsMatch(filterLogic, value[i], armourData))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	public bool ShouldKeep(ArmourData armourData)
	{
		if (armourData == null)
		{
			return false;
		}
		if (armourData.GetOwnerId() > 0)
		{
			return true;
		}
		if (!HasAnyFilterSelection())
		{
			return false;
		}
		foreach (KeyValuePair<int, List<int>> item in selectedMatchIdsByTypeId)
		{
			int key = item.Key;
			List<int> value = item.Value;
			bool flag = false;
			EquipmentFilterLogic filterLogic = GetFilterLogic(key);
			if (value != null)
			{
				for (int i = 0; i < value.Count; i++)
				{
					if (IsMatch(filterLogic, value[i], armourData))
					{
						flag = true;
						break;
					}
				}
			}
			if (value != null && value.Count > 0 && !flag)
			{
				return false;
			}
		}
		return true;
	}

	private bool HasAnyFilterSelection()
	{
		if (selectedFilterIds != null)
		{
			return selectedFilterIds.Count > 0;
		}
		return false;
	}

	public void ResetToDefault()
	{
		ApplySelectionToOptions(null, !isPreferenceEditing);
		optRequest.Raise("RefreshFilterList");
	}

	public void ConfirmPreferenceSelection()
	{
		CommitPreferenceEdit();
		optRequest.Raise("RefreshFilterList");
	}

	public void RefreshArmourItemsFromServiceIfEmpty()
	{
		if (armourItems == null || armourItems.Count <= 0)
		{
			ReloadArmoursFromService();
		}
	}

	private void ReloadArmoursFromService()
	{
		List<KnapsackItemViewModel> items = ArmourFilterDataUtil.BuildArmourItemsForDecomposeWindow(this, out var _, screenType, armourBlockList, equipmentEnum);
		RefreshArmourItems(items);
	}

	private void InitFilterGroupsFromTable()
	{
		filterTypes.Clear();
		filterOptionViewModelsByTypeId.Clear();
		defaultSelectedMatchIdsByTypeId.Clear();
		filterLogicByTypeId.Clear();
		EquipmentFilterScene filterScene = EquipmentFilterDefinition.GetWarehouseScene(equipmentEnum);
		DREquipmentFilterType[] dataRows = GameEntry.DataTable.GetDataRows((DREquipmentFilterType p) => p.IsActive && EquipmentFilterDefinition.ContainsScene(p, filterScene));
		DREquipmentFilter[] dataRows2 = GameEntry.DataTable.GetDataRows((DREquipmentFilter p) => true);
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		dataRows = dataRows.OrderBy((DREquipmentFilterType p) => p.Id).ToArray();
		foreach (DREquipmentFilterType type in dataRows)
		{
			ReportItemViewModel reportItemViewModel = new ReportItemViewModel(this, type.TypeName, type.Id);
			EquipmentFilterLogic filterLogic = EquipmentFilterDefinition.GetFilterLogic(type);
			List<ArmourFilterOptionViewModel> list = new List<ArmourFilterOptionViewModel>();
			HashSet<int> hashSet = new HashSet<int>();
			if (dataRows2 != null && dataRows2.Length != 0)
			{
				DREquipmentFilter[] array = (from p in dataRows2
					where p.TypeId == type.Id
					orderby p.Id
					select p).ToArray();
				foreach (DREquipmentFilter dREquipmentFilter in array)
				{
					ArmourFilterOptionViewModel item = new ArmourFilterOptionViewModel(this, dREquipmentFilter.Choice, dREquipmentFilter.Id, dREquipmentFilter.MatchId, dREquipmentFilter.TypeId, dREquipmentFilter.IsAcquiesce, filterLogic);
					list.Add(item);
					if (dREquipmentFilter.IsAcquiesce)
					{
						hashSet.Add(dREquipmentFilter.MatchId);
					}
				}
			}
			if (list.Count > 0)
			{
				filterTypes.Add(reportItemViewModel);
				filterOptionViewModelsByTypeId[reportItemViewModel.ReportId] = list;
				defaultSelectedMatchIdsByTypeId[reportItemViewModel.ReportId] = hashSet;
				filterLogicByTypeId[reportItemViewModel.ReportId] = filterLogic;
			}
		}
	}

	private void ApplySelectionToOptions(List<int> serverSelectedFilterIds, bool updateCommitted)
	{
		bool flag = serverSelectedFilterIds == null;
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			int key = item.Key;
			List<ArmourFilterOptionViewModel> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				bool flag2 = ((!flag) ? serverSelectedFilterIds.Contains(value[i].FilterId) : (defaultSelectedMatchIdsByTypeId.TryGetValue(key, out var value2) && value2.Contains(value[i].MatchId)));
				value[i].SetSelect(flag2);
			}
		}
		if (updateCommitted)
		{
			RebuildSelectedMatchIds();
		}
	}

	private void RebuildSelectedMatchIds()
	{
		selectedMatchIdsByTypeId.Clear();
		selectedFilterIds.Clear();
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			int key = item.Key;
			List<ArmourFilterOptionViewModel> value = item.Value;
			List<int> list = new List<int>();
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].IsSelect)
				{
					list.Add(value[i].MatchId);
					selectedFilterIds.Add(value[i].FilterId);
				}
			}
			selectedMatchIdsByTypeId[key] = list;
		}
		HasFilterSelected = selectedFilterIds.Count > 0;
	}

	private List<int> GetDefaultSelectedFilterIds()
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			int key = item.Key;
			if (!defaultSelectedMatchIdsByTypeId.TryGetValue(key, out var value) || value == null || value.Count <= 0)
			{
				continue;
			}
			List<ArmourFilterOptionViewModel> value2 = item.Value;
			for (int i = 0; i < value2.Count; i++)
			{
				if (value.Contains(value2[i].MatchId))
				{
					list.Add(value2[i].FilterId);
				}
			}
		}
		return list;
	}

	private void BeginPreferenceEdit()
	{
		if (!isPreferenceEditing)
		{
			preferenceEditSnapshotFilterIds = new List<int>(selectedFilterIds);
			isPreferenceEditing = true;
		}
	}

	private void CancelPreferenceEdit()
	{
		if (isPreferenceEditing)
		{
			ApplySelectionToOptions(preferenceEditSnapshotFilterIds, updateCommitted: true);
			isPreferenceEditing = false;
			preferenceEditSnapshotFilterIds = null;
		}
	}

	private void CommitPreferenceEdit()
	{
		if (!isPreferenceEditing)
		{
			RebuildSelectedMatchIds();
			return;
		}
		RebuildSelectedMatchIds();
		isPreferenceEditing = false;
		preferenceEditSnapshotFilterIds = null;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if ("ChangeLock".Equals(optionArg.OptionName))
			{
				ReloadArmoursFromService();
			}
			else if ("OnShowEntryPanel".Equals(optionArg.OptionName) && optionArg.Obj is EntryItem entryItem)
			{
				entryItem.ViewModel.SetSelect(isSelect: true);
				armourEntryItemData = entryItem.ViewModel;
				optRequest.Raise("ShowArmourEntryInfo");
			}
			else if ("Press".Equals(optionArg.OptionName) && optionArg.Obj is ArmourFilterOptionViewModel filterOption)
			{
				ShowFilterEntryInfo(filterOption);
			}
			else if ("CloseArmourFilterView".Equals(optionArg.OptionName) && optionArg.Obj is ArmourFilterSubViewModel armourFilterSubViewModel)
			{
				ApplyFilterViewSelection(armourFilterSubViewModel.SelectedFilterIds);
				optRequest.Raise("CloseFilterView");
			}
			else if ("CancelArmourFilterView".Equals(optionArg.OptionName))
			{
				optRequest.Raise("CloseFilterView");
			}
		}
		else if (obj is ArmourFilterOptionViewModel)
		{
			if (!isPreferenceEditing)
			{
				RebuildSelectedMatchIds();
			}
		}
		else if (obj is ArmourItemData armourItemData)
		{
			OnArmourItemClick(armourItemData);
		}
		base.ItemOnClick(obj);
	}

	private void ShowFilterEntryInfo(ArmourFilterOptionViewModel filterOption)
	{
		if (filterOption != null && EquipmentFilterDefinition.IsEntryFilterLogic(filterOption.FilterLogic))
		{
			int matchId = filterOption.MatchId;
			if (matchId > 0)
			{
				EntryItemData entryItemData = new EntryItemData(new EntryData(matchId, 1));
				filterEntryItemData = entryItemData;
				optRequest.Raise("ShowFilterEntryInfo");
			}
		}
	}

	private void OnArmourItemClick(ArmourItemData armourItemData)
	{
		if (armourItemData == null || armourItemData.Data == null)
		{
			return;
		}
		curSelectArmourUid = armourItemData.Data.Uid;
		for (int i = 0; i < armourItemDataList.Count; i++)
		{
			if (armourItemDataList[i]?.Data != null)
			{
				armourItemDataList[i].IsSelected = armourItemDataList[i].Data.Uid == curSelectArmourUid;
			}
		}
		RefreshPopupData(armourItemData.Data);
		if (!armourItemData.Data.CanDecompose())
		{
			if (armourItemData.Data.GetOwnerId() > 0)
			{
				Toast.ShowInfo("已穿戴，无法分解");
			}
			else if (armourItemData.Data.IsLock)
			{
				Toast.ShowInfo("已锁定，无法分解");
			}
		}
		else
		{
			ToggleSelectDecompose(armourItemData);
		}
	}

	private void ToggleSelectDecompose(ArmourItemData armourItemData)
	{
		long uid = armourItemData.Data.Uid;
		if (uid <= 0)
		{
			return;
		}
		if (selectedDecomposeByUid.ContainsKey(uid))
		{
			selectedDecomposeByUid.Remove(uid);
			armourItemData.IsToggleOn = false;
		}
		else
		{
			if (selectedDecomposeByUid.Count >= 1000)
			{
				Toast.ShowInfo($"单次最多选择{1000}个");
				return;
			}
			selectedDecomposeByUid[uid] = armourItemData;
			armourItemData.IsToggleOn = true;
		}
		UpdateDecomposeProducts();
	}

	public void AutoSelectDecompose()
	{
		if (!HasAnyFilterSelection())
		{
			Toast.ShowInfo("请先设置筛选规则");
			return;
		}
		ClearDecomposeSelect(updateProducts: false);
		List<KnapsackItemViewModel> decomposeCandidates = GetDecomposeCandidates();
		HashSet<long> hashSet = new HashSet<long>();
		for (int i = 0; i < decomposeCandidates.Count; i++)
		{
			ArmourItemData armourItemData = decomposeCandidates[i] as ArmourItemData;
			if (armourItemData?.Data != null && armourItemData.Data.Uid > 0)
			{
				hashSet.Add(armourItemData.Data.Uid);
			}
		}
		for (int j = 0; j < armourItemDataList.Count; j++)
		{
			if (selectedDecomposeByUid.Count >= 1000)
			{
				break;
			}
			ArmourItemData armourItemData2 = armourItemDataList[j];
			if (armourItemData2 != null && armourItemData2.Data != null && hashSet.Contains(armourItemData2.Data.Uid) && armourItemData2.Data.CanDecompose())
			{
				long uid = armourItemData2.Data.Uid;
				if (uid > 0)
				{
					selectedDecomposeByUid[uid] = armourItemData2;
					armourItemData2.IsToggleOn = true;
				}
			}
		}
		UpdateDecomposeProducts();
		scrollToArmourIndex = GetFirstSelectedArmourIndex();
		if (scrollToArmourIndex >= 0)
		{
			optRequest.Raise("ScrollToSelectedArmour");
		}
	}

	private int GetFirstSelectedArmourIndex()
	{
		if (armourItemDataList == null || armourItemDataList.Count <= 0)
		{
			return -1;
		}
		for (int i = 0; i < armourItemDataList.Count; i++)
		{
			if (armourItemDataList[i] != null && armourItemDataList[i].IsToggleOn)
			{
				return i;
			}
		}
		return -1;
	}

	private void ClearDecomposeSelect(bool updateProducts = true)
	{
		foreach (ArmourItemData value in selectedDecomposeByUid.Values)
		{
			value.IsToggleOn = false;
		}
		selectedDecomposeByUid.Clear();
		if (updateProducts)
		{
			UpdateDecomposeProducts();
		}
	}

	public async void DecomposeSelected()
	{
		if (selectedDecomposeByUid.Count <= 0)
		{
			Toast.ShowInfo((equipmentEnum == EquipmentEnum.SuitBox) ? "请选择一个手提箱分解" : "请选择一件明饰分解");
			optCommand.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		List<long> list = new List<long>();
		foreach (ArmourItemData value in selectedDecomposeByUid.Values)
		{
			if (value?.Data != null)
			{
				list.Add(value.Data.Uid);
			}
		}
		RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().RequestDecomposeEquipment(list, equipmentEnum);
		if (rewardGetData != null)
		{
			ClearDecomposeSelect();
			if (rewardGetData.PropList != null && rewardGetData.PropList.Count > 0)
			{
				PropGetViewModel userData = new PropGetViewModel(this, rewardGetData.PropList);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
			}
			ReloadArmoursFromService();
		}
		loading?.Dispose();
		optCommand.Enabled = true;
	}

	private void UpdateDecomposeProducts()
	{
		decomposeProducts.Clear();
		SelectedCount = selectedDecomposeByUid.Count;
		SelectedCountText = $"{SelectedCount}/{1000}";
		if (selectedDecomposeByUid.Count <= 0)
		{
			refreshDecomposeProducts.Raise();
			return;
		}
		List<ArmourData> list = new List<ArmourData>();
		foreach (ArmourItemData value in selectedDecomposeByUid.Values)
		{
			if (value?.Data != null)
			{
				list.Add(value.Data);
			}
		}
		decomposeProducts = ((equipmentEnum == EquipmentEnum.SuitBox) ? KnapsackDefinition.GetSuitBoxDecomposeProducts(list) : KnapsackDefinition.GetArmourDecomposeProducts(list));
		decomposeProducts.ClearZeroAmount();
		refreshDecomposeProducts.Raise();
	}

	private void RebuildArmourItemDataList()
	{
		armourItemDataList.Clear();
		for (int i = 0; i < armourItems.Count; i++)
		{
			if (armourItems[i] is ArmourItemData item)
			{
				armourItemDataList.Add(item);
			}
		}
	}

	private HashSet<long> GetSelectedDecomposeUids()
	{
		HashSet<long> hashSet = new HashSet<long>();
		foreach (KeyValuePair<long, ArmourItemData> item in selectedDecomposeByUid)
		{
			if (item.Key > 0)
			{
				hashSet.Add(item.Key);
			}
		}
		return hashSet;
	}

	private void RestoreDecomposeSelect(HashSet<long> selectedDecomposeUids)
	{
		selectedDecomposeByUid.Clear();
		for (int i = 0; i < armourItemDataList.Count; i++)
		{
			ArmourItemData armourItemData = armourItemDataList[i];
			if (armourItemData?.Data != null)
			{
				long uid = armourItemData.Data.Uid;
				if (armourItemData.IsToggleOn = selectedDecomposeUids != null && selectedDecomposeUids.Contains(uid) && armourItemData.Data.CanDecompose())
				{
					selectedDecomposeByUid[uid] = armourItemData;
				}
			}
		}
	}

	private void EnsureDefaultSelectedArmour()
	{
		if (armourItemDataList.Count <= 0)
		{
			return;
		}
		ArmourItemData armourItemData = null;
		if (curSelectArmourUid > 0)
		{
			for (int i = 0; i < armourItemDataList.Count; i++)
			{
				if (armourItemDataList[i]?.Data != null && armourItemDataList[i].Data.Uid == curSelectArmourUid)
				{
					armourItemData = armourItemDataList[i];
					break;
				}
			}
		}
		if (armourItemData == null)
		{
			armourItemData = armourItemDataList[0];
		}
		if (armourItemData?.Data == null)
		{
			return;
		}
		curSelectArmourUid = armourItemData.Data.Uid;
		for (int j = 0; j < armourItemDataList.Count; j++)
		{
			if (armourItemDataList[j]?.Data != null)
			{
				armourItemDataList[j].IsSelected = armourItemDataList[j].Data.Uid == curSelectArmourUid;
			}
		}
		RefreshPopupData(armourItemData.Data);
	}

	private void RefreshPopupData(ArmourData armourData)
	{
		if (equipmentEnum == EquipmentEnum.SuitBox)
		{
			rockPopupViewModel.RefreshData(armourData);
		}
		else
		{
			armourPopupViewModel.RefreshData(armourData);
		}
	}

	private EquipmentFilterLogic GetFilterLogic(int typeId)
	{
		if (filterLogicByTypeId.TryGetValue(typeId, out var value))
		{
			return value;
		}
		return EquipmentFilterDefinition.GetDefaultFilterLogic(typeId);
	}

	private static bool IsMatch(EquipmentFilterLogic filterLogic, int matchId, ArmourData armourData)
	{
		switch (filterLogic)
		{
		case EquipmentFilterLogic.Rarity:
			return armourData.Rarity == matchId;
		case EquipmentFilterLogic.Rank:
			return armourData.Rank == matchId;
		case EquipmentFilterLogic.Part:
		{
			if (TryGetArmourEnum(matchId, out var armourEnum))
			{
				return armourData.ArmourEnum == armourEnum;
			}
			return false;
		}
		case EquipmentFilterLogic.MainAttribute:
		{
			EquipAttribute mainAttribute = armourData.GetMainAttribute();
			if (mainAttribute == null)
			{
				return false;
			}
			return mainAttribute.Id == matchId;
		}
		case EquipmentFilterLogic.SubAttribute:
			return armourData.GetSubAttribute().Any((EquipAttribute p) => p.Id == matchId);
		case EquipmentFilterLogic.FixedEntry:
			if (armourData.EntryDataList != null && armourData.EntryDataList.Count > 0 && armourData.EntryDataList[0].DrEntry != null)
			{
				return armourData.EntryDataList[0].DrEntry.EntryId == matchId;
			}
			return false;
		case EquipmentFilterLogic.OtherEntry:
			if (armourData.AdditionalEntryList != null)
			{
				return armourData.AdditionalEntryList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
			}
			return false;
		case EquipmentFilterLogic.MainEntry:
			if (armourData.EquipmentEnum == EquipmentEnum.SuitBox && armourData.EntryDataList != null)
			{
				return armourData.EntryDataList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
			}
			return false;
		default:
			return false;
		}
	}

	private static bool TryGetArmourEnum(int matchId, out ArmourEnum armourEnum)
	{
		if (Enum.IsDefined(typeof(ArmourEnum), matchId))
		{
			armourEnum = (ArmourEnum)matchId;
			return true;
		}
		armourEnum = ArmourEnum.Box;
		return false;
	}

	public void OnOpt(string optName)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		if ("Decompose".Equals(optName))
		{
			DecomposeSelected();
		}
		else if ("AutoSelect".Equals(optName))
		{
			AutoSelectDecompose();
			optCommand.Enabled = true;
		}
		else if ("OpenFilterView".Equals(optName))
		{
			if (FilterTypes == null || FilterTypes.Count <= 0)
			{
				optCommand.Enabled = true;
				return;
			}
			filterSubViewModel.BeginEdit(FilterTypes, FilterOptionViewModels, SelectedFilterIds, GetDefaultSelectedFilterIds());
			optRequest.Raise("OpenFilterView");
			optCommand.Enabled = true;
		}
		else if ("CloseFilterView".Equals(optName))
		{
			optRequest.Raise("CloseFilterView");
			optCommand.Enabled = true;
		}
		else if ("ResetFilter".Equals(optName))
		{
			ResetToDefault();
			optCommand.Enabled = true;
		}
		else if ("ConfirmFilter".Equals(optName))
		{
			CommitPreferenceEdit();
			optRequest.Raise("CloseFilterView");
			SavePreferencesToService();
			optCommand.Enabled = true;
		}
		else
		{
			optCommand.Enabled = true;
		}
	}

	private async void SavePreferencesToService()
	{
		List<int> preferences = ((selectedFilterIds != null) ? new List<int>(selectedFilterIds) : new List<int>());
		await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().SetEquipmentDecomposePreferences(equipmentEnum, preferences);
	}

	public List<ArmourFilterOptionViewModel> GetFilterOptionViewModelsByIndex(int typeIndex)
	{
		if (typeIndex < 0 || typeIndex >= filterTypes.Count)
		{
			return EmptyOptionList;
		}
		int reportId = filterTypes[typeIndex].ReportId;
		if (!filterOptionViewModelsByTypeId.TryGetValue(reportId, out var value) || value == null)
		{
			return EmptyOptionList;
		}
		return value;
	}
}
