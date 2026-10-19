using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

public struct Entity : IEquatable<Entity>
{
	private EntityId _id;

	public readonly World? World;

	private string? _logStr;

	public static readonly Entity Invalid = new Entity(EntityId.Invalid, null);

	public EntityId Id => _id;

	public bool IsValid
	{
		get
		{
			if (World != null)
			{
				return World.IsEntityValid(Id);
			}
			return false;
		}
	}

	public Entity(EntityId id, World? world)
	{
		_logStr = null;
		_id = id;
		World = world;
	}

	public T AddComponent<T>() where T : class, IComponent, new()
	{
		if (World == null)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} does not belong to any world");
		}
		if (!IsValid)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} is no longer valid");
		}
		T val = World.AddComponent<T>(Id);
		val.Init(this);
		_logStr = null;
		return val;
	}

	public IEnumerator<IComponent> GetComponents()
	{
		if (World == null)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} does not belong to any world");
		}
		if (!IsValid)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} is no longer valid");
		}
		return World.GetComponents(Id);
	}

	public T? GetComponent<T>() where T : class, IComponent
	{
		if (World == null)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} does not belong to any world");
		}
		if (!World.TryGetComponent<T>(Id, out T component))
		{
			return null;
		}
		return component;
	}

	public bool TryGetComponent<T>(out T? component) where T : class, IComponent
	{
		if (World == null)
		{
			component = null;
			return false;
		}
		return World.TryGetComponent<T>(Id, out component);
	}

	public void RemoveComponent<T>() where T : class, IComponent
	{
		if (World == null)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} does not belong to any world");
		}
		if (!IsValid)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} is no longer valid");
		}
		World.RemoveComponent<T>(Id);
		_logStr = null;
	}

	public bool HasComponent<T>() where T : class, IComponent
	{
		if (World != null)
		{
			return World.HasComponent<T>(Id);
		}
		return false;
	}

	public void Destroy()
	{
		if (World == null)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} does not belong to any world");
		}
		if (!IsValid)
		{
			throw new InvalidOperationException($"Entity {Id.Index}:{Id.Version} is already destroyed");
		}
		World.DestroyEntity(Id);
	}

	public bool Equals(Entity other)
	{
		if (Id.Equals(other.Id))
		{
			return World == other.World;
		}
		return false;
	}

	public override bool Equals(object? obj)
	{
		if (obj is Entity entity)
		{
			return entity.Equals(this);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(Id, World);
	}

	public static bool operator ==(Entity left, Entity right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(Entity left, Entity right)
	{
		return !left.Equals(right);
	}

	public static bool operator ==(Entity left, Entity? right)
	{
		return right?.Equals(left) ?? (!left.IsValid);
	}

	public static bool operator !=(Entity left, Entity? right)
	{
		if (!right.HasValue)
		{
			return left.IsValid;
		}
		return !right.GetValueOrDefault().Equals(left);
	}

	public static bool operator ==(Entity? left, Entity right)
	{
		return left?.Equals(right) ?? (!right.IsValid);
	}

	public static bool operator !=(Entity? left, Entity right)
	{
		if (!left.HasValue)
		{
			return right.IsValid;
		}
		return !left.GetValueOrDefault().Equals(right);
	}

	public override string ToString()
	{
		return _logStr ?? (_logStr = GetLogPrint());
	}

	private string GetLogPrint()
	{
		if (World == null)
		{
			return string.Empty;
		}
		switch (World.EntityLogLevel)
		{
		case EntityLogLevel.None:
			return string.Empty;
		case EntityLogLevel.Entity:
			return _logStr ?? (_logStr = $"[ Entity ({Id.Index}:{Id.Version}, Valid={IsValid}) ]");
		case EntityLogLevel.Components:
			if (IsValid)
			{
				return $"[ Entity ({Id.Index}:{Id.Version}, Valid=true) {GetComponentLogPrint()}]";
			}
			return $"[ Entity ({Id.Index}:{Id.Version}, Valid=false)]";
		default:
			return string.Empty;
		}
	}

	private string GetComponentLogPrint()
	{
		IEnumerator<IComponent> components = GetComponents();
		string text = string.Empty;
		while (components.MoveNext())
		{
			IComponent current = components.Current;
			if (current != null && current.NeedPrint)
			{
				text = text + " (" + current.GetPrintLog() + ")";
			}
		}
		return text;
	}

	public static EntityBuilder GetBuilder(World world)
	{
		return EntityBuilder.GetOne(world);
	}
}
