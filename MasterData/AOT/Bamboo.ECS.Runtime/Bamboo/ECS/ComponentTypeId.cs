using System;

namespace Bamboo.ECS;

internal struct ComponentTypeId(int id) : IEquatable<ComponentTypeId>
{
	public int Id = id;

	public bool Equals(ComponentTypeId other)
	{
		return Id == other.Id;
	}

	public override bool Equals(object obj)
	{
		if (obj is ComponentTypeId other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Id;
	}

	public static bool operator ==(ComponentTypeId left, ComponentTypeId right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(ComponentTypeId left, ComponentTypeId right)
	{
		return !left.Equals(right);
	}
}
