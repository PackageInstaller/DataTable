using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[DontApplyToListElements]
public sealed class OnValueChangedAttribute : Attribute
{
	public string Action;

	public bool IncludeChildren;

	public bool InvokeOnUndoRedo = true;

	public bool InvokeOnInitialize;

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

	public OnValueChangedAttribute(string action, bool includeChildren = false)
	{
		Action = action;
		IncludeChildren = includeChildren;
	}
}
