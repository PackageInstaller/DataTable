using System;
using System.Runtime.CompilerServices;

namespace UnityEngine.InputSystem.Utilities;

public struct FourCC : IEquatable<FourCC>
{
	private int m_Code;

	public FourCC(int code)
	{
		m_Code = code;
	}

	public FourCC(char a, char b = ' ', char c = ' ', char d = ' ')
	{
		m_Code = (int)(((uint)a << 24) | ((uint)b << 16) | ((uint)c << 8) | d);
	}

	public FourCC(string str)
	{
		this = default(FourCC);
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		int length = str.Length;
		if (length < 1 || length > 4)
		{
			throw new ArgumentException("FourCC string must be one to four characters long!", "str");
		}
		char c = str[0];
		char c2 = ((length > 1) ? str[1] : ' ');
		char c3 = ((length > 2) ? str[2] : ' ');
		char c4 = ((length > 3) ? str[3] : ' ');
		m_Code = (int)(((uint)c << 24) | ((uint)c2 << 16) | ((uint)c3 << 8) | c4);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator int(FourCC fourCC)
	{
		return fourCC.m_Code;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator FourCC(int i)
	{
		return new FourCC(i);
	}

	public override string ToString()
	{
		return $"{(char)(m_Code >> 24)}{(char)((m_Code & 0xFF0000) >> 16)}{(char)((m_Code & 0xFF00) >> 8)}{(char)(m_Code & 0xFF)}";
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(FourCC other)
	{
		return m_Code == other.m_Code;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is FourCC other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Code;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(FourCC left, FourCC right)
	{
		return left.m_Code == right.m_Code;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(FourCC left, FourCC right)
	{
		return left.m_Code != right.m_Code;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static FourCC FromInt32(int i)
	{
		return i;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int ToInt32(FourCC fourCC)
	{
		return fourCC.m_Code;
	}
}
