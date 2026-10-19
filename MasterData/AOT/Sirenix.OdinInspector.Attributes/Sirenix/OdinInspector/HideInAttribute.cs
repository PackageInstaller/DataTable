using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
public class HideInAttribute : Attribute
{
	public PrefabKind PrefabKind;

	public HideInAttribute(PrefabKind prefabKind)
	{
		PrefabKind = prefabKind;
	}
}
