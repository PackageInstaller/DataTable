using System;

[Serializable]
public class SkillFloatVariable : SkillBlackVariable
{
	public float variableValue;

	public override string InitVariableKey => "FloatVariable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(float);
	}

	public override void SetValue(object obj)
	{
		variableValue = (float)obj;
	}
}
