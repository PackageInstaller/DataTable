using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[HideInTables]
[IncludeMyAttributes]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = false)]
public class OnInspectorInitAttribute : ShowInInspectorAttribute
{
	public string Action;

	public OnInspectorInitAttribute()
	{
	}

	public OnInspectorInitAttribute(string action)
	{
		Action = action;
	}
}
