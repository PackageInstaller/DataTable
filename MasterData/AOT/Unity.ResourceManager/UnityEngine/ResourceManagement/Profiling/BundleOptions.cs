using System;

namespace UnityEngine.ResourceManagement.Profiling;

[Flags]
internal enum BundleOptions : short
{
	None = 0,
	CachingEnabled = 1,
	CheckSumEnabled = 2
}
