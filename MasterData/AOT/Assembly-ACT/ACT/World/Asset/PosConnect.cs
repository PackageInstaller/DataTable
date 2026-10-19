using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PosConnect : IEquatable<PosConnect>, IDataToBake
{
	public Pos pos1;

	public Pos pos2;

	public Vector3 position;

	public Quaternion rotation;

	public float scale;

	public bool Equals(PosConnect other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		if (!object.Equals(pos1, other.pos1) || !object.Equals(pos2, other.pos2))
		{
			if (object.Equals(pos1, other.pos2))
			{
				return object.Equals(pos2, other.pos1);
			}
			return false;
		}
		return true;
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
		return Equals((PosConnect)obj);
	}

	public override int GetHashCode()
	{
		return pos1.GetHashCode() + pos2.GetHashCode();
	}
}
