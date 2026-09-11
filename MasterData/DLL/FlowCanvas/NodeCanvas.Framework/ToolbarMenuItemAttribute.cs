using System;

namespace NodeCanvas.Framework;

[AttributeUsage(AttributeTargets.Method)]
public class ToolbarMenuItemAttribute : Attribute
{
	public readonly string path;

	public ToolbarMenuItemAttribute(string path)
	{
		this.path = path;
	}
}
