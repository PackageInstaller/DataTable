namespace System.Runtime.Serialization;

internal class ObjectHolderListEnumerator
{
	private bool m_isFixupEnumerator;

	private ObjectHolderList m_list;

	private int m_startingVersion;

	private int m_currPos;

	internal ObjectHolder Current => m_list.m_values[m_currPos];

	internal ObjectHolderListEnumerator(ObjectHolderList list, bool isFixupEnumerator)
	{
		m_list = list;
		m_startingVersion = m_list.Version;
		m_currPos = -1;
		m_isFixupEnumerator = isFixupEnumerator;
	}

	internal bool MoveNext()
	{
		if (m_isFixupEnumerator)
		{
			while (++m_currPos < m_list.Count && m_list.m_values[m_currPos].CompletelyFixed)
			{
			}
			if (m_currPos == m_list.Count)
			{
				return false;
			}
			return true;
		}
		m_currPos++;
		if (m_currPos == m_list.Count)
		{
			return false;
		}
		return true;
	}
}
