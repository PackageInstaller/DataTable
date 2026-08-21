using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[HideInTables]
[DontApplyToListElements]
[IncludeMyAttributes]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class OnStateUpdateAttribute : Attribute
{
	public string Action;

	public OnStateUpdateAttribute(string action)
	{
		Action = action;
	}
}
