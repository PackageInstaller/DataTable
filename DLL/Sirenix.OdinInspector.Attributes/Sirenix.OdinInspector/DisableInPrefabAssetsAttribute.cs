using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All)]
[Conditional("UNITY_EDITOR")]
[EditorBrowsable(EditorBrowsableState.Never)]
[Obsolete("Use [DisableIn(PrefabKind.PrefabAsset)] instead.", false)]
public class DisableInPrefabAssetsAttribute : Attribute
{
}
