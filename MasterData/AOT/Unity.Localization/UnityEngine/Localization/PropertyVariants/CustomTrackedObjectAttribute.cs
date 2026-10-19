using System;

namespace UnityEngine.Localization.PropertyVariants;

[AttributeUsage(AttributeTargets.Class)]
public class CustomTrackedObjectAttribute : Attribute
{
	internal Type ObjectType { get; }

	internal bool SupportsInheritedTypes { get; }

	public CustomTrackedObjectAttribute(Type type, bool supportsInheritedTypes)
	{
		ObjectType = type;
		SupportsInheritedTypes = supportsInheritedTypes;
	}
}
