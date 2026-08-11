using System.Collections.Generic;

namespace Ase;

public class EquipmentSortByLevel : Comparer<WeaponItemData>
{
	public override int Compare(WeaponItemData x, WeaponItemData y)
	{
		if (y.Data.Level.CompareTo(x.Data.Level) != 0)
		{
			return y.Data.Level.CompareTo(x.Data.Level);
		}
		if (y.Data.Rarity.CompareTo(x.Data.Rarity) != 0)
		{
			return y.Data.Rarity.CompareTo(x.Data.Rarity);
		}
		if (y.Data.Id.CompareTo(x.Data.Id) != 0)
		{
			return y.Data.Id.CompareTo(x.Data.Id);
		}
		if (y.OwnerId.CompareTo(x.OwnerId) != 0)
		{
			return y.OwnerId.CompareTo(x.OwnerId);
		}
		if (y.Data.WeaponRefine.CompareTo(x.Data.WeaponRefine) != 0)
		{
			return y.Data.WeaponRefine.CompareTo(x.Data.WeaponRefine);
		}
		if (y.Data.IsLock.CompareTo(x.Data.IsLock) != 0)
		{
			return x.Data.IsLock.CompareTo(y.Data.IsLock);
		}
		if (y.Data.Uid.CompareTo(x.Data.Uid) != 0)
		{
			return x.Data.Uid.CompareTo(y.Data.Uid);
		}
		return 0;
	}
}
