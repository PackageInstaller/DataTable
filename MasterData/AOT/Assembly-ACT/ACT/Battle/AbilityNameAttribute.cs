using System;
using System.Diagnostics;

namespace ACT.Battle;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
public class AbilityNameAttribute : Attribute
{
	public bool nullOrEmptyIsVaild;

	public AbilityNameLayout layout = AbilityNameLayout.CompactWithInlineEditor;

	public bool compactLayout => (layout & AbilityNameLayout.Compact) != 0;

	public bool withInlineEditor => (layout & AbilityNameLayout.WithInlineEditor) != 0;

	public AbilityNameAttribute(bool nullOrEmptyIsVaild = false, AbilityNameLayout layout = AbilityNameLayout.CompactWithInlineEditor)
	{
		this.nullOrEmptyIsVaild = nullOrEmptyIsVaild;
		this.layout = layout;
	}

	public AbilityNameAttribute(AbilityNameLayout layout)
	{
		this.layout = layout;
	}
}
