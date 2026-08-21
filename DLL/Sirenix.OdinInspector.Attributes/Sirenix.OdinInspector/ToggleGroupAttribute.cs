using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class ToggleGroupAttribute : PropertyGroupAttribute
{
	public string ToggleGroupTitle;

	public bool CollapseOthersOnExpand;

	public string ToggleMemberName => GroupName;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Add a $ infront of group title instead, i.e: \"$MyStringMember\".")]
	public string TitleStringMemberName { get; set; }

	public ToggleGroupAttribute(string toggleMemberName, float order = 0f, string groupTitle = null)
		: base(toggleMemberName, order)
	{
		ToggleGroupTitle = groupTitle;
		CollapseOthersOnExpand = true;
	}

	public ToggleGroupAttribute(string toggleMemberName, string groupTitle)
		: this(toggleMemberName, 0f, groupTitle)
	{
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use [ToggleGroup(\"toggleMemberName\", groupTitle: \"$titleStringMemberName\")] instead")]
	public ToggleGroupAttribute(string toggleMemberName, float order, string groupTitle, string titleStringMemberName)
		: base(toggleMemberName, order)
	{
		ToggleGroupTitle = groupTitle;
		CollapseOthersOnExpand = true;
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		ToggleGroupAttribute toggleGroupAttribute = other as ToggleGroupAttribute;
		if (ToggleGroupTitle == null)
		{
			ToggleGroupTitle = toggleGroupAttribute.ToggleGroupTitle;
		}
		else if (toggleGroupAttribute.ToggleGroupTitle == null)
		{
			toggleGroupAttribute.ToggleGroupTitle = ToggleGroupTitle;
		}
		CollapseOthersOnExpand = CollapseOthersOnExpand && toggleGroupAttribute.CollapseOthersOnExpand;
		toggleGroupAttribute.CollapseOthersOnExpand = CollapseOthersOnExpand;
	}
}
