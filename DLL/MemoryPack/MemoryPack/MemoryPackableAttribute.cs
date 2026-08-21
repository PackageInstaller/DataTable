using System;

namespace MemoryPack;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = false, Inherited = false)]
public sealed class MemoryPackableAttribute : Attribute
{
	public GenerateType GenerateType { get; }

	public SerializeLayout SerializeLayout { get; }

	public MemoryPackableAttribute(GenerateType generateType = GenerateType.Object)
	{
		GenerateType = generateType;
		SerializeLayout = ((generateType == GenerateType.VersionTolerant || generateType == GenerateType.CircularReference) ? SerializeLayout.Explicit : SerializeLayout.Sequential);
	}

	public MemoryPackableAttribute(SerializeLayout serializeLayout)
	{
		GenerateType = GenerateType.Object;
		SerializeLayout = serializeLayout;
	}

	public MemoryPackableAttribute(GenerateType generateType, SerializeLayout serializeLayout)
	{
		GenerateType = generateType;
		SerializeLayout = serializeLayout;
	}
}
