using System;

namespace Unity.VisualScripting.FullSerializer;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
public class fsPropertyAttribute : Attribute
{
	public string Name;

	public Type Converter;

	public fsPropertyAttribute()
		: this(string.Empty)
	{
	}

	public fsPropertyAttribute(string name)
	{
		Name = name;
	}
}
