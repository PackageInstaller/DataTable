using System;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace UnityEngine;

public struct Ray2D : IFormattable
{
	private Vector2 m_Origin;

	private Vector2 m_Direction;

	public Vector2 origin
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

	public Vector2 direction
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

	[MethodImpl((MethodImplOptions)256)]
	public override string ToString()
	{
		return ToString(null, null);
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
