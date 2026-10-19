using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All)]
[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[EditorBrowsable(EditorBrowsableState.Never)]
[Obsolete("Use [HideIn(PrefabKind.PrefabAsset | PrefabKind.PrefabInstance)] instead.", false)]
public class HideInPrefabsAttribute : Attribute
{
}
