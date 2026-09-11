using System.Collections.Generic;
using System.Numerics;
using System.Runtime.CompilerServices;
using Octree;
using UnityEngine;

public class QwSpaceQuery
{
	private static BoundsOctree<IQwLodObject> boundsTree;

	public static void Init()
	{
		boundsTree = new BoundsOctree<IQwLodObject>(15f, System.Numerics.Vector3.Zero, 1f, 1.25f);
	}

	public static void Shutdown()
	{
		boundsTree = null;
	}

	public static void AddObject(IQwLodObject lodObject)
	{
		boundsTree.Add(lodObject, GetBoundingBox(lodObject, ref lodObject.GetLodData()));
	}

	public static void RemoveObject(IQwLodObject lodObject)
	{
		boundsTree.Remove(lodObject);
	}

	public static void Update()
	{
		if (!QwLodMgr.inited)
		{
			return;
		}
		foreach (IQwLodObject lodObject in QwLodMgr.lodObjects)
		{
			ref QwLodData lodData = ref lodObject.GetLodData();
			if (lodData.positionDirty)
			{
				boundsTree.Remove(lodObject);
				boundsTree.Add(lodObject, GetBoundingBox(lodObject, ref lodData));
			}
		}
	}

	public static void GetObejcts(UnityEngine.Vector3 position, UnityEngine.Vector3 size, List<IQwLodObject> results)
	{
		boundsTree.GetCollidingNonAlloc(results, new BoundingBox(Cast(position), Cast(size)));
	}

	public static void GetObejcts(UnityEngine.Vector3 position, float radius, List<IQwLodObject> results)
	{
		GetObejcts(position, new UnityEngine.Vector3(radius, radius, radius), results);
		float num = radius * radius;
		for (int num2 = results.Count; num2 >= 0; num2--)
		{
			IQwLodObject qwLodObject = results[num2];
			qwLodObject.GetLodData();
			if (qwLodObject is QWorldMapEntity qWorldMapEntity && (qWorldMapEntity.transform.position - position).sqrMagnitude > num)
			{
				results.RemoveAt(num2);
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private static BoundingBox GetBoundingBox(IQwLodObject lodObject, ref QwLodData lodData)
	{
		UnityEngine.Vector3 size = lodData.bounds.size;
		if (lodObject is QWorldMapEntity qWorldMapEntity)
		{
			return new BoundingBox(Cast(qWorldMapEntity.transform.position), Cast(size));
		}
		return default(BoundingBox);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static System.Numerics.Vector3 Cast(UnityEngine.Vector3 vec)
	{
		return new System.Numerics.Vector3(vec.x, vec.y, vec.z);
	}
}
