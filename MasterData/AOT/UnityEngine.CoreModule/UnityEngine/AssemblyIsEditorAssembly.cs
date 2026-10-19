using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Assembly)]
public class AssemblyIsEditorAssembly : Attribute
{
}
