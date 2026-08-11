using System;

[Serializable]
public class SkillStringVariable : SkillBlackVariable
{
	public string variableValue = "test";

	public override string InitVariableKey => "stringVariable";

	public override object GetValue => variableValue;

	public override Type VariableType()
	{
		return typeof(string);
	}

	public override void SetValue(object obj)
	{
		variableValue = (string)obj;
	}
}
