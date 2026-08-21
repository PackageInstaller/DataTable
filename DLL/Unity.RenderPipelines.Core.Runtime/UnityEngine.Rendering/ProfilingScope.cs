using System;
using System.Runtime.InteropServices;

namespace UnityEngine.Rendering;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct ProfilingScope : IDisposable
{
	public ProfilingScope(CommandBuffer cmd, ProfilingSampler sampler)
	{
	}

	public void Dispose()
	{
	}
}
