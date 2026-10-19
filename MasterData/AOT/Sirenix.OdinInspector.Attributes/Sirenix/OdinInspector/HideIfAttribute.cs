using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public sealed class HideIfAttribute : Attribute
{
	public string Condition;

	public object Value;

	public bool Animate;

	[Obsolete("Use the Condition member instead.", false)]
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

	public HideIfAttribute(string condition, bool animate = true)
	{
		Condition = condition;
		Animate = animate;
	}

	public HideIfAttribute(string condition, object optionalValue, bool animate = true)
	{
		Condition = condition;
		Value = optionalValue;
		Animate = animate;
	}
}
