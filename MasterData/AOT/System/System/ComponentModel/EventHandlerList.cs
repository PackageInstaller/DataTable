namespace System.ComponentModel;

public sealed class EventHandlerList
{
	private sealed class ListEntry
	{
		internal ListEntry _next;

		internal object _key;

		internal Delegate _handler;
	}

	private ListEntry _head;

	private Component _parent;

	public Delegate this[object key]
	{
		get
		{
			ListEntry listEntry = null;
			if (_parent == null || _parent.CanRaiseEventsInternal)
			{
				listEntry = Find(key);
			}
			return listEntry?._handler;
		}
	}

	private ListEntry Find(object key)
	{
		ListEntry listEntry = _head;
		while (listEntry != null && listEntry._key != key)
		{
			listEntry = listEntry._next;
		}
		return listEntry;
	}
}
