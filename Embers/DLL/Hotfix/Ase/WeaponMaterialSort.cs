using System.Collections.Generic;

namespace Ase;

public class WeaponMaterialSort : Comparer<WeaponMaterialItemData>
{
	public override int Compare(WeaponMaterialItemData x, WeaponMaterialItemData y)
	{
		if (y.WeaponData.Level.CompareTo(x.WeaponData.Level) != 0)
		{
			return x.WeaponData.Level.CompareTo(y.WeaponData.Level);
		}
		if (y.WeaponData.WeaponRefine.CompareTo(x.WeaponData.WeaponRefine) != 0)
		{
			return x.WeaponData.WeaponRefine.CompareTo(y.WeaponData.WeaponRefine);
		}
		if (y.WeaponData.IsLock.CompareTo(x.WeaponData.IsLock) != 0)
		{
			return x.WeaponData.IsLock.CompareTo(y.WeaponData.IsLock);
		}
		return 0;
	}
}
