using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public sealed class MemoryPackAllowSerializeAttribute : Attribute
{
}
