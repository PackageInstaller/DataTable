using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigWeapon : ScriptableObject
{
	public List<DefaultWeaponScaleInfo> defaultWeaponScale;

	public WeaponProperty defaultWeapon;

	public WeaponProperty[] weapons;
}
