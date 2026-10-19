using System;

namespace ACT.Core;

public enum PropertySource
{
	None,
	Character,
	[Obsolete("Use System instead")]
	Weapon,
	[Obsolete("Use System instead")]
	Chip,
	Monseter,
	Neutral,
	Summon,
	Raid,
	AssistNpc,
	[Obsolete("Use System instead")]
	Equip,
	[Obsolete("Use System instead")]
	Elite,
	[Obsolete("Use System instead")]
	Treasure,
	System,
	Rogue
}
