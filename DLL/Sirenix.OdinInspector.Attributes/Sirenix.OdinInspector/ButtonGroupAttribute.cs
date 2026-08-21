using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
[IncludeMyAttributes]
[ShowInInspector]
public class ButtonGroupAttribute : PropertyGroupAttribute
{
	public int ButtonHeight;

	private IconAlignment buttonIconAlignment;

	private int buttonAlignment;

	private bool stretch;

	public IconAlignment IconAlignment
	{
		get
		{
			return buttonIconAlignment;
		}
		set
		{
			buttonIconAlignment = value;
			HasDefinedButtonIconAlignment = true;
		}
	}

	public int ButtonAlignment
	{
		get
		{
			return buttonAlignment;
		}
		set
		{
			buttonAlignment = value;
			HasDefinedButtonAlignment = true;
		}
	}

	public bool Stretch
	{
		get
		{
			return stretch;
		}
		set
		{
			stretch = value;
			HasDefinedStretch = true;
		}
	}

	public bool HasDefinedButtonIconAlignment { get; private set; }

	public bool HasDefinedButtonAlignment { get; private set; }

	public bool HasDefinedStretch { get; private set; }

	public ButtonGroupAttribute(string group = "_DefaultGroup", float order = 0f)
		: base(group, order)
	{
	}
}
