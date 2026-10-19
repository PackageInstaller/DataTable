using System.Reflection;

namespace System;

public class AssemblyLoadEventArgs : EventArgs
{
	public Assembly LoadedAssembly { get; }

	public AssemblyLoadEventArgs(Assembly loadedAssembly)
	{
		LoadedAssembly = loadedAssembly;
	}
}
