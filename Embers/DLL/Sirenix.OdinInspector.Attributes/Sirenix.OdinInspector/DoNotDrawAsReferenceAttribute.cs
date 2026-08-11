using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
public sealed class DoNotDrawAsReferenceAttribute : Attribute
{
}
