namespace System.Collections.Specialized;

public class NotifyCollectionChangedEventArgs : EventArgs
{
	private NotifyCollectionChangedAction _action;

	private IList _newItems;

	private IList _oldItems;

	private int _newStartingIndex = -1;

	private int _oldStartingIndex = -1;

	public NotifyCollectionChangedAction Action => _action;

	public IList NewItems => _newItems;

	public IList OldItems => _oldItems;

	public int NewStartingIndex => _newStartingIndex;

	public int OldStartingIndex => _oldStartingIndex;

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action)
	{
		if (action != NotifyCollectionChangedAction.Reset)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Reset), "action");
		}
		InitializeAdd(action, null, -1);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, object changedItem)
	{
		if (action != NotifyCollectionChangedAction.Add && action != NotifyCollectionChangedAction.Remove && action != NotifyCollectionChangedAction.Reset)
		{
			throw new ArgumentException("Constructor only supports either a Reset, Add, or Remove action.", "action");
		}
		if (action == NotifyCollectionChangedAction.Reset)
		{
			if (changedItem != null)
			{
				throw new ArgumentException("Reset action must be initialized with no changed items.", "action");
			}
			InitializeAdd(action, null, -1);
		}
		else
		{
			InitializeAddOrRemove(action, new object[1] { changedItem }, -1);
		}
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, object changedItem, int index)
	{
		if (action != NotifyCollectionChangedAction.Add && action != NotifyCollectionChangedAction.Remove && action != NotifyCollectionChangedAction.Reset)
		{
			throw new ArgumentException("Constructor only supports either a Reset, Add, or Remove action.", "action");
		}
		if (action == NotifyCollectionChangedAction.Reset)
		{
			if (changedItem != null)
			{
				throw new ArgumentException("Reset action must be initialized with no changed items.", "action");
			}
			if (index != -1)
			{
				throw new ArgumentException("Reset action must be initialized with index -1.", "action");
			}
			InitializeAdd(action, null, -1);
		}
		else
		{
			InitializeAddOrRemove(action, new object[1] { changedItem }, index);
		}
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList changedItems)
	{
		if (action != NotifyCollectionChangedAction.Add && action != NotifyCollectionChangedAction.Remove && action != NotifyCollectionChangedAction.Reset)
		{
			throw new ArgumentException("Constructor only supports either a Reset, Add, or Remove action.", "action");
		}
		if (action == NotifyCollectionChangedAction.Reset)
		{
			if (changedItems != null)
			{
				throw new ArgumentException("Reset action must be initialized with no changed items.", "action");
			}
			InitializeAdd(action, null, -1);
		}
		else
		{
			if (changedItems == null)
			{
				throw new ArgumentNullException("changedItems");
			}
			InitializeAddOrRemove(action, changedItems, -1);
		}
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList changedItems, int startingIndex)
	{
		if (action != NotifyCollectionChangedAction.Add && action != NotifyCollectionChangedAction.Remove && action != NotifyCollectionChangedAction.Reset)
		{
			throw new ArgumentException("Constructor only supports either a Reset, Add, or Remove action.", "action");
		}
		if (action == NotifyCollectionChangedAction.Reset)
		{
			if (changedItems != null)
			{
				throw new ArgumentException("Reset action must be initialized with no changed items.", "action");
			}
			if (startingIndex != -1)
			{
				throw new ArgumentException("Reset action must be initialized with index -1.", "action");
			}
			InitializeAdd(action, null, -1);
		}
		else
		{
			if (changedItems == null)
			{
				throw new ArgumentNullException("changedItems");
			}
			if (startingIndex < -1)
			{
				throw new ArgumentException("Index cannot be negative.", "startingIndex");
			}
			InitializeAddOrRemove(action, changedItems, startingIndex);
		}
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, object newItem, object oldItem)
	{
		if (action != NotifyCollectionChangedAction.Replace)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Replace), "action");
		}
		InitializeMoveOrReplace(action, new object[1] { newItem }, new object[1] { oldItem }, -1, -1);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, object newItem, object oldItem, int index)
	{
		if (action != NotifyCollectionChangedAction.Replace)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Replace), "action");
		}
		InitializeMoveOrReplace(action, new object[1] { newItem }, new object[1] { oldItem }, index, index);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList newItems, IList oldItems)
	{
		if (action != NotifyCollectionChangedAction.Replace)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Replace), "action");
		}
		if (newItems == null)
		{
			throw new ArgumentNullException("newItems");
		}
		if (oldItems == null)
		{
			throw new ArgumentNullException("oldItems");
		}
		InitializeMoveOrReplace(action, newItems, oldItems, -1, -1);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList newItems, IList oldItems, int startingIndex)
	{
		if (action != NotifyCollectionChangedAction.Replace)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Replace), "action");
		}
		if (newItems == null)
		{
			throw new ArgumentNullException("newItems");
		}
		if (oldItems == null)
		{
			throw new ArgumentNullException("oldItems");
		}
		InitializeMoveOrReplace(action, newItems, oldItems, startingIndex, startingIndex);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, object changedItem, int index, int oldIndex)
	{
		if (action != NotifyCollectionChangedAction.Move)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Move), "action");
		}
		if (index < 0)
		{
			throw new ArgumentException("Index cannot be negative.", "index");
		}
		object[] array = new object[1] { changedItem };
		InitializeMoveOrReplace(action, array, array, index, oldIndex);
	}

	public NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList changedItems, int index, int oldIndex)
	{
		if (action != NotifyCollectionChangedAction.Move)
		{
			throw new ArgumentException(global::SR.Format("Constructor supports only the '{0}' action.", NotifyCollectionChangedAction.Move), "action");
		}
		if (index < 0)
		{
			throw new ArgumentException("Index cannot be negative.", "index");
		}
		InitializeMoveOrReplace(action, changedItems, changedItems, index, oldIndex);
	}

	internal NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction action, IList newItems, IList oldItems, int newIndex, int oldIndex)
	{
		_action = action;
		_newItems = ((newItems == null) ? null : new ReadOnlyList(newItems));
		_oldItems = ((oldItems == null) ? null : new ReadOnlyList(oldItems));
		_newStartingIndex = newIndex;
		_oldStartingIndex = oldIndex;
	}

	private void InitializeAddOrRemove(NotifyCollectionChangedAction action, IList changedItems, int startingIndex)
	{
		switch (action)
		{
		case NotifyCollectionChangedAction.Add:
			InitializeAdd(action, changedItems, startingIndex);
			break;
		case NotifyCollectionChangedAction.Remove:
			InitializeRemove(action, changedItems, startingIndex);
			break;
		}
	}

	private void InitializeAdd(NotifyCollectionChangedAction action, IList newItems, int newStartingIndex)
	{
		_action = action;
		_newItems = ((newItems == null) ? null : new ReadOnlyList(newItems));
		_newStartingIndex = newStartingIndex;
	}

	private void InitializeRemove(NotifyCollectionChangedAction action, IList oldItems, int oldStartingIndex)
	{
		_action = action;
		_oldItems = ((oldItems == null) ? null : new ReadOnlyList(oldItems));
		_oldStartingIndex = oldStartingIndex;
	}

	private void InitializeMoveOrReplace(NotifyCollectionChangedAction action, IList newItems, IList oldItems, int startingIndex, int oldStartingIndex)
	{
		InitializeAdd(action, newItems, startingIndex);
		InitializeRemove(action, oldItems, oldStartingIndex);
	}
}
