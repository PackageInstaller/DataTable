using System.Collections.Generic;
using System.Diagnostics;

namespace System.Threading;

[DebuggerTypeProxy(typeof(SystemThreading_ThreadLocalDebugView<>))]
[DebuggerDisplay("IsValueCreated={IsValueCreated}, Value={ValueForDebugDisplay}, Count={ValuesCountForDebugDisplay}")]
public class ThreadLocal<T> : IDisposable
{
	private struct LinkedSlotVolatile
	{
		internal volatile LinkedSlot Value;
	}

	private sealed class LinkedSlot
	{
		internal volatile LinkedSlot Next;

		internal volatile LinkedSlot Previous;

		internal volatile LinkedSlotVolatile[] SlotArray;

		internal T Value;

		internal LinkedSlot(LinkedSlotVolatile[] slotArray)
		{
			SlotArray = slotArray;
		}
	}

	private class IdManager
	{
		private int m_nextIdToTry;

		private List<bool> m_freeIds = new List<bool>();

		internal int GetId()
		{
			lock (m_freeIds)
			{
				int i;
				for (i = m_nextIdToTry; i < m_freeIds.Count && !m_freeIds[i]; i++)
				{
				}
				if (i == m_freeIds.Count)
				{
					m_freeIds.Add(item: false);
				}
				else
				{
					m_freeIds[i] = false;
				}
				m_nextIdToTry = i + 1;
				return i;
			}
		}

		internal void ReturnId(int id)
		{
			lock (m_freeIds)
			{
				m_freeIds[id] = true;
				if (id < m_nextIdToTry)
				{
					m_nextIdToTry = id;
				}
			}
		}
	}

	private class FinalizationHelper
	{
		internal LinkedSlotVolatile[] SlotArray;

		private bool m_trackAllValues;

		internal FinalizationHelper(LinkedSlotVolatile[] slotArray, bool trackAllValues)
		{
			SlotArray = slotArray;
			m_trackAllValues = trackAllValues;
		}

		~FinalizationHelper()
		{
			LinkedSlotVolatile[] slotArray = SlotArray;
			int i = 0;
			for (; i < slotArray.Length; i++)
			{
				LinkedSlot value = slotArray[i].Value;
				if (value == null)
				{
					continue;
				}
				if (m_trackAllValues)
				{
					value.SlotArray = null;
					continue;
				}
				lock (ThreadLocal<T>.s_idManager)
				{
					if (value.Next != null)
					{
						value.Next.Previous = value.Previous;
					}
					value.Previous.Next = value.Next;
				}
			}
		}
	}

	private Func<T> m_valueFactory;

	[ThreadStatic]
	private static LinkedSlotVolatile[] ts_slotArray;

	[ThreadStatic]
	private static FinalizationHelper ts_finalizationHelper;

	private int m_idComplement;

	private volatile bool m_initialized;

	private static IdManager s_idManager = new IdManager();

	private LinkedSlot m_linkedSlot = new LinkedSlot(null);

	private bool m_trackAllValues;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	public T Value
	{
		get
		{
			LinkedSlotVolatile[] array = ts_slotArray;
			int num = ~m_idComplement;
			LinkedSlot value;
			if (array != null && num >= 0 && num < array.Length && (value = array[num].Value) != null && m_initialized)
			{
				return value.Value;
			}
			return GetValueSlow();
		}
		set
		{
			LinkedSlotVolatile[] array = ts_slotArray;
			int num = ~m_idComplement;
			LinkedSlot value2;
			if (array != null && num >= 0 && num < array.Length && (value2 = array[num].Value) != null && m_initialized)
			{
				value2.Value = value;
			}
			else
			{
				SetValueSlow(value, array);
			}
		}
	}

	public bool IsValueCreated
	{
		get
		{
			int num = ~m_idComplement;
			if (num < 0)
			{
				throw new ObjectDisposedException(Environment.GetResourceString("The ThreadLocal object has been disposed."));
			}
			LinkedSlotVolatile[] array = ts_slotArray;
			if (array != null && num < array.Length)
			{
				return array[num].Value != null;
			}
			return false;
		}
	}

	public ThreadLocal()
	{
		Initialize(null, trackAllValues: false);
	}

	private void Initialize(Func<T> valueFactory, bool trackAllValues)
	{
		m_valueFactory = valueFactory;
		m_trackAllValues = trackAllValues;
		try
		{
		}
		finally
		{
			m_idComplement = ~s_idManager.GetId();
			m_initialized = true;
		}
	}

	~ThreadLocal()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		int num;
		lock (s_idManager)
		{
			num = ~m_idComplement;
			m_idComplement = 0;
			if (num < 0 || !m_initialized)
			{
				return;
			}
			m_initialized = false;
			for (LinkedSlot next = m_linkedSlot.Next; next != null; next = next.Next)
			{
				LinkedSlotVolatile[] slotArray = next.SlotArray;
				if (slotArray != null)
				{
					next.SlotArray = null;
					slotArray[num].Value.Value = default(T);
					slotArray[num].Value = null;
				}
			}
		}
		m_linkedSlot = null;
		s_idManager.ReturnId(num);
	}

	public override string ToString()
	{
		return Value.ToString();
	}

	private T GetValueSlow()
	{
		if (~m_idComplement < 0)
		{
			throw new ObjectDisposedException(Environment.GetResourceString("The ThreadLocal object has been disposed."));
		}
		Debugger.NotifyOfCrossThreadDependency();
		T val;
		if (m_valueFactory == null)
		{
			val = default(T);
		}
		else
		{
			val = m_valueFactory();
			if (IsValueCreated)
			{
				throw new InvalidOperationException(Environment.GetResourceString("ValueFactory attempted to access the Value property of this instance."));
			}
		}
		Value = val;
		return val;
	}

	private void SetValueSlow(T value, LinkedSlotVolatile[] slotArray)
	{
		int num = ~m_idComplement;
		if (num < 0)
		{
			throw new ObjectDisposedException(Environment.GetResourceString("The ThreadLocal object has been disposed."));
		}
		if (slotArray == null)
		{
			slotArray = new LinkedSlotVolatile[GetNewTableSize(num + 1)];
			ts_finalizationHelper = new FinalizationHelper(slotArray, m_trackAllValues);
			ts_slotArray = slotArray;
		}
		if (num >= slotArray.Length)
		{
			GrowTable(ref slotArray, num + 1);
			ts_finalizationHelper.SlotArray = slotArray;
			ts_slotArray = slotArray;
		}
		if (slotArray[num].Value == null)
		{
			CreateLinkedSlot(slotArray, num, value);
			return;
		}
		LinkedSlot value2 = slotArray[num].Value;
		if (!m_initialized)
		{
			throw new ObjectDisposedException(Environment.GetResourceString("The ThreadLocal object has been disposed."));
		}
		value2.Value = value;
	}

	private void CreateLinkedSlot(LinkedSlotVolatile[] slotArray, int id, T value)
	{
		LinkedSlot linkedSlot = new LinkedSlot(slotArray);
		lock (s_idManager)
		{
			if (!m_initialized)
			{
				throw new ObjectDisposedException(Environment.GetResourceString("The ThreadLocal object has been disposed."));
			}
			LinkedSlot linkedSlot2 = (linkedSlot.Next = m_linkedSlot.Next);
			linkedSlot.Previous = m_linkedSlot;
			linkedSlot.Value = value;
			if (linkedSlot2 != null)
			{
				linkedSlot2.Previous = linkedSlot;
			}
			m_linkedSlot.Next = linkedSlot;
			slotArray[id].Value = linkedSlot;
		}
	}

	private void GrowTable(ref LinkedSlotVolatile[] table, int minLength)
	{
		LinkedSlotVolatile[] array = new LinkedSlotVolatile[GetNewTableSize(minLength)];
		lock (s_idManager)
		{
			for (int i = 0; i < table.Length; i++)
			{
				LinkedSlot value = table[i].Value;
				if (value != null && value.SlotArray != null)
				{
					value.SlotArray = array;
					array[i] = table[i];
				}
			}
		}
		table = array;
	}

	private static int GetNewTableSize(int minSize)
	{
		if ((uint)minSize > 2146435071u)
		{
			return int.MaxValue;
		}
		int num = minSize;
		num--;
		num |= num >> 1;
		num |= num >> 2;
		num |= num >> 4;
		num |= num >> 8;
		num |= num >> 16;
		num++;
		if ((uint)num > 2146435071u)
		{
			num = 2146435071;
		}
		return num;
	}
}
