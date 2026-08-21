using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class EntityPositionData : IReference
{
	public Vector3 position;

	public Vector3 rotation;

	public Vector3 scale = Vector3.one;

	public static EntityPositionData Create()
	{
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = new Vector3(0f, 0f, 0f);
		entityPositionData.scale = Vector3.one;
		entityPositionData.rotation = Vector3.zero;
		return entityPositionData;
	}

	public static EntityPositionData Create(Vector3 position)
	{
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = position;
		entityPositionData.scale = Vector3.one;
		entityPositionData.rotation = Vector3.zero;
		return entityPositionData;
	}

	public static EntityPositionData Create(Vector3 position, Vector3 rotation)
	{
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = position;
		entityPositionData.scale = Vector3.one;
		entityPositionData.rotation = rotation;
		return entityPositionData;
	}

	public static EntityPositionData Create(Vector3 position, Vector3 rotation, Vector3 scale)
	{
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = position;
		entityPositionData.scale = scale;
		entityPositionData.rotation = rotation;
		return entityPositionData;
	}

	public EntityPositionData Clone()
	{
		EntityPositionData entityPositionData = ReferencePool.Acquire<EntityPositionData>();
		entityPositionData.position = position;
		entityPositionData.rotation = rotation;
		entityPositionData.scale = scale;
		return entityPositionData;
	}

	public void Clear()
	{
		position = Vector3.zero;
		rotation = Vector3.zero;
		scale = Vector3.one;
	}
}
