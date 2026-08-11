using System;

namespace GameFramework.Runtime;

public class InteractionEventArgs : EventArgs
{
	private object context;

	private Action callback;

	public object Context => context;

	public Action Callback => callback;

	public InteractionEventArgs(object context, Action callback)
	{
		this.context = context;
		this.callback = callback;
	}
}
