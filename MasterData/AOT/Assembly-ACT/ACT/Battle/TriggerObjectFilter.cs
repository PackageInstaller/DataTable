using System;

namespace ACT.Battle;

[Flags]
public enum TriggerObjectFilter
{
	character = 1,
	enemy = 2,
	freeObject = 4
}
