using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Field)]
public sealed class NativeDisableContainerSafetyRestrictionAttribute : Attribute
{
}
