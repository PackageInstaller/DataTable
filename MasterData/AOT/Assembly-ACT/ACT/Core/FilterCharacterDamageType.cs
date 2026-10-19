using System;

namespace ACT.Core;

[Flags]
public enum FilterCharacterDamageType
{
	Null = 0,
	Striker = 1,
	Breaker = 2,
	AssistStriker = 4
}
