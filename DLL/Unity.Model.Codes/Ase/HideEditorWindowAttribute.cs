using System;
using System.Diagnostics;

namespace Ase;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
[Conditional("UNITY_EDITOR")]
public class HideEditorWindowAttribute : Attribute
{
}
