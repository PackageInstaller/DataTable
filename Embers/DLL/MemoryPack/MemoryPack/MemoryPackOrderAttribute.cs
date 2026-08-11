using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public sealed class MemoryPackOrderAttribute : Attribute
{
	public int Order { get; }

	public MemoryPackOrderAttribute(int order)
	{
		Order = order;
	}
}
