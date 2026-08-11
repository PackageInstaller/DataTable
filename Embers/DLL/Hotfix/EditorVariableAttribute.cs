using System;

public class EditorVariableAttribute : Attribute
{
	public string VariableName;

	public EditorVariableAttribute(string variableName)
	{
		VariableName = variableName;
	}

	public EditorVariableAttribute()
	{
	}
}
