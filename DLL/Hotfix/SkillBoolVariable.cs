using System;

[Serializable]
public class SkillBoolVariable : SkillBlackVariable
{
	public bool variableValue;

	public override string InitVariableKey => "BoolVariable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(bool);
	}

	public override void SetValue(object obj)
	{
		variableValue = (bool)obj;
	}
}
