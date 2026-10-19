using System.Runtime.CompilerServices;
using System.Threading;

namespace System;

internal sealed class LocalDataStore
{
	private LocalDataStoreElement[] m_DataTable;

	private LocalDataStoreMgr m_Manager;

	public LocalDataStore(LocalDataStoreMgr mgr, int InitialCapacity)
	{
		m_Manager = mgr;
		m_DataTable = new LocalDataStoreElement[InitialCapacity];
	}

	internal void Dispose()
	{
		m_Manager.DeleteLocalDataStore(this);
	}

	public object GetData(LocalDataStoreSlot slot)
	{
		m_Manager.ValidateSlot(slot);
		int slot2 = slot.Slot;
		if (slot2 >= 0)
		{
			if (slot2 >= m_DataTable.Length)
			{
				return null;
			}
			LocalDataStoreElement localDataStoreElement = m_DataTable[slot2];
			if (localDataStoreElement == null)
			{
				return null;
			}
			if (localDataStoreElement.Cookie == slot.Cookie)
			{
				return localDataStoreElement.Value;
			}
		}
		throw new InvalidOperationException(Environment.GetResourceString("LocalDataStoreSlot storage has been freed."));
	}

	public void SetData(LocalDataStoreSlot slot, object data)
	{
		m_Manager.ValidateSlot(slot);
		int slot2 = slot.Slot;
		if (slot2 >= 0)
		{
			LocalDataStoreElement localDataStoreElement = ((slot2 < m_DataTable.Length) ? m_DataTable[slot2] : null);
			if (localDataStoreElement == null)
			{
				localDataStoreElement = PopulateElement(slot);
			}
			if (localDataStoreElement.Cookie == slot.Cookie)
			{
				localDataStoreElement.Value = data;
				return;
			}
		}
		throw new InvalidOperationException(Environment.GetResourceString("LocalDataStoreSlot storage has been freed."));
	}

	internal void FreeData(int slot, long cookie)
	{
		if (slot < m_DataTable.Length)
		{
			LocalDataStoreElement localDataStoreElement = m_DataTable[slot];
			if (localDataStoreElement != null && localDataStoreElement.Cookie == cookie)
			{
				m_DataTable[slot] = null;
			}
		}
	}

	private LocalDataStoreElement PopulateElement(LocalDataStoreSlot slot)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(m_Manager, ref lockTaken);
			int slot2 = slot.Slot;
			if (slot2 < 0)
			{
				throw new InvalidOperationException(Environment.GetResourceString("LocalDataStoreSlot storage has been freed."));
			}
			if (slot2 >= m_DataTable.Length)
			{
				LocalDataStoreElement[] array = new LocalDataStoreElement[m_Manager.GetSlotTableLength()];
				Array.Copy(m_DataTable, array, m_DataTable.Length);
				m_DataTable = array;
			}
			if (m_DataTable[slot2] == null)
			{
				m_DataTable[slot2] = new LocalDataStoreElement(slot.Cookie);
			}
			return m_DataTable[slot2];
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(m_Manager);
			}
		}
	}
}
