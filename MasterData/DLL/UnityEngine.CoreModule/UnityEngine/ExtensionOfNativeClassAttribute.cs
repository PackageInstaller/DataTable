using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, Inherited = true)]
[RequiredByNativeCode]
internal sealed class ExtensionOfNativeClassAttribute : Attribute
{
}
