using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class ToggleLeftAttribute : Attribute
{
}
