using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
public class DrawWithUnityAttribute : Attribute
{
	public bool PreferImGUI;
}
