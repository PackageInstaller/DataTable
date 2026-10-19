using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public class DisableInPlayModeAttribute : Attribute
{
}
