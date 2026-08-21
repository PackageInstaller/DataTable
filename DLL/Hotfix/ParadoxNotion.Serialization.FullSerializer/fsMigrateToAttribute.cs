using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Class)]
public class fsMigrateToAttribute : Attribute
{
	public readonly Type targetType;

	public fsMigrateToAttribute(Type targetType)
	{
		this.targetType = targetType;
	}
}
