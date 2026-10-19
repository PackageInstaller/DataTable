using System;

namespace UnityEngine.Rendering;

public struct ShaderTagId(string name) : IEquatable<ShaderTagId>
{
	public static readonly ShaderTagId none;

	private int m_Id = Shader.TagToID(name);

	internal int id
	{
		get
		{
			return m_Id;
		}
		set
		{
			m_Id = value;
		}
	}

	public string name => Shader.IDToTag(id);

	public override bool Equals(object obj)
	{
		return obj is ShaderTagId && Equals((ShaderTagId)obj);
	}

	public bool Equals(ShaderTagId other)
	{
		return m_Id == other.m_Id;
	}

	public override int GetHashCode()
	{
		int num = 2079669542;
		return num * -1521134295 + m_Id.GetHashCode();
	}

	public static bool operator ==(ShaderTagId tag1, ShaderTagId tag2)
	{
		return tag1.Equals(tag2);
	}

	public static bool operator !=(ShaderTagId tag1, ShaderTagId tag2)
	{
		return !(tag1 == tag2);
	}

	public static explicit operator ShaderTagId(string name)
	{
		return new ShaderTagId(name);
	}

	public static explicit operator string(ShaderTagId tagId)
	{
		return tagId.name;
	}
}
