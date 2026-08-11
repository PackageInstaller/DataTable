using System;

namespace GameFramework.Runtime;

public abstract class CommandBase : ICommand
{
	private readonly object _lock = new object();

	private EventHandler canExecuteChanged;

	public event EventHandler CanExecuteChanged
	{
		add
		{
			lock (_lock)
			{
				canExecuteChanged = (EventHandler)Delegate.Combine(canExecuteChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				canExecuteChanged = (EventHandler)Delegate.Remove(canExecuteChanged, value);
			}
		}
	}

	public virtual void RaiseCanExecuteChanged()
	{
		canExecuteChanged?.Invoke(this, EventArgs.Empty);
	}

	public abstract bool CanExecute(object parameter);

	public abstract void Execute(object parameter);
}
