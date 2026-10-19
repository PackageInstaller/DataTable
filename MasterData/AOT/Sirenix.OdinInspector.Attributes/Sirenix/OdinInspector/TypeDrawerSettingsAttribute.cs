using System;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
public class TypeDrawerSettingsAttribute : Attribute
{
	public Type BaseType;

	public TypeInclusionFilter Filter = TypeInclusionFilter.IncludeAll;
}
