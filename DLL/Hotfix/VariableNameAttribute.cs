using System;

public class VariableNameAttribute : Attribute
{
	public string VariableName;

	public VariableNameAttribute(string variableName)
	{
		VariableName = variableName;
	}
}
