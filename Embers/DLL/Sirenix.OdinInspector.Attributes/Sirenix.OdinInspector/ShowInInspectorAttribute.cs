using System;
using System.Diagnostics;
using JetBrains.Annotations;

namespace Sirenix.OdinInspector;

[MeansImplicitUse]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = false)]
[Conditional("UNITY_EDITOR")]
public class ShowInInspectorAttribute : Attribute
{
}
