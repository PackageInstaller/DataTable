using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

public sealed class EntityBuilder
{
	private static readonly Stack<EntityBuilder> _entityBuilderPool = new Stack<EntityBuilder>(16);

	private IEntityBuilder _entityBuilder;

	private EntityId? _specifiedId;

	private readonly List<ComponentTypeId> _componentTypeIds = new List<ComponentTypeId>(8);

	private readonly Dictionary<Type, object> _componentInstances = new Dictionary<Type, object>(8);

	internal static EntityBuilder GetOne(IEntityBuilder entityBuilder)
	{
		EntityBuilder entityBuilder2 = ((_entityBuilderPool.Count > 0) ? _entityBuilderPool.Pop() : new EntityBuilder());
		entityBuilder2.Init(entityBuilder);
		return entityBuilder2;
	}

	private static void ReturnOne(EntityBuilder builder)
	{
		_entityBuilderPool.Push(builder);
	}

	private EntityBuilder()
	{
	}

	private void Init(IEntityBuilder entityBuilder)
	{
		_entityBuilder = entityBuilder;
	}

	public EntityBuilder WithId(EntityId id)
	{
		_specifiedId = id;
		return this;
	}

	public EntityBuilder With<T>(Action<T>? configure = null) where T : class, IComponent, new()
	{
		if (_entityBuilder == null)
		{
			throw new InvalidOperationException("EntityBuilder is not bound to any World. Use World.CreateEntityBuilder() to obtain an instance.");
		}
		Type typeFromHandle = typeof(T);
		if (_componentInstances.ContainsKey(typeFromHandle))
		{
			return this;
		}
		T val = (T)ComponentPoolRegistry.GetOps<T>().Get();
		configure?.Invoke(val);
		_componentTypeIds.Add(ComponentTypeCache<T>.TypeId);
		_componentInstances[typeFromHandle] = val;
		return this;
	}

	public Entity Build()
	{
		if (_entityBuilder == null)
		{
			throw new InvalidOperationException("EntityBuilder is not bound to any World.");
		}
		Entity result = _entityBuilder.BuildEntity(_componentTypeIds, _componentInstances, _specifiedId);
		Reset();
		return result;
	}

	private void Reset()
	{
		_componentTypeIds.Clear();
		_componentInstances.Clear();
		_specifiedId = null;
		_entityBuilder = null;
		ReturnOne(this);
	}
}
