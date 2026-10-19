namespace Fundamental;

public class DisjointSet
{
	private int[] m_Parent;

	private int[] m_Size;

	public int Capacity { get; private set; }

	public DisjointSet(int capacity)
	{
		Capacity = capacity;
		m_Parent = new int[capacity];
		for (int i = 0; i < capacity; i++)
		{
			m_Parent[i] = i;
		}
		m_Size = new int[capacity];
		for (int j = 0; j < capacity; j++)
		{
			m_Size[j] = 1;
		}
	}

	public int GetRoot(int index)
	{
		while (m_Parent[index] != index)
		{
			index = m_Parent[index];
		}
		return index;
	}

	public bool Unite(int x, int y)
	{
		x = GetRoot(x);
		y = GetRoot(y);
		if (x == y)
		{
			return false;
		}
		if (m_Size[x] < m_Size[y])
		{
			int num = x;
			x = y;
			y = num;
		}
		m_Parent[y] = x;
		m_Size[x] += m_Size[y];
		return true;
	}

	public bool Connected(int x, int y)
	{
		return GetRoot(x) == GetRoot(y);
	}

	public int GetSize(int index)
	{
		return m_Size[index];
	}
}
