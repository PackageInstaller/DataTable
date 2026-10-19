using System;
using System.Collections;
using System.Collections.Generic;

namespace Bamboo.ECS;

public class Filter : IEnumerable<Entity>, IEnumerable
{
	private readonly World _world;

	private readonly ulong _allMask;

	private readonly ulong _anyMask;

	private readonly ulong _noneMask;

	private readonly List<EntityId> _iterationEntityIds = new List<EntityId>(256);

	private readonly List<Archetype> _matchingArchetypes = new List<Archetype>(8);

	private int _cachedArchetypeVersion = -1;

	public int Count
	{
		get
		{
			int num = 0;
			List<Archetype> matchingArchetypes = GetMatchingArchetypes();
			for (int i = 0; i < matchingArchetypes.Count; i++)
			{
				Archetype archetype = matchingArchetypes[i];
				num += archetype.EntityCount;
			}
			return num;
		}
	}

	public bool IsEmpty
	{
		get
		{
			List<Archetype> matchingArchetypes = GetMatchingArchetypes();
			for (int i = 0; i < matchingArchetypes.Count; i++)
			{
				if (matchingArchetypes[i].EntityCount > 0)
				{
					return false;
				}
			}
			return true;
		}
	}

	internal Filter(World world, ulong allMask, ulong anyMask, ulong noneMask)
	{
		_world = world ?? throw new ArgumentNullException("world");
		_allMask = allMask;
		_anyMask = anyMask;
		_noneMask = noneMask;
		RefreshMatchingArchetypes();
	}

	private List<Archetype> GetMatchingArchetypes()
	{
		RefreshMatchingArchetypes();
		return _matchingArchetypes;
	}

	private void RefreshMatchingArchetypes()
	{
		if (_cachedArchetypeVersion != _world.ArchetypeVersion)
		{
			_world.GetMatchingArchetypesNonAlloc(_matchingArchetypes, _allMask, _anyMask, _noneMask);
			_cachedArchetypeVersion = _world.ArchetypeVersion;
		}
	}

	public Entity FirstOrDefault()
	{
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			if (archetype.EntityCount > 0)
			{
				EntityId entity = archetype.GetEntity(0);
				if (!_world.IsEntityValid(entity))
				{
					return Entity.Invalid;
				}
				return new Entity(entity, _world);
			}
		}
		return Entity.Invalid;
	}

	public IEnumerator<Entity> GetEnumerator()
	{
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int archetypeIndex = 0; archetypeIndex < matchingArchetypes.Count; archetypeIndex++)
		{
			Archetype archetype = matchingArchetypes[archetypeIndex];
			for (int i = 0; i < archetype.EntityCount; i++)
			{
				EntityId entity = archetype.GetEntity(i);
				if (_world.IsEntityValid(entity))
				{
					yield return new Entity(entity, _world);
				}
			}
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void ForEach(EntityAction action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectAllEntityIds(_iterationEntityIds);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.IsEntityValid(id))
			{
				action(new Entity(id, _world));
			}
		}
	}

	public void ForEach<T1>(EntityAction<T1> action) where T1 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				if (componentArray != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2>(EntityAction<T1, T2> action) where T1 : class, IComponent where T2 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				if (componentArray != null && componentArray2 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3>(EntityAction<T1, T2, T3> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEachStable<T1>(EntityAction<T1> action) where T1 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			if (componentArray != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2>(EntityAction<T1, T2> action) where T1 : class, IComponent where T2 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			if (componentArray != null && componentArray2 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3>(EntityAction<T1, T2, T3> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4>(EntityAction<T1, T2, T3, T4> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4, T5>(EntityAction<T1, T2, T3, T4, T5> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j), componentArray5.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4, T5, T6>(EntityAction<T1, T2, T3, T4, T5, T6> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
			ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j), componentArray5.GetUnchecked(j), componentArray6.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4, T5, T6, T7>(EntityAction<T1, T2, T3, T4, T5, T6, T7> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
			ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
			ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j), componentArray5.GetUnchecked(j), componentArray6.GetUnchecked(j), componentArray7.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4, T5, T6, T7, T8>(EntityAction<T1, T2, T3, T4, T5, T6, T7, T8> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent where T8 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
			ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
			ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
			ComponentArray<T8> componentArray8 = archetype.GetComponentArray<T8>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null && componentArray8 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j), componentArray5.GetUnchecked(j), componentArray6.GetUnchecked(j), componentArray7.GetUnchecked(j), componentArray8.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEachStable<T1, T2, T3, T4, T5, T6, T7, T8, T9>(EntityAction<T1, T2, T3, T4, T5, T6, T7, T8, T9> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent where T8 : class, IComponent where T9 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
			ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
			ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
			ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
			ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
			ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
			ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
			ComponentArray<T8> componentArray8 = archetype.GetComponentArray<T8>();
			ComponentArray<T9> componentArray9 = archetype.GetComponentArray<T9>();
			if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null && componentArray8 != null && componentArray9 != null)
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					action(new Entity(archetype.GetEntity(j), _world), componentArray.GetUnchecked(j), componentArray2.GetUnchecked(j), componentArray3.GetUnchecked(j), componentArray4.GetUnchecked(j), componentArray5.GetUnchecked(j), componentArray6.GetUnchecked(j), componentArray7.GetUnchecked(j), componentArray8.GetUnchecked(j), componentArray9.GetUnchecked(j));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4>(EntityAction<T1, T2, T3, T4> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4, T5>(EntityAction<T1, T2, T3, T4, T5> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask | ComponentTypeCache<T5>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex), componentArray5.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4, T5, T6>(EntityAction<T1, T2, T3, T4, T5, T6> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask | ComponentTypeCache<T5>.Mask | ComponentTypeCache<T6>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
				ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex), componentArray5.GetUnchecked(entityIndex), componentArray6.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4, T5, T6, T7>(EntityAction<T1, T2, T3, T4, T5, T6, T7> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask | ComponentTypeCache<T5>.Mask | ComponentTypeCache<T6>.Mask | ComponentTypeCache<T7>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
				ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
				ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex), componentArray5.GetUnchecked(entityIndex), componentArray6.GetUnchecked(entityIndex), componentArray7.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4, T5, T6, T7, T8>(EntityAction<T1, T2, T3, T4, T5, T6, T7, T8> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent where T8 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask | ComponentTypeCache<T5>.Mask | ComponentTypeCache<T6>.Mask | ComponentTypeCache<T7>.Mask | ComponentTypeCache<T8>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
				ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
				ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
				ComponentArray<T8> componentArray8 = archetype.GetComponentArray<T8>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null && componentArray8 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex), componentArray5.GetUnchecked(entityIndex), componentArray6.GetUnchecked(entityIndex), componentArray7.GetUnchecked(entityIndex), componentArray8.GetUnchecked(entityIndex));
				}
			}
		}
	}

	public void ForEach<T1, T2, T3, T4, T5, T6, T7, T8, T9>(EntityAction<T1, T2, T3, T4, T5, T6, T7, T8, T9> action) where T1 : class, IComponent where T2 : class, IComponent where T3 : class, IComponent where T4 : class, IComponent where T5 : class, IComponent where T6 : class, IComponent where T7 : class, IComponent where T8 : class, IComponent where T9 : class, IComponent
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		CollectEntityIds(_iterationEntityIds, ComponentTypeCache<T1>.Mask | ComponentTypeCache<T2>.Mask | ComponentTypeCache<T3>.Mask | ComponentTypeCache<T4>.Mask | ComponentTypeCache<T5>.Mask | ComponentTypeCache<T6>.Mask | ComponentTypeCache<T7>.Mask | ComponentTypeCache<T8>.Mask | ComponentTypeCache<T9>.Mask);
		for (int i = 0; i < _iterationEntityIds.Count; i++)
		{
			EntityId id = _iterationEntityIds[i];
			if (_world.TryGetEntityLocation(id, out Archetype archetype, out int entityIndex) && archetype != null)
			{
				ComponentArray<T1> componentArray = archetype.GetComponentArray<T1>();
				ComponentArray<T2> componentArray2 = archetype.GetComponentArray<T2>();
				ComponentArray<T3> componentArray3 = archetype.GetComponentArray<T3>();
				ComponentArray<T4> componentArray4 = archetype.GetComponentArray<T4>();
				ComponentArray<T5> componentArray5 = archetype.GetComponentArray<T5>();
				ComponentArray<T6> componentArray6 = archetype.GetComponentArray<T6>();
				ComponentArray<T7> componentArray7 = archetype.GetComponentArray<T7>();
				ComponentArray<T8> componentArray8 = archetype.GetComponentArray<T8>();
				ComponentArray<T9> componentArray9 = archetype.GetComponentArray<T9>();
				if (componentArray != null && componentArray2 != null && componentArray3 != null && componentArray4 != null && componentArray5 != null && componentArray6 != null && componentArray7 != null && componentArray8 != null && componentArray9 != null)
				{
					action(new Entity(id, _world), componentArray.GetUnchecked(entityIndex), componentArray2.GetUnchecked(entityIndex), componentArray3.GetUnchecked(entityIndex), componentArray4.GetUnchecked(entityIndex), componentArray5.GetUnchecked(entityIndex), componentArray6.GetUnchecked(entityIndex), componentArray7.GetUnchecked(entityIndex), componentArray8.GetUnchecked(entityIndex), componentArray9.GetUnchecked(entityIndex));
				}
			}
		}
	}

	private void CollectAllEntityIds(List<EntityId> ids)
	{
		ids.Clear();
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			int entityCount = archetype.EntityCount;
			for (int j = 0; j < entityCount; j++)
			{
				ids.Add(archetype.GetEntity(j));
			}
		}
	}

	private void CollectEntityIds(List<EntityId> ids, ulong requiredMask)
	{
		if ((_allMask & requiredMask) == requiredMask)
		{
			CollectAllEntityIds(ids);
			return;
		}
		ids.Clear();
		List<Archetype> matchingArchetypes = GetMatchingArchetypes();
		for (int i = 0; i < matchingArchetypes.Count; i++)
		{
			Archetype archetype = matchingArchetypes[i];
			if (archetype.HasAllComponents(requiredMask))
			{
				int entityCount = archetype.EntityCount;
				for (int j = 0; j < entityCount; j++)
				{
					ids.Add(archetype.GetEntity(j));
				}
			}
		}
	}
}
