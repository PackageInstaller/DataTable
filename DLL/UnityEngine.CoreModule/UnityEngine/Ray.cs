using System;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace UnityEngine;

public struct Ray(Vector3 origin, Vector3 direction) : IFormattable
{
	private Vector3 m_Origin = origin;

	private Vector3 m_Direction = direction.normalized;

	public Vector3 origin
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Origin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Origin = value;
		}
	}

	public Vector3 direction
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Direction;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Direction = value.normalized;
		}
	}

	public Vector3 GetPoint(float distance)
	{
		return m_Origin + m_Direction * distance;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override string ToString()
	{
		return ToString(null, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ToString(string format)
	{
		return ToString(format, null);
	}

	[MethodImpl((MethodImplOptions)256)]
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
		return UnityString.Format("Origin: {0}, Dir: {1}", m_Origin.ToString(format, formatProvider), m_Direction.ToString(format, formatProvider));
	}
}
