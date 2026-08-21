using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Class)]
public class ExecutionPriorityAttribute : Attribute
{
	public readonly int priority;

	public ExecutionPriorityAttribute(int priority)
	{
		this.priority = priority;
	}
}
