using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct)]
public sealed class fsObjectAttribute : Attribute
{
	public Type[] PreviousModels;

	public string VersionString;

	public fsMemberSerialization MemberSerialization = fsMemberSerialization.Default;

	public Type Converter;

	public Type Processor;

	public fsObjectAttribute()
	{
	}

	public fsObjectAttribute(string versionString, params Type[] previousModels)
	{
		VersionString = versionString;
		PreviousModels = previousModels;
	}
}
