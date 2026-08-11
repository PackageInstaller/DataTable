using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System;

internal sealed class LocalDataStoreMgr
{
	private bool[] m_SlotInfoTable = new bool[64];

	private int m_FirstAvailableSlot;

	private List<LocalDataStore> m_ManagedLocalDataStores = new List<LocalDataStore>();

	private Dictionary<string, LocalDataStoreSlot> m_KeyToSlotMap = new Dictionary<string, LocalDataStoreSlot>();

	private long m_CookieGenerator;

	public LocalDataStoreHolder CreateLocalDataStore()
	{
		LocalDataStore localDataStore = new LocalDataStore(this, m_SlotInfoTable.Length);
		LocalDataStoreHolder result = new LocalDataStoreHolder(localDataStore);
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			m_ManagedLocalDataStores.Add(localDataStore);
			return result;
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public void DeleteLocalDataStore(LocalDataStore store)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			m_ManagedLocalDataStores.Remove(store);
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public LocalDataStoreSlot AllocateDataSlot()
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			int num = m_SlotInfoTable.Length;
			int i;
			for (i = m_FirstAvailableSlot; i < num && m_SlotInfoTable[i]; i++)
			{
			}
			if (i >= num)
			{
				int num2 = ((num >= 512) ? (num + 128) : (num * 2));
				bool[] array = new bool[num2];
				Array.Copy(m_SlotInfoTable, array, num);
				m_SlotInfoTable = array;
			}
			m_SlotInfoTable[i] = true;
			LocalDataStoreSlot result = new LocalDataStoreSlot(this, i, checked(m_CookieGenerator++));
			m_FirstAvailableSlot = i + 1;
			return result;
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public LocalDataStoreSlot AllocateNamedDataSlot(string name)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			LocalDataStoreSlot localDataStoreSlot = AllocateDataSlot();
			m_KeyToSlotMap.Add(name, localDataStoreSlot);
			return localDataStoreSlot;
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public LocalDataStoreSlot GetNamedDataSlot(string name)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			LocalDataStoreSlot valueOrDefault = m_KeyToSlotMap.GetValueOrDefault(name);
			if (valueOrDefault == null)
			{
				return AllocateNamedDataSlot(name);
			}
			return valueOrDefault;
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public void FreeNamedDataSlot(string name)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			m_KeyToSlotMap.Remove(name);
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	internal void FreeDataSlot(int slot, long cookie)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(this, ref lockTaken);
			for (int i = 0; i < m_ManagedLocalDataStores.Count; i++)
			{
				m_ManagedLocalDataStores[i].FreeData(slot, cookie);
			}
			m_SlotInfoTable[slot] = false;
			if (slot < m_FirstAvailableSlot)
			{
				m_FirstAvailableSlot = slot;
			}
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(this);
			}
		}
	}

	public void ValidateSlot(LocalDataStoreSlot slot)
	{
		if (slot == null || slot.Manager != this)
		{
			throw new ArgumentException(Environment.GetResourceString("Specified slot number was invalid."));
		}
	}

	internal int GetSlotTableLength()
	{
		return m_SlotInfoTable.Length;
	}
}
