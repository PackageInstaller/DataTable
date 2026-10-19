using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
public class DisableInAttribute : Attribute
{
	public PrefabKind PrefabKind;

	public DisableInAttribute(PrefabKind prefabKind)
	{
		PrefabKind = prefabKind;
	}
}
