using System;

namespace GameFramework.Runtime;

public class WindowStateEventArgs : EventArgs
{
	private readonly WindowState oldState;

	private readonly WindowState state;

	private readonly IWindow window;

	public WindowState OldState => oldState;

	public WindowState State => state;

	public IWindow Window => window;

	public WindowStateEventArgs(IWindow window, WindowState oldState, WindowState newState)
	{
		this.window = window;
		this.oldState = oldState;
		state = newState;
	}
}
