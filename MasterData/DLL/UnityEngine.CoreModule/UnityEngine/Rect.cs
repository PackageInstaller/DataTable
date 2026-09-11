using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Math/Rect.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeClass("Rectf", "template<typename T> class RectT; typedef RectT<float> Rectf;")]
public struct Rect : IEquatable<Rect>, IFormattable
{
	[NativeName("x")]
	private float m_XMin;

	[NativeName("y")]
	private float m_YMin;

	[NativeName("width")]
	private float m_Width;

	[NativeName("height")]
	private float m_Height;

	public static Rect zero => new Rect(0f, 0f, 0f, 0f);

	public float x
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

	public float y
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

	public Vector2 position
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Vector2(m_XMin, m_YMin);
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_XMin = value.x;
			m_YMin = value.y;
		}
	}

	public Vector2 center
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Vector2(x + m_Width / 2f, y + m_Height / 2f);
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_XMin = value.x - m_Width / 2f;
			m_YMin = value.y - m_Height / 2f;
		}
	}

	public Vector2 min
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Vector2(xMin, yMin);
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			xMin = value.x;
			yMin = value.y;
		}
	}

	public Vector2 max
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Vector2(xMax, yMax);
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			xMax = value.x;
			yMax = value.y;
		}
	}

	public float width
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

	public float height
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

	public Vector2 size
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Vector2(m_Width, m_Height);
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Width = value.x;
			m_Height = value.y;
		}
	}

	public float xMin
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_XMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			float num = xMax;
			m_XMin = value;
			m_Width = num - m_XMin;
		}
	}

	public float yMin
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_YMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			float num = yMax;
			m_YMin = value;
			m_Height = num - m_YMin;
		}
	}

	public float xMax
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Width + m_XMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Width = value - m_XMin;
		}
	}

	public float yMax
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Height + m_YMin;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Height = value - m_YMin;
		}
	}

	[Obsolete("use xMin")]
	public float left => m_XMin;

	[Obsolete("use xMax")]
	public float right => m_XMin + m_Width;

	[Obsolete("use yMin")]
	public float top => m_YMin;

	[Obsolete("use yMax")]
	public float bottom => m_YMin + m_Height;

	[MethodImpl((MethodImplOptions)256)]
	public Rect(float x, float y, float width, float height)
	{
		m_XMin = x;
		m_YMin = y;
		m_Width = width;
		m_Height = height;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Rect(Vector2 position, Vector2 size)
	{
		m_XMin = position.x;
		m_YMin = position.y;
		m_Width = size.x;
		m_Height = size.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Rect(Rect source)
	{
		m_XMin = source.m_XMin;
		m_YMin = source.m_YMin;
		m_Width = source.m_Width;
		m_Height = source.m_Height;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Rect MinMaxRect(float xmin, float ymin, float xmax, float ymax)
	{
		return new Rect(xmin, ymin, xmax - xmin, ymax - ymin);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(float x, float y, float width, float height)
	{
		m_XMin = x;
		m_YMin = y;
		m_Width = width;
		m_Height = height;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Contains(Vector2 point)
	{
		return point.x >= xMin && point.x < xMax && point.y >= yMin && point.y < yMax;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Contains(Vector3 point)
	{
		return point.x >= xMin && point.x < xMax && point.y >= yMin && point.y < yMax;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Contains(Vector3 point, bool allowInverse)
	{
		if (!allowInverse)
		{
			return Contains(point);
		}
		bool flag = (width < 0f && point.x <= xMin && point.x > xMax) || (width >= 0f && point.x >= xMin && point.x < xMax);
		bool flag2 = (height < 0f && point.y <= yMin && point.y > yMax) || (height >= 0f && point.y >= yMin && point.y < yMax);
		return flag & flag2;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static Rect OrderMinMax(Rect rect)
	{
		if (rect.xMin > rect.xMax)
		{
			float num = rect.xMin;
			rect.xMin = rect.xMax;
			rect.xMax = num;
		}
		if (rect.yMin > rect.yMax)
		{
			float num2 = rect.yMin;
			rect.yMin = rect.yMax;
			rect.yMax = num2;
		}
		return rect;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Overlaps(Rect other)
	{
		return other.xMax > xMin && other.xMin < xMax && other.yMax > yMin && other.yMin < yMax;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Overlaps(Rect other, bool allowInverse)
	{
		Rect rect = this;
		if (allowInverse)
		{
			rect = OrderMinMax(rect);
			other = OrderMinMax(other);
		}
		return rect.Overlaps(other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 NormalizedToPoint(Rect rectangle, Vector2 normalizedRectCoordinates)
	{
		return new Vector2(Mathf.Lerp(rectangle.x, rectangle.xMax, normalizedRectCoordinates.x), Mathf.Lerp(rectangle.y, rectangle.yMax, normalizedRectCoordinates.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 PointToNormalized(Rect rectangle, Vector2 point)
	{
		return new Vector2(Mathf.InverseLerp(rectangle.x, rectangle.xMax, point.x), Mathf.InverseLerp(rectangle.y, rectangle.yMax, point.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Rect lhs, Rect rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Rect lhs, Rect rhs)
	{
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.width == rhs.width && lhs.height == rhs.height;
	}

	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (width.GetHashCode() << 2) ^ (y.GetHashCode() >> 2) ^ (height.GetHashCode() >> 1);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Rect))
		{
			return false;
		}
		return Equals((Rect)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Rect other)
	{
		return x.Equals(other.x) && y.Equals(other.y) && width.Equals(other.width) && height.Equals(other.height);
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
		return UnityString.Format("(x:{0}, y:{1}, width:{2}, height:{3})", x.ToString(format, formatProvider), y.ToString(format, formatProvider), width.ToString(format, formatProvider), height.ToString(format, formatProvider));
	}
}
