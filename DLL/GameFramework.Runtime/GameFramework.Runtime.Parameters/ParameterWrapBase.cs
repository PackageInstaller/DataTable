using System;

namespace GameFramework.Runtime.Parameters;

public class ParameterWrapBase
{
	protected readonly ICommandParameter commandParameter;

	public ParameterWrapBase(ICommandParameter commandParameter)
	{
		if (commandParameter == null)
		{
			throw new ArgumentNullException("commandParameter");
		}
		this.commandParameter = commandParameter;
	}

	protected virtual object GetParameterValue()
	{
		return commandParameter.GetValue();
	}

	protected virtual Type GetParameterValueType()
	{
		return commandParameter.GetValueType();
	}
}
