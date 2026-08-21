using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[Il2CppEagerStaticClassConstruction]
public struct Vector3Int : IEquatable<Vector3Int>, IFormattable
{
	private int m_X;

	private int m_Y;

	private int m_Z;

	private static readonly Vector3Int s_Zero = new Vector3Int(0, 0, 0);

	private static readonly Vector3Int s_One = new Vector3Int(1, 1, 1);

	private static readonly Vector3Int s_Up = new Vector3Int(0, 1, 0);

	private static readonly Vector3Int s_Down = new Vector3Int(0, -1, 0);

	private static readonly Vector3Int s_Left = new Vector3Int(-1, 0, 0);

	private static readonly Vector3Int s_Right = new Vector3Int(1, 0, 0);

	private static readonly Vector3Int s_Forward = new Vector3Int(0, 0, 1);

	private static readonly Vector3Int s_Back = new Vector3Int(0, 0, -1);

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

	public int z
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return m_Z;
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			m_Z = value;
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
				2 => z, 
				_ => throw new IndexOutOfRangeException(UnityString.Format("Invalid Vector3Int index addressed: {0}!", index)), 
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
			case 2:
				z = value;
				break;
			default:
				throw new IndexOutOfRangeException(UnityString.Format("Invalid Vector3Int index addressed: {0}!", index));
			}
		}
	}

	public float magnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Mathf.Sqrt(x * x + y * y + z * z);
		}
	}

	public int sqrMagnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return x * x + y * y + z * z;
		}
	}

	public static Vector3Int zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Zero;
		}
	}

	public static Vector3Int one
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_One;
		}
	}

	public static Vector3Int up
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Up;
		}
	}

	public static Vector3Int down
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Down;
		}
	}

	public static Vector3Int left
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Left;
		}
	}

	public static Vector3Int right
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Right;
		}
	}

	public static Vector3Int forward
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Forward;
		}
	}

	public static Vector3Int back
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Back;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector3Int(int x, int y)
	{
		m_X = x;
		m_Y = y;
		m_Z = 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector3Int(int x, int y, int z)
	{
		m_X = x;
		m_Y = y;
		m_Z = z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(int x, int y, int z)
	{
		m_X = x;
		m_Y = y;
		m_Z = z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Distance(Vector3Int a, Vector3Int b)
	{
		return (a - b).magnitude;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int Min(Vector3Int lhs, Vector3Int rhs)
	{
		return new Vector3Int(Mathf.Min(lhs.x, rhs.x), Mathf.Min(lhs.y, rhs.y), Mathf.Min(lhs.z, rhs.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int Max(Vector3Int lhs, Vector3Int rhs)
	{
		return new Vector3Int(Mathf.Max(lhs.x, rhs.x), Mathf.Max(lhs.y, rhs.y), Mathf.Max(lhs.z, rhs.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int Scale(Vector3Int a, Vector3Int b)
	{
		return new Vector3Int(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Scale(Vector3Int scale)
	{
		x *= scale.x;
		y *= scale.y;
		z *= scale.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Clamp(Vector3Int min, Vector3Int max)
	{
		x = Math.Max(min.x, x);
		x = Math.Min(max.x, x);
		y = Math.Max(min.y, y);
		y = Math.Min(max.y, y);
		z = Math.Max(min.z, z);
		z = Math.Min(max.z, z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector3(Vector3Int v)
	{
		return new Vector3(v.x, v.y, v.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static explicit operator Vector2Int(Vector3Int v)
	{
		return new Vector2Int(v.x, v.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int FloorToInt(Vector3 v)
	{
		return new Vector3Int(Mathf.FloorToInt(v.x), Mathf.FloorToInt(v.y), Mathf.FloorToInt(v.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int CeilToInt(Vector3 v)
	{
		return new Vector3Int(Mathf.CeilToInt(v.x), Mathf.CeilToInt(v.y), Mathf.CeilToInt(v.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int RoundToInt(Vector3 v)
	{
		return new Vector3Int(Mathf.RoundToInt(v.x), Mathf.RoundToInt(v.y), Mathf.RoundToInt(v.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator +(Vector3Int a, Vector3Int b)
	{
		return new Vector3Int(a.x + b.x, a.y + b.y, a.z + b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator -(Vector3Int a, Vector3Int b)
	{
		return new Vector3Int(a.x - b.x, a.y - b.y, a.z - b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator *(Vector3Int a, Vector3Int b)
	{
		return new Vector3Int(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator -(Vector3Int a)
	{
		return new Vector3Int(-a.x, -a.y, -a.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator *(Vector3Int a, int b)
	{
		return new Vector3Int(a.x * b, a.y * b, a.z * b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator *(int a, Vector3Int b)
	{
		return new Vector3Int(a * b.x, a * b.y, a * b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3Int operator /(Vector3Int a, int b)
	{
		return new Vector3Int(a.x / b, a.y / b, a.z / b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector3Int lhs, Vector3Int rhs)
	{
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector3Int lhs, Vector3Int rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Vector3Int))
		{
			return false;
		}
		return Equals((Vector3Int)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Vector3Int other)
	{
		return this == other;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		int hashCode = y.GetHashCode();
		int hashCode2 = z.GetHashCode();
		return x.GetHashCode() ^ (hashCode << 4) ^ (hashCode >> 28) ^ (hashCode2 >> 4) ^ (hashCode2 << 28);
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
		return UnityString.Format("({0}, {1}, {2})", x.ToString(format, formatProvider), y.ToString(format, formatProvider), z.ToString(format, formatProvider));
	}
}
