using System;
using System.Runtime.InteropServices;

namespace Unity.VisualScripting;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct ProfilingScope : IDisposable
{
	public ProfilingScope(string name)
	{
	}

	public void Dispose()
	{
	}
}
