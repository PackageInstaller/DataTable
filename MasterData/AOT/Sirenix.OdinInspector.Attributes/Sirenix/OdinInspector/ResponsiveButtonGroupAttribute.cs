using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[IncludeMyAttributes]
[ShowInInspector]
[AttributeUsage(AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class ResponsiveButtonGroupAttribute(string group = "_DefaultResponsiveButtonGroup") : PropertyGroupAttribute(group)
{
	public ButtonSizes DefaultButtonSize = ButtonSizes.Medium;

	public bool UniformLayout;

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		ResponsiveButtonGroupAttribute responsiveButtonGroupAttribute = other as ResponsiveButtonGroupAttribute;
		if (other != null)
		{
			if (responsiveButtonGroupAttribute.DefaultButtonSize != ButtonSizes.Medium)
			{
				DefaultButtonSize = responsiveButtonGroupAttribute.DefaultButtonSize;
			}
			else if (DefaultButtonSize != ButtonSizes.Medium)
			{
				responsiveButtonGroupAttribute.DefaultButtonSize = DefaultButtonSize;
			}
			UniformLayout = UniformLayout || responsiveButtonGroupAttribute.UniformLayout;
		}
	}
}
