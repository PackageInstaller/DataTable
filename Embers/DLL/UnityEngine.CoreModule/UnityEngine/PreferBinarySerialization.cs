using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class)]
[RequiredByNativeCode]
public sealed class PreferBinarySerialization : Attribute
{
}
