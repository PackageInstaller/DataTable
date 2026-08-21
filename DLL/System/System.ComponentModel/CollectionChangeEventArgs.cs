namespace System.ComponentModel;

public class CollectionChangeEventArgs : EventArgs
{
	public virtual CollectionChangeAction Action { get; }

	public virtual object Element { get; }

	public CollectionChangeEventArgs(CollectionChangeAction action, object element)
	{
		Action = action;
		Element = element;
	}
}
