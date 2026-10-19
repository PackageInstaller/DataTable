using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Profiling;

namespace Bamboo.ECS;

public class World : IEntityBuilder
{
	public enum SamplerLevel
	{
		None,
		Update,
		LateUpdate,
		FixedUpdate,
		FixedLateUpdate
	}

	private readonly Dictionary<ArchetypeSignature, Archetype> _archetypes;

	private int _archetypeVersion;

	private Archetype?[] _entityToArchetype;

	private int[] _entityToIndex;

	private readonly List<EntityId> _entities;

	private int[] _entityVersions;

	private readonly Stack<int> _freeEntityIndices;

	private int _nextEntityIndex;

	private readonly List<ISystem> _systems;

	private bool _isRunning;

	private SamplerLevel _sampleLevel;

	private readonly Dictionary<SamplerLevel, Dictionary<ISystem, CustomSampler>> _samplerDict = new Dictionary<SamplerLevel, Dictionary<ISystem, CustomSampler>>();

	internal int ArchetypeVersion => _archetypeVersion;

	public EntityLogLevel EntityLogLevel { get; private set; } = EntityLogLevel.Entity;

	public int EntityCount => _entities.Count;

	public void ChangeEntityLogLevel(EntityLogLevel level)
	{
		EntityLogLevel = level;
	}

	public World(int initialEntityCapacity = 256)
	{
		_archetypes = new Dictionary<ArchetypeSignature, Archetype>(32);
		_entityToArchetype = new Archetype[Math.Max(1, initialEntityCapacity)];
		_entityToIndex = new int[Math.Max(1, initialEntityCapacity)];
		_entities = new List<EntityId>(initialEntityCapacity);
		_entityVersions = new int[Math.Max(1, initialEntityCapacity)];
		_freeEntityIndices = new Stack<int>(Math.Max(1, initialEntityCapacity / 4));
		for (int i = 0; i < _entityVersions.Length; i++)
		{
			_entityToIndex[i] = -1;
		}
		_nextEntityIndex = 1;
		_systems = new List<ISystem>(16);
	}

	public void SetSamplerLevel(SamplerLevel level)
	{
		_sampleLevel = level;
	}

	public void Start()
	{
		_isRunning = true;
	}

	public void Stop()
	{
		_isRunning = false;
	}

	public Entity CreateEntity()
	{
		return CreateEntity(GenerateNewEntityId());
	}

	public EntityBuilder NewEntity()
	{
		return EntityBuilder.GetOne(this);
	}

	Entity IEntityBuilder.BuildEntity(List<ComponentTypeId> componentTypeIds, Dictionary<Type, object> componentInstances, EntityId? specifiedId)
	{
		EntityId entityId;
		if (specifiedId.HasValue)
		{
			entityId = specifiedId.Value;
			if (entityId.Index <= 0 || entityId.Version <= 0)
			{
				throw new InvalidOperationException($"Specified EntityId {entityId} is invalid.");
			}
			if (IsEntityValid(entityId))
			{
				throw new InvalidOperationException($"Specified EntityId {entityId} is already use in this World.");
			}
		}
		else
		{
			entityId = GenerateNewEntityId();
		}
		ArchetypeSignature signature = new ArchetypeSignature(componentTypeIds.ToArray());
		Archetype orCreateArchetype = GetOrCreateArchetype(signature);
		orCreateArchetype.AddEntity(entityId, componentInstances);
		_entityToArchetype[entityId.Index] = orCreateArchetype;
		Entity entity = new Entity(entityId, this);
		foreach (object value in componentInstances.Values)
		{
			if (value is IComponent component)
			{
				component.Init(entity);
			}
		}
		return entity;
	}

	public EntityId GenerateNewEntityId()
	{
		int num;
		if (_freeEntityIndices.Count > 0)
		{
			num = _freeEntityIndices.Pop();
		}
		else
		{
			num = _nextEntityIndex++;
			if (num < 0)
			{
				throw new OverflowException("Entity index overflowed.");
			}
			EnsureEntitySlotCapacity(num + 1);
		}
		int num2 = _entityVersions[num];
		if (num2 <= 0)
		{
			num2 = 1;
			_entityVersions[num] = num2;
		}
		EntityId entityId = new EntityId(num, num2);
		_entities.Add(entityId);
		_entityToIndex[num] = _entities.Count - 1;
		return entityId;
	}

	private Entity CreateEntity(EntityId id)
	{
		ArchetypeSignature signature = new ArchetypeSignature(Array.Empty<ComponentTypeId>());
		Archetype orCreateArchetype = GetOrCreateArchetype(signature);
		orCreateArchetype.AddEntityWithoutComponents(id);
		_entityToArchetype[id.Index] = orCreateArchetype;
		return new Entity(id, this);
	}

	private Archetype GetOrCreateArchetype(ArchetypeSignature signature)
	{
		if (_archetypes.TryGetValue(signature, out Archetype value))
		{
			return value;
		}
		value = new Archetype(signature);
		_archetypes[signature] = value;
		_archetypeVersion++;
		return value;
	}

	private bool TryGetArchetypeWithAddedComponent(Archetype currentArchetype, ComponentTypeId addedType, out Archetype archetype)
	{
		ArchetypeSignature key = new ArchetypeSignature(currentArchetype.Signature.ComponentTypes, addedType, isAdd: true);
		return _archetypes.TryGetValue(key, out archetype);
	}

	private bool TryGetArchetypeWithRemovedComponent(Archetype currentArchetype, ComponentTypeId removedType, out Archetype archetype)
	{
		ArchetypeSignature key = new ArchetypeSignature(currentArchetype.Signature.ComponentTypes, removedType, isAdd: false);
		return _archetypes.TryGetValue(key, out archetype);
	}

	private Archetype CreateArchetypeWithAddedComponent(Archetype currentArchetype, ComponentTypeId addedType)
	{
		ComponentTypeId[] componentTypes = currentArchetype.Signature.ComponentTypes;
		ComponentTypeId[] array = new ComponentTypeId[componentTypes.Length + 1];
		int num = 0;
		bool flag = false;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (!flag && addedType.Id < componentTypes[i].Id)
			{
				array[num++] = addedType;
				flag = true;
			}
			array[num++] = componentTypes[i];
		}
		if (!flag)
		{
			array[num] = addedType;
		}
		return GetOrCreateArchetype(new ArchetypeSignature(array));
	}

	private Archetype CreateArchetypeWithRemovedComponent(Archetype currentArchetype, ComponentTypeId removedType)
	{
		ComponentTypeId[] componentTypes = currentArchetype.Signature.ComponentTypes;
		ComponentTypeId[] array = new ComponentTypeId[componentTypes.Length - 1];
		int num = 0;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (componentTypes[i].Id != removedType.Id)
			{
				array[num++] = componentTypes[i];
			}
		}
		return GetOrCreateArchetype(new ArchetypeSignature(array));
	}

	public void DestroyEntity(EntityId id)
	{
		if (!IsEntityValid(id))
		{
			return;
		}
		Archetype entityArchetype = GetEntityArchetype(id);
		if (entityArchetype.TryGetEntityIndex(id, out var index))
		{
			ReleaseManagedComponents(entityArchetype, index);
		}
		entityArchetype.RemoveEntitySwapBack(id);
		_entityToArchetype[id.Index] = null;
		int num = _entityToIndex[id.Index];
		if (num >= 0)
		{
			int num2 = _entities.Count - 1;
			if (num < num2)
			{
				EntityId value = _entities[num2];
				_entities[num] = value;
				_entityToIndex[value.Index] = num;
			}
			_entities.RemoveAt(num2);
			_entityToIndex[id.Index] = -1;
		}
		_entityVersions[id.Index]++;
		_freeEntityIndices.Push(id.Index);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool IsEntityValid(EntityId id)
	{
		int index = id.Index;
		if (index > 0 && id.Version > 0 && (uint)index < (uint)_entityVersions.Length)
		{
			return _entityVersions[index] == id.Version;
		}
		return false;
	}

	public T AddComponent<T>(EntityId id) where T : class, IComponent, new()
	{
		if (!IsEntityValid(id))
		{
			throw new InvalidOperationException($"Entity {id} is not valid");
		}
		Archetype entityArchetype = GetEntityArchetype(id);
		ComponentArray<T> componentArray = entityArchetype.GetComponentArray<T>();
		if (componentArray != null && entityArchetype.TryGetEntityIndex(id, out var index))
		{
			return componentArray.GetUnchecked(index);
		}
		T extraComponent = (T)ComponentPoolRegistry.GetOps<T>().Get();
		ComponentTypeId typeId = ComponentTypeCache<T>.TypeId;
		if (!entityArchetype.AddEdges.TryGetValue(typeId.Id, out var value))
		{
			if (!TryGetArchetypeWithAddedComponent(entityArchetype, typeId, out value))
			{
				value = CreateArchetypeWithAddedComponent(entityArchetype, typeId);
			}
			entityArchetype.AddEdges[typeId.Id] = value;
			value.RemoveEdges[typeId.Id] = entityArchetype;
		}
		MigrateEntity(id, entityArchetype, value, typeId, extraComponent);
		if (value.TryGetEntityIndex(id, out var index2))
		{
			return value.GetComponentArray<T>().GetUnchecked(index2);
		}
		throw new InvalidOperationException($"Failed to get component index for entity {id} after adding managed component.");
	}

	public bool TryGetComponent<T>(EntityId id, out T? component) where T : class?, IComponent?
	{
		component = null;
		if (!IsEntityValid(id))
		{
			return false;
		}
		Archetype entityArchetype = GetEntityArchetype(id);
		ComponentArray<T> componentArray = entityArchetype.GetComponentArray<T>();
		if (componentArray == null)
		{
			return false;
		}
		if (entityArchetype.TryGetEntityIndex(id, out var index))
		{
			component = componentArray.GetUnchecked(index);
			return true;
		}
		return false;
	}

	public void RemoveComponent<T>(EntityId id) where T : class, IComponent
	{
		if (!IsEntityValid(id))
		{
			throw new InvalidOperationException($"Entity {id} is not valid");
		}
		Archetype entityArchetype = GetEntityArchetype(id);
		object obj = null;
		Type typeFromHandle = typeof(T);
		ComponentTypeId typeId = ComponentTypeCache<T>.TypeId;
		IComponentArray componentArray = entityArchetype.GetComponentArray(typeId);
		if (componentArray == null)
		{
			return;
		}
		if (entityArchetype.TryGetEntityIndex(id, out var index))
		{
			obj = componentArray.GetObject(index);
		}
		if (!entityArchetype.RemoveEdges.TryGetValue(typeId.Id, out var value))
		{
			if (!TryGetArchetypeWithRemovedComponent(entityArchetype, typeId, out value))
			{
				value = CreateArchetypeWithRemovedComponent(entityArchetype, typeId);
			}
			entityArchetype.RemoveEdges[typeId.Id] = value;
			value.AddEdges[typeId.Id] = entityArchetype;
		}
		MigrateEntity(id, entityArchetype, value, null, null);
		if (obj != null)
		{
			ComponentPoolRegistry.Release(typeFromHandle, obj);
		}
	}

	public bool HasComponent<T>(EntityId id) where T : class, IComponent
	{
		if (!IsEntityValid(id))
		{
			return false;
		}
		return GetEntityArchetype(id).HasComponent<T>();
	}

	internal IEnumerator<IComponent> GetComponents(EntityId id)
	{
		if (!IsEntityValid(id))
		{
			throw new InvalidOperationException($"Entity {id} is not valid");
		}
		Archetype archetype = GetEntityArchetype(id);
		if (archetype == null)
		{
			throw new InvalidOperationException($"Entity {id} does not exist");
		}
		if (!archetype.TryGetEntityIndex(id, out var index))
		{
			throw new InvalidOperationException($"Failed to get component index for entity {id}");
		}
		ComponentTypeId[] componentTypes = archetype.Signature.ComponentTypes;
		foreach (ComponentTypeId componentTypeId in componentTypes)
		{
			if (!(ComponentTypeRegistry.GetType(componentTypeId) == null) && archetype.GetComponentArray(componentTypeId)?.GetObject(index) is IComponent component)
			{
				yield return component;
			}
		}
	}

	private void MigrateEntity(EntityId id, Archetype from, Archetype to, ComponentTypeId? extraTypeId, object? extraComponent)
	{
		if (from.TryGetEntityIndex(id, out var index))
		{
			to.AddEntityFromArchetype(id, from, index, extraTypeId, extraComponent);
			from.RemoveEntitySwapBack(id);
			_entityToArchetype[id.Index] = to;
		}
	}

	private void ReleaseManagedComponents(Archetype archetype, int entityIndex)
	{
		ComponentTypeId[] componentTypes = archetype.Signature.ComponentTypes;
		foreach (ComponentTypeId componentTypeId in componentTypes)
		{
			Type type = ComponentTypeRegistry.GetType(componentTypeId);
			if (!(type == null) && ComponentPoolRegistry.IsManagedComponent(type))
			{
				object obj = archetype.GetComponentArray(componentTypeId)?.GetObject(entityIndex);
				ComponentPoolRegistry.Release(type, obj);
			}
		}
	}

	internal void GetMatchingArchetypesNonAlloc(List<Archetype> results, ulong allMask, ulong anyMask, ulong noneMask)
	{
		if (results == null)
		{
			throw new ArgumentNullException("results");
		}
		results.Clear();
		foreach (Archetype value in _archetypes.Values)
		{
			if ((allMask == 0L || value.HasAllComponents(allMask)) && (anyMask == 0L || value.HasAnyComponent(anyMask)) && (noneMask == 0L || value.HasNoneComponent(noneMask)))
			{
				results.Add(value);
			}
		}
	}

	public Entity GetEntity(EntityId id)
	{
		if (!IsEntityValid(id))
		{
			return Entity.Invalid;
		}
		return new Entity(id, this);
	}

	public FilterBuilder NewFilter()
	{
		return FilterBuilder.GetOne(this);
	}

	public T AddSystem<T>(T system) where T : ISystem
	{
		if (system == null)
		{
			throw new ArgumentNullException("system");
		}
		system.World = this;
		system.OnCreate();
		_systems.Add(system);
		return system;
	}

	public bool RemoveSystem<T>() where T : ISystem
	{
		for (int i = 0; i < _systems.Count; i++)
		{
			if (_systems[i] is T)
			{
				_systems[i].OnDestroy();
				_systems.RemoveAt(i);
				return true;
			}
		}
		return false;
	}

	public T? GetSystem<T>() where T : ISystem
	{
		foreach (ISystem system in _systems)
		{
			if (system is T)
			{
				return (T)system;
			}
		}
		return default;
	}

	private CustomSampler? GetSampler(ISystem system, SamplerLevel level)
	{
		if (_sampleLevel < level)
		{
			return null;
		}
		if (!_samplerDict.TryGetValue(level, out Dictionary<ISystem, CustomSampler> value))
		{
			value = new Dictionary<ISystem, CustomSampler>();
			_samplerDict.Add(level, value);
		}
		if (!value.TryGetValue(system, out var value2))
		{
			value2 = CustomSampler.Create($"{system.GetType().Name}.{level}");
			value.Add(system, value2);
		}
		return value2;
	}

	public void Update()
	{
		if (!_isRunning)
		{
			return;
		}
		foreach (ISystem system in _systems)
		{
			if (system.Enabled)
			{
				GetSampler(system, SamplerLevel.Update);
				system.OnUpdate();
			}
		}
	}

	public void FixedUpdate()
	{
		if (!_isRunning)
		{
			return;
		}
		foreach (ISystem system in _systems)
		{
			if (system.Enabled)
			{
				GetSampler(system, SamplerLevel.FixedUpdate);
				system.OnFixedUpdate();
			}
		}
	}

	public void FixedLateUpdate()
	{
		if (!_isRunning)
		{
			return;
		}
		foreach (ISystem system in _systems)
		{
			if (system.Enabled)
			{
				GetSampler(system, SamplerLevel.FixedLateUpdate);
				system.OnFixedLateUpdate();
			}
		}
	}

	public void LateUpdate()
	{
		if (!_isRunning)
		{
			return;
		}
		foreach (ISystem system in _systems)
		{
			if (system.Enabled)
			{
				GetSampler(system, SamplerLevel.LateUpdate);
				system.OnLateUpdate();
			}
		}
	}

	public IEnumerable<Entity> GetAllEntities()
	{
		foreach (EntityId entity in _entities)
		{
			if (IsEntityValid(entity))
			{
				yield return new Entity(entity, this);
			}
		}
	}

	public void GetAllEntitiesNonAlloc(List<Entity> output)
	{
		if (output == null)
		{
			throw new ArgumentNullException("output");
		}
		for (int i = 0; i < _entities.Count; i++)
		{
			EntityId id = _entities[i];
			if (IsEntityValid(id))
			{
				output.Add(new Entity(id, this));
			}
		}
	}

	public void ForEachEntity(Action<Entity> action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		for (int i = 0; i < _entities.Count; i++)
		{
			EntityId id = _entities[i];
			if (IsEntityValid(id))
			{
				action(new Entity(id, this));
			}
		}
	}

	public void ClearAllEntities()
	{
		foreach (Archetype value in _archetypes.Values)
		{
			for (int i = 0; i < value.EntityCount; i++)
			{
				ReleaseManagedComponents(value, i);
			}
		}
		_archetypes.Clear();
		_archetypeVersion++;
		for (int j = 0; j < _entityToArchetype.Length; j++)
		{
			_entityToArchetype[j] = null;
		}
		foreach (EntityId entity in _entities)
		{
			_entityVersions[entity.Index]++;
			_freeEntityIndices.Push(entity.Index);
		}
		_entities.Clear();
	}

	private void EnsureEntitySlotCapacity(int requiredCapacity)
	{
		if (requiredCapacity > _entityVersions.Length)
		{
			int num = _entityVersions.Length;
			int num2;
			for (num2 = _entityVersions.Length; num2 < requiredCapacity; num2 *= 2)
			{
			}
			Array.Resize(ref _entityVersions, num2);
			Array.Resize(ref _entityToArchetype, num2);
			Array.Resize(ref _entityToIndex, num2);
			for (int i = num; i < num2; i++)
			{
				_entityToArchetype[i] = null;
				_entityToIndex[i] = -1;
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private Archetype GetEntityArchetype(EntityId id)
	{
		return _entityToArchetype[id.Index];
	}

	[MethodImpl((MethodImplOptions)256)]
	internal bool TryGetEntityLocation(EntityId id, out Archetype archetype, out int entityIndex)
	{
		archetype = GetEntityArchetype(id);
		return archetype.TryGetEntityIndex(id, out entityIndex);
	}

	public (int entityCount, int archetypeCount, int systemCount) GetStats()
	{
		return (entityCount: _entities.Count, archetypeCount: _archetypes.Count, systemCount: _systems.Count);
	}

	public void Destroy()
	{
		foreach (ISystem system in _systems)
		{
			system.OnDestroy();
		}
		_systems.Clear();
	}
}
