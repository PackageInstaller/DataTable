namespace System.Net.Cache;

public class RequestCachePolicy
{
	private RequestCacheLevel m_Level;

	public RequestCacheLevel Level => m_Level;

	public RequestCachePolicy()
		: this(RequestCacheLevel.Default)
	{
	}

	public RequestCachePolicy(RequestCacheLevel level)
	{
		if (level < RequestCacheLevel.Default || level > RequestCacheLevel.NoCacheNoStore)
		{
			throw new ArgumentOutOfRangeException("level");
		}
		m_Level = level;
	}

	public override string ToString()
	{
		return "Level:" + m_Level;
	}
}
