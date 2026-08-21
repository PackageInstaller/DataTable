using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[EditorBrowsable(EditorBrowsableState.Never)]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
[Obsolete("Use [HideIn(PrefabKind.PrefabAsset)] instead.", false)]
public class HideInPrefabAssetsAttribute : Attribute
{
}
