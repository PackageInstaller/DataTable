using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[Obsolete("Use NativeSetThreadIndexAttribute instead")]
[AttributeUsage(AttributeTargets.Struct)]
[RequiredByNativeCode]
public sealed class NativeContainerNeedsThreadIndexAttribute : Attribute
{
}
