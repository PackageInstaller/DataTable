using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public class TaskCategoryAttribute : Attribute
{
	public readonly string mCategory;

	public string Category => mCategory;

	public TaskCategoryAttribute(string category)
	{
		mCategory = category;
	}
}
