using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

internal class Archetype
{
	private readonly ArchetypeSignature _signature;

	private readonly ulong _componentMask;

	private IComponentArray[] _componentArraysByTypeId;

	private readonly List<EntityId> _entities;

	private int[] _entityToIndex;

	internal readonly Dictionary<int, Archetype> AddEdges = new Dictionary<int, Archetype>(4);

	internal readonly Dictionary<int, Archetype> RemoveEdges = new Dictionary<int, Archetype>(4);

	public ArchetypeSignature Signature => _signature;

	public int EntityCount => _entities.Count;

	public Archetype(ArchetypeSignature signature, int initialCapacity = 16)
	{
		_signature = signature;
		_componentMask = BuildComponentMask(signature.ComponentTypes);
		_componentArraysByTypeId = new IComponentArray[Math.Max(ComponentTypeRegistry.Count, 1)];
		_entities = new List<EntityId>(initialCapacity);
		_entityToIndex = new int[Math.Max(initialCapacity, 1)];
		Array.Fill(_entityToIndex, -1);
		ComponentTypeId[] componentTypes = signature.ComponentTypes;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			ComponentTypeId id = componentTypes[i];
			EnsureComponentArrayCapacity(id.Id + 1);
			Type type = ComponentTypeRegistry.GetType(id);
			if (type != null)
			{
				IComponentArray componentArray = (IComponentArray)Activator.CreateInstance(typeof(ComponentArray<>).MakeGenericType(type), initialCapacity);
				_componentArraysByTypeId[id.Id] = componentArray;
			}
		}
	}

	public int AddEntity(EntityId entity, Dictionary<Type, object> components)
	{
		int count = _entities.Count;
		_entities.Add(entity);
		EnsureEntityIndexCapacity(entity.Index + 1);
		_entityToIndex[entity.Index] = count;
		ComponentTypeId[] componentTypes = _signature.ComponentTypes;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			ComponentTypeId id = componentTypes[i];
			Type type = ComponentTypeRegistry.GetType(id);
			if (type == null)
			{
				continue;
			}
			IComponentArray componentArray = _componentArraysByTypeId[id.Id];
			if (componentArray == null)
			{
				continue;
			}
			if (components.TryGetValue(type, out var value))
			{
				componentArray.AddObject(value);
				continue;
			}
			if (ComponentPoolRegistry.IsManagedComponent(type))
			{
				throw new InvalidOperationException("Managed component " + type.Name + " requires explicit instance when adding to Archetype.");
			}
			object component = Activator.CreateInstance(type);
			componentArray.AddObject(component);
		}
		return count;
	}

	internal int AddEntityWithoutComponents(EntityId entity)
	{
		int count = _entities.Count;
		_entities.Add(entity);
		EnsureEntityIndexCapacity(entity.Index + 1);
		_entityToIndex[entity.Index] = count;
		return count;
	}

	internal int AddEntityFromArchetype(EntityId entity, Archetype? source, int sourceIndex, ComponentTypeId? extraTypeId, object? extraComponent)
	{
		int count = _entities.Count;
		_entities.Add(entity);
		EnsureEntityIndexCapacity(entity.Index + 1);
		_entityToIndex[entity.Index] = count;
		ComponentTypeId[] componentTypes = _signature.ComponentTypes;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			ComponentTypeId componentTypeId = componentTypes[i];
			IComponentArray componentArray = _componentArraysByTypeId[componentTypeId.Id];
			if (componentArray == null)
			{
				continue;
			}
			if (extraTypeId.HasValue && componentTypeId == extraTypeId.Value)
			{
				componentArray.AddObject(extraComponent);
				continue;
			}
			IComponentArray componentArray2 = source?.GetComponentArray(componentTypeId);
			if (componentArray2 != null)
			{
				componentArray.AddObject(componentArray2.GetObject(sourceIndex));
				continue;
			}
			Type type = ComponentTypeRegistry.GetType(componentTypeId);
			if (!(type == null))
			{
				if (ComponentPoolRegistry.IsManagedComponent(type))
				{
					throw new InvalidOperationException("Managed component " + type.Name + " requires explicit instance when adding to Archetype.");
				}
				componentArray.AddObject(Activator.CreateInstance(type));
			}
		}
		return count;
	}

	public int RemoveEntitySwapBack(EntityId entity)
	{
		if (!TryGetEntityIndex(entity, out var index))
		{
			return -1;
		}
		int num = _entities.Count - 1;
		EntityId entityId = _entities[num];
		ComponentTypeId[] componentTypes = _signature.ComponentTypes;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			ComponentTypeId componentTypeId = componentTypes[i];
			_componentArraysByTypeId[componentTypeId.Id]?.RemoveAtSwapBack(index);
		}
		if (index < num)
		{
			EnsureEntityIndexCapacity(entityId.Index + 1);
			_entityToIndex[entityId.Index] = index;
		}
		_entityToIndex[entity.Index] = -1;
		if (index < num)
		{
			_entities[index] = _entities[num];
		}
		_entities.RemoveAt(num);
		if (index >= num)
		{
			return index;
		}
		return num;
	}

	public bool TryGetEntityIndex(EntityId entity, out int index)
	{
		int index2 = entity.Index;
		if ((uint)index2 >= (uint)_entityToIndex.Length)
		{
			index = -1;
			return false;
		}
		index = _entityToIndex[index2];
		return index >= 0;
	}

	public ComponentArray<T> GetComponentArray<T>() where T : class, IComponent
	{
		int typeIndex = ComponentTypeCache<T>.TypeIndex;
		if ((uint)typeIndex >= (uint)_componentArraysByTypeId.Length)
		{
			return null;
		}
		return (ComponentArray<T>)_componentArraysByTypeId[typeIndex];
	}

	internal IComponentArray GetComponentArray(ComponentTypeId typeId)
	{
		int id = typeId.Id;
		if ((uint)id >= (uint)_componentArraysByTypeId.Length)
		{
			return null;
		}
		return _componentArraysByTypeId[id];
	}

	public EntityId GetEntity(int index)
	{
		return _entities[index];
	}

	public bool HasComponent<T>() where T : class, IComponent
	{
		int typeIndex = ComponentTypeCache<T>.TypeIndex;
		if ((uint)typeIndex < 64u)
		{
			return (_componentMask & (ulong)(1L << typeIndex)) != 0;
		}
		return false;
	}

	internal bool HasComponent(ComponentTypeId typeId)
	{
		int id = typeId.Id;
		if ((uint)id < 64u)
		{
			return (_componentMask & (ulong)(1L << id)) != 0;
		}
		return false;
	}

	internal bool HasAllComponents(ulong componentMask)
	{
		return (_componentMask & componentMask) == componentMask;
	}

	internal bool HasAnyComponent(ulong componentMask)
	{
		return (_componentMask & componentMask) != 0;
	}

	internal bool HasNoneComponent(ulong componentMask)
	{
		return (_componentMask & componentMask) == 0;
	}

	internal static ulong BuildComponentMask(ComponentTypeId[] componentTypes)
	{
		ulong num = 0uL;
		if (componentTypes == null || componentTypes.Length == 0)
		{
			return num;
		}
		for (int i = 0; i < componentTypes.Length; i++)
		{
			int id = componentTypes[i].Id;
			if ((uint)id >= 64u)
			{
				throw new InvalidOperationException($"Bamboo ECS 64-bit component signature supports type ids 0..63, but got {id}.");
			}
			num |= (ulong)(1L << id);
		}
		return num;
	}

	private void EnsureEntityIndexCapacity(int requiredCapacity)
	{
		if (requiredCapacity > _entityToIndex.Length)
		{
			int num = _entityToIndex.Length;
			int num2;
			for (num2 = num; num2 < requiredCapacity; num2 *= 2)
			{
			}
			Array.Resize(ref _entityToIndex, num2);
			Array.Fill(_entityToIndex, -1, num, num2 - num);
		}
	}

	private void EnsureComponentArrayCapacity(int requiredCapacity)
	{
		if (requiredCapacity > _componentArraysByTypeId.Length)
		{
			int num;
			for (num = _componentArraysByTypeId.Length; num < requiredCapacity; num *= 2)
			{
			}
			Array.Resize(ref _componentArraysByTypeId, num);
		}
	}
}
