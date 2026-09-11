using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[AttributeUsage(AttributeTargets.Struct)]
[RequiredByNativeCode]
public sealed class NativeContainerAttribute : Attribute
{
}
