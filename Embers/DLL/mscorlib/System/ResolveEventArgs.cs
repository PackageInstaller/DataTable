using System.Reflection;
using System.Runtime.CompilerServices;

namespace System;

public class ResolveEventArgs : EventArgs
{
	[CompilerGenerated]
	private readonly string _003CName_003Ek__BackingField;

	[CompilerGenerated]
	private readonly Assembly _003CRequestingAssembly_003Ek__BackingField;

	public ResolveEventArgs(string name)
	{
		_003CName_003Ek__BackingField = name;
	}

	public ResolveEventArgs(string name, Assembly requestingAssembly)
	{
		_003CName_003Ek__BackingField = name;
		_003CRequestingAssembly_003Ek__BackingField = requestingAssembly;
	}
}
