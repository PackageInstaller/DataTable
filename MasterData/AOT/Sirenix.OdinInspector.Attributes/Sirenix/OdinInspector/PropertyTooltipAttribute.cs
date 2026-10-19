using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[DontApplyToListElements]
public sealed class PropertyTooltipAttribute : Attribute
{
	public string Tooltip;

	public PropertyTooltipAttribute(string tooltip)
	{
		Tooltip = tooltip;
	}
}
