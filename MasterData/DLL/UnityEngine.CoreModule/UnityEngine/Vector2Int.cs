using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeType("Runtime/Math/Vector2Int.h")]
[UsedByNativeCode]
[Il2CppEagerStaticClassConstruction]
public struct Vector2Int : IEquatable<Vector2Int>, IFormattable
{
	private int m_X;

	private int m_Y;

	private static readonly Vector2Int s_Zero = new Vector2Int(0, 0);

	private static readonly Vector2Int s_One = new Vector2Int(1, 1);

	private static readonly Vector2Int s_Up = new Vector2Int(0, 1);

	private static readonly Vector2Int s_Down = new Vector2Int(0, -1);

	private static readonly Vector2Int s_Left = new Vector2Int(-1, 0);

	private static readonly Vector2Int s_Right = new Vector2Int(1, 0);

	public int x
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_X;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_X = value;
		}
	}

	public int y
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Y;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Y = value;
		}
	}

	public int this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return index switch
			{
				0 => x, 
				1 => y, 
				_ => throw new IndexOutOfRangeException($"Invalid Vector2Int index addressed: {index}!"), 
			};
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			switch (index)
			{
			case 0:
				x = value;
				break;
			case 1:
				y = value;
				break;
			default:
				throw new IndexOutOfRangeException($"Invalid Vector2Int index addressed: {index}!");
			}
		}
	}

	public float magnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Mathf.Sqrt(x * x + y * y);
		}
	}

	public int sqrMagnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return x * x + y * y;
		}
	}

	public static Vector2Int zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Zero;
		}
	}

	public static Vector2Int one
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_One;
		}
	}

	public static Vector2Int up
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Up;
		}
	}

	public static Vector2Int down
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Down;
		}
	}

	public static Vector2Int left
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Left;
		}
	}

	public static Vector2Int right
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Right;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector2Int(int x, int y)
	{
		m_X = x;
		m_Y = y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(int x, int y)
	{
		m_X = x;
		m_Y = y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Distance(Vector2Int a, Vector2Int b)
	{
		float num = a.x - b.x;
		float num2 = a.y - b.y;
		return (float)Math.Sqrt(num * num + num2 * num2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int Min(Vector2Int lhs, Vector2Int rhs)
	{
		return new Vector2Int(Mathf.Min(lhs.x, rhs.x), Mathf.Min(lhs.y, rhs.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int Max(Vector2Int lhs, Vector2Int rhs)
	{
		return new Vector2Int(Mathf.Max(lhs.x, rhs.x), Mathf.Max(lhs.y, rhs.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int Scale(Vector2Int a, Vector2Int b)
	{
		return new Vector2Int(a.x * b.x, a.y * b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Scale(Vector2Int scale)
	{
		x *= scale.x;
		y *= scale.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Clamp(Vector2Int min, Vector2Int max)
	{
		x = Math.Max(min.x, x);
		x = Math.Min(max.x, x);
		y = Math.Max(min.y, y);
		y = Math.Min(max.y, y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector2(Vector2Int v)
	{
		return new Vector2(v.x, v.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static explicit operator Vector3Int(Vector2Int v)
	{
		return new Vector3Int(v.x, v.y, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int FloorToInt(Vector2 v)
	{
		return new Vector2Int(Mathf.FloorToInt(v.x), Mathf.FloorToInt(v.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int CeilToInt(Vector2 v)
	{
		return new Vector2Int(Mathf.CeilToInt(v.x), Mathf.CeilToInt(v.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int RoundToInt(Vector2 v)
	{
		return new Vector2Int(Mathf.RoundToInt(v.x), Mathf.RoundToInt(v.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator -(Vector2Int v)
	{
		return new Vector2Int(-v.x, -v.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator +(Vector2Int a, Vector2Int b)
	{
		return new Vector2Int(a.x + b.x, a.y + b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator -(Vector2Int a, Vector2Int b)
	{
		return new Vector2Int(a.x - b.x, a.y - b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator *(Vector2Int a, Vector2Int b)
	{
		return new Vector2Int(a.x * b.x, a.y * b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator *(int a, Vector2Int b)
	{
		return new Vector2Int(a * b.x, a * b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator *(Vector2Int a, int b)
	{
		return new Vector2Int(a.x * b, a.y * b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2Int operator /(Vector2Int a, int b)
	{
		return new Vector2Int(a.x / b, a.y / b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector2Int lhs, Vector2Int rhs)
	{
		return lhs.x == rhs.x && lhs.y == rhs.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector2Int lhs, Vector2Int rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Vector2Int))
		{
			return false;
		}
		return Equals((Vector2Int)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Vector2Int other)
	{
		return x == other.x && y == other.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (y.GetHashCode() << 2);
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
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("({0}, {1})", x.ToString(format, formatProvider), y.ToString(format, formatProvider));
	}
}
