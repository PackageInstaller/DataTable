using System;

namespace GameFramework.Runtime;

public class SimpleCommand : CommandBase
{
	private bool enabled = true;

	private readonly Action execute;

	public bool Enabled
	{
		get
		{
			return enabled;
		}
		set
		{
			if (enabled != value)
			{
				enabled = value;
				RaiseCanExecuteChanged();
			}
		}
	}

	public SimpleCommand(Action execute, bool keepStrongRef = false)
	{
		if (execute == null)
		{
			throw new ArgumentNullException("execute");
		}
		this.execute = (keepStrongRef ? execute : execute.AsWeak());
	}

	public override bool CanExecute(object parameter)
	{
		return Enabled;
	}

	public override void Execute(object parameter)
	{
		if (CanExecute(parameter) && execute != null)
		{
			execute();
		}
	}
}
public class SimpleCommand<T> : CommandBase
{
	private bool enabled = true;

	private readonly Action<T> execute;

	public bool Enabled
	{
		get
		{
			return enabled;
		}
		set
		{
			if (enabled != value)
			{
				enabled = value;
				RaiseCanExecuteChanged();
			}
		}
	}

	public SimpleCommand(Action<T> execute, bool keepStrongRef = false)
	{
		if (execute == null)
		{
			throw new ArgumentNullException("execute");
		}
		this.execute = (keepStrongRef ? execute : execute.AsWeak());
	}

	public override bool CanExecute(object parameter)
	{
		return Enabled;
	}

	public override void Execute(object parameter)
	{
		if (CanExecute(parameter) && execute != null)
		{
			execute((T)Convert.ChangeType(parameter, typeof(T)));
		}
	}
}
