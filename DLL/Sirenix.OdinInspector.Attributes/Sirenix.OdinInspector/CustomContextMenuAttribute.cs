using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class CustomContextMenuAttribute : Attribute
{
	public string MenuItem;

	public string Action;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the Action member instead.", false)]
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

	public CustomContextMenuAttribute(string menuItem, string action)
	{
		MenuItem = menuItem;
		Action = action;
	}
}
