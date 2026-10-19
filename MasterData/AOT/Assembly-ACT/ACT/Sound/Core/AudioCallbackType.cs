using System;

namespace ACT.Sound.Core;

[Flags]
public enum AudioCallbackType : uint
{
	TimelineMarker = 0x800u,
	All = uint.MaxValue
}
