using System;

namespace ACT.Core;

[Flags]
public enum FilterCharacterFrequencyType
{
	Null = 0,
	Echo = 1,
	Resonance = 2,
	Noise = 4
}
