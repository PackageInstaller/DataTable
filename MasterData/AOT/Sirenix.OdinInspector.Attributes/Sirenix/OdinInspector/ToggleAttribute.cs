using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
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
