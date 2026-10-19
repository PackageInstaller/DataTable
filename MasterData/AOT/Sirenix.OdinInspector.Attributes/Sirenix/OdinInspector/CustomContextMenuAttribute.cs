using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
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
