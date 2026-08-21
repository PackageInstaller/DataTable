using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class PropertyTooltipAttribute : Attribute
{
	public string Tooltip;

	public PropertyTooltipAttribute(string tooltip)
	{
		Tooltip = tooltip;
	}
}
