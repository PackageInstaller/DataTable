using System;

namespace GameFramework.Runtime.Parameters;

public class ConstantCommandParameter : ICommandParameter
{
	private object parameter;

	public ConstantCommandParameter(object parameter)
	{
		this.parameter = parameter;
	}

	public object GetValue()
	{
		return parameter;
	}

	public Type GetValueType()
	{
		return (parameter != null) ? parameter.GetType() : typeof(object);
	}
}
