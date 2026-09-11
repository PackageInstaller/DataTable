namespace System.Runtime.Serialization;

[Serializable]
internal class FixupHolder
{
	internal long m_id;

	internal object m_fixupInfo;

	internal int m_fixupType;

	internal FixupHolder(long id, object fixupInfo, int fixupType)
	{
		m_id = id;
		m_fixupInfo = fixupInfo;
		m_fixupType = fixupType;
	}
}
