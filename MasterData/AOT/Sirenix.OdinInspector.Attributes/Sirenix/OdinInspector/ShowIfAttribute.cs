using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class ShowIfAttribute : Attribute
{
	public string Condition;

	public object Value;

	public bool Animate;

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

	public ShowIfAttribute(string condition, bool animate = true)
	{
		Condition = condition;
		Animate = animate;
	}

	public ShowIfAttribute(string condition, object optionalValue, bool animate = true)
	{
		Condition = condition;
		Value = optionalValue;
		Animate = animate;
	}
}
