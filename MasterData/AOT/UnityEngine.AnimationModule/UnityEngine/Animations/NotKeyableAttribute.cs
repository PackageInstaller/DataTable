using System;
using UnityEngine.Scripting;

namespace UnityEngine.Animations;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Field)]
[RequiredByNativeCode]
public class NotKeyableAttribute : Attribute
{
}
