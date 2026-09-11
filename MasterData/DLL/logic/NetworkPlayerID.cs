using System;

public struct NetworkPlayerID(ulong id) : IEquatable<NetworkPlayerID>, IComparable<NetworkPlayerID>
{
	public static NetworkPlayerID kInvalidID;

	public ulong ID = id;

	public override string ToString()
	{
		return ID.ToString();
	}

	public bool Equals(NetworkPlayerID playerID)
	{
		return ID == playerID.ID;
	}

	public int CompareTo(NetworkPlayerID other)
	{
		return ID.CompareTo(other.ID);
	}

	public override bool Equals(object obj)
	{
		if (obj is NetworkPlayerID)
		{
			return this == (NetworkPlayerID)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ID.GetHashCode();
	}

	public static bool operator ==(NetworkPlayerID lhs, NetworkPlayerID rhs)
	{
		return lhs.ID == rhs.ID;
	}

	public static bool operator !=(NetworkPlayerID lhs, NetworkPlayerID rhs)
	{
		return !(lhs == rhs);
	}

	static NetworkPlayerID()
	{
		kInvalidID = new NetworkPlayerID(0uL);
	}
}
