using System;

namespace GameFramework.Runtime;

public interface IWindow
{
	string Name { get; set; }

	string AssetPath { get; set; }

	bool Created { get; }

	bool Dismissed { get; }

	bool Visibility { get; }

	bool Activated { get; }

	IWindowManager WindowManager { get; set; }

	WindowType WindowType { get; set; }

	int WindowPriority { get; set; }

	event EventHandler VisibilityChanged;

	event EventHandler ActivatedChanged;

	event EventHandler OnDismissed;

	event EventHandler<WindowStateEventArgs> StateChanged;

	void Create(IBundle bundle = null);

	ITransition Show(bool ignoreAnimation = false);

	ITransition Hide(bool ignoreAnimation = false);

	ITransition Dismiss(bool ignoreAnimation = false);
}
