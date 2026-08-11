using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Struct)]
[Obsolete("Use NativeSetThreadIndexAttribute instead")]
public sealed class NativeContainerNeedsThreadIndexAttribute : Attribute
{
}
