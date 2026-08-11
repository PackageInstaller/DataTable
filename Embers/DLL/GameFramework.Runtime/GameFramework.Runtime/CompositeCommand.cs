#define ENABLE_LOG
using System;
using System.Collections.Generic;
using System.Linq;

namespace GameFramework.Runtime;

public class CompositeCommand : CommandBase
{
	private readonly List<ICommand> commands = new List<ICommand>();

	private readonly bool monitorCommandActivity;

	private readonly EventHandler onCanExecuteChangedHandler;

	public IList<ICommand> RegisteredCommands
	{
		get
		{
			lock (commands)
			{
				return commands.ToList();
			}
		}
	}

	public CompositeCommand()
		: this(monitorCommandActivity: false)
	{
	}

	public CompositeCommand(bool monitorCommandActivity)
	{
		this.monitorCommandActivity = monitorCommandActivity;
		onCanExecuteChangedHandler = OnCanExecuteChanged;
	}

	public virtual void RegisterCommand(ICommand command)
	{
		if (command == null)
		{
			throw new ArgumentNullException("command");
		}
		if (command == this)
		{
			throw new ArgumentException("Cannot register a CompositeCommand in itself.");
		}
		lock (commands)
		{
			if (commands.Contains(command))
			{
				throw new InvalidOperationException("Cannot register the same command twice in the same CompositeCommand.");
			}
			commands.Add(command);
		}
		command.CanExecuteChanged += onCanExecuteChangedHandler;
		RaiseCanExecuteChanged();
		if (monitorCommandActivity && command is IActiveAware activeAware)
		{
			activeAware.IsActiveChanged += OnIsActiveChanged;
		}
	}

	public virtual void UnregisterCommand(ICommand command)
	{
		if (command == null)
		{
			throw new ArgumentNullException("command");
		}
		lock (commands)
		{
			if (!commands.Remove(command))
			{
				return;
			}
		}
		command.CanExecuteChanged -= onCanExecuteChangedHandler;
		RaiseCanExecuteChanged();
		if (monitorCommandActivity && command is IActiveAware activeAware)
		{
			activeAware.IsActiveChanged -= OnIsActiveChanged;
		}
	}

	private void OnCanExecuteChanged(object sender, EventArgs e)
	{
		RaiseCanExecuteChanged();
	}

	private void OnIsActiveChanged(object sender, EventArgs e)
	{
		RaiseCanExecuteChanged();
	}

	public override bool CanExecute(object parameter)
	{
		ICommand[] array;
		lock (commands)
		{
			array = commands.ToArray();
		}
		if (array.Length == 0)
		{
			return false;
		}
		ICommand[] array2 = array;
		foreach (ICommand command in array2)
		{
			if (ShouldExecute(command) && !command.CanExecute(parameter))
			{
				return false;
			}
		}
		return true;
	}

	public override void Execute(object parameter)
	{
		Queue<ICommand> queue;
		lock (commands)
		{
			queue = new Queue<ICommand>(commands.Where(ShouldExecute).ToList());
		}
		while (queue.Count > 0)
		{
			try
			{
				ICommand command = queue.Dequeue();
				command.Execute(parameter);
			}
			catch (Exception message)
			{
				Log.Warning(message);
			}
		}
	}

	protected virtual bool ShouldExecute(ICommand command)
	{
		if (!monitorCommandActivity)
		{
			return true;
		}
		if (!(command is IActiveAware { IsActive: var isActive }))
		{
			return true;
		}
		return isActive;
	}
}
