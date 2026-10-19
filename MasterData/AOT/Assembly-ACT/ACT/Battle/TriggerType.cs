using System;

namespace ACT.Battle;

[Flags]
public enum TriggerType
{
	triggerEnter = 1,
	DodgeEnter = 2,
	jumpEnter = 4,
	triggerExit = 8,
	attack = 0x10,
	triggerStay = 0x20
}
