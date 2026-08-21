using System;
using System.Runtime.InteropServices;

namespace UnityEngine.Rendering;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[Obsolete("VolumeIsolationScope is deprecated, it does not have any effect anymore.")]
public struct VolumeIsolationScope : IDisposable
{
	public VolumeIsolationScope(bool unused)
	{
	}

	void IDisposable.Dispose()
	{
	}
}
