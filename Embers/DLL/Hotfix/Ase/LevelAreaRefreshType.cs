using System;

namespace Ase;

[Flags]
public enum LevelAreaRefreshType
{
	Monster = 2,
	MapItem = 4,
	Npc = 8,
	Event = 0x10,
	TriggerArea = 0x20,
	All = Monster | MapItem | Npc | Event | TriggerArea
}
