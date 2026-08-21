using System.Collections;
using System.Reflection;

namespace System.Diagnostics;

[DefaultMember("Item")]
public class TraceListenerCollection : IList, ICollection, IEnumerable
{
	private ArrayList list;

	public int Count => list.Count;

	object IList.this[int index]
	{
		get
		{
			return list[index];
		}
		set
		{
			if (!(value is TraceListener traceListener))
			{
				throw new ArgumentException(global::SR.GetString("Only TraceListeners can be added to a TraceListenerCollection."), "value");
			}
			InitializeListener(traceListener);
			list[index] = traceListener;
		}
	}

	bool IList.IsReadOnly => false;

	bool IList.IsFixedSize => false;

	object ICollection.SyncRoot => this;

	bool ICollection.IsSynchronized => true;

	internal TraceListenerCollection()
	{
		list = new ArrayList(1);
	}

	public int Add(TraceListener listener)
	{
		InitializeListener(listener);
		lock (TraceInternal.critSec)
		{
			return list.Add(listener);
		}
	}

	public void Clear()
	{
		list = new ArrayList();
	}

	public IEnumerator GetEnumerator()
	{
		return list.GetEnumerator();
	}

	internal void InitializeListener(TraceListener listener)
	{
		if (listener == null)
		{
			throw new ArgumentNullException("listener");
		}
		listener.IndentSize = TraceInternal.IndentSize;
		listener.IndentLevel = TraceInternal.IndentLevel;
	}

	public void RemoveAt(int index)
	{
		lock (TraceInternal.critSec)
		{
			list.RemoveAt(index);
		}
	}

	int IList.Add(object value)
	{
		if (!(value is TraceListener listener))
		{
			throw new ArgumentException(global::SR.GetString("Only TraceListeners can be added to a TraceListenerCollection."), "value");
		}
		InitializeListener(listener);
		lock (TraceInternal.critSec)
		{
			return list.Add(value);
		}
	}

	bool IList.Contains(object value)
	{
		return list.Contains(value);
	}

	int IList.IndexOf(object value)
	{
		return list.IndexOf(value);
	}

	void IList.Insert(int index, object value)
	{
		if (!(value is TraceListener listener))
		{
			throw new ArgumentException(global::SR.GetString("Only TraceListeners can be added to a TraceListenerCollection."), "value");
		}
		InitializeListener(listener);
		lock (TraceInternal.critSec)
		{
			list.Insert(index, value);
		}
	}

	void IList.Remove(object value)
	{
		lock (TraceInternal.critSec)
		{
			list.Remove(value);
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		lock (TraceInternal.critSec)
		{
			list.CopyTo(array, index);
		}
	}
}
