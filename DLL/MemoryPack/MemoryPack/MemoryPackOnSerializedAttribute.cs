using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = false, Inherited = false)]
public sealed class MemoryPackOnSerializedAttribute : Attribute
{
}
