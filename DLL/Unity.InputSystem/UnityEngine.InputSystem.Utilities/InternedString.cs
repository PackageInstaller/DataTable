using System;
using System.Globalization;

namespace UnityEngine.InputSystem.Utilities;

public struct InternedString : IEquatable<InternedString>, IComparable<InternedString>
{
	private readonly string m_StringOriginalCase;

	private readonly string m_StringLowerCase;

	public int length => m_StringLowerCase?.Length ?? 0;

	public InternedString(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			m_StringOriginalCase = null;
			m_StringLowerCase = null;
		}
		else
		{
			m_StringOriginalCase = string.Intern(text);
			m_StringLowerCase = string.Intern(text.ToLower(CultureInfo.InvariantCulture));
		}
	}

	public bool IsEmpty()
	{
		return m_StringLowerCase == null;
	}

	public string ToLower()
	{
		return m_StringLowerCase;
	}

	public override bool Equals(object obj)
	{
		if (obj is InternedString other)
		{
			return Equals(other);
		}
		if (obj is string text)
		{
			if (m_StringLowerCase == null)
			{
				return string.IsNullOrEmpty(text);
			}
			return string.Equals(m_StringLowerCase, text.ToLower(CultureInfo.InvariantCulture));
		}
		return false;
	}

	public bool Equals(InternedString other)
	{
		return (object)m_StringLowerCase == other.m_StringLowerCase;
	}

	public int CompareTo(InternedString other)
	{
		return string.Compare(m_StringLowerCase, other.m_StringLowerCase, StringComparison.InvariantCultureIgnoreCase);
	}

	public override int GetHashCode()
	{
		if (m_StringLowerCase == null)
		{
			return 0;
		}
		return m_StringLowerCase.GetHashCode();
	}

	public override string ToString()
	{
		return m_StringOriginalCase ?? string.Empty;
	}

	public static bool operator ==(InternedString a, InternedString b)
	{
		return a.Equals(b);
	}

	public static bool operator !=(InternedString a, InternedString b)
	{
		return !a.Equals(b);
	}

	public static bool operator ==(InternedString a, string b)
	{
		return string.Compare(a.m_StringLowerCase, b.ToLower(CultureInfo.InvariantCulture), StringComparison.InvariantCultureIgnoreCase) == 0;
	}

	public static bool operator !=(InternedString a, string b)
	{
		return string.Compare(a.m_StringLowerCase, b.ToLower(CultureInfo.InvariantCulture), StringComparison.InvariantCultureIgnoreCase) != 0;
	}

	public static bool operator ==(string a, InternedString b)
	{
		return string.Compare(a.ToLower(CultureInfo.InvariantCulture), b.m_StringLowerCase, StringComparison.InvariantCultureIgnoreCase) == 0;
	}

	public static bool operator !=(string a, InternedString b)
	{
		return string.Compare(a.ToLower(CultureInfo.InvariantCulture), b.m_StringLowerCase, StringComparison.InvariantCultureIgnoreCase) != 0;
	}

	public static bool operator <(InternedString left, InternedString right)
	{
		return string.Compare(left.m_StringLowerCase, right.m_StringLowerCase, StringComparison.InvariantCultureIgnoreCase) < 0;
	}

	public static bool operator >(InternedString left, InternedString right)
	{
		return string.Compare(left.m_StringLowerCase, right.m_StringLowerCase, StringComparison.InvariantCultureIgnoreCase) > 0;
	}

	public static implicit operator string(InternedString str)
	{
		return str.ToString();
	}
}
