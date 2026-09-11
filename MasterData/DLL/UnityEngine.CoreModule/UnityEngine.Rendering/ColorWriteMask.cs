using System;

namespace UnityEngine.Rendering;

[Flags]
public enum ColorWriteMask
{
	Alpha = 1,
	Blue = 2,
	Green = 4,
	Red = 8,
	All = Alpha | Blue | Green | Red
}
