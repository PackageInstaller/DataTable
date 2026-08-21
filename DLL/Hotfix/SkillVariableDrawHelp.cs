using System;
using UnityEngine;

public static class SkillVariableDrawHelp
{
	[Obsolete("Obsolete")]
	public static object DrawVariable(Type propertyType, object propertyValue, float inputFieldHight, float inputFieldWeight, bool isExpandWidth)
	{
		GUILayoutOption[] array = (GUILayoutOption[])(object)new GUILayoutOption[2]
		{
			GUILayout.Height(inputFieldHight),
			default(GUILayoutOption)
		};
		if (!isExpandWidth)
		{
			array[1] = GUILayout.Width(inputFieldWeight);
		}
		else
		{
			array[1] = GUILayout.ExpandWidth(true);
		}
		return null;
	}

	public static SkillBlackVariable GetVariableInitValue(Type propertyType)
	{
		if (propertyType == typeof(int))
		{
			return new SkillIntVariable();
		}
		if (propertyType == typeof(float))
		{
			return new SkillFloatVariable();
		}
		if (propertyType == typeof(bool))
		{
			return new SkillBoolVariable();
		}
		if (propertyType == typeof(string))
		{
			return new SkillStringVariable();
		}
		if (propertyType == typeof(Vector3))
		{
			return new SkillVector3Variable();
		}
		if (propertyType == typeof(Vector2))
		{
			return new SkillVector2Variable();
		}
		if (propertyType == typeof(AnimationCurve))
		{
			return new SkillCuveVariable();
		}
		if (propertyType.IsEnum)
		{
			SkillEnumVariable skillEnumVariable = new SkillEnumVariable();
			skillEnumVariable.SetEnumType(propertyType.FullName);
			Array values = Enum.GetValues(propertyType);
			skillEnumVariable.SetValue(values.GetValue(0));
			return skillEnumVariable;
		}
		return null;
	}
}
