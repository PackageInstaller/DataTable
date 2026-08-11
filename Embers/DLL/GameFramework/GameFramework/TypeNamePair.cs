using System;
using System.Runtime.InteropServices;

namespace GameFramework;

[StructLayout(LayoutKind.Auto)]
internal struct TypeNamePair : IEquatable<TypeNamePair>
{
	private readonly Type m_Type;

	private readonly string m_Name;

	public Type Type => m_Type;

	public string Name => m_Name;

	public TypeNamePair(Type type)
		: this(type, string.Empty)
	{
	}

	public TypeNamePair(Type type, string name)
	{
		if (type == null)
		{
			throw new GameFrameworkException("Type is invalid.");
		}
		m_Type = type;
		m_Name = name ?? string.Empty;
	}

	public override string ToString()
	{
		if (m_Type == null)
		{
			throw new GameFrameworkException("Type is invalid.");
		}
		string fullName = m_Type.FullName;
		return string.IsNullOrEmpty(m_Name) ? fullName : Utility.Text.Format("{0}.{1}", fullName, m_Name);
	}

	public override int GetHashCode()
	{
		return m_Type.GetHashCode() ^ m_Name.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return obj is TypeNamePair && Equals((TypeNamePair)obj);
	}

	public bool Equals(TypeNamePair value)
	{
		return m_Type == value.m_Type && m_Name == value.m_Name;
	}

	public static bool operator ==(TypeNamePair a, TypeNamePair b)
	{
		return a.Equals(b);
	}

	public static bool operator !=(TypeNamePair a, TypeNamePair b)
	{
		return !(a == b);
	}
}
