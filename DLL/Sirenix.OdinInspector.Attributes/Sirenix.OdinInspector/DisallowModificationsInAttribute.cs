using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class DisallowModificationsInAttribute : Attribute
{
	public PrefabKind PrefabKind;

	public DisallowModificationsInAttribute(PrefabKind kind)
	{
		PrefabKind = kind;
	}
}
