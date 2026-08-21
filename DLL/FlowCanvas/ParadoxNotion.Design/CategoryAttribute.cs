using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.All)]
public class CategoryAttribute : Attribute
{
	public readonly string category;

	public CategoryAttribute(string category)
	{
		this.category = category;
	}
}
