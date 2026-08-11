#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ArmourChangeViewModel : OptionBase
{
	protected ArmourEnum curArmourType;

	protected HeroModel heroModel;

	protected Dictionary<long, ArmourItemData> datas;

	protected List<ArmourItemData> filterResultsArmourData;

	protected List<ArmourItemData> equipmentShowList;

	protected ArmourItemData curItemData;

	protected ArmourData armourData;

	protected TabItemData curTab;

	protected TabItemNormalData exactBtn;

	protected TabItemNormalData fuzzyBtn;

	protected EntryCompareViewModel entryContrastViewModel;

	protected ArmourDetailViewModel contrastViewModel;

	protected ArmourDetailViewModel selectedViewModel;

	protected TabItemData armourContrastTabItemData;

	protected TabItemData entryContrastTabItemData;

	protected EntryInfoViewModel entryInfoViewModel;

	protected bool _showArmour;

	protected bool _showArmourMask;

	protected List<TabItemData> tabDataList;

	protected bool exactMatch;

	protected InteractionRequest refreshShowDatasRequest;

	protected InteractionRequest<EntryItemData> _showEntryDetailRequest;

	protected InteractionRequest hideEntryDetailRequest;

	protected InteractionRequest armourChangeRequest;

	protected InteractionRequest closeEffectRequest;

	protected InteractionRequest refreshRedPointRequest;

	protected readonly SimpleCommand<string> optCommand;

	protected readonly InteractionRequest<string> optRequest;

	protected readonly ArmourFilterSubViewModel filterSubViewModel;

	protected readonly List<ReportItemViewModel> filterTypes = new List<ReportItemViewModel>();

	protected readonly Dictionary<int, List<ArmourFilterOptionViewModel>> filterOptionViewModelsByTypeId = new Dictionary<int, List<ArmourFilterOptionViewModel>>();

	protected readonly Dictionary<int, EquipmentFilterLogic> filterLogicByTypeId = new Dictionary<int, EquipmentFilterLogic>();

	protected readonly Dictionary<int, List<int>> selectedMatchIdsByTypeId = new Dictionary<int, List<int>>();

	protected readonly List<int> selectedFilterIds = new List<int>();

	protected ArmourRecommendViewModel armourRecommendViewModel;

	protected ArmourRecommendViewModel pendingRecommendFilter;

	protected bool pendingRecommendFilterIncludeOtherEntry = true;

	protected Dictionary<int, string> sortTypeName = new Dictionary<int, string>
	{
		[1] = "等级排序",
		[2] = "稀有度排序",
		[3] = "RANK排序"
	};

	protected bool showDialogWindow;

	protected string dialogText;

	protected int curSortType = 1;

	protected string curSortName;

	protected bool isEmpty;

	protected List<ArmourScreenItemData> screenItemData;

	protected Dictionary<int, int> attributeSelected;

	protected Dictionary<int, int> fixEntrySelected;

	protected Dictionary<int, int> otherEntrySelected;

	protected List<ArmourScreenTagItemData> selectedScreenTagData;

	protected InteractionRequest _refreshSelectedRequest;

	protected InteractionRequest _refreshScreenItemRequest;

	protected InteractionRequest _refreshArmourShowRequest;

	protected InteractionRequest _closeScreenRequest;

	protected bool clearBtnCanClick;

	protected bool isShowScreenResult;

	protected bool isArmourChanging;

	private bool contrastPanelVisible;

	public ArmourEnum CurArmourType => curArmourType;

	public EntryInfoViewModel EntryInfoViewModel => entryInfoViewModel;

	public EntryCompareViewModel EntryContrastViewModel => entryContrastViewModel;

	public TabItemData ArmourContrastTabItemData => armourContrastTabItemData;

	public TabItemData EntryContrastTabItemData => entryContrastTabItemData;

	public Dictionary<int, string> SortTypeName => sortTypeName;

	public List<ArmourScreenItemData> ScreenItemData => screenItemData;

	public bool ContrastPanelVisible
	{
		get
		{
			return contrastPanelVisible;
		}
		set
		{
			Set(ref contrastPanelVisible, value, "ContrastPanelVisible");
		}
	}

	public InteractionRequest RefreshShowDatasRequest => refreshShowDatasRequest;

	public InteractionRequest HideEntryDetailRequest => hideEntryDetailRequest;

	public InteractionRequest ArmourChangeRequest => armourChangeRequest;

	public InteractionRequest CloseEffectRequest => closeEffectRequest;

	public InteractionRequest RefreshRedPointRequest => refreshRedPointRequest;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => _showEntryDetailRequest;

	public InteractionRequest CloseScreenRequest => _closeScreenRequest;

	public ArmourDetailViewModel SelectedViewModel => selectedViewModel;

	public ArmourDetailViewModel ContrastViewModel => contrastViewModel;

	public List<TabItemData> TabDataList => tabDataList;

	public List<ArmourItemData> EquipmentShowList
	{
		get
		{
			return equipmentShowList;
		}
		private set
		{
			Set(ref equipmentShowList, value, "EquipmentShowList");
		}
	}

	public int CurSortType
	{
		get
		{
			return curSortType;
		}
		set
		{
			Set(ref curSortType, value, "CurSortType");
			CurSortName = sortTypeName[curSortType];
		}
	}

	public string CurSortName
	{
		get
		{
			return curSortName;
		}
		set
		{
			Set(ref curSortName, value, "CurSortName");
		}
	}

	public virtual string CurrentSlotTitle => "当前佩戴";

	public bool ClearBtnCanClick
	{
		get
		{
			return clearBtnCanClick;
		}
		private set
		{
			Set(ref clearBtnCanClick, value, "ClearBtnCanClick");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		private set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public ArmourData ArmourData
	{
		get
		{
			return armourData;
		}
		set
		{
			Set(ref armourData, value, "ArmourData");
			_refreshArmourShowRequest.Raise();
		}
	}

	public bool ShowArmour
	{
		get
		{
			return _showArmour;
		}
		protected set
		{
			Set(ref _showArmour, value, "ShowArmour");
		}
	}

	public bool ShowArmourMask
	{
		get
		{
			return _showArmourMask;
		}
		protected set
		{
			Set(ref _showArmourMask, value, "ShowArmourMask");
		}
	}

	public List<ArmourScreenTagItemData> SelectedScreenTagData
	{
		get
		{
			return selectedScreenTagData;
		}
		private set
		{
			Set(ref selectedScreenTagData, value, "SelectedScreenTagData");
		}
	}

	public bool IsShowScreenResult
	{
		get
		{
			return isShowScreenResult;
		}
		set
		{
			Set(ref isShowScreenResult, value, "IsShowScreenResult");
		}
	}

	public TabItemNormalData ExactBtn => exactBtn;

	public TabItemNormalData FuzzyBtn => fuzzyBtn;

	public InteractionRequest RefreshSelectedRequest => _refreshSelectedRequest;

	public InteractionRequest RefreshScreenItemRequest => _refreshScreenItemRequest;

	public InteractionRequest RefreshArmourShowRequest => _refreshArmourShowRequest;

	public ArmourFilterSubViewModel FilterSubViewModel => filterSubViewModel;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public ArmourChangeViewModel(OptionBase parent, HeroModel heroModel, ArmourEnum armourEnum)
		: this(parent, heroModel, armourEnum, deferInitialize: false)
	{
	}

	protected ArmourChangeViewModel(OptionBase parent, HeroModel heroModel, ArmourEnum armourEnum, bool deferInitialize)
	{
		base.parent = parent;
		_refreshArmourShowRequest = new InteractionRequest();
		_showEntryDetailRequest = new InteractionRequest<EntryItemData>();
		hideEntryDetailRequest = new InteractionRequest();
		_closeScreenRequest = new InteractionRequest();
		armourChangeRequest = new InteractionRequest();
		closeEffectRequest = new InteractionRequest();
		refreshRedPointRequest = new InteractionRequest();
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		filterSubViewModel = new ArmourFilterSubViewModel(this);
		entryInfoViewModel = new EntryInfoViewModel(this);
		entryContrastViewModel = new EntryCompareViewModel(this);
		armourContrastTabItemData = new TabItemData(this, -1);
		entryContrastTabItemData = new TabItemData(this, -2);
		this.heroModel = heroModel;
		equipmentShowList = new List<ArmourItemData>();
		filterResultsArmourData = new List<ArmourItemData>();
		datas = new Dictionary<long, ArmourItemData>();
		tabDataList = new List<TabItemData>();
		for (int i = 0; i < 6; i++)
		{
			tabDataList.Add(new TabItemData(this, i));
		}
		showDialogWindow = false;
		SetCurTab(tabDataList[(int)armourEnum]);
		refreshShowDatasRequest = new InteractionRequest();
		if (!deferInitialize)
		{
			InitializeAfterSetup();
		}
	}

	protected virtual void InitializeAfterSetup()
	{
		ClearBtnCanClick = false;
		InitFilterGroupsFromTable();
		LoadTags();
		GetSaveInfo();
		SetShowArmours();
		selectedViewModel = new ArmourDetailViewModel(this, null);
		contrastViewModel = new ArmourDetailViewModel(this, null);
		RefreshCurrentSlotData();
		HideContrastPanel();
		selectedViewModel.Type = 1;
		contrastViewModel.Type = 2;
		SetEquipmentShowList();
		attributeSelected = new Dictionary<int, int>();
		fixEntrySelected = new Dictionary<int, int>();
		otherEntrySelected = new Dictionary<int, int>();
		selectedScreenTagData = new List<ArmourScreenTagItemData>();
		_refreshSelectedRequest = new InteractionRequest();
		_refreshScreenItemRequest = new InteractionRequest();
		if (pendingRecommendFilter != null)
		{
			ApplyRecommendFilter(pendingRecommendFilter, pendingRecommendFilterIncludeOtherEntry);
			pendingRecommendFilter = null;
			pendingRecommendFilterIncludeOtherEntry = true;
		}
	}

	protected ArmourChangeViewModel()
	{
	}

	protected virtual ArmourData GetCurrentSlotArmourData()
	{
		if (heroModel != null && heroModel.Armours != null && heroModel.Armours.TryGetValue((int)curArmourType, out var value))
		{
			return value;
		}
		return null;
	}

	protected virtual void RefreshCurrentSlotData()
	{
		ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
		if (currentSlotArmourData != null)
		{
			armourData = currentSlotArmourData;
			_showArmour = true;
			_showArmourMask = false;
			selectedViewModel.RefreshData(currentSlotArmourData);
			contrastViewModel.RefreshData(currentSlotArmourData);
			selectedViewModel.RightBtnText = "强化";
			selectedViewModel.LeftBtnText = "卸下";
		}
		else
		{
			armourData = null;
			_showArmour = false;
			_showArmourMask = false;
			selectedViewModel.RefreshData(null);
			contrastViewModel.RefreshData(null);
			selectedViewModel.RightBtnText = "强化";
		}
	}

	public void ApplyRecommendFilterOnOpen(ArmourRecommendViewModel recommendViewModel, bool includeOtherEntry = true)
	{
		if (filterOptionViewModelsByTypeId.Count <= 0 || datas == null)
		{
			pendingRecommendFilter = recommendViewModel;
			pendingRecommendFilterIncludeOtherEntry = includeOtherEntry;
		}
		else
		{
			ApplyRecommendFilter(recommendViewModel, includeOtherEntry);
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}

	public bool GetRedPoint(int index)
	{
		if (heroModel.Armours.ContainsKey(index) && heroModel.Armours[index] != null)
		{
			return false;
		}
		List<ArmourData> armourListByType = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourListByType((ArmourEnum)index);
		if (armourListByType.Count == 0)
		{
			return false;
		}
		foreach (ArmourData item in armourListByType)
		{
			if (item.GetOwnerId() == 0)
			{
				return true;
			}
		}
		return false;
	}

	protected virtual void LoadTags()
	{
		screenItemData = new List<ArmourScreenItemData>();
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		List<int> list3 = new List<int>();
		DRAttributeTotal[] allDataRows = GameEntry.DataTable.GetDataTable<DRAttributeTotal>().GetAllDataRows();
		foreach (DRAttributeTotal dRAttributeTotal in allDataRows)
		{
			if (dRAttributeTotal.Type == 2)
			{
				list.Add(dRAttributeTotal.Id);
			}
			else if (dRAttributeTotal.Type == 3)
			{
				if (dRAttributeTotal.EntryType == 1)
				{
					list2.Add(dRAttributeTotal.Id);
				}
				else if (dRAttributeTotal.EntryType == 2)
				{
					list3.Add(dRAttributeTotal.Id);
				}
			}
		}
		screenItemData.Add(LoadScreenData(1, list));
		screenItemData.Add(LoadScreenData(2, list2));
		screenItemData.Add(LoadScreenData(3, list3));
	}

	protected virtual ArmourScreenItemData LoadScreenData(int type, List<int> uidList)
	{
		List<ArmourScreenTagItemData> armourScreenTagItemData = LoadTagData(uidList);
		return new ArmourScreenItemData(this, type, armourScreenTagItemData);
	}

	protected virtual List<ArmourScreenTagItemData> LoadTagData(List<int> uidList)
	{
		List<ArmourScreenTagItemData> list = new List<ArmourScreenTagItemData>();
		foreach (int uid in uidList)
		{
			ArmourScreenTagItemData item = new ArmourScreenTagItemData(this, uid);
			list.Add(item);
		}
		return list;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ArmourItemData itemData)
		{
			EquipmentOnClick(itemData);
		}
		else if (obj is ArmourDetailViewModel armourDetailViewModel)
		{
			if (armourDetailViewModel.ActionName.Equals("Equip"))
			{
				if (!isArmourChanging)
				{
					ChangeEquipment();
				}
			}
			else if (armourDetailViewModel.ActionName.Equals("Remove"))
			{
				if (!isArmourChanging)
				{
					RemoveEquip();
				}
			}
			else if (armourDetailViewModel.ActionName.Equals("OpenCultureWindow"))
			{
				OpenCultureWindow();
			}
		}
		else if (obj is TabItemData tabItemData)
		{
			if (tabItemData.TabIndex >= 0)
			{
				if (curArmourType != (ArmourEnum)tabItemData.TabIndex)
				{
					hideEntryDetailRequest.Raise();
					SetCurTab(tabItemData);
					EquipmentShowList = filterResultsArmourData.FindAll((ArmourItemData p) => p.Data.ArmourEnum == CurArmourType);
					SelectFirstItem(IsShowScreenResult);
				}
			}
			else
			{
				OnContrastTabClick(tabItemData.TabIndex);
			}
		}
		else if (obj is OptionArg optionArg && "CloseArmourFilterView".Equals(optionArg.OptionName) && optionArg.Obj is ArmourFilterSubViewModel armourFilterSubViewModel)
		{
			ApplyFilterViewSelection(armourFilterSubViewModel.SelectedFilterIds);
			optRequest.Raise("CloseFilterView");
		}
		else if (obj is OptionArg optionArg2 && "CancelArmourFilterView".Equals(optionArg2.OptionName))
		{
			optRequest.Raise("CloseFilterView");
		}
		else if (obj is ArmourCultureViewModel)
		{
			long uid = curItemData.Data.Uid;
			SetShowArmours();
			RefreshScreenArmour();
			EquipmentOnClick(datas[uid], needCheck: false);
			refreshRedPointRequest.Raise();
		}
		else if (obj is int index)
		{
			RefreshSortEquipment(index);
		}
		else if (obj is ArmourScreenTagItemData data)
		{
			ScreenTagItemOnclick(data);
		}
		else if (obj is ArmourScreenItemData)
		{
			_refreshScreenItemRequest.Raise();
		}
		else if (obj is OptionArg optionArg3)
		{
			if ("QuickFilterRecommend".Equals(optionArg3.OptionName) && optionArg3.Obj is ArmourRecommendViewModel armourRecommendViewModel)
			{
				ApplyRecommendFilter(armourRecommendViewModel);
				showViewRequest.Raise(new ShowViewArg(armourRecommendViewModel, isShow: false));
			}
			else if ("QuickFilterRecommendWithoutOtherEntry".Equals(optionArg3.OptionName) && optionArg3.Obj is ArmourRecommendViewModel armourRecommendViewModel2)
			{
				ApplyRecommendFilter(armourRecommendViewModel2, includeOtherEntry: false);
				showViewRequest.Raise(new ShowViewArg(armourRecommendViewModel2, isShow: false));
			}
			else if ("CloseRecommend".Equals(optionArg3.OptionName) && optionArg3.Obj is ArmourRecommendViewModel userData)
			{
				showViewRequest.Raise(new ShowViewArg(userData, isShow: false));
			}
			else if (optionArg3.Obj is OptionArg optionArg4)
			{
				bool owner = optionArg3.OptionName.Equals("True");
				ShowEntryDetail((EntryItem)optionArg4.Obj, owner);
			}
			else if (optionArg3.OptionName.Equals("HideEntryPanelLevel"))
			{
				entryContrastViewModel?.ClearSelected();
			}
			else
			{
				parent?.ItemOnClick(optionArg3);
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			SaveInfo(tabItemNormalData);
		}
		else if (obj is EntryCompareViewModel entryCompareViewModel)
		{
			ShowEntryDetail(entryCompareViewModel.SelectItemData.EntryChangeData);
		}
	}

	protected virtual void ShowEntryDetail(EntryItem entryItem, bool owner)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		EntryItem entryItemByHero = GetEntryItemByHero(entryItem, owner);
		_showEntryDetailRequest.Raise(entryItemByHero.ViewModel);
	}

	protected virtual void ShowEntryDetail(EntryChangeData entryChangeData)
	{
		EntryItemData entryItemData = new EntryItemData(entryChangeData.EntryData);
		entryItemData.SetLevel(entryChangeData.CurLevel);
		entryItemData.AllLevel = entryChangeData.CurLevel;
		entryItemData.IsMainEntry = entryChangeData.EntryData.IsFixed && !entryChangeData.EntryData.IsSpecial;
		entryItemData.Type = 2;
		_showEntryDetailRequest.Raise(entryItemData);
	}

	protected virtual EntryItem GetEntryItemByHero(EntryItem entryItem, bool owner)
	{
		entryItem.ViewModel.EntryData.IsRealData = true;
		if (owner)
		{
			List<EntryData> allEntry = heroModel.GetAllEntry();
			for (int i = 0; i < allEntry.Count; i++)
			{
				if (allEntry[i].DrEntry.EntryId == entryItem.ViewModel.EntryData.DrEntry.EntryId)
				{
					entryItem.ViewModel.AllLevel = allEntry[i].CurLevel;
					entryItem.ViewModel.EntryData.IsRealData = true;
					return entryItem;
				}
			}
		}
		return entryItem;
	}

	protected virtual void HideContrastPanel()
	{
		ContrastPanelVisible = false;
	}

	protected virtual void ShowContrastPanel(ArmourData curEquipArmour, ArmourData selectArmour)
	{
		if (curEquipArmour != null)
		{
			List<EntryData> list = new List<EntryData>();
			list.AddRange(curEquipArmour.EntryDataList);
			list.AddRange(curEquipArmour.AdditionalEntryList);
			List<EntryData> list2 = new List<EntryData>();
			list2.AddRange(selectArmour.EntryDataList);
			list2.AddRange(selectArmour.AdditionalEntryList);
			contrastViewModel.RefreshData(curEquipArmour);
			entryContrastViewModel.Refresh(selectArmour.ArmourEnum == ArmourEnum.Rock, heroModel.GetAllEntry(), list, list2);
			OnContrastTabClick(-1);
			ContrastPanelVisible = true;
		}
	}

	protected virtual void OnContrastTabClick(int tabIndex)
	{
		armourContrastTabItemData.IsSelected = tabIndex == -1;
		entryContrastTabItemData.IsSelected = tabIndex == -2;
		contrastViewModel.IsShow = tabIndex == -1;
		entryContrastViewModel.Visible = tabIndex == -2;
	}

	protected virtual void SelectFirstItem(bool isScreen)
	{
		if (EquipmentShowList.Count > 0)
		{
			if (isScreen)
			{
				RefreshSortEquipmentScreen(CurSortType);
			}
			else
			{
				RefreshSortEquipment(CurSortType);
			}
			ArmourItemData itemData = EquipmentShowList[0];
			ArmourData currentSlotArmour = GetCurrentSlotArmourData();
			if (currentSlotArmour != null)
			{
				ArmourItemData armourItemData = EquipmentShowList.Find((ArmourItemData p) => p?.Data != null && p.Data.Uid == currentSlotArmour.Uid);
				if (armourItemData != null)
				{
					itemData = armourItemData;
				}
			}
			EquipmentOnClick(itemData, needCheck: false);
		}
		else
		{
			refreshShowDatasRequest.Raise();
		}
		CheckIsEmpty();
	}

	protected virtual void SetShowArmours()
	{
		Dictionary<long, int> heroHeldEquip = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroHeldEquip();
		EquipmentShowList.Clear();
		datas.Clear();
		foreach (KeyValuePair<long, ArmourData> allArmourDatum in Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllArmourData())
		{
			int value = 0;
			heroHeldEquip.TryGetValue(allArmourDatum.Key, out value);
			ArmourItemData armourItemData = new ArmourItemData(this, allArmourDatum.Value, value);
			datas.Add(armourItemData.Data.Uid, armourItemData);
		}
		foreach (KeyValuePair<long, ArmourItemData> data in datas)
		{
			if (data.Value.Data.ArmourEnum == curArmourType)
			{
				EquipmentShowList.Add(data.Value);
			}
		}
		ApplyCurrentFilter(refreshCurrentType: true);
		IsEmpty = EquipmentShowList.Count <= 0;
		RefreshSortEquipment(CurSortType);
		refreshShowDatasRequest.Raise();
	}

	public void OpenFilterView()
	{
		if (filterTypes.Count > 0)
		{
			filterSubViewModel.BeginEdit(filterTypes, filterOptionViewModelsByTypeId, selectedFilterIds, new List<int>());
			optRequest.Raise("OpenFilterView");
		}
	}

	public void OpenRecommendView()
	{
		ArmourRecommendViewModel recommendViewModel = GetRecommendViewModel();
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourRecommendView), recommendViewModel, "ArmourChange", isOpenWindow: false));
	}

	public ArmourRecommendViewModel GetRecommendViewModel()
	{
		if (armourRecommendViewModel == null)
		{
			armourRecommendViewModel = new ArmourRecommendViewModel(this, heroModel);
		}
		return armourRecommendViewModel;
	}

	private void OnOpt(string optName)
	{
		if (optCommand.Enabled)
		{
			optCommand.Enabled = false;
			if ("OpenFilterView".Equals(optName))
			{
				OpenFilterView();
				optCommand.Enabled = true;
			}
			else if ("CloseFilterView".Equals(optName))
			{
				optRequest.Raise("CloseFilterView");
				optCommand.Enabled = true;
			}
			else
			{
				optCommand.Enabled = true;
			}
		}
	}

	private void InitFilterGroupsFromTable()
	{
		filterTypes.Clear();
		filterOptionViewModelsByTypeId.Clear();
		filterLogicByTypeId.Clear();
		DREquipmentFilterType[] dataRows = GameEntry.DataTable.GetDataRows((DREquipmentFilterType p) => p.IsActive && EquipmentFilterDefinition.ContainsScene(p, EquipmentFilterScene.ArmourChange));
		DREquipmentFilter[] dataRows2 = GameEntry.DataTable.GetDataRows((DREquipmentFilter p) => true);
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		dataRows = dataRows.OrderBy((DREquipmentFilterType p) => p.Id).ToArray();
		foreach (DREquipmentFilterType type in dataRows)
		{
			EquipmentFilterLogic filterLogic = EquipmentFilterDefinition.GetFilterLogic(type);
			List<ArmourFilterOptionViewModel> list = new List<ArmourFilterOptionViewModel>();
			if (dataRows2 != null && dataRows2.Length != 0)
			{
				DREquipmentFilter[] array = (from p in dataRows2
					where p.TypeId == type.Id
					orderby p.Id
					select p).ToArray();
				foreach (DREquipmentFilter dREquipmentFilter in array)
				{
					list.Add(new ArmourFilterOptionViewModel(this, dREquipmentFilter.Choice, dREquipmentFilter.Id, dREquipmentFilter.MatchId, dREquipmentFilter.TypeId, isSelect: false, filterLogic));
				}
			}
			if (list.Count > 0)
			{
				ReportItemViewModel reportItemViewModel = new ReportItemViewModel(this, type.TypeName, type.Id);
				filterTypes.Add(reportItemViewModel);
				filterOptionViewModelsByTypeId[reportItemViewModel.ReportId] = list;
				filterLogicByTypeId[reportItemViewModel.ReportId] = filterLogic;
			}
		}
	}

	protected virtual void ApplyFilterViewSelection(List<int> filterIds)
	{
		HashSet<int> hashSet = ((filterIds != null) ? new HashSet<int>(filterIds) : new HashSet<int>());
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			List<ArmourFilterOptionViewModel> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				value[i].SetSelect(hashSet.Contains(value[i].FilterId));
			}
		}
		RebuildSelectedMatchIds();
		ApplyCurrentFilter(refreshCurrentType: true);
		SelectFirstItem(isScreen: true);
	}

	protected virtual void ApplyRecommendFilter(ArmourRecommendViewModel recommendViewModel, bool includeOtherEntry = true)
	{
		if (recommendViewModel == null)
		{
			ApplyFilterViewSelection(new List<int>());
			return;
		}
		HashSet<int> hashSet = new HashSet<int>();
		AddRecommendFilterIds(hashSet, recommendViewModel.RecommendAttrIds, EquipmentFilterLogic.MainAttribute);
		AddRecommendFilterIds(hashSet, recommendViewModel.RecommendAttrIds, EquipmentFilterLogic.SubAttribute);
		AddRecommendEntryFilterIds(hashSet, recommendViewModel.RecommendEntryIds, includeOtherEntry);
		ApplyFilterViewSelection(hashSet.ToList());
	}

	protected virtual void AddRecommendFilterIds(HashSet<int> filterIds, List<int> matchIds, EquipmentFilterLogic filterLogic)
	{
		if (filterIds == null || matchIds == null || matchIds.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			if (GetFilterLogic(item.Key) != filterLogic)
			{
				continue;
			}
			List<ArmourFilterOptionViewModel> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				if (matchIds.Contains(value[i].MatchId))
				{
					filterIds.Add(value[i].FilterId);
				}
			}
		}
	}

	protected virtual void AddRecommendEntryFilterIds(HashSet<int> filterIds, List<int> matchIds, bool includeOtherEntry = true)
	{
		if (filterIds == null || matchIds == null || matchIds.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			List<ArmourFilterOptionViewModel> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				if ((includeOtherEntry || value[i].FilterLogic != EquipmentFilterLogic.OtherEntry) && matchIds.Contains(value[i].MatchId) && EquipmentFilterDefinition.IsEntryFilterLogic(value[i].FilterLogic))
				{
					filterIds.Add(value[i].FilterId);
				}
			}
		}
	}

	protected virtual void RebuildSelectedMatchIds()
	{
		selectedMatchIdsByTypeId.Clear();
		selectedFilterIds.Clear();
		foreach (KeyValuePair<int, List<ArmourFilterOptionViewModel>> item in filterOptionViewModelsByTypeId)
		{
			int key = item.Key;
			List<int> list = new List<int>();
			List<ArmourFilterOptionViewModel> value = item.Value;
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
		IsShowScreenResult = selectedFilterIds.Count > 0;
		ClearBtnCanClick = selectedFilterIds.Count > 0;
	}

	protected virtual void ApplyCurrentFilter(bool refreshCurrentType)
	{
		List<ArmourItemData> list = datas.Values.ToList();
		if (selectedFilterIds.Count <= 0)
		{
			filterResultsArmourData = list;
		}
		else
		{
			filterResultsArmourData = list.FindAll((ArmourItemData p) => IsMatchSelectedFilters(p?.Data));
		}
		if (refreshCurrentType)
		{
			EquipmentShowList = filterResultsArmourData.FindAll((ArmourItemData p) => p.Data.ArmourEnum == CurArmourType);
		}
	}

	protected virtual bool IsMatchSelectedFilters(ArmourData armourData)
	{
		if (armourData == null)
		{
			return false;
		}
		foreach (KeyValuePair<int, List<int>> item in selectedMatchIdsByTypeId)
		{
			List<int> value = item.Value;
			if (value == null || value.Count <= 0)
			{
				continue;
			}
			EquipmentFilterLogic filterLogic = GetFilterLogic(item.Key);
			if ((filterLogic == EquipmentFilterLogic.MainAttribute && !IsMainAttributeFilterAvailable(armourData)) || (filterLogic == EquipmentFilterLogic.SubAttribute && armourData.EquipmentEnum == EquipmentEnum.SuitBox))
			{
				continue;
			}
			if (filterLogic == EquipmentFilterLogic.SubAttribute && value.Count > 1)
			{
				if (!IsAllSubAttributesInSelected(armourData, value))
				{
					return false;
				}
			}
			else if (filterLogic == EquipmentFilterLogic.OtherEntry && value.Count > 1)
			{
				if (!IsMatchOtherEntryFilter(armourData, value))
				{
					return false;
				}
			}
			else if (!IsMatchAny(filterLogic, value, armourData))
			{
				return false;
			}
		}
		return true;
	}

	protected virtual bool IsMatchOtherEntryFilter(ArmourData armourData, List<int> selectedMatchIds)
	{
		if (selectedMatchIds == null || selectedMatchIds.Count == 0)
		{
			return true;
		}
		List<int> otherEntryIds = GetOtherEntryIds(armourData);
		if (otherEntryIds.Count == 0)
		{
			return false;
		}
		int num = otherEntryIds.Count((int p) => selectedMatchIds.Contains(p));
		if (num <= 0)
		{
			return false;
		}
		if (selectedMatchIds.Count < otherEntryIds.Count)
		{
			return selectedMatchIds.All((int p) => otherEntryIds.Contains(p));
		}
		if (selectedMatchIds.Count > otherEntryIds.Count)
		{
			return otherEntryIds.All((int p) => selectedMatchIds.Contains(p));
		}
		if (num == selectedMatchIds.Count)
		{
			return num == otherEntryIds.Count;
		}
		return false;
	}

	protected virtual List<int> GetOtherEntryIds(ArmourData armourData)
	{
		List<int> list = new List<int>();
		if (armourData?.AdditionalEntryList == null)
		{
			return list;
		}
		for (int i = 0; i < armourData.AdditionalEntryList.Count; i++)
		{
			EntryData entryData = armourData.AdditionalEntryList[i];
			if (entryData?.DrEntry != null)
			{
				list.Add(entryData.DrEntry.EntryId);
			}
		}
		return list;
	}

	protected virtual bool IsMainAttributeFilterAvailable(ArmourData armourData)
	{
		if (armourData != null)
		{
			if (armourData.ArmourEnum != ArmourEnum.Heart)
			{
				return armourData.ArmourEnum == ArmourEnum.Book;
			}
			return true;
		}
		return false;
	}

	protected virtual bool IsMatchAny(EquipmentFilterLogic filterLogic, List<int> selectedMatchIds, ArmourData armourData)
	{
		for (int i = 0; i < selectedMatchIds.Count; i++)
		{
			if (IsMatch(filterLogic, selectedMatchIds[i], armourData))
			{
				return true;
			}
		}
		return false;
	}

	protected virtual bool IsAllSubAttributesInSelected(ArmourData armourData, List<int> selectedMatchIds)
	{
		if (armourData == null || armourData.EquipmentEnum == EquipmentEnum.SuitBox)
		{
			return false;
		}
		List<EquipAttribute> subAttribute = armourData.GetSubAttribute();
		if (subAttribute == null || subAttribute.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < subAttribute.Count; i++)
		{
			if (subAttribute[i] == null || !selectedMatchIds.Contains(subAttribute[i].Id))
			{
				return false;
			}
		}
		return true;
	}

	protected virtual bool IsAllOtherEntriesInSelected(ArmourData armourData, List<int> selectedMatchIds)
	{
		if (armourData?.AdditionalEntryList == null || armourData.AdditionalEntryList.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < armourData.AdditionalEntryList.Count; i++)
		{
			EntryData entryData = armourData.AdditionalEntryList[i];
			if (entryData?.DrEntry == null || !selectedMatchIds.Contains(entryData.DrEntry.EntryId))
			{
				return false;
			}
		}
		return true;
	}

	protected virtual EquipmentFilterLogic GetFilterLogic(int typeId)
	{
		if (filterLogicByTypeId.TryGetValue(typeId, out var value))
		{
			return value;
		}
		return EquipmentFilterDefinition.GetDefaultFilterLogic(typeId);
	}

	protected virtual bool IsMatch(EquipmentFilterLogic filterLogic, int matchId, ArmourData armourData)
	{
		switch (filterLogic)
		{
		case EquipmentFilterLogic.MainAttribute:
			if (IsMainAttributeFilterAvailable(armourData))
			{
				EquipAttribute mainAttribute = armourData.GetMainAttribute();
				if (mainAttribute == null)
				{
					return false;
				}
				return mainAttribute.Id == matchId;
			}
			return false;
		case EquipmentFilterLogic.SubAttribute:
			if (armourData.EquipmentEnum != EquipmentEnum.SuitBox)
			{
				return armourData.GetSubAttribute().Any((EquipAttribute p) => p.Id == matchId);
			}
			return false;
		case EquipmentFilterLogic.FixedEntry:
			if (armourData.EquipmentEnum != EquipmentEnum.SuitBox)
			{
				if (armourData.EntryDataList != null)
				{
					return armourData.EntryDataList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
				}
				return false;
			}
			return true;
		case EquipmentFilterLogic.MainEntry:
			if (armourData.EquipmentEnum == EquipmentEnum.SuitBox)
			{
				if (armourData.EntryDataList != null)
				{
					return armourData.EntryDataList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
				}
				return false;
			}
			return true;
		case EquipmentFilterLogic.OtherEntry:
			if (armourData.EquipmentEnum == EquipmentEnum.SuitBox)
			{
				if (armourData.AdditionalEntryList != null)
				{
					return armourData.AdditionalEntryList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
				}
				return false;
			}
			if (armourData.AdditionalEntryList != null)
			{
				return armourData.AdditionalEntryList.Any((EntryData p) => p.DrEntry != null && p.DrEntry.EntryId == matchId);
			}
			return false;
		default:
			return true;
		}
	}

	protected virtual void RefreshSortEquipment(int index)
	{
		CurSortType = index;
		switch (index)
		{
		case 1:
			EquipmentShowList.Sort(new ArmourItemScreenSortByLevel());
			break;
		case 2:
			EquipmentShowList.Sort(new ArmourItemScreenSortByRarity());
			break;
		case 3:
			EquipmentShowList.Sort(new ArmourItemScreenSortByRank());
			break;
		}
		refreshShowDatasRequest.Raise();
	}

	protected virtual void RefreshSortEquipmentScreen(int index)
	{
		CurSortType = index;
		switch (index)
		{
		case 1:
			EquipmentShowList.Sort(new ArmourItemScreenSortByLevel());
			break;
		case 2:
			EquipmentShowList.Sort(new ArmourItemScreenSortByRarity());
			break;
		case 3:
			EquipmentShowList.Sort(new ArmourItemScreenSortByRank());
			break;
		}
		refreshShowDatasRequest.Raise();
	}

	protected virtual async void RemoveEquip()
	{
		isArmourChanging = true;
		if (curItemData == null || !datas.ContainsKey(curItemData.Data.Uid))
		{
			return;
		}
		HeroModel curHero = heroModel;
		ArmourData curArmourData = curItemData.Data;
		Loading loading = await Loading.Show();
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroChangeEquip(curHero.Id, curArmourData, heroModel.Armours[(int)curArmourType].Uid, curArmourType))
			{
				datas[curArmourData.Uid].RefreshOwnerInfo();
				selectedViewModel.RefreshData(curArmourData);
				RefreshDetailFunction();
				ArmourData = curArmourData;
				ShowArmour = true;
				ShowArmourMask = false;
				refreshRedPointRequest.Raise();
				await UniTask.Delay(200);
				selectedViewModel.ReSetLeftCmd();
				loading.Dispose();
			}
			else
			{
				loading.Dispose();
				await UIHelper.AccountDisconnect();
			}
		}
		catch (Exception ex)
		{
			Log.Error("替换发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		finally
		{
			loading.Dispose();
			isArmourChanging = false;
		}
	}

	protected virtual void ChangeEquipment()
	{
		isArmourChanging = true;
		int ownerId = curItemData.OwnerId;
		if (ownerId != 0)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(ownerId);
			if (dataRow == null)
			{
				return;
			}
			IAsyncResult<int> result = AlertDialog.Show("提示", "该明饰已被" + dataRow.Name + "所拥有,是否更换明饰?", "确认", "取消");
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result == -1)
				{
					ChangeArmour();
				}
				else
				{
					selectedViewModel.ReSetLeftCmd();
					isArmourChanging = false;
				}
			});
		}
		else
		{
			ChangeArmour();
		}
	}

	protected virtual async void ChangeArmour()
	{
		_ = curItemData.OwnerId;
		long oldUid = 0L;
		if (heroModel.Armours.ContainsKey((int)curArmourType) && heroModel.Armours[(int)curArmourType] != null)
		{
			oldUid = heroModel.Armours[(int)curArmourType].Uid;
		}
		HeroModel curHero = heroModel;
		ArmourData curArmourData = curItemData.Data;
		Loading loading = await Loading.Show();
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroChangeEquip(curHero.Id, curArmourData, oldUid, curArmourType))
			{
				datas[curArmourData.Uid].RefreshOwnerInfo();
				if (datas.ContainsKey(oldUid))
				{
					datas[oldUid].RefreshOwnerInfo();
				}
				selectedViewModel.RefreshData(curArmourData);
				RefreshDetailFunction();
				selectedViewModel.RefreshHeroInfo();
				HideContrastPanel();
				contrastViewModel.RefreshData(null);
				ArmourData = curArmourData;
				ShowArmour = true;
				ShowArmourMask = false;
				armourChangeRequest.Raise();
				refreshRedPointRequest.Raise();
				await UniTask.Delay(200);
				selectedViewModel.ReSetLeftCmd();
				loading.Dispose();
			}
			else
			{
				await UIHelper.AccountDisconnect();
				loading.Dispose();
			}
		}
		catch (Exception value)
		{
			loading.Dispose();
			Console.WriteLine(value);
			throw;
		}
		finally
		{
			isArmourChanging = false;
		}
	}

	protected virtual async void OpenCultureWindow()
	{
		int ownerId = curItemData.Data.GetOwnerId();
		HeroModel heroModel = null;
		if (ownerId > 0)
		{
			heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
		}
		if (armourData.EquipmentEnum == EquipmentEnum.SuitBox)
		{
			long unselectedUid = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetUnselectSuitBox();
			ArmourData unselectedData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(unselectedUid);
			if (unselectedUid != 0L)
			{
				Loading loading = await Loading.Show();
				bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().EnterMakeSuitBox(unselectedUid, unselectedData.AdditionalEntryList);
				loading.Dispose();
				if (num)
				{
					OpenRockCultureWindow();
				}
				else
				{
					Toast.ShowInfo("进入护石改造界面失败!");
					await UIHelper.AccountDisconnect();
				}
			}
			else
			{
				OpenRockCultureWindow();
			}
		}
		else
		{
			ArmourCultureViewModel userData = new ArmourCultureViewModel(this, curItemData.Data, heroModel, this.heroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourCultureWindow), userData));
		}
		selectedViewModel.ReSetRightCmd();
	}

	protected virtual void OpenRockCultureWindow()
	{
		RockCultureViewModel userData = new RockCultureViewModel(this, armourData, needOpenDetail: false);
		openWindowRequest.Raise(new OpenViewArg(typeof(RockCultureWindow), userData), delegate
		{
			long uid = curItemData.Data.Uid;
			datas[uid].Data = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(uid);
			SetShowArmours();
			EquipmentOnClick(datas[uid], needCheck: false);
		});
	}

	protected virtual void EquipmentOnClick(ArmourItemData itemData, bool needCheck = true)
	{
		if (curItemData != null)
		{
			if (needCheck && curItemData.Data.Uid == itemData.Data.Uid)
			{
				return;
			}
			curItemData.IsSelected = false;
		}
		curItemData = itemData;
		curItemData.IsSelected = true;
		hideEntryDetailRequest.Raise();
		selectedViewModel.RefreshData(curItemData.Data);
		selectedViewModel.RefreshHeroInfo();
		ArmourData = curItemData.Data;
		if (curItemData.OwnerId == heroModel.Id)
		{
			ShowArmour = true;
			ShowArmourMask = false;
			HideContrastPanel();
		}
		else if (GetCurrentSlotArmourData() != null)
		{
			ShowArmour = true;
			ShowArmourMask = true;
			ShowContrastPanel(GetCurrentSlotArmourData(), curItemData.Data);
		}
		else
		{
			ShowArmour = true;
			ShowArmourMask = false;
			HideContrastPanel();
		}
		RefreshDetailFunction();
	}

	protected virtual void RefreshDetailFunction()
	{
		if (curItemData != null && !heroModel.IsNullOrEmpty() && selectedViewModel != null)
		{
			if (curItemData.OwnerId == heroModel.Id)
			{
				selectedViewModel.SetFunction(isChange: false, "卸下");
			}
			else if (GetCurrentSlotArmourData() != null)
			{
				selectedViewModel.SetFunction(isChange: true, "替换");
			}
			else
			{
				selectedViewModel.SetFunction(isChange: true, "佩戴");
			}
		}
	}

	protected virtual void SetCurTab(TabItemData data)
	{
		curArmourType = (ArmourEnum)data.TabIndex;
		if (curTab != null && curTab.TabIndex != (int)curArmourType)
		{
			curTab.IsSelected = false;
		}
		curTab = data;
		curTab.IsSelected = true;
	}

	protected virtual bool TryGetCurrentSlotItemData(out ArmourItemData itemData)
	{
		itemData = null;
		ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
		if (currentSlotArmourData == null)
		{
			return false;
		}
		if (datas.TryGetValue(currentSlotArmourData.Uid, out itemData))
		{
			return itemData != null;
		}
		return false;
	}

	protected virtual void SetEquipmentShowList()
	{
		if (curItemData != null)
		{
			curItemData.IsSelected = false;
		}
		RefreshSortEquipment(CurSortType);
		ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
		if (currentSlotArmourData != null)
		{
			if (TryGetCurrentSlotItemData(out curItemData))
			{
				curItemData.IsSelected = true;
				if (SelectedViewModel != null)
				{
					ArmourData = currentSlotArmourData;
					ShowArmour = true;
					ShowArmourMask = false;
					SelectedViewModel.RefreshData(currentSlotArmourData);
					SelectedViewModel.RefreshHeroInfo();
					RefreshDetailFunction();
				}
				if (ContrastViewModel != null)
				{
					ContrastViewModel.RefreshData(null);
				}
			}
		}
		else if (SelectedViewModel != null)
		{
			ShowArmour = false;
			closeEffectRequest.Raise();
			ShowArmourMask = false;
			SelectedViewModel.RefreshData(null);
			if (ContrastViewModel != null)
			{
				ContrastViewModel.RefreshData(null);
			}
			if (EquipmentShowList.Count > 0)
			{
				EquipmentOnClick(EquipmentShowList[0]);
			}
			else
			{
				curItemData = null;
			}
		}
	}

	protected virtual void ScreenTagItemOnclick(ArmourScreenTagItemData data)
	{
		bool flag = true;
		if (SelectedScreenTagData.Count > 0)
		{
			for (int i = 0; i < SelectedScreenTagData.Count; i++)
			{
				if (SelectedScreenTagData[i].EntryType == data.EntryType && SelectedScreenTagData[i].ID == data.ID)
				{
					ScreenTagItemDelete(data);
					SelectedScreenTagData.RemoveAt(i);
					flag = false;
					break;
				}
			}
		}
		if (SelectedScreenTagData.Count == 4)
		{
			Toast.ShowInfo("至多可选择4个筛选条件");
			flag = false;
		}
		if (flag)
		{
			SelectedScreenTagData.Add(data);
			ScreenTagItemAdd(data);
		}
		ClearBtnCanClick = SelectedScreenTagData.Count > 0;
		RefreshSelectedRequest.Raise();
	}

	protected virtual void GetSaveInfo()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		exactMatch = PlayerPrefs.GetInt($"_{uid}_armourChange_filter", 0) == 0;
		exactBtn = new TabItemNormalData(this, "empty", 1, exactMatch, "精确筛选");
		fuzzyBtn = new TabItemNormalData(this, "empty", 2, !exactMatch, "模糊筛选");
	}

	protected virtual void SaveInfo(TabItemNormalData tabItemNormalData)
	{
		if (!tabItemNormalData.IsSelected)
		{
			exactBtn.SetSelected(tabItemNormalData.ID == 1);
			fuzzyBtn.SetSelected(tabItemNormalData.ID == 2);
			exactMatch = tabItemNormalData.ID == 1;
			int value = ((!exactMatch) ? 1 : 0);
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
				.Uid;
			PlayerPrefs.SetInt($"_{uid}_armourChange_filter", value);
		}
	}

	public void RefreshScreenArmour()
	{
		ApplyCurrentFilter(refreshCurrentType: true);
		SelectFirstItem(isScreen: true);
	}

	protected virtual void Exact()
	{
		bool flag = attributeSelected.Count == 0;
		bool flag2 = fixEntrySelected.Count == 0;
		bool flag3 = otherEntrySelected.Count == 0;
		List<ArmourItemData> allArmourData = datas.Values.ToList();
		filterResultsArmourData.Clear();
		List<int> list = attributeSelected.Values.ToList();
		int i;
		for (i = 0; i < allArmourData.Count; i++)
		{
			ArmourItemData armourItemData = allArmourData[i];
			armourItemData.Flag = 0;
			if (armourItemData.Data.ArmourEnum != ArmourEnum.Rock && armourItemData.Data.EquipAttributeList.Count > 0 && list.Exists((int id) => !allArmourData[i].Data.EquipAttributeList.Exists((EquipAttribute v) => v.Id == id)))
			{
				continue;
			}
			List<int> list2 = new List<int>();
			if (armourItemData.Data.ArmourEnum != ArmourEnum.Rock)
			{
				foreach (EntryData entryData in armourItemData.Data.EntryDataList)
				{
					list2.Add(entryData.DrEntry.EntryId);
				}
				List<int> list3 = fixEntrySelected.Values.ToList();
				if (list2.Intersect(list3).ToList().Count != list3.Count)
				{
					continue;
				}
			}
			List<int> list4 = new List<int>();
			foreach (EntryData additionalEntry in armourItemData.Data.AdditionalEntryList)
			{
				list4.Add(additionalEntry.DrEntry.EntryId);
			}
			List<int> list5 = otherEntrySelected.Values.ToList();
			if (list4.Intersect(list5).ToList().Count == list5.Count)
			{
				filterResultsArmourData.Add(armourItemData);
			}
		}
		if (flag)
		{
			attributeSelected.Clear();
		}
		if (flag2)
		{
			fixEntrySelected.Clear();
		}
		if (flag3)
		{
			otherEntrySelected.Clear();
		}
		EquipmentShowList.Clear();
		if (selectedScreenTagData.Count == 0)
		{
			filterResultsArmourData = datas.Values.ToList();
			ClearBtnCanClick = false;
		}
		IsShowScreenResult = ClearBtnCanClick;
		EquipmentShowList = filterResultsArmourData.FindAll((ArmourItemData p) => p.Data.ArmourEnum == CurArmourType);
		_closeScreenRequest.Raise();
	}

	protected virtual void Fuzzy()
	{
		bool flag = attributeSelected.Count == 0;
		bool flag2 = fixEntrySelected.Count == 0;
		bool flag3 = otherEntrySelected.Count == 0;
		List<ArmourItemData> list = new List<ArmourItemData>();
		List<ArmourItemData> list2 = new List<ArmourItemData>();
		List<ArmourItemData> list3 = new List<ArmourItemData>();
		List<ArmourItemData> list4 = datas.Values.ToList();
		filterResultsArmourData.Clear();
		for (int i = 0; i < list4.Count; i++)
		{
			ArmourItemData armourItemData = list4[i];
			armourItemData.Flag = 0;
			armourItemData.ConditionCount = 0;
			foreach (KeyValuePair<int, int> attribute in attributeSelected)
			{
				if (armourItemData.Data.ArmourEnum != ArmourEnum.Rock && armourItemData.Data.EquipAttributeList.Count > 0 && armourItemData.Data.EquipAttributeList.Exists((EquipAttribute p) => p.Id == attribute.Key))
				{
					armourItemData.Flag += 100;
					armourItemData.ConditionCount++;
					list.Add(armourItemData);
				}
			}
			foreach (KeyValuePair<int, int> item in fixEntrySelected)
			{
				if (armourItemData.Data.ArmourEnum == ArmourEnum.Rock)
				{
					continue;
				}
				int num = 0;
				for (int num2 = 0; num2 < armourItemData.Data.EntryDataList.Count; num2++)
				{
					if (armourItemData.Data.EntryDataList.Count == 0)
					{
						break;
					}
					if (armourItemData.Data.EntryDataList[num2].DrEntry == null)
					{
						break;
					}
					if (item.Key == armourItemData.Data.EntryDataList[num2].DrEntry.EntryId)
					{
						num++;
					}
				}
				if (num != 0)
				{
					armourItemData.Flag += num * 10;
					armourItemData.ConditionCount += num;
					list2.Add(armourItemData);
				}
			}
			foreach (KeyValuePair<int, int> item2 in otherEntrySelected)
			{
				int num3 = 0;
				for (int num4 = 0; num4 < armourItemData.Data.AdditionalEntryList.Count; num4++)
				{
					if (armourItemData.Data.AdditionalEntryList.Count == 0)
					{
						break;
					}
					if (armourItemData.Data.AdditionalEntryList[num4].DrEntry == null)
					{
						break;
					}
					if (item2.Key == armourItemData.Data.AdditionalEntryList[num4].DrEntry.EntryId)
					{
						num3++;
					}
				}
				if (num3 != 0)
				{
					armourItemData.Flag += num3;
					armourItemData.ConditionCount += num3;
					list3.Add(armourItemData);
				}
			}
			if (otherEntrySelected.Count == 0 && armourItemData.Data.ArmourEnum == ArmourEnum.Rock)
			{
				list3.Add(armourItemData);
			}
		}
		if (flag)
		{
			attributeSelected.Clear();
		}
		if (flag2)
		{
			fixEntrySelected.Clear();
		}
		if (flag3)
		{
			otherEntrySelected.Clear();
		}
		EquipmentShowList.Clear();
		if (selectedScreenTagData.Count != 0)
		{
			filterResultsArmourData = list.Union(list2).Union(list3).ToList();
		}
		else
		{
			filterResultsArmourData = datas.Values.ToList();
			ClearBtnCanClick = false;
		}
		IsShowScreenResult = ClearBtnCanClick;
		EquipmentShowList = filterResultsArmourData.FindAll((ArmourItemData p) => p.Data.ArmourEnum == CurArmourType);
		_closeScreenRequest.Raise();
	}

	protected virtual void CheckIsEmpty()
	{
		if (EquipmentShowList.Count > 0)
		{
			IsEmpty = false;
			return;
		}
		IsEmpty = true;
		ShowArmour = false;
		HideContrastPanel();
		selectedViewModel.RefreshData(null);
	}

	public void ClearSelectedScreenTags()
	{
		foreach (ArmourScreenTagItemData selectedScreenTagDatum in SelectedScreenTagData)
		{
			ScreenTagItemDelete(selectedScreenTagDatum);
		}
		foreach (ArmourScreenItemData screenItemDatum in ScreenItemData)
		{
			screenItemDatum.CloseButton();
		}
		SelectedScreenTagData.Clear();
		ClearBtnCanClick = false;
		IsShowScreenResult = false;
		RefreshSelectedRequest.Raise();
	}

	protected virtual void ScreenTagItemDelete(ArmourScreenTagItemData data)
	{
		data.IsSelected = false;
		if (data.Type == 2)
		{
			attributeSelected.Remove(data.ID);
		}
		else if (data.Type == 3)
		{
			if (data.EntryType == 1)
			{
				fixEntrySelected.Remove(data.ID);
			}
			else if (data.EntryType == 2)
			{
				otherEntrySelected.Remove(data.ID);
			}
		}
	}

	protected virtual void ScreenTagItemAdd(ArmourScreenTagItemData data)
	{
		data.IsSelected = true;
		if (data.Type == 2)
		{
			attributeSelected.Add(data.ID, data.ID);
		}
		else if (data.Type == 3)
		{
			if (data.EntryType == 1)
			{
				fixEntrySelected.Add(data.ID, data.ID);
			}
			else if (data.EntryType == 2)
			{
				otherEntrySelected.Add(data.ID, data.ID);
			}
		}
	}

	public ArmourItemData GetArmourItemData(int index)
	{
		if (index >= 0 && index < EquipmentShowList.Count)
		{
			return EquipmentShowList[index];
		}
		return null;
	}
}
