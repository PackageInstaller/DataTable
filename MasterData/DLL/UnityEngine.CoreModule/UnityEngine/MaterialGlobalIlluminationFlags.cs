using System;

namespace UnityEngine;

[Flags]
public enum MaterialGlobalIlluminationFlags
{
	None = 0,
	RealtimeEmissive = 1,
	BakedEmissive = 2,
	EmissiveIsBlack = 4,
	AnyEmissive = RealtimeEmissive | BakedEmissive
}
