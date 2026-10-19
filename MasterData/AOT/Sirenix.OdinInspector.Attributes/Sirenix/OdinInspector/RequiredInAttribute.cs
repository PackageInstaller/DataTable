using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class RequiredInAttribute : Attribute
{
	public string ErrorMessage;

	public PrefabKind PrefabKind;

	public RequiredInAttribute(PrefabKind kind)
	{
		PrefabKind = kind;
	}
}
