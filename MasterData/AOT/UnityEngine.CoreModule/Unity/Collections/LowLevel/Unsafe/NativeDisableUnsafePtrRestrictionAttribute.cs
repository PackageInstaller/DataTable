using System;
using UnityEngine.Scripting;

namespace Unity.Collections.LowLevel.Unsafe;

[AttributeUsage(AttributeTargets.Field)]
[RequiredByNativeCode]
public sealed class NativeDisableUnsafePtrRestrictionAttribute : Attribute
{
}
