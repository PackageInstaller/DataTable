namespace System.Runtime.Serialization;

[Serializable]
internal class LongList
{
	private long[] m_values;

	private int m_count;

	private int m_totalItems;

	private int m_currentItem;

	internal int Count => m_count;

	internal long Current => m_values[m_currentItem];

	internal LongList()
		: this(2)
	{
	}

	internal LongList(int startingSize)
	{
		m_count = 0;
		m_totalItems = 0;
		m_values = new long[startingSize];
	}

	internal void Add(long value)
	{
		if (m_totalItems == m_values.Length)
		{
			EnlargeArray();
		}
		m_values[m_totalItems++] = value;
		m_count++;
	}

	internal void StartEnumeration()
	{
		m_currentItem = -1;
	}

	internal bool MoveNext()
	{
		while (++m_currentItem < m_totalItems && m_values[m_currentItem] == -1)
		{
		}
		if (m_currentItem == m_totalItems)
		{
			return false;
		}
		return true;
	}

	internal bool RemoveElement(long value)
	{
		int i;
		for (i = 0; i < m_totalItems && m_values[i] != value; i++)
		{
		}
		if (i == m_totalItems)
		{
			return false;
		}
		m_values[i] = -1L;
		return true;
	}

	private void EnlargeArray()
	{
		int num = m_values.Length * 2;
		if (num < 0)
		{
			if (num == int.MaxValue)
			{
				throw new SerializationException(Environment.GetResourceString("The internal array cannot expand to greater than Int32.MaxValue elements."));
			}
			num = int.MaxValue;
		}
		long[] array = new long[num];
		Array.Copy(m_values, array, m_count);
		m_values = array;
	}
}
