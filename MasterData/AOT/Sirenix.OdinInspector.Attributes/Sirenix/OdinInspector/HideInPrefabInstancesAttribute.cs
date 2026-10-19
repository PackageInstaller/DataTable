using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[EditorBrowsable(EditorBrowsableState.Never)]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
[Obsolete("Use [HideIn(PrefabKind.PrefabInstance)] instead.", false)]
public class HideInPrefabInstancesAttribute : Attribute
{
}
