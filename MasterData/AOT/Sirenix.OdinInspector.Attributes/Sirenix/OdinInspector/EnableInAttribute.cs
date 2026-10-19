using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public class EnableInAttribute : Attribute
{
	public PrefabKind PrefabKind;

	public EnableInAttribute(PrefabKind prefabKind)
	{
		PrefabKind = prefabKind;
	}
}
