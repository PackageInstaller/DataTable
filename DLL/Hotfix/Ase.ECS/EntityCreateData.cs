using System;
using GameFramework;

namespace Ase.ECS;

public class EntityCreateData : IReference
{
	public int id;

	public int entityId;

	public Type entityType;

	public BaseEntity parent;

	public EntityData entityData;

	public WorldBase world;

	public void Clear()
	{
		id = 0;
		entityId = 0;
		parent = null;
		world = null;
		if (entityData != null)
		{
			ReferencePool.Release(entityData);
			entityData = null;
		}
	}
}
