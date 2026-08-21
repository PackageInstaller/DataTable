using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[EditorBrowsable(EditorBrowsableState.Never)]
[Conditional("UNITY_EDITOR")]
[Obsolete("Use [DisableIn(PrefabKind.NonPrefabInstance)] instead.", false)]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All)]
public class DisableInNonPrefabsAttribute : Attribute
{
}
