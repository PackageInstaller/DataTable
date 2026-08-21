using System;

public class BlackVariableAttribute : Attribute
{
	public Type VariableType;

	public BlackVariableAttribute(Type variableType)
	{
		VariableType = variableType;
	}

	public BlackVariableAttribute()
	{
	}
}
