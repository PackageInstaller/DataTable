using System;

namespace Ase;

[Flags]
public enum LevelAreaAddtiveType
{
	MapItem = 2,
	Npc = 4,
	TriggerArea = 8,
	All = MapItem | Npc | TriggerArea
}
