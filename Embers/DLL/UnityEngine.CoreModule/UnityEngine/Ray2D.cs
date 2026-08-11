using System;
using System.Globalization;

namespace UnityEngine;

public struct Ray2D(Vector2 origin, Vector2 direction) : IFormattable
{
	private Vector2 m_Origin = origin;

	private Vector2 m_Direction = direction.normalized;

	public Vector2 origin
	{
		get
		{
			return m_Origin;
		}
		set
		{
			m_Origin = value;
		}
	}

	public Vector2 direction
	{
		get
		{
			return m_Direction;
		}
		set
		{
			m_Direction = value.normalized;
		}
	}

	public Vector2 GetPoint(float distance)
	{
		return m_Origin + m_Direction * distance;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (string.IsNullOrEmpty(format))
		{
			format = "F2";
		}
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("Origin: {0}, Dir: {1}", new object[2]
		{
			m_Origin.ToString(format, formatProvider),
			m_Direction.ToString(format, formatProvider)
		});
	}
}
