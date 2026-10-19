using System;

namespace UnityEngine.ResourceManagement.Util;

[Flags]
internal enum BundleSource
{
	None = 0,
	Local = 1,
	Cache = 2,
	Download = 4
}
