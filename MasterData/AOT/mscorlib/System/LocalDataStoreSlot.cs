using System.Runtime.InteropServices;
using Unity;

namespace System;

[ComVisible(true)]
public sealed class LocalDataStoreSlot
{
	private LocalDataStoreMgr m_mgr;

	private int m_slot;

	private long m_cookie;

	internal LocalDataStoreMgr Manager => m_mgr;

	internal int Slot => m_slot;

	internal long Cookie => m_cookie;

	internal LocalDataStoreSlot(LocalDataStoreMgr mgr, int slot, long cookie)
	{
		m_mgr = mgr;
		m_slot = slot;
		m_cookie = cookie;
	}

	~LocalDataStoreSlot()
	{
		LocalDataStoreMgr mgr = m_mgr;
		if (mgr != null)
		{
			int slot = m_slot;
			m_slot = -1;
			mgr.FreeDataSlot(slot, m_cookie);
		}
	}

	internal LocalDataStoreSlot()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
