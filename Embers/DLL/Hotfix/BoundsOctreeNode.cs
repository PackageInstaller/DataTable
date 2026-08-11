#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

public class BoundsOctreeNode<T>
{
	private struct OctreeObject
	{
		public T Obj;

		public Bounds Bounds;
	}

	private float looseness;

	private float minSize;

	private float adjLength;

	private Bounds bounds;

	private readonly List<OctreeObject> objects = new List<OctreeObject>();

	private BoundsOctreeNode<T>[] children;

	private Bounds[] childBounds;

	private const int NUM_OBJECTS_ALLOWED = 8;

	public Vector3 Center { get; private set; }

	public float BaseLength { get; private set; }

	private bool HasChildren => children != null;

	public BoundsOctreeNode(float baseLengthVal, float minSizeVal, float loosenessVal, Vector3 centerVal)
	{
		SetValues(baseLengthVal, minSizeVal, loosenessVal, centerVal);
	}

	public bool Add(T obj, Bounds objBounds)
	{
		if (!Encapsulates(bounds, objBounds))
		{
			return false;
		}
		SubAdd(obj, objBounds);
		return true;
	}

	public bool Remove(T obj)
	{
		bool flag = false;
		for (int i = 0; i < objects.Count; i++)
		{
			OctreeObject octreeObject = objects[i];
			if (octreeObject.Obj.Equals(obj))
			{
				flag = objects.Remove(objects[i]);
				break;
			}
		}
		if (!flag && children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				flag = children[j].Remove(obj);
				if (flag)
				{
					break;
				}
			}
		}
		if (flag && children != null && ShouldMerge())
		{
			Merge();
		}
		return flag;
	}

	public bool Remove(T obj, Bounds objBounds)
	{
		if (!Encapsulates(bounds, objBounds))
		{
			return false;
		}
		return SubRemove(obj, objBounds);
	}

	public bool IsColliding(ref Bounds checkBounds)
	{
		if (!bounds.Intersects(checkBounds))
		{
			return false;
		}
		for (int i = 0; i < objects.Count; i++)
		{
			if (objects[i].Bounds.Intersects(checkBounds))
			{
				return true;
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				if (children[j].IsColliding(ref checkBounds))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool IsColliding(ref Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		if (!bounds.IntersectRay(checkRay, out var distance) || distance > maxDistance)
		{
			return false;
		}
		for (int i = 0; i < objects.Count; i++)
		{
			if (objects[i].Bounds.IntersectRay(checkRay, out distance) && distance <= maxDistance)
			{
				return true;
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				if (children[j].IsColliding(ref checkRay, maxDistance))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void GetColliding(ref Bounds checkBounds, List<T> result)
	{
		if (!bounds.Intersects(checkBounds))
		{
			return;
		}
		for (int i = 0; i < objects.Count; i++)
		{
			if (objects[i].Bounds.Intersects(checkBounds))
			{
				result.Add(objects[i].Obj);
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				children[j].GetColliding(ref checkBounds, result);
			}
		}
	}

	public void GetColliding(ref Ray checkRay, List<T> result, float maxDistance = float.PositiveInfinity)
	{
		if (!bounds.IntersectRay(checkRay, out var distance) || distance > maxDistance)
		{
			return;
		}
		for (int i = 0; i < objects.Count; i++)
		{
			if (objects[i].Bounds.IntersectRay(checkRay, out distance) && distance <= maxDistance)
			{
				result.Add(objects[i].Obj);
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				children[j].GetColliding(ref checkRay, result, maxDistance);
			}
		}
	}

	public void GetWithinFrustum(Plane[] planes, List<T> result)
	{
		if (!GeometryUtility.TestPlanesAABB(planes, bounds))
		{
			return;
		}
		for (int i = 0; i < objects.Count; i++)
		{
			if (GeometryUtility.TestPlanesAABB(planes, objects[i].Bounds))
			{
				result.Add(objects[i].Obj);
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				children[j].GetWithinFrustum(planes, result);
			}
		}
	}

	public void SetChildren(BoundsOctreeNode<T>[] childOctrees)
	{
		if (childOctrees.Length != 8)
		{
			Log.Error("Child octree array must be length 8. Was length: " + childOctrees.Length);
		}
		else
		{
			children = childOctrees;
		}
	}

	public Bounds GetBounds()
	{
		return bounds;
	}

	public void DrawAllBounds(float depth = 0f)
	{
		float num = depth / 7f;
		Gizmos.color = new Color(num, 0f, 1f - num);
		Bounds bounds = new Bounds(Center, new Vector3(adjLength, adjLength, adjLength));
		Gizmos.DrawWireCube(bounds.center, bounds.size);
		if (children != null)
		{
			depth++;
			for (int i = 0; i < 8; i++)
			{
				children[i].DrawAllBounds(depth);
			}
		}
		Gizmos.color = Color.white;
	}

	public void DrawAllObjects()
	{
		float num = BaseLength / 20f;
		Gizmos.color = new Color(0f, 1f - num, num, 0.25f);
		foreach (OctreeObject @object in objects)
		{
			Bounds bounds = @object.Bounds;
			Vector3 center = bounds.center;
			bounds = @object.Bounds;
			Gizmos.DrawCube(center, bounds.size);
		}
		if (children != null)
		{
			for (int i = 0; i < 8; i++)
			{
				children[i].DrawAllObjects();
			}
		}
		Gizmos.color = Color.white;
	}

	public BoundsOctreeNode<T> ShrinkIfPossible(float minLength)
	{
		if (BaseLength < 2f * minLength)
		{
			return this;
		}
		if (objects.Count == 0 && (children == null || children.Length == 0))
		{
			return this;
		}
		int num = -1;
		for (int i = 0; i < objects.Count; i++)
		{
			OctreeObject octreeObject = objects[i];
			int num2 = BestFitChild(octreeObject.Bounds.center);
			if (i == 0 || num2 == num)
			{
				if (Encapsulates(childBounds[num2], octreeObject.Bounds))
				{
					if (num < 0)
					{
						num = num2;
					}
					continue;
				}
				return this;
			}
			return this;
		}
		if (children != null)
		{
			bool flag = false;
			for (int j = 0; j < children.Length; j++)
			{
				if (children[j].HasAnyObjects())
				{
					if (flag)
					{
						return this;
					}
					if (num >= 0 && num != j)
					{
						return this;
					}
					flag = true;
					num = j;
				}
			}
		}
		if (children == null)
		{
			SetValues(BaseLength / 2f, minSize, looseness, childBounds[num].center);
			return this;
		}
		if (num == -1)
		{
			return this;
		}
		return children[num];
	}

	public int BestFitChild(Vector3 objBoundsCenter)
	{
		return ((!(objBoundsCenter.x <= Center.x)) ? 1 : 0) + ((!(objBoundsCenter.y >= Center.y)) ? 4 : 0) + ((!(objBoundsCenter.z <= Center.z)) ? 2 : 0);
	}

	public bool HasAnyObjects()
	{
		if (objects.Count > 0)
		{
			return true;
		}
		if (children != null)
		{
			for (int i = 0; i < 8; i++)
			{
				if (children[i].HasAnyObjects())
				{
					return true;
				}
			}
		}
		return false;
	}

	private void SetValues(float baseLengthVal, float minSizeVal, float loosenessVal, Vector3 centerVal)
	{
		BaseLength = baseLengthVal;
		minSize = minSizeVal;
		looseness = loosenessVal;
		Center = centerVal;
		adjLength = looseness * baseLengthVal;
		bounds = new Bounds(size: new Vector3(adjLength, adjLength, adjLength), center: Center);
		float num = BaseLength / 4f;
		float num2 = BaseLength / 2f * looseness;
		Vector3 size = new Vector3(num2, num2, num2);
		childBounds = new Bounds[8];
		childBounds[0] = new Bounds(Center + new Vector3(0f - num, num, 0f - num), size);
		childBounds[1] = new Bounds(Center + new Vector3(num, num, 0f - num), size);
		childBounds[2] = new Bounds(Center + new Vector3(0f - num, num, num), size);
		childBounds[3] = new Bounds(Center + new Vector3(num, num, num), size);
		childBounds[4] = new Bounds(Center + new Vector3(0f - num, 0f - num, 0f - num), size);
		childBounds[5] = new Bounds(Center + new Vector3(num, 0f - num, 0f - num), size);
		childBounds[6] = new Bounds(Center + new Vector3(0f - num, 0f - num, num), size);
		childBounds[7] = new Bounds(Center + new Vector3(num, 0f - num, num), size);
	}

	private void SubAdd(T obj, Bounds objBounds)
	{
		if (!HasChildren)
		{
			if (objects.Count < 8 || BaseLength / 2f < minSize)
			{
				OctreeObject item = new OctreeObject
				{
					Obj = obj,
					Bounds = objBounds
				};
				objects.Add(item);
				return;
			}
			if (children == null)
			{
				Split();
				if (children == null)
				{
					Log.Error("Child creation failed for an unknown reason. Early exit.");
					return;
				}
				for (int num = objects.Count - 1; num >= 0; num--)
				{
					OctreeObject item2 = objects[num];
					int num2 = BestFitChild(item2.Bounds.center);
					if (Encapsulates(children[num2].bounds, item2.Bounds))
					{
						children[num2].SubAdd(item2.Obj, item2.Bounds);
						objects.Remove(item2);
					}
				}
			}
		}
		int num3 = BestFitChild(objBounds.center);
		if (Encapsulates(children[num3].bounds, objBounds))
		{
			children[num3].SubAdd(obj, objBounds);
			return;
		}
		OctreeObject item3 = new OctreeObject
		{
			Obj = obj,
			Bounds = objBounds
		};
		objects.Add(item3);
	}

	private bool SubRemove(T obj, Bounds objBounds)
	{
		bool flag = false;
		for (int i = 0; i < objects.Count; i++)
		{
			OctreeObject octreeObject = objects[i];
			if (octreeObject.Obj.Equals(obj))
			{
				flag = objects.Remove(objects[i]);
				break;
			}
		}
		if (!flag && children != null)
		{
			int num = BestFitChild(objBounds.center);
			flag = children[num].SubRemove(obj, objBounds);
		}
		if (flag && children != null && ShouldMerge())
		{
			Merge();
		}
		return flag;
	}

	private void Split()
	{
		float num = BaseLength / 4f;
		float baseLengthVal = BaseLength / 2f;
		children = new BoundsOctreeNode<T>[8];
		children[0] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(0f - num, num, 0f - num));
		children[1] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(num, num, 0f - num));
		children[2] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(0f - num, num, num));
		children[3] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(num, num, num));
		children[4] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(0f - num, 0f - num, 0f - num));
		children[5] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(num, 0f - num, 0f - num));
		children[6] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(0f - num, 0f - num, num));
		children[7] = new BoundsOctreeNode<T>(baseLengthVal, minSize, looseness, Center + new Vector3(num, 0f - num, num));
	}

	private void Merge()
	{
		for (int i = 0; i < 8; i++)
		{
			BoundsOctreeNode<T> boundsOctreeNode = children[i];
			for (int num = boundsOctreeNode.objects.Count - 1; num >= 0; num--)
			{
				OctreeObject item = boundsOctreeNode.objects[num];
				objects.Add(item);
			}
		}
		children = null;
	}

	private static bool Encapsulates(Bounds outerBounds, Bounds innerBounds)
	{
		if (outerBounds.Contains(innerBounds.min))
		{
			return outerBounds.Contains(innerBounds.max);
		}
		return false;
	}

	private bool ShouldMerge()
	{
		int num = objects.Count;
		if (children != null)
		{
			BoundsOctreeNode<T>[] array = children;
			foreach (BoundsOctreeNode<T> boundsOctreeNode in array)
			{
				if (boundsOctreeNode.children != null)
				{
					return false;
				}
				num += boundsOctreeNode.objects.Count;
			}
		}
		return num <= 8;
	}
}
