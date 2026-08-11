#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

public class BoundsOctree<T>
{
	private BoundsOctreeNode<T> rootNode;

	private readonly float looseness;

	private readonly float initialSize;

	private readonly float minSize;

	private readonly Plane[] _planes = new Plane[6];

	public int Count { get; private set; }

	public BoundsOctree(float initialWorldSize, Vector3 initialWorldPos, float minNodeSize, float loosenessVal)
	{
		if (minNodeSize > initialWorldSize)
		{
			minNodeSize = initialWorldSize;
		}
		Count = 0;
		initialSize = initialWorldSize;
		minSize = minNodeSize;
		looseness = Mathf.Clamp(loosenessVal, 1f, 2f);
		rootNode = new BoundsOctreeNode<T>(initialSize, minSize, looseness, initialWorldPos);
	}

	public void Add(T obj, Bounds objBounds)
	{
		int num = 0;
		while (!rootNode.Add(obj, objBounds))
		{
			Grow(objBounds.center - rootNode.Center);
			if (++num > 20)
			{
				Log.Error("Aborted Add operation as it seemed to be going on forever (" + (num - 1) + ") attempts at growing the octree.");
				return;
			}
		}
		Count++;
	}

	public bool Remove(T obj)
	{
		bool num = rootNode.Remove(obj);
		if (num)
		{
			Count--;
			Shrink();
		}
		return num;
	}

	public bool Remove(T obj, Bounds objBounds)
	{
		bool num = rootNode.Remove(obj, objBounds);
		if (num)
		{
			Count--;
			Shrink();
		}
		return num;
	}

	public bool IsColliding(Bounds checkBounds)
	{
		return rootNode.IsColliding(ref checkBounds);
	}

	public bool IsColliding(Ray checkRay, float maxDistance)
	{
		return rootNode.IsColliding(ref checkRay, maxDistance);
	}

	public void GetColliding(List<T> collidingWith, Bounds checkBounds)
	{
		rootNode.GetColliding(ref checkBounds, collidingWith);
	}

	public void GetColliding(List<T> collidingWith, Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		rootNode.GetColliding(ref checkRay, collidingWith, maxDistance);
	}

	public List<T> GetWithinFrustum(Matrix4x4 pMatrix, Matrix4x4 worldToCameraMatrix)
	{
		Plane[] planes = GeometryUtility.CalculateFrustumPlanes(pMatrix * worldToCameraMatrix);
		List<T> result = new List<T>();
		rootNode.GetWithinFrustum(planes, result);
		return result;
	}

	public void GetWithinFrustum(Matrix4x4 pMatrix, Matrix4x4 worldToCameraMatrix, in List<T> result)
	{
		GeometryUtility.CalculateFrustumPlanes(pMatrix * worldToCameraMatrix, _planes);
		rootNode.GetWithinFrustum(_planes, result);
	}

	public Bounds GetMaxBounds()
	{
		return rootNode.GetBounds();
	}

	public void DrawAllBounds()
	{
		rootNode.DrawAllBounds();
	}

	public void DrawAllObjects()
	{
		rootNode.DrawAllObjects();
	}

	private void Grow(Vector3 direction)
	{
		int num = ((direction.x >= 0f) ? 1 : (-1));
		int num2 = ((direction.y >= 0f) ? 1 : (-1));
		int num3 = ((direction.z >= 0f) ? 1 : (-1));
		BoundsOctreeNode<T> boundsOctreeNode = rootNode;
		float num4 = rootNode.BaseLength / 2f;
		float baseLengthVal = rootNode.BaseLength * 2f;
		Vector3 vector = rootNode.Center + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4);
		rootNode = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, vector);
		if (!boundsOctreeNode.HasAnyObjects())
		{
			return;
		}
		int num5 = rootNode.BestFitChild(boundsOctreeNode.Center);
		BoundsOctreeNode<T>[] array = new BoundsOctreeNode<T>[8];
		for (int i = 0; i < 8; i++)
		{
			if (i == num5)
			{
				array[i] = boundsOctreeNode;
				continue;
			}
			num = ((i % 2 != 0) ? 1 : (-1));
			num2 = ((i <= 3) ? 1 : (-1));
			num3 = ((i >= 2 && (i <= 3 || i >= 6)) ? 1 : (-1));
			array[i] = new BoundsOctreeNode<T>(boundsOctreeNode.BaseLength, minSize, looseness, vector + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4));
		}
		rootNode.SetChildren(array);
	}

	private void Shrink()
	{
		rootNode = rootNode.ShrinkIfPossible(initialSize);
	}
}
