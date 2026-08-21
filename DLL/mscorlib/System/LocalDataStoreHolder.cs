namespace System;

internal sealed class LocalDataStoreHolder
{
	private LocalDataStore m_Store;

	public LocalDataStore Store => m_Store;

	public LocalDataStoreHolder(LocalDataStore store)
	{
		m_Store = store;
	}

	~LocalDataStoreHolder()
	{
		m_Store?.Dispose();
	}
}
