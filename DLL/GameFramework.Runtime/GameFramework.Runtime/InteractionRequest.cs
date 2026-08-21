using System;

namespace GameFramework.Runtime;

public class InteractionRequest : IInteractionRequest
{
	private static readonly InteractionEventArgs emptyEventArgs = new InteractionEventArgs(null, null);

	private object sender;

	public event EventHandler<InteractionEventArgs> Raised;

	public InteractionRequest()
		: this(null)
	{
	}

	public InteractionRequest(object sender)
	{
		this.sender = ((sender != null) ? sender : this);
	}

	public void Raise()
	{
		Raise(null);
	}

	public void Raise(Action callback)
	{
		Raised?.Invoke(sender, (callback == null) ? emptyEventArgs : new InteractionEventArgs(null, delegate
		{
			if (callback != null)
			{
				callback();
			}
		}));
	}
}
public class InteractionRequest<T> : IInteractionRequest
{
	private static readonly InteractionEventArgs emptyEventArgs = new InteractionEventArgs(null, null);

	private object sender;

	public event EventHandler<InteractionEventArgs> Raised;

	public InteractionRequest()
		: this((object)null)
	{
	}

	public InteractionRequest(object sender)
	{
		this.sender = ((sender != null) ? sender : this);
	}

	public void Raise(T context)
	{
		Raise(context, null);
	}

	public void Raise(T context, Action<T> callback)
	{
		Raised?.Invoke(sender, (context == null && callback == null) ? emptyEventArgs : new InteractionEventArgs(context, delegate
		{
			if (callback != null)
			{
				callback(context);
			}
		}));
	}
}
