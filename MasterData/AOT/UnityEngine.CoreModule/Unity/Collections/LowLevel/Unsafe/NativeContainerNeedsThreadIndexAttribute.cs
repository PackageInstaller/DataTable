using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[RequiredByNativeCode]
[Obsolete("Use NativeSetThreadIndexAttribute instead")]
[AttributeUsage(AttributeTargets.Struct)]
public sealed class NativeContainerNeedsThreadIndexAttribute : Attribute
{
}
