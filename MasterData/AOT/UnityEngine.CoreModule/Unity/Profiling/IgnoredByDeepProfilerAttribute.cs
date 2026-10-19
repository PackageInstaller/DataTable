using System;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Method, AllowMultiple = false)]
public sealed class IgnoredByDeepProfilerAttribute : Attribute
{
}
