using System;
using System.Globalization;

namespace UnityEngine;

public struct Ray(Vector3 origin, Vector3 direction) : IFormattable
{
	private Vector3 m_Origin = origin;

	private Vector3 m_Direction = direction.normalized;

	public Vector3 origin
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

	public Vector3 direction
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

	public Vector3 GetPoint(float distance)
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
