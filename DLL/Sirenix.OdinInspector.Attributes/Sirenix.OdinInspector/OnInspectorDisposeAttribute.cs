using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[IncludeMyAttributes]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = false)]
[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[HideInTables]
public class OnInspectorDisposeAttribute : ShowInInspectorAttribute
{
	public string Action;

	public OnInspectorDisposeAttribute()
	{
	}

	public OnInspectorDisposeAttribute(string action)
	{
		Action = action;
	}
}
