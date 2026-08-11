using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class ToggleAttribute : Attribute
{
	public string ToggleMemberName;

	public bool CollapseOthersOnExpand;

	public ToggleAttribute(string toggleMemberName)
	{
		ToggleMemberName = toggleMemberName;
		CollapseOthersOnExpand = true;
	}
}
