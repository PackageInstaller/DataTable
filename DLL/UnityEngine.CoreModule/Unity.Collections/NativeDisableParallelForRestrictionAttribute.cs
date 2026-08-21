using System;
using UnityEngine.Scripting;

namespace Unity.Collections;

[AttributeUsage(AttributeTargets.Field)]
[RequiredByNativeCode]
public sealed class NativeDisableParallelForRestrictionAttribute : Attribute
{
}
