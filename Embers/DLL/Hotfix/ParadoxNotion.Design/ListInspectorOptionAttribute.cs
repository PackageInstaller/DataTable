using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class ListInspectorOptionAttribute : Attribute
{
	public readonly bool allowAdd;

	public readonly bool allowRemove;

	public readonly bool showFoldout;

	public ListInspectorOptionAttribute(bool allowAdd, bool allowRemove, bool alwaysExpanded)
	{
		this.allowAdd = allowAdd;
		this.allowRemove = allowRemove;
		showFoldout = alwaysExpanded;
	}
}
