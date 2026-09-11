using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Assembly)]
[RequiredByNativeCode]
public class AssemblyIsEditorAssembly : Attribute
{
}
