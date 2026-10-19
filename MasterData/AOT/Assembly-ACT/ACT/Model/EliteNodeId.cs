using System;

namespace ACT.Model;

public readonly struct EliteNodeId : IEquatable<EliteNodeId>
{
	public static readonly EliteNodeId Invalid = new EliteNodeId(EliteNodeType.Point, -1);

	public EliteNodeType NodeType { get; }

	public int Index { get; }

	public bool IsValid => Index >= 0;

	public EliteNodeId(EliteNodeType nodeType, int index)
	{
		NodeType = nodeType;
		Index = index;
	}

	public bool Equals(EliteNodeId other)
	{
		if (NodeType == other.NodeType)
		{
			return Index == other.Index;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is EliteNodeId other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ((int)NodeType * 397) ^ Index;
	}

	public static bool operator ==(EliteNodeId left, EliteNodeId right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(EliteNodeId left, EliteNodeId right)
	{
		return !left.Equals(right);
	}

	public override string ToString()
	{
		return $"{NodeType}:{Index}";
	}
}
