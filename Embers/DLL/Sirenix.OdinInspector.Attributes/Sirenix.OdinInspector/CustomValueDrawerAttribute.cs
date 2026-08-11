using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class CustomValueDrawerAttribute : Attribute
{
	public string Action;

	[Obsolete("Use the Action member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string MethodName
	{
		get
		{
			return Action;
		}
		set
		{
			Action = value;
		}
	}

	public CustomValueDrawerAttribute(string action)
	{
		Action = action;
	}
}
