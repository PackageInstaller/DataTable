using System;
using UnityEngine;

[Serializable]
public class SkillCuveVariable : SkillBlackVariable
{
	public AnimationCurve variableValue = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	public override string InitVariableKey => "CuveVariable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(AnimationCurve);
	}

	public override void SetValue(object obj)
	{
		variableValue = (AnimationCurve)obj;
	}
}
