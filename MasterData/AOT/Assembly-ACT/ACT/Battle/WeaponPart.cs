using System;

namespace ACT.Battle;

[Serializable]
public struct WeaponPart
{
	public string name;

	public MonoWeaponPart[] monoWeaponParts;
}
