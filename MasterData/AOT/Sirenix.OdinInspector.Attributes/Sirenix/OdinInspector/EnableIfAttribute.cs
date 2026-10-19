using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[DontApplyToListElements]
public sealed class EnableIfAttribute : Attribute
{
	public string Condition;

	public object Value;

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

	public EnableIfAttribute(string condition)
	{
		Condition = condition;
	}

	public EnableIfAttribute(string condition, object optionalValue)
	{
		Condition = condition;
		Value = optionalValue;
	}
}
