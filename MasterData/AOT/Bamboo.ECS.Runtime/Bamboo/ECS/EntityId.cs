using System;

namespace Bamboo.ECS;

public struct EntityId : IEquatable<EntityId>
{
	private int _index;

	private int _version;

	private string? _logStr;

	public static readonly EntityId Invalid;

	public int Index => _index;

	public int Version => _version;

	public EntityId(int index, int version)
	{
		_index = index;
		_version = version;
		_logStr = null;
	}

	public bool Equals(EntityId other)
	{
		if (Index == other.Index)
		{
			return Version == other.Version;
		}
		return false;
	}

	public override bool Equals(object? obj)
	{
		if (obj is EntityId other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(Index, Version);
	}

	public static bool operator ==(EntityId left, EntityId right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(EntityId left, EntityId right)
	{
		return !left.Equals(right);
	}

	public override string ToString()
	{
		return _logStr ?? (_logStr = $"EntityId({Index}:{Version})");
	}
}
