using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class Pos : IDataToBake, IEquatable<Pos>
{
	public string posName;

	public Vector3 value;

	public Quaternion rotate;

	public Vector3 localScale;

	public static implicit operator Vector3(Pos Pos)
	{
		return Pos.value;
	}

	public static implicit operator Quaternion(Pos Pos)
	{
		return Pos.rotate;
	}

	public bool Equals(Pos other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		return object.Equals(value, other.value);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((Pos)obj);
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(value.GetHashCode(), rotate.GetHashCode());
	}
}
