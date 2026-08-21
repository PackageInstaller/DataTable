using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Field)]
public sealed class fsSerializeAsAttribute : Attribute
{
	public readonly string Name;

	public fsSerializeAsAttribute()
	{
	}

	public fsSerializeAsAttribute(string name)
	{
		Name = name;
	}
}
