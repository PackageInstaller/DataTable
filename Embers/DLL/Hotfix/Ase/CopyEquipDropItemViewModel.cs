using System.Collections.Generic;

namespace Ase;

public class CopyEquipDropItemViewModel : OptionBase
{
	private KnapsackItemViewModel propItemVM;

	private List<EntryItemData> entryItemVMs = new List<EntryItemData>();

	private int additionCount;

	public List<EntryItemData> EntryItemVMs => entryItemVMs;

	public KnapsackItemViewModel PropItemVM => propItemVM;

	public int AdditionCount
	{
		get
		{
			return additionCount;
		}
		private set
		{
			Set(ref additionCount, value, "AdditionCount");
		}
	}

	public CopyEquipDropItemViewModel()
	{
	}

	public CopyEquipDropItemViewModel(OptionBase parent, KnapsackItemViewModel armourItemData, List<EntryItemData> entryItemVMs, int additionCount)
	{
		base.parent = parent;
		propItemVM = armourItemData;
		this.entryItemVMs = entryItemVMs;
		this.additionCount = additionCount;
		for (int i = entryItemVMs.Count; i < 3; i++)
		{
			entryItemVMs.Add(new EntryItemData());
		}
	}
}
