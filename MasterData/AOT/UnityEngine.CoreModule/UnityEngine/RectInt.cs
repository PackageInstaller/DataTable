using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct RectInt : IEquatable<RectInt>, IFormattable
{
	private int m_XMin;

	private int m_YMin;

	private int m_Width;

	private int m_Height;

	public int x
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_XMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_XMin = value;
		}
	}

	public int y
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_YMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_YMin = value;
		}
	}

	public int width
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Width;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Width = value;
		}
	}

	public int height
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Height;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Height = value;
		}
	}

	public int xMin
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Math.Min(m_XMin, m_XMin + m_Width);
		}
	}

	public int yMin
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Math.Min(m_YMin, m_YMin + m_Height);
		}
	}

	public int xMax
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Math.Max(m_XMin, m_XMin + m_Width);
		}
	}

	public int yMax
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Math.Max(m_YMin, m_YMin + m_Height);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public RectInt(int xMin, int yMin, int width, int height)
	{
		m_XMin = xMin;
		m_YMin = yMin;
		m_Width = width;
		m_Height = height;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Overlaps(RectInt other)
	{
		return other.xMin < xMax && other.xMax > xMin && other.yMin < yMax && other.yMax > yMin;
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
		return UnityString.Format("(x:{0}, y:{1}, width:{2}, height:{3})", x.ToString(format, formatProvider), y.ToString(format, formatProvider), width.ToString(format, formatProvider), height.ToString(format, formatProvider));
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(RectInt other)
	{
		return m_XMin == other.m_XMin && m_YMin == other.m_YMin && m_Width == other.m_Width && m_Height == other.m_Height;
	}
}
