using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
public class DisableInInlineEditorsAttribute : Attribute
{
}
