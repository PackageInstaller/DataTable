using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
public class ChildGameObjectsOnlyAttribute : Attribute
{
	public bool IncludeSelf = true;

	public bool IncludeInactive;
}
