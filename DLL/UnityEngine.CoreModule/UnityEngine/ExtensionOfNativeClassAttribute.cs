using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, Inherited = true)]
internal sealed class ExtensionOfNativeClassAttribute : Attribute
{
}
