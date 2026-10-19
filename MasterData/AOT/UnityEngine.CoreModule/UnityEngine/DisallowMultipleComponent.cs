using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class, Inherited = false)]
[RequiredByNativeCode]
public sealed class DisallowMultipleComponent : Attribute
{
}
