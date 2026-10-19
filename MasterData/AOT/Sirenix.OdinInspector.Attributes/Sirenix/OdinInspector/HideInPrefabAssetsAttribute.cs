using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All)]
[Conditional("UNITY_EDITOR")]
[Obsolete("Use [HideIn(PrefabKind.PrefabAsset)] instead.", false)]
[EditorBrowsable(EditorBrowsableState.Never)]
public class HideInPrefabAssetsAttribute : Attribute
{
}
