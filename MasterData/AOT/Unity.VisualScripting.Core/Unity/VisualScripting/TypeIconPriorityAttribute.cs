using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Interface, AllowMultiple = false, Inherited = false)]
public sealed class TypeIconPriorityAttribute : Attribute
{
	public int priority { get; }

	public TypeIconPriorityAttribute(int priority)
	{
		this.priority = priority;
	}

	public TypeIconPriorityAttribute()
	{
		priority = 0;
	}
}
