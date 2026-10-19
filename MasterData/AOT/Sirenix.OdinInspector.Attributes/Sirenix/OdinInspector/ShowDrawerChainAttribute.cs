using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All)]
[Conditional("UNITY_EDITOR")]
public class ShowDrawerChainAttribute : Attribute
{
}
