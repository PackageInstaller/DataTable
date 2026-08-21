using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All)]
public class HideInEditorModeAttribute : Attribute
{
}
