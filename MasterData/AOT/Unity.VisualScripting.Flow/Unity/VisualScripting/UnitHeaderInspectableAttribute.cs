using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public sealed class UnitHeaderInspectableAttribute : Attribute
{
	public string label { get; }

	public UnitHeaderInspectableAttribute()
	{
	}

	public UnitHeaderInspectableAttribute(string label)
	{
		this.label = label;
	}
}
