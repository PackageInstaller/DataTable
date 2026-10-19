using System;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[Il2CppEagerStaticClassConstruction]
[UsedByNativeCode]
[DefaultMember("Item")]
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

	public static Vector3Int zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return s_Zero;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector3Int(int x, int y, int z)
	{
		m_X = x;
		m_Y = y;
		m_Z = z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector3Int lhs, Vector3Int rhs)
	{
		return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z;
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
	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("({0}, {1}, {2})", x.ToString(format, formatProvider), y.ToString(format, formatProvider), z.ToString(format, formatProvider));
	}
}
