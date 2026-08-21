using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class PropertyDetailViewModel : OptionBase
{
	public OuterPropertyType PropType;

	public List<PropertyData> PrimeProps;

	public List<PropertyData> AdvanceProps;

	public List<PropertyData> Passive;

	public List<EntryLevelItemData> Entries;

	public Dictionary<int, int> EntryLevels;

	private EntryInfoViewModel _entryInfoViewModel;

	private EntryLevelItem selectedEntryLevelItem;

	public PropertyDetailViewModel()
	{
	}

	public PropertyDetailViewModel(OptionBase parent, OuterPropertyType propType, List<PropertyData> primeProps = null, List<PropertyData> advanceProps = null, List<PropertyData> passive = null, List<EntryLevelItemData> entries = null, Dictionary<int, int> entryLevels = null)
	{
		base.parent = parent;
		PropType = propType;
		PrimeProps = primeProps;
		AdvanceProps = advanceProps;
		Passive = passive;
		Entries = entries;
		EntryLevels = entryLevels;
		_entryInfoViewModel = new EntryInfoViewModel(this);
		SetParent();
	}

	public void SetEntryShowPos(Vector2 pos)
	{
		_entryInfoViewModel?.SetPos(pos);
	}

	private void SetParent()
	{
		foreach (EntryLevelItemData entry in Entries)
		{
			entry.SetParent(this);
		}
	}

	private void ShowEntryDetail(EntryLevelItem entryLevelItem)
	{
		EntryItemData entryItemData = new EntryItemData(entryLevelItem.viewModel.EntryData);
		entryItemData.IsMainEntry = !entryLevelItem.viewModel.ShowLevel;
		_entryInfoViewModel.RefreshData(entryItemData);
		openWindowRequest.Raise(new OpenViewArg(typeof(EntryInfoView), _entryInfoViewModel, "PropertyDetail", isOpenWindow: false));
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OpenEntryPanelLevel"))
			{
				if (selectedEntryLevelItem != null)
				{
					selectedEntryLevelItem.SetSelected(selected: false);
				}
				selectedEntryLevelItem = (EntryLevelItem)optionArg.Obj;
				selectedEntryLevelItem.SetSelected(selected: true);
				ShowEntryDetail(selectedEntryLevelItem);
			}
			else if (optionArg.Obj is EntryInfoViewModel && optionArg.OptionName.Equals("HideEntryPanelLevel") && selectedEntryLevelItem != null)
			{
				selectedEntryLevelItem.SetSelected(selected: false);
			}
		}
		base.ItemOnClick(obj);
	}
}
