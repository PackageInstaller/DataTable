using System;
using Bamboo.ECS;

namespace ACT.Battle;

public struct EntityReference : IEquatable<EntityReference>
{
	public Entity entity;

	public bool isValid => entity.IsValid;

	public bool IsValid => entity.IsValid;

	private EntityReference(Entity en)
	{
		entity = en;
	}

	public static implicit operator Entity(EntityReference entityReference)
	{
		return entityReference.entity;
	}

	public static implicit operator EntityReference(Entity entity)
	{
		return new EntityReference(entity);
	}

	public static bool operator ==(EntityReference x, Entity y)
	{
		return x.entity == y;
	}

	public static bool operator !=(EntityReference x, Entity y)
	{
		return x.entity != y;
	}

	public static bool operator ==(Entity x, EntityReference y)
	{
		return x == y.entity;
	}

	public static bool operator !=(Entity x, EntityReference y)
	{
		return x != y.entity;
	}

	public static bool operator ==(EntityReference x, EntityReference y)
	{
		return x.entity == y.entity;
	}

	public static bool operator !=(EntityReference x, EntityReference y)
	{
		return x.entity != y.entity;
	}

	public static bool operator !=(EntityReference? x, EntityReference y)
	{
		if (x.HasValue)
		{
			return x.Value != y;
		}
		return false;
	}

	public static bool operator ==(EntityReference? x, EntityReference y)
	{
		if (x.HasValue)
		{
			return x.Value == y;
		}
		return false;
	}

	public static bool operator !=(EntityReference x, EntityReference? y)
	{
		if (y.HasValue)
		{
			return y.Value != x;
		}
		return false;
	}

	public static bool operator ==(EntityReference x, EntityReference? y)
	{
		if (y.HasValue)
		{
			return y.Value == x;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return entity.GetHashCode();
	}

	public bool Equals(EntityReference other)
	{
		return entity.Equals(other.entity);
	}

	public override bool Equals(object obj)
	{
		if (obj is EntityReference other)
		{
			return Equals(other);
		}
		return false;
	}
}
