using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = false)]
[Conditional("UNITY_EDITOR")]
public class ButtonAttribute : ShowInInspectorAttribute
{
	public string Name;

	public ButtonStyle Style;

	public bool Expanded;

	public bool DisplayParameters = true;

	public bool DirtyOnClick = true;

	public SdfIconType Icon;

	private int buttonHeight;

	private bool drawResult;

	private bool drawResultIsSet;

	private bool stretch;

	private IconAlignment buttonIconAlignment;

	private float buttonAlignment;

	public int ButtonHeight
	{
		get
		{
			return buttonHeight;
		}
		set
		{
			buttonHeight = value;
			HasDefinedButtonHeight = true;
		}
	}

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

	public float ButtonAlignment
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

	public bool DrawResult
	{
		get
		{
			return drawResult;
		}
		set
		{
			drawResult = value;
			drawResultIsSet = true;
		}
	}

	public bool DrawResultIsSet => drawResultIsSet;

	public bool HasDefinedButtonHeight { get; private set; }

	public bool HasDefinedIcon => Icon != SdfIconType.None;

	public bool HasDefinedButtonIconAlignment { get; private set; }

	public bool HasDefinedButtonAlignment { get; private set; }

	public bool HasDefinedStretch { get; private set; }

	public ButtonAttribute()
	{
		Name = null;
	}

	public ButtonAttribute(ButtonSizes size)
	{
		Name = null;
		ButtonHeight = (int)size;
	}

	public ButtonAttribute(int buttonSize)
	{
		ButtonHeight = buttonSize;
		Name = null;
	}

	public ButtonAttribute(string name)
	{
		Name = name;
	}

	public ButtonAttribute(string name, ButtonSizes buttonSize)
	{
		Name = name;
		ButtonHeight = (int)buttonSize;
	}

	public ButtonAttribute(string name, int buttonSize)
	{
		Name = name;
		ButtonHeight = buttonSize;
	}

	public ButtonAttribute(ButtonStyle parameterBtnStyle)
	{
		Name = null;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(int buttonSize, ButtonStyle parameterBtnStyle)
	{
		ButtonHeight = buttonSize;
		Name = null;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(ButtonSizes size, ButtonStyle parameterBtnStyle)
	{
		ButtonHeight = (int)size;
		Name = null;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(string name, ButtonStyle parameterBtnStyle)
	{
		Name = name;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(string name, ButtonSizes buttonSize, ButtonStyle parameterBtnStyle)
	{
		Name = name;
		ButtonHeight = (int)buttonSize;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(string name, int buttonSize, ButtonStyle parameterBtnStyle)
	{
		Name = name;
		ButtonHeight = buttonSize;
		Style = parameterBtnStyle;
	}

	public ButtonAttribute(SdfIconType icon, IconAlignment iconAlignment)
	{
		Icon = icon;
		IconAlignment = iconAlignment;
		Name = null;
	}

	public ButtonAttribute(SdfIconType icon)
	{
		Icon = icon;
		Name = null;
	}

	public ButtonAttribute(SdfIconType icon, string name)
	{
		Name = name;
		Icon = icon;
	}
}
