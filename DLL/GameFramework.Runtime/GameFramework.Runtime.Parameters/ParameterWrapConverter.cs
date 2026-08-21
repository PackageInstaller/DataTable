using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime.Parameters;

public class ParameterWrapConverter : AbstractConverter
{
	private readonly ICommandParameter commandParameter;

	public ParameterWrapConverter(ICommandParameter commandParameter)
	{
		if (commandParameter == null)
		{
			throw new ArgumentNullException("commandParameter");
		}
		this.commandParameter = commandParameter;
	}

	public override object Convert(object value)
	{
		if (value == null)
		{
			return null;
		}
		if (value is Delegate)
		{
			return new ParameterWrapDelegateInvoker(value as Delegate, commandParameter);
		}
		if (value is ICommand)
		{
			return new ParameterWrapCommand(value as ICommand, commandParameter);
		}
		if (value is IScriptInvoker)
		{
			return new ParameterWrapScriptInvoker(value as IScriptInvoker, commandParameter);
		}
		if (value is IProxyInvoker)
		{
			return new ParameterWrapProxyInvoker(value as IProxyInvoker, commandParameter);
		}
		throw new NotSupportedException($"Unsupported type \"{value.GetType()}\".");
	}

	public override object ConvertBack(object value)
	{
		throw new NotSupportedException();
	}
}
