using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class AddEntryPreViewViewModel : OptionBase
{
	private List<EntryItemData2> entryItemDataList;

	private InteractionRequest<EntryItemData> showEntryDetailRequest;

	public List<EntryItemData2> EntryItemDataList => entryItemDataList;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => showEntryDetailRequest;

	public AddEntryPreViewViewModel(OptionBase parent, List<EntryItemData2> entryItemDataList)
	{
		base.parent = parent;
		this.entryItemDataList = entryItemDataList;
		foreach (EntryItemData2 entryItemData in entryItemDataList)
		{
			entryItemData.SetParent(this);
		}
		showEntryDetailRequest = new InteractionRequest<EntryItemData>();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel") && optionArg.Obj is EntryItem2 entryItem)
		{
			ShowEntryDetail(entryItem.ViewModel);
		}
	}

	private void ShowEntryDetail(EntryItemData2 entryItemData2)
	{
		EntryItemData entryItemData3 = new EntryItemData(entryItemData2.EntryData);
		EntryItemData entryItemByHero = GetEntryItemByHero(entryItemData3);
		showEntryDetailRequest.Raise(entryItemByHero);
	}

	private EntryItemData GetEntryItemByHero(EntryItemData entryItemData)
	{
		entryItemData.EntryData.IsRealData = false;
		return entryItemData;
	}
}
