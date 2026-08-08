namespace System.Globalization;

[Serializable]
public sealed class SortVersion : IEquatable<SortVersion>
{
	private int m_NlsVersion;

	private Guid m_SortId;

	public override bool Equals(object obj)
	{
		SortVersion sortVersion = obj as SortVersion;
		if (sortVersion != null)
		{
			return Equals(sortVersion);
		}
		return false;
	}

	public bool Equals(SortVersion other)
	{
		if (other == null)
		{
			return false;
		}
		if (m_NlsVersion == other.m_NlsVersion)
		{
			return m_SortId == other.m_SortId;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (m_NlsVersion * 7) | m_SortId.GetHashCode();
	}

	public static bool operator ==(SortVersion left, SortVersion right)
	{
		return left?.Equals(right) ?? right?.Equals(left) ?? true;
	}

	public static bool operator !=(SortVersion left, SortVersion right)
	{
		return !(left == right);
	}
}
