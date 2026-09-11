using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.All)]
public class NameAttribute : Attribute
{
	public readonly string name;

	public readonly int priority;

	public NameAttribute(string name, int priority = 0)
	{
		this.name = name;
		this.priority = priority;
	}
}
