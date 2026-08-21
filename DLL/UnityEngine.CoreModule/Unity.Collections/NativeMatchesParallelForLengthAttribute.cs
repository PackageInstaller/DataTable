using System;
using UnityEngine.Scripting;

namespace Unity.Collections;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Field)]
public sealed class NativeMatchesParallelForLengthAttribute : Attribute
{
}
