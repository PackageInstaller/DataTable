using UnityEngine;

public class EnumHideAttribute : PropertyAttribute
{
	public readonly string[] HiddenNames;

	public EnumHideAttribute(params string[] hiddenNames)
	{
		HiddenNames = hiddenNames;
	}
}
