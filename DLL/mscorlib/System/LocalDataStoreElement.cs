namespace System;

internal sealed class LocalDataStoreElement
{
	private object m_value;

	private long m_cookie;

	public object Value
	{
		get
		{
			return m_value;
		}
		set
		{
			m_value = value;
		}
	}

	public long Cookie => m_cookie;

	public LocalDataStoreElement(long cookie)
	{
		m_cookie = cookie;
	}
}
