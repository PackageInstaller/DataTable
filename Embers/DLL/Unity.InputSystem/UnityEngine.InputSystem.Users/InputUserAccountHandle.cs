using System;

namespace UnityEngine.InputSystem.Users;

public struct InputUserAccountHandle : IEquatable<InputUserAccountHandle>
{
	private string m_ApiName;

	private ulong m_Handle;

	public string apiName => m_ApiName;

	public ulong handle => m_Handle;

	public InputUserAccountHandle(string apiName, ulong handle)
	{
		if (string.IsNullOrEmpty(apiName))
		{
			throw new ArgumentNullException("apiName");
		}
		m_ApiName = apiName;
		m_Handle = handle;
	}

	public override string ToString()
	{
		if (m_ApiName == null)
		{
			return base.ToString();
		}
		return $"{m_ApiName}({m_Handle})";
	}

	public bool Equals(InputUserAccountHandle other)
	{
		if (string.Equals(apiName, other.apiName))
		{
			return object.Equals(handle, other.handle);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputUserAccountHandle)
		{
			return Equals((InputUserAccountHandle)obj);
		}
		return false;
	}

	public static bool operator ==(InputUserAccountHandle left, InputUserAccountHandle right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputUserAccountHandle left, InputUserAccountHandle right)
	{
		return !left.Equals(right);
	}

	public override int GetHashCode()
	{
		return (((apiName != null) ? apiName.GetHashCode() : 0) * 397) ^ handle.GetHashCode();
	}
}
