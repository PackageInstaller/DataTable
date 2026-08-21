using System;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Method, AllowMultiple = false)]
[RequiredByNativeCode]
public sealed class IgnoredByDeepProfilerAttribute : Attribute
{
}
