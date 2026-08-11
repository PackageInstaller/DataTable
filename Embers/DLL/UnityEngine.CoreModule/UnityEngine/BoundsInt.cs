using System;
using System.Globalization;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct BoundsInt : IEquatable<BoundsInt>, IFormattable
{
	private Vector3Int m_Position;

	private Vector3Int m_Size;

	public Vector3Int position => m_Position;

	public Vector3Int size => m_Size;

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("Position: {0}, Size: {1}", new object[2]
		{
			m_Position.ToString(format, formatProvider),
			m_Size.ToString(format, formatProvider)
		});
	}

	public override bool Equals(object other)
	{
		if (!(other is BoundsInt))
		{
			return false;
		}
		return Equals((BoundsInt)other);
	}

	public bool Equals(BoundsInt other)
	{
		return m_Position.Equals(other.m_Position) && m_Size.Equals(other.m_Size);
	}

	public override int GetHashCode()
	{
		return m_Position.GetHashCode() ^ (m_Size.GetHashCode() << 2);
	}
}
