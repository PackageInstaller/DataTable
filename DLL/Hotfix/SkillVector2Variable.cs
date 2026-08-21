using System;
using UnityEngine;

[Serializable]
public class SkillVector2Variable : SkillBlackVariable
{
	public Vector2 variableValue = Vector2.zero;

	public override string InitVariableKey => "Vector2Variable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(Vector2);
	}

	public override void SetValue(object obj)
	{
		variableValue = (Vector2)obj;
	}
}
