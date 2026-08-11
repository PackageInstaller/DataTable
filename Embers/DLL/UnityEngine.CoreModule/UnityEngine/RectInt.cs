using System;
using System.Globalization;
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
		get
		{
			return m_XMin;
		}
		set
		{
			m_XMin = value;
		}
	}

	public int y
	{
		get
		{
			return m_YMin;
		}
		set
		{
			m_YMin = value;
		}
	}

	public int width
	{
		get
		{
			return m_Width;
		}
		set
		{
			m_Width = value;
		}
	}

	public int height
	{
		get
		{
			return m_Height;
		}
		set
		{
			m_Height = value;
		}
	}

	public int xMin => Math.Min(m_XMin, m_XMin + m_Width);

	public int yMin => Math.Min(m_YMin, m_YMin + m_Height);

	public int xMax => Math.Max(m_XMin, m_XMin + m_Width);

	public int yMax => Math.Max(m_YMin, m_YMin + m_Height);

	public RectInt(int xMin, int yMin, int width, int height)
	{
		m_XMin = xMin;
		m_YMin = yMin;
		m_Width = width;
		m_Height = height;
	}

	public bool Overlaps(RectInt other)
	{
		return other.xMin < xMax && other.xMax > xMin && other.yMin < yMax && other.yMax > yMin;
	}

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
		return UnityString.Format("(x:{0}, y:{1}, width:{2}, height:{3})", new object[4]
		{
			x.ToString(format, formatProvider),
			y.ToString(format, formatProvider),
			width.ToString(format, formatProvider),
			height.ToString(format, formatProvider)
		});
	}

	public bool Equals(RectInt other)
	{
		return m_XMin == other.m_XMin && m_YMin == other.m_YMin && m_Width == other.m_Width && m_Height == other.m_Height;
	}
}
