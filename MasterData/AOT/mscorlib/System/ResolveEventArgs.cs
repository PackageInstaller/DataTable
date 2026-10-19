using System.Reflection;
using System.Runtime.CompilerServices;

namespace System;

public class ResolveEventArgs : EventArgs
{
	[CompilerGenerated]
	private readonly Assembly RequestingAssembly__BackingField;

	public string Name { get; }

	public ResolveEventArgs(string name)
	{
		Name = name;
	}

	public ResolveEventArgs(string name, Assembly requestingAssembly)
	{
		Name = name;
		RequestingAssembly__BackingField = requestingAssembly;
	}
}
