using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class FoldoutGroupAttribute : PropertyGroupAttribute
{
	private bool expanded;

	public bool Expanded
	{
		get
		{
			return expanded;
		}
		set
		{
			expanded = value;
			HasDefinedExpanded = true;
		}
	}

	public bool HasDefinedExpanded { get; private set; }

	public FoldoutGroupAttribute(string groupName, float order = 0f)
		: base(groupName, order)
	{
	}

	public FoldoutGroupAttribute(string groupName, bool expanded, float order = 0f)
		: base(groupName, order)
	{
		this.expanded = expanded;
		HasDefinedExpanded = true;
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		FoldoutGroupAttribute foldoutGroupAttribute = other as FoldoutGroupAttribute;
		if (foldoutGroupAttribute.HasDefinedExpanded)
		{
			HasDefinedExpanded = true;
			Expanded = foldoutGroupAttribute.Expanded;
		}
		if (HasDefinedExpanded)
		{
			foldoutGroupAttribute.HasDefinedExpanded = true;
			foldoutGroupAttribute.Expanded = Expanded;
		}
	}
}
