using System;

namespace ACT.Config;

[Serializable]
public class ItemWeaponType
{
	public readonly int id;

	public readonly int weaponType;

	public readonly int nameLocal;

	public ItemWeaponType(int id, int weaponType, int nameLocal)
	{
		this.id = id;
		this.weaponType = weaponType;
		this.nameLocal = nameLocal;
	}
}
