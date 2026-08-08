namespace System.Runtime.Serialization;

[Serializable]
internal class FixupHolderList
{
	internal FixupHolder[] m_values;

	internal int m_count;

	internal FixupHolderList()
		: this(2)
	{
	}

	internal FixupHolderList(int startingSize)
	{
		m_count = 0;
		m_values = new FixupHolder[startingSize];
	}

	internal virtual void Add(FixupHolder fixup)
	{
		if (m_count == m_values.Length)
		{
			EnlargeArray();
		}
		m_values[m_count++] = fixup;
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
		FixupHolder[] array = new FixupHolder[num];
		Array.Copy(m_values, array, m_count);
		m_values = array;
	}
}
