namespace Ase;

public class EntryExChangeViewModel : OptionBase
{
	private EntryItemData2 curEntryItemData;

	private EntryItemData2 exChangeEntryItemData;

	private int curEntryIndex;

	private int exchangeEntryIndex;

	public EntryItemData2 CurEntryItemData => curEntryItemData;

	public EntryItemData2 ExChangeEntryItemData => exChangeEntryItemData;

	public int CurEntryIndex => curEntryIndex;

	public int ExchangeEntryIndex => exchangeEntryIndex;

	public EntryExChangeViewModel(OptionBase parent, EntryData curEntryData, int curEntryIndex, EntryData exChangeEntryData, int exchangeEntryIndex)
	{
		base.parent = parent;
		curEntryItemData = new EntryItemData2(null, curEntryData);
		exChangeEntryItemData = new EntryItemData2(null, exChangeEntryData);
		this.curEntryIndex = curEntryIndex;
		this.exchangeEntryIndex = exchangeEntryIndex;
	}

	public void ConfirmOnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "Confirm"));
		Close();
	}
}
