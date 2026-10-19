namespace System.Runtime.Serialization;

internal class ObjectHolderList
{
	internal ObjectHolder[] m_values;

	internal int m_count;

	internal int Version => m_count;

	internal int Count => m_count;

	internal ObjectHolderList()
		: this(8)
	{
	}

	internal ObjectHolderList(int startingSize)
	{
		m_count = 0;
		m_values = new ObjectHolder[startingSize];
	}

	internal virtual void Add(ObjectHolder value)
	{
		if (m_count == m_values.Length)
		{
			EnlargeArray();
		}
		m_values[m_count++] = value;
	}

	internal ObjectHolderListEnumerator GetFixupEnumerator()
	{
		return new ObjectHolderListEnumerator(this, isFixupEnumerator: true);
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
		ObjectHolder[] array = new ObjectHolder[num];
		Array.Copy(m_values, array, m_count);
		m_values = array;
	}
}
