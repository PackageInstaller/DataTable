using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[EditorBrowsable(EditorBrowsableState.Never)]
[Obsolete("Use [DisableIn(PrefabKind.PrefabInstance)] instead.", false)]
[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public class DisableInPrefabInstancesAttribute : Attribute
{
}
