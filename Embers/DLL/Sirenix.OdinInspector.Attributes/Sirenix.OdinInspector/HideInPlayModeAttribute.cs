using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
public class HideInPlayModeAttribute : Attribute
{
}
