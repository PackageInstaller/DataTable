using System;

namespace Sirenix.Serialization;

public struct NodeInfo
{
	public static readonly NodeInfo Empty = new NodeInfo(parameter: true);

	public readonly string Name;

	public readonly int Id;

	public readonly Type Type;

	public readonly bool IsArray;

	public readonly bool IsEmpty;

	public NodeInfo(string name, int id, Type type, bool isArray)
	{
		Name = name;
		Id = id;
		Type = type;
		IsArray = isArray;
		IsEmpty = false;
	}

	private NodeInfo(bool parameter)
	{
		Name = null;
		Id = -1;
		Type = null;
		IsArray = false;
		IsEmpty = true;
	}

	public static bool operator ==(NodeInfo a, NodeInfo b)
	{
		if (a.Name == b.Name && a.Id == b.Id && a.Type == b.Type && a.IsArray == b.IsArray)
		{
			return a.IsEmpty == b.IsEmpty;
		}
		return false;
	}

	public static bool operator !=(NodeInfo a, NodeInfo b)
	{
		return !(a == b);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is NodeInfo)
		{
			return (NodeInfo)obj == this;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (IsEmpty)
		{
			return 0;
		}
		return -2128831035 ^ (((Name == null) ? 12321 : Name.GetHashCode()) * 16777619) ^ (Id * 16777619) ^ (((Type == null) ? 1423 : Type.GetHashCode()) * 16777619) ^ ((IsArray ? 124124 : 43234) * 16777619) ^ ((IsEmpty ? 872934 : 27323) * 16777619);
	}
}
