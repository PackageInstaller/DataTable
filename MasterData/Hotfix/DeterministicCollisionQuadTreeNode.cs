using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

public class DeterministicCollisionQuadTreeNode
{
	protected const int NUM_COLLIDERS_ALLOWED = 8;

	protected FP _minSize;

	protected FP _adjLength;

	public DeterministicCollisionQuadTreeNode parent { get; protected set; }

	public TSVector2 center { get; protected set; }

	public FP baseLength { get; protected set; }

	public FP looseness { get; protected set; }

	public AABB bounds { get; protected set; }

	public List<DeterministicCollider> colliders { get; protected set; } = new List<DeterministicCollider>();

	public DeterministicCollisionQuadTreeNode[] children { get; protected set; }

	public AABB[] childBounds { get; protected set; }

	public bool hasChildren => children != null;

	public bool hasAnyColliders
	{
		get
		{
			if (colliders.Count > 0)
			{
				return true;
			}
			if (children == null)
			{
				return false;
			}
			for (int i = 0; i < 4; i++)
			{
				if (children[i].hasAnyColliders)
				{
					return true;
				}
			}
			return false;
		}
	}

	public DeterministicCollisionQuadTreeNode(FP baseLengthVal, FP minSizeVal, FP loosenessVal, TSVector2 centerVal, DeterministicCollisionQuadTreeNode parentVal = null)
	{
		SetValues(baseLengthVal, minSizeVal, loosenessVal, centerVal, parentVal);
	}

	protected void SetValues(FP baseLengthVal, FP minSizeVal, FP loosenessVal, TSVector2 centerVal, DeterministicCollisionQuadTreeNode parentVal)
	{
		parent = parentVal;
		baseLength = baseLengthVal;
		_minSize = minSizeVal;
		looseness = loosenessVal;
		center = centerVal;
		_adjLength = baseLength * looseness;
		bounds = new AABB(center, _adjLength, _adjLength);
		FP fP = baseLength / 4f;
		FP fP2 = baseLength / 2f * looseness;
		childBounds = new AABB[4];
		childBounds[0] = new AABB(new TSVector2(-fP, -fP), fP2, fP2);
		childBounds[1] = new AABB(new TSVector2(fP, -fP), fP2, fP2);
		childBounds[2] = new AABB(new TSVector2(-fP, fP), fP2, fP2);
		childBounds[3] = new AABB(new TSVector2(fP, fP), fP2, fP2);
	}

	protected void Split()
	{
		FP fP = baseLength / 4f;
		FP baseLengthVal = baseLength / 2f;
		children = new DeterministicCollisionQuadTreeNode[4];
		children[0] = new DeterministicCollisionQuadTreeNode(baseLengthVal, _minSize, looseness, center + new TSVector2(-fP, -fP), this);
		children[1] = new DeterministicCollisionQuadTreeNode(baseLengthVal, _minSize, looseness, center + new TSVector2(fP, -fP), this);
		children[2] = new DeterministicCollisionQuadTreeNode(baseLengthVal, _minSize, looseness, center + new TSVector2(-fP, fP), this);
		children[3] = new DeterministicCollisionQuadTreeNode(baseLengthVal, _minSize, looseness, center + new TSVector2(fP, fP), this);
	}

	public bool Add(DeterministicCollider collider)
	{
		if (!bounds.Contains(ref collider._colliderBounds))
		{
			return false;
		}
		SubAdd(collider);
		return true;
	}

	protected void SubAdd(DeterministicCollider collider)
	{
		int num2;
		if (!hasChildren)
		{
			if (colliders.Count < 8 || baseLength / 2f < _minSize)
			{
				colliders.Add(collider);
				collider._quadTreeNode = this;
				return;
			}
			if (children == null)
			{
				Split();
				if (children == null)
				{
					Debug.LogError("Child creation failed for an unknown reason. Early exit.");
					return;
				}
				for (int num = colliders.Count - 1; num >= 0; num--)
				{
					DeterministicCollider deterministicCollider = colliders.get_Item(num);
					num2 = BestFitChildIndex(deterministicCollider._colliderBounds.Center);
					if (children[num2].bounds.Contains(ref deterministicCollider._colliderBounds))
					{
						colliders.RemoveAt(num);
						deterministicCollider._quadTreeNode = null;
						children[num2].SubAdd(deterministicCollider);
					}
				}
			}
		}
		num2 = BestFitChildIndex(collider._colliderBounds.Center);
		if (children[num2].bounds.Contains(ref collider._colliderBounds))
		{
			children[num2].SubAdd(collider);
			return;
		}
		colliders.Add(collider);
		collider._quadTreeNode = this;
	}

	public bool Remove(DeterministicCollider collider)
	{
		bool flag = false;
		for (int i = 0; i < colliders.Count; i++)
		{
			if (colliders.get_Item(i) == collider)
			{
				colliders.RemoveAt(i);
				collider._quadTreeNode = null;
				flag = true;
				break;
			}
		}
		if (!flag && children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				flag = children[j].Remove(collider);
				if (flag)
				{
					break;
				}
			}
		}
		return flag;
	}

	public bool Update(DeterministicCollider collider)
	{
		if (!bounds.Contains(ref collider._colliderBounds) && colliders.Remove(collider))
		{
			DeterministicCollisionQuadTreeNode quadTreeNode = collider._quadTreeNode;
			collider._quadTreeNode = null;
			DeterministicCollisionQuadTreeNode newRootNode;
			return quadTreeNode.AddWithGrow(collider, out newRootNode);
		}
		return false;
	}

	public bool IsColliding(ref TSVector2 checkPoint)
	{
		if (!bounds.Contains(ref checkPoint))
		{
			return false;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (colliders.get_Item(i)._colliderBounds.Contains(ref checkPoint))
			{
				return true;
			}
		}
		if (children == null)
		{
			return false;
		}
		for (int j = 0; j < 4; j++)
		{
			if (children[j].IsColliding(ref checkPoint))
			{
				return true;
			}
		}
		return false;
	}

	public bool IsColliding(ref AABB checkBounds)
	{
		AABB a = bounds;
		if (!AABB.TestOverlap(ref a, ref checkBounds))
		{
			return false;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (AABB.TestOverlap(ref colliders.get_Item(i)._colliderBounds, ref checkBounds))
			{
				return true;
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				if (children[j].IsColliding(ref checkBounds))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool IsColliding(ref TSVector2 rayOrigin, ref TSVector2 rayDirection, FP maxDistance)
	{
		TSVector2 point = rayOrigin + rayDirection * maxDistance;
		RayCastInput raycastInput = new RayCastInput
		{
			Point1 = rayOrigin,
			Point2 = point,
			MaxFraction = 1f
		};
		return IsCollidingInternal(ref raycastInput);
	}

	protected bool IsCollidingInternal(ref RayCastInput raycastInput)
	{
		if (!bounds.RayCast(out var output, ref raycastInput, doInteriorCheck: false))
		{
			return false;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (colliders.get_Item(i)._colliderBounds.RayCast(out output, ref raycastInput, doInteriorCheck: false))
			{
				return true;
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				if (children[j].IsCollidingInternal(ref raycastInput))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void GetColliding(ref TSVector2 checkPoint, List<DeterministicCollider> result)
	{
		result.Clear();
		GetCollidingInternal(ref checkPoint, result);
	}

	protected void GetCollidingInternal(ref TSVector2 checkPoint, List<DeterministicCollider> result)
	{
		if (!bounds.Contains(ref checkPoint))
		{
			return;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (colliders.get_Item(i)._colliderBounds.Contains(ref checkPoint))
			{
				result.Add(colliders.get_Item(i));
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				children[j].GetCollidingInternal(ref checkPoint, result);
			}
		}
	}

	public void GetColliding(ref AABB checkBounds, List<DeterministicCollider> result)
	{
		result.Clear();
		GetCollidingInternal(ref checkBounds, result);
	}

	protected void GetCollidingInternal(ref AABB checkBounds, List<DeterministicCollider> result)
	{
		AABB a = bounds;
		if (!AABB.TestOverlap(ref a, ref checkBounds))
		{
			return;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (AABB.TestOverlap(ref colliders.get_Item(i)._colliderBounds, ref checkBounds))
			{
				result.Add(colliders.get_Item(i));
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				children[j].GetCollidingInternal(ref checkBounds, result);
			}
		}
	}

	public void GetColliding(ref TSVector2 rayOrigin, ref TSVector2 rayDirection, FP maxDistance, List<DeterministicCollider> result)
	{
		result.Clear();
		TSVector2 rayInverseDirection = -rayDirection;
		GetCollidingInternal(ref rayOrigin, ref rayInverseDirection, result);
	}

	protected void GetCollidingInternal(ref TSVector2 rayOrigin, ref TSVector2 rayInverseDirection, List<DeterministicCollider> result)
	{
		if (!bounds.FastRayCast(ref rayOrigin, ref rayInverseDirection))
		{
			return;
		}
		for (int i = 0; i < colliders.Count; i++)
		{
			if (colliders.get_Item(i)._colliderBounds.FastRayCast(ref rayOrigin, ref rayInverseDirection))
			{
				result.Add(colliders.get_Item(i));
			}
		}
		if (children != null)
		{
			for (int j = 0; j < 4; j++)
			{
				children[j].GetCollidingInternal(ref rayOrigin, ref rayInverseDirection, result);
			}
		}
	}

	public int BestFitChildIndex(TSVector2 colliderCenter)
	{
		TSVector2 tSVector = bounds.Center;
		return ((!(colliderCenter.x <= tSVector.x)) ? 1 : 0) + ((!(colliderCenter.y <= tSVector.y)) ? 2 : 0);
	}

	public DeterministicCollisionQuadTreeNode GetRootNode()
	{
		DeterministicCollisionQuadTreeNode deterministicCollisionQuadTreeNode = this;
		while (deterministicCollisionQuadTreeNode.parent != null)
		{
			deterministicCollisionQuadTreeNode = deterministicCollisionQuadTreeNode.parent;
		}
		return deterministicCollisionQuadTreeNode;
	}

	public int GetTotalColliders()
	{
		return GetRootNode().GetSubTotalColliders();
	}

	protected int GetSubTotalColliders()
	{
		int num = colliders.Count;
		if (children == null)
		{
			return num;
		}
		for (int i = 0; i < 4; i++)
		{
			num += children[i].GetSubTotalColliders();
		}
		return num;
	}

	public bool AddWithGrow(DeterministicCollider collider, out DeterministicCollisionQuadTreeNode newRootNode)
	{
		newRootNode = GetRootNode();
		int num = 0;
		while (!newRootNode.Add(collider))
		{
			newRootNode = newRootNode.Grow(collider._colliderBounds.Center - newRootNode.center);
			if (++num > 4)
			{
				Debug.LogError("Aborted Add operation as it seemed to be going on forever (" + (num - 1) + ") attempts at growing the tree.");
				return false;
			}
		}
		return true;
	}

	protected DeterministicCollisionQuadTreeNode Grow(TSVector2 direction)
	{
		int num = ((direction.x >= 0f) ? 1 : (-1));
		int num2 = ((direction.y >= 0f) ? 1 : (-1));
		FP fP = baseLength / 2f;
		FP baseLengthVal = baseLength * 2;
		TSVector2 tSVector = center + new TSVector2(num * fP, num2 * fP);
		DeterministicCollisionQuadTreeNode deterministicCollisionQuadTreeNode = new DeterministicCollisionQuadTreeNode(baseLengthVal, _minSize, looseness, tSVector);
		if (hasAnyColliders)
		{
			int num3 = deterministicCollisionQuadTreeNode.BestFitChildIndex(center);
			DeterministicCollisionQuadTreeNode[] array = new DeterministicCollisionQuadTreeNode[4];
			for (int i = 0; i < 4; i++)
			{
				if (i == num3)
				{
					array[i] = this;
					continue;
				}
				num = ((i % 2 != 0) ? 1 : (-1));
				num2 = ((i >= 2) ? 1 : (-1));
				TSVector2 centerVal = tSVector + new TSVector2(num * fP, num2 * fP);
				array[i] = new DeterministicCollisionQuadTreeNode(baseLength, _minSize, looseness, centerVal);
			}
			deterministicCollisionQuadTreeNode.children = array;
		}
		return deterministicCollisionQuadTreeNode;
	}
}
