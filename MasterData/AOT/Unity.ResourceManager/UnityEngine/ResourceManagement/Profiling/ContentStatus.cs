using System;

namespace UnityEngine.ResourceManagement.Profiling;

[Flags]
internal enum ContentStatus
{
	None = 0,
	Queue = 2,
	Downloading = 4,
	Released = 0x10,
	Loading = 0x40,
	Active = 0x100
}
