using System;

namespace GameFramework;

[AttributeUsage(AttributeTargets.Field)]
public class StaticFieldAttribute : Attribute
{
	public readonly object valueToAssign;

	public readonly bool assignNewTypeInstance;

	public StaticFieldAttribute()
	{
		valueToAssign = null;
		assignNewTypeInstance = false;
	}

	public StaticFieldAttribute(object valueToAssign)
	{
		this.valueToAssign = valueToAssign;
		assignNewTypeInstance = false;
	}

	public StaticFieldAttribute(bool assignNewTypeInstance)
	{
		valueToAssign = null;
		this.assignNewTypeInstance = assignNewTypeInstance;
	}
}
