using System;

namespace GameFramework.Runtime;

public interface ICommand
{
	event EventHandler CanExecuteChanged;

	bool CanExecute(object parameter);

	void Execute(object parameter);
}
