using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, AllowMultiple = true, Inherited = false)]
public sealed class MemoryPackUnionAttribute : Attribute
{
	public ushort Tag { get; }

	public Type Type { get; }

	public MemoryPackUnionAttribute(ushort tag, Type type)
	{
		Tag = tag;
		Type = type;
	}
}
