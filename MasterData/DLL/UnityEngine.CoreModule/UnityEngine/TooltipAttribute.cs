using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.All, Inherited = true, AllowMultiple = false)]
public class TooltipAttribute : PropertyAttribute
{
	public readonly string tooltip;

	public TooltipAttribute(string tooltip)
	{
		this.tooltip = tooltip;
	}
}
