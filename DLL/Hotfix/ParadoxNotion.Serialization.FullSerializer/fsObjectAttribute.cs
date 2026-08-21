using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct)]
public sealed class fsObjectAttribute : Attribute
{
	public Type Converter;

	public Type Processor;
}
