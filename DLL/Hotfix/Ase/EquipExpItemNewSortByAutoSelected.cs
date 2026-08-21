using System.Collections.Generic;

namespace Ase;

public class EquipExpItemNewSortByAutoSelected : Comparer<EquipExpItemDataNew>
{
	public override int Compare(EquipExpItemDataNew x, EquipExpItemDataNew y)
	{
		if (y.Rarity.CompareTo(x.Rarity) != 0)
		{
			return x.Rarity.CompareTo(y.Rarity);
		}
		if (y.Refine.CompareTo(x.Refine) != 0)
		{
			return x.Refine.CompareTo(y.Refine);
		}
		if (y.Rank.CompareTo(x.Rank) != 0)
		{
			return x.Rank.CompareTo(y.Rank);
		}
		if (y.ItemType.CompareTo(x.ItemType) != 0)
		{
			return x.ItemType.CompareTo(y.ItemType);
		}
		if (y.ID.CompareTo(x.ID) != 0)
		{
			return y.ID.CompareTo(x.ID);
		}
		if (y.Uid.CompareTo(x.Uid) != 0)
		{
			return y.Uid.CompareTo(x.Uid);
		}
		return 0;
	}
}
