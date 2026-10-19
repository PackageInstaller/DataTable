using System;
using UnityEngine;

[Serializable]
public struct VarName : IEquatable<VarName>, ISerializationCallbackReceiver
{
	[SerializeField]
	private string name;

	private int hashCode;

	public string Name => name;

	public VarName(string name)
	{
		this.name = name;
		hashCode = name.GetHashCode();
	}

	public override int GetHashCode()
	{
		return hashCode;
	}

	public override bool Equals(object other)
	{
		if (other is VarName)
		{
			return Equals((VarName)other);
		}
		return false;
	}

	public bool Equals(VarName other)
	{
		return name == other.name;
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (name != null)
		{
			hashCode = name.GetHashCode();
		}
	}

	public override string ToString()
	{
		return name;
	}

	public static implicit operator VarName(string name)
	{
		return new VarName(name);
	}

	public static implicit operator string(VarName varName)
	{
		return varName.name;
	}
}
