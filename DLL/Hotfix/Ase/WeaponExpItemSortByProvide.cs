using System.Collections.Generic;

namespace Ase;

public class WeaponExpItemSortByProvide : Comparer<EquipExpItemDataNew>
{
	public override int Compare(EquipExpItemDataNew x, EquipExpItemDataNew y)
	{
		if (y.ItemType.CompareTo(x.ItemType) != 0)
		{
			return x.ItemType.CompareTo(y.ItemType);
		}
		if (y.IsLock.CompareTo(x.IsLock) != 0)
		{
			return x.IsLock.CompareTo(y.IsLock);
		}
		if (y.ProvideExp.CompareTo(x.ProvideExp) != 0)
		{
			return y.ProvideExp.CompareTo(x.ProvideExp);
		}
		if (y.Level.CompareTo(x.Level) != 0)
		{
			return y.Level.CompareTo(x.Level);
		}
		if (y.Level.CompareTo(x.Level) != 0)
		{
			return y.Level.CompareTo(x.Level);
		}
		if (y.ID.CompareTo(x.ID) != 0)
		{
			return y.ID.CompareTo(x.ID);
		}
		if (y.WeaponData.WeaponRefine.CompareTo(x.WeaponData.WeaponRefine) != 0)
		{
			return y.WeaponData.WeaponRefine.CompareTo(x.WeaponData.WeaponRefine);
		}
		if (y.Uid.CompareTo(x.Uid) != 0)
		{
			return y.Uid.CompareTo(x.Uid);
		}
		return 0;
	}
}
