namespace GameFramework;

public struct GameFrameworkSegment<T> where T : class
{
	private readonly T m_Source;

	private readonly int m_Offset;

	private readonly int m_Length;

	public T Source => m_Source;

	public int Offset => m_Offset;

	public int Length => m_Length;

	public GameFrameworkSegment(T source, int offset, int length)
	{
		if (source == null)
		{
			throw new GameFrameworkException("Source is invalid.");
		}
		if (offset < 0)
		{
			throw new GameFrameworkException("Offset is invalid.");
		}
		if (length <= 0)
		{
			throw new GameFrameworkException("Length is invalid.");
		}
		m_Source = source;
		m_Offset = offset;
		m_Length = length;
	}

	public override int GetHashCode()
	{
		return m_Source.GetHashCode() ^ m_Offset ^ m_Length;
	}

	public override bool Equals(object obj)
	{
		return obj is GameFrameworkSegment<T> && Equals((GameFrameworkSegment<T>)obj);
	}

	public bool Equals(GameFrameworkSegment<T> obj)
	{
		return obj.m_Source == m_Source && obj.m_Offset == m_Offset && obj.m_Length == m_Length;
	}

	public static bool operator ==(GameFrameworkSegment<T> a, GameFrameworkSegment<T> b)
	{
		return a.Equals(b);
	}

	public static bool operator !=(GameFrameworkSegment<T> a, GameFrameworkSegment<T> b)
	{
		return !(a == b);
	}
}
