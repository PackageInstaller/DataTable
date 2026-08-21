using System;
using UnityEngine.Scripting;

namespace Unity.Collections;

[AttributeUsage(AttributeTargets.Field | AttributeTargets.Parameter | AttributeTargets.ReturnValue)]
[RequiredByNativeCode]
public sealed class WriteOnlyAttribute : Attribute
{
}
