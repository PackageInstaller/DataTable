using UnityEngine;

namespace GameFramework.Resource;

public class InstantiateData : IReference
{
	public bool SetPositionAndRotation { get; private set; }

	public Vector3 Position { get; private set; }

	public Quaternion Rotation { get; private set; }

	public Transform Parent { get; private set; }

	public bool WorldStay { get; private set; }

	public bool Active { get; private set; }

	public bool AutoLifecycle { get; set; } = true;

	public static InstantiateData Create(bool active = true)
	{
		InstantiateData instantiateData = ReferencePool.Acquire<InstantiateData>();
		instantiateData.SetPositionAndRotation = false;
		instantiateData.Position = Vector3.zero;
		instantiateData.Rotation = Quaternion.identity;
		instantiateData.Parent = null;
		instantiateData.WorldStay = false;
		instantiateData.Active = active;
		return instantiateData;
	}

	public static InstantiateData Create(Transform parent, bool active = true)
	{
		InstantiateData instantiateData = ReferencePool.Acquire<InstantiateData>();
		instantiateData.SetPositionAndRotation = false;
		instantiateData.Position = Vector3.zero;
		instantiateData.Rotation = Quaternion.identity;
		instantiateData.Parent = parent;
		instantiateData.WorldStay = false;
		instantiateData.Active = active;
		return instantiateData;
	}

	public static InstantiateData Create(Transform parent, bool worldPositionStays, bool active)
	{
		InstantiateData instantiateData = ReferencePool.Acquire<InstantiateData>();
		instantiateData.SetPositionAndRotation = false;
		instantiateData.Position = Vector3.zero;
		instantiateData.Rotation = Quaternion.identity;
		instantiateData.Parent = parent;
		instantiateData.WorldStay = worldPositionStays;
		instantiateData.Active = active;
		return instantiateData;
	}

	public static InstantiateData Create(Vector3 position, Quaternion rotation, bool active = true)
	{
		InstantiateData instantiateData = ReferencePool.Acquire<InstantiateData>();
		instantiateData.SetPositionAndRotation = true;
		instantiateData.Position = position;
		instantiateData.Rotation = rotation;
		instantiateData.Parent = null;
		instantiateData.WorldStay = false;
		instantiateData.Active = active;
		return instantiateData;
	}

	public static InstantiateData Create(Vector3 position, Quaternion rotation, Transform parent, bool active = true)
	{
		InstantiateData instantiateData = ReferencePool.Acquire<InstantiateData>();
		instantiateData.SetPositionAndRotation = true;
		instantiateData.Position = position;
		instantiateData.Rotation = rotation;
		instantiateData.Parent = parent;
		instantiateData.WorldStay = false;
		instantiateData.Active = active;
		return instantiateData;
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		SetPositionAndRotation = false;
		Position = Vector3.zero;
		Rotation = Quaternion.identity;
		Parent = null;
		WorldStay = false;
		Active = false;
	}
}
