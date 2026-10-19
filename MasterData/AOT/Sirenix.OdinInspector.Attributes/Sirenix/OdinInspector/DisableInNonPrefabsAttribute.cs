using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[EditorBrowsable(EditorBrowsableState.Never)]
[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
[Obsolete("Use [DisableIn(PrefabKind.NonPrefabInstance)] instead.", false)]
public class DisableInNonPrefabsAttribute : Attribute
{
}
