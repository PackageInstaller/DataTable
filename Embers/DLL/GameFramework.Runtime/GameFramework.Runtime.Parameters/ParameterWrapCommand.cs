using System;

namespace GameFramework.Runtime.Parameters;

public class ParameterWrapCommand : ParameterWrapBase, ICommand
{
	private readonly object _lock = new object();

	private readonly ICommand wrappedCommand;

	public event EventHandler CanExecuteChanged
	{
		add
		{
			lock (_lock)
			{
				wrappedCommand.CanExecuteChanged += value;
			}
		}
		remove
		{
			lock (_lock)
			{
				wrappedCommand.CanExecuteChanged -= value;
			}
		}
	}

	public ParameterWrapCommand(ICommand wrappedCommand, ICommandParameter commandParameter)
		: base(commandParameter)
	{
		if (wrappedCommand == null)
		{
			throw new ArgumentNullException("wrappedCommand");
		}
		this.wrappedCommand = wrappedCommand;
	}

	public bool CanExecute(object parameter)
	{
		return wrappedCommand.CanExecute(GetParameterValue());
	}

	public void Execute(object parameter)
	{
		object parameterValue = GetParameterValue();
		if (wrappedCommand.CanExecute(parameterValue))
		{
			wrappedCommand.Execute(parameterValue);
		}
	}
}
