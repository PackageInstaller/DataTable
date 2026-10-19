namespace UnityEngine.Localization.Tables;

public class SequentialIDGenerator : IKeyGenerator
{
	[SerializeField]
	private long m_NextAvailableId = 1L;

	public long NextAvailableId => m_NextAvailableId;

	public SequentialIDGenerator()
	{
	}

	public SequentialIDGenerator(long startingId)
	{
		m_NextAvailableId = startingId;
	}

	public long GetNextKey()
	{
		return m_NextAvailableId++;
	}
}
