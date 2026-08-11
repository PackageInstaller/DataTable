using System;

[Serializable]
public class SkillIntVariable : SkillBlackVariable
{
	public int variableValue;

	public override string InitVariableKey => "IntVariable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(int);
	}

	public override void SetValue(object obj)
	{
		variableValue = (int)obj;
	}
}
