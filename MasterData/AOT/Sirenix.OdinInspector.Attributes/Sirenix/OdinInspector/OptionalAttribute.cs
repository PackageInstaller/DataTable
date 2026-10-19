using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class OptionalAttribute : Attribute
{
}
