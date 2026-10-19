using ACT.Game.Data;
using UnityEngine;

namespace ACT.Game;

public class LocalInventorySave : ScriptableObject
{
	public LocalWeaponSave weapon;

	public stackableItem[] stackableItems;

	public Inventory ToPB()
	{
		Inventory inventory = new Inventory();
		LocalWeapon[] weapons = weapon.weapons;
		foreach (LocalWeapon localWeapon in weapons)
		{
			inventory.Weapons.Add(localWeapon.ToPB());
		}
		stackableItem[] array = stackableItems;
		foreach (stackableItem stackableItem2 in array)
		{
			inventory.Items.Add(stackableItem2.ToPB());
		}
		return inventory;
	}
}
