using System;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public sealed class BindTypeNameToTypeAttribute : Attribute
{
	internal readonly Type NewType;

	internal readonly string OldTypeName;

	public BindTypeNameToTypeAttribute(string oldFullTypeName, Type newType)
	{
		OldTypeName = oldFullTypeName;
		NewType = newType;
	}
}
