using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct BoundsInt : IEquatable<BoundsInt>, IFormattable
{
	private Vector3Int m_Position;

	private Vector3Int m_Size;

	public Vector3Int position
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Position;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Position = value;
		}
	}

	public Vector3Int size
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Size;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Size = value;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public BoundsInt(Vector3Int position, Vector3Int size)
	{
		m_Position = position;
		m_Size = size;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override string ToString()
	{
		return ToString(null, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("Position: {0}, Size: {1}", m_Position.ToString(format, formatProvider), m_Size.ToString(format, formatProvider));
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is BoundsInt))
		{
			return false;
		}
		return Equals((BoundsInt)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(BoundsInt other)
	{
		return m_Position.Equals(other.m_Position) && m_Size.Equals(other.m_Size);
	}

	public override int GetHashCode()
	{
		return m_Position.GetHashCode() ^ (m_Size.GetHashCode() << 2);
	}
}
