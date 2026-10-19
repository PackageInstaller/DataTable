using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = false)]
[Conditional("UNITY_EDITOR")]
[IncludeMyAttributes]
[HideInTables]
[DontApplyToListElements]
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
