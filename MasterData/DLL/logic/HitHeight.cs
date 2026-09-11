using System;

[Flags]
public enum HitHeight
{
	None = 0,
	Ground = 1,
	AirLow = 2,
	AirMedium = 4,
	AirHigh = 8
}
