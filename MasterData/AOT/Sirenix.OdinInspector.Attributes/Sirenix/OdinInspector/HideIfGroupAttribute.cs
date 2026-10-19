using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
public class HideIfGroupAttribute : PropertyGroupAttribute
{
	public object Value;

	public bool Animate
	{
		get
		{
			return AnimateVisibility;
		}
		set
		{
			AnimateVisibility = value;
		}
	}

	[Obsolete("Use the Condition member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string MemberName
	{
		get
		{
			return Condition;
		}
		set
		{
			Condition = value;
		}
	}

	public string Condition
	{
		get
		{
			if (!string.IsNullOrEmpty(VisibleIf))
			{
				return VisibleIf;
			}
			return GroupName;
		}
		set
		{
			VisibleIf = value;
		}
	}

	public HideIfGroupAttribute(string path, bool animate = true)
		: base(path)
	{
		Animate = animate;
	}

	public HideIfGroupAttribute(string path, object value, bool animate = true)
		: base(path)
	{
		Value = value;
		Animate = animate;
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		HideIfGroupAttribute hideIfGroupAttribute = other as HideIfGroupAttribute;
		if (Value != null)
		{
			hideIfGroupAttribute.Value = Value;
		}
	}
}
