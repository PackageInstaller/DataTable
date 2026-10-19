using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
[RequiredByNativeCode]
public sealed class SharedBetweenAnimatorsAttribute : Attribute
{
}
