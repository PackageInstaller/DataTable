using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public sealed class DisableIfAttribute : Attribute
{
	public string Condition;

	public object Value;

	[EditorBrowsable(EditorBrowsableState.Never)]
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

	public DisableIfAttribute(string condition)
	{
		Condition = condition;
	}

	public DisableIfAttribute(string condition, object optionalValue)
	{
		Condition = condition;
		Value = optionalValue;
	}
}
