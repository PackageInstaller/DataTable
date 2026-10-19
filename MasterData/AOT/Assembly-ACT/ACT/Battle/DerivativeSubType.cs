using System;

namespace ACT.Battle;

[Flags]
public enum DerivativeSubType
{
	None = 0,
	Drones = 1,
	Monster = 2,
	Projectiles = 4
}
