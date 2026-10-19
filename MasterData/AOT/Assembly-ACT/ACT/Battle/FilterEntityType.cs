using System;

namespace ACT.Battle;

[Flags]
public enum FilterEntityType
{
	Null = 0,
	Character = 1,
	Monster = 2,
	Boss = 4,
	Robot = 8,
	Trajectory = 0x10,
	Npc = 0x20,
	Elite = 0x40,
	StateObject = 0x80,
	AssistNpc = 0x100
}
