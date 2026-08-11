using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Class, Inherited = false)]
public sealed class DisallowMultipleComponent : Attribute
{
}
