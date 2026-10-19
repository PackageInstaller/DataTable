using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public class TaskNameAttribute : Attribute
{
	public readonly string mName;

	public string Name => mName;

	public TaskNameAttribute(string name)
	{
		mName = name;
	}
}
