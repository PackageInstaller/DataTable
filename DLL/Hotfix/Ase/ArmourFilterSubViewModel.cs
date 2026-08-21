using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ArmourFilterSubViewModel : OptionBase
{
	private readonly SimpleCommand<string> optCommand;

	private readonly InteractionRequest<string> optRequest;

	private readonly List<ReportItemViewModel> filterTypes = new List<ReportItemViewModel>();

	private readonly Dictionary<int, List<ArmourFilterOptionViewModel>> filterOptionViewModelsByTypeId = new Dictionary<int, List<ArmourFilterOptionViewModel>>();

	private readonly Dictionary<int, List<int>> selectedMatchIdsByTypeId = new Dictionary<int, List<int>>();

	private readonly List<int> selectedFilterIds = new List<int>();

	private readonly List<int> committedFilterIds = new List<int>();

	private readonly List<int> defaultSelectedFilterIds = new List<int>();

	private EntryItemData filterEntryItemData;

	private bool hasFilterSelected;

	private static readonly List<ArmourFilterOptionViewModel> EmptyOptionList = new List<ArmourFilterOptionViewModel>();

	public List<ReportItemViewModel> FilterTypes => filterTypes;

	public Dictionary<int, List<int>> FilterOptions => selectedMatchIdsByTypeId;

	public List<int> SelectedFilterIds => selectedFilterIds;

	public EntryItemData FilterEntryItemData => filterEntryItemData;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

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

	public ArmourFilterSubViewModel()
	{
	}

	public ArmourFilterSubViewModel(OptionBase parent)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
	}

	public void BeginEdit(List<ReportItemViewModel> sourceTypes, Dictionary<int, List<ArmourFilterOptionViewModel>> sourceOptionsByTypeId, List<int> sourceCommittedFilterIds, List<int> defaultFilterIds = null)
	{
		filterTypes.Clear();
		filterOptionViewModelsByTypeId.Clear();
		defaultSelectedFilterIds.Clear();
		if (defaultFilterIds != null)
		{
			defaultSelectedFilterIds.AddRange(defaultFilterIds);
		}
		HashSet<int> hashSet = ((sourceCommittedFilterIds != null) ? new HashSet<int>(sourceCommittedFilterIds) : new HashSet<int>());
		committedFilterIds.Clear();
		if (sourceCommittedFilterIds != null)
		{
			committedFilterIds.AddRange(sourceCommittedFilterIds);
		}
		if (sourceTypes != null)
		{
			for (int i = 0; i < sourceTypes.Count; i++)
			{
				ReportItemViewModel reportItemViewModel = sourceTypes[i];
				if (reportItemViewModel == null || sourceOptionsByTypeId == null || !sourceOptionsByTypeId.TryGetValue(reportItemViewModel.ReportId, out var value) || value == null || value.Count <= 0)
				{
					continue;
				}
				filterTypes.Add(new ReportItemViewModel(this, reportItemViewModel.Name, reportItemViewModel.ReportId));
				List<ArmourFilterOptionViewModel> list = new List<ArmourFilterOptionViewModel>();
				for (int j = 0; j < value.Count; j++)
				{
					ArmourFilterOptionViewModel armourFilterOptionViewModel = value[j];
					if (armourFilterOptionViewModel != null)
					{
						list.Add(new ArmourFilterOptionViewModel(this, armourFilterOptionViewModel.Name, armourFilterOptionViewModel.FilterId, armourFilterOptionViewModel.MatchId, armourFilterOptionViewModel.FilterTypeId, hashSet.Contains(armourFilterOptionViewModel.FilterId), armourFilterOptionViewModel.FilterLogic));
					}
				}
				filterOptionViewModelsByTypeId[reportItemViewModel.ReportId] = list;
			}
		}
		RebuildSelectedMatchIds();
		optRequest.Raise("RefreshFilterList");
	}

	public void ClearAllSelection()
	{
		ApplySelection(new List<int>());
		CommitCurrentSelection();
	}

	public void BeginEdit()
	{
		ApplySelection(committedFilterIds);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && "Press".Equals(optionArg.OptionName) && optionArg.Obj is ArmourFilterOptionViewModel filterOption)
		{
			ShowFilterEntryInfo(filterOption);
		}
		else if (obj is ArmourFilterOptionViewModel)
		{
			RebuildSelectedMatchIds();
		}
		base.ItemOnClick(obj);
	}

	private void ApplySelection(List<int> filterIds)
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
		optRequest.Raise("RefreshFilterList");
	}

	private void RebuildSelectedMatchIds()
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
		HasFilterSelected = selectedFilterIds.Count > 0;
	}

	private void OnOpt(string optName)
	{
		if (optCommand.Enabled)
		{
			optCommand.Enabled = false;
			if ("CloseFilterView".Equals(optName))
			{
				parent?.ItemOnClick(new OptionArg(this, "CancelArmourFilterView"));
				optCommand.Enabled = true;
			}
			else if ("ResetFilter".Equals(optName))
			{
				ApplySelection(defaultSelectedFilterIds);
				optCommand.Enabled = true;
			}
			else if ("ConfirmFilter".Equals(optName))
			{
				RebuildSelectedMatchIds();
				CommitCurrentSelection();
				parent?.ItemOnClick(new OptionArg(this, "CloseArmourFilterView"));
				optCommand.Enabled = true;
			}
			else
			{
				optCommand.Enabled = true;
			}
		}
	}

	private void CommitCurrentSelection()
	{
		committedFilterIds.Clear();
		committedFilterIds.AddRange(selectedFilterIds);
	}

	private void ShowFilterEntryInfo(ArmourFilterOptionViewModel filterOption)
	{
		if (filterOption != null && EquipmentFilterDefinition.IsEntryFilterLogic(filterOption.FilterLogic) && filterOption.MatchId > 0)
		{
			EntryData entryData = new EntryData(filterOption.MatchId, 1);
			filterEntryItemData = new EntryItemData(entryData);
			optRequest.Raise("ShowFilterEntryInfo");
		}
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
