using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemWeaponProperty
{
	public readonly int id;

	public readonly List<Int10000> atkUpgrade;

	public readonly List<Int10000> atkBreakthrough;

	public readonly List<Int10000> subPropertyUpgrade;

	public ItemWeaponProperty(int id, List<Int10000> atkUpgrade, List<Int10000> atkBreakthrough, List<Int10000> subPropertyUpgrade)
	{
		this.id = id;
		this.atkUpgrade = atkUpgrade;
		this.atkBreakthrough = atkBreakthrough;
		this.subPropertyUpgrade = subPropertyUpgrade;
	}
}
