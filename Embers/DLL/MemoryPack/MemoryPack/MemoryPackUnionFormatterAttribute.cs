using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public sealed class MemoryPackUnionFormatterAttribute : Attribute
{
	public Type Type { get; }

	public MemoryPackUnionFormatterAttribute(Type type)
	{
		Type = type;
	}
}
