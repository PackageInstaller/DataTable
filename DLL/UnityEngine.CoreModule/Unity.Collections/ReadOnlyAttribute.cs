using System;
using UnityEngine.Scripting;

namespace Unity.Collections;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Parameter | AttributeTargets.ReturnValue)]
public sealed class ReadOnlyAttribute : Attribute
{
}
