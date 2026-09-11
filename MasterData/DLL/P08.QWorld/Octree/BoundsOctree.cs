using System;
using System.Collections.Generic;
using System.Numerics;

namespace Octree;

public class BoundsOctree<T>
{
	private class Node
	{
		private class OctreeObject
		{
			public T Obj;

			public BoundingBox Bounds;
		}

		private float _looseness;

		private float _minSize;

		private float _adjLength;

		private BoundingBox _bounds;

		private readonly List<OctreeObject> _objects = new List<OctreeObject>();

		private Node[] _children;

		private BoundingBox[] _childBounds;

		private const int NumObjectsAllowed = 8;

		public Vector3 Center { get; private set; }

		public float BaseLength { get; private set; }

		private bool HasChildren => _children != null;

		public BoundingBox Bounds => _bounds;

		public void GetChildBounds(List<BoundingBox> bounds)
		{
			if (HasChildren)
			{
				Node[] children = _children;
				for (int i = 0; i < children.Length; i++)
				{
					children[i].GetChildBounds(bounds);
				}
			}
			else
			{
				bounds.Add(Bounds);
			}
		}

		public Node(float baseLengthVal, float minSizeVal, float loosenessVal, Vector3 centerVal)
		{
			SetValues(baseLengthVal, minSizeVal, loosenessVal, centerVal);
		}

		public bool Add(T obj, BoundingBox objBounds)
		{
			if (!Encapsulates(_bounds, objBounds))
			{
				return false;
			}
			SubAdd(obj, objBounds);
			return true;
		}

		public bool Remove(T obj)
		{
			bool flag = false;
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Obj.Equals(obj))
				{
					flag = _objects.Remove(_objects[i]);
					break;
				}
			}
			if (!flag && _children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					flag = _children[j].Remove(obj);
					if (flag)
					{
						break;
					}
				}
			}
			if (flag && _children != null && ShouldMerge())
			{
				Merge();
			}
			return flag;
		}

		public bool Remove(T obj, BoundingBox objBounds)
		{
			if (!Encapsulates(_bounds, objBounds))
			{
				return false;
			}
			return SubRemove(obj, objBounds);
		}

		public bool IsColliding(ref BoundingBox checkBounds)
		{
			if (!_bounds.Intersects(checkBounds))
			{
				return false;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Bounds.Intersects(checkBounds))
				{
					return true;
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					if (_children[j].IsColliding(ref checkBounds))
					{
						return true;
					}
				}
			}
			return false;
		}

		public bool IsColliding(ref Ray checkRay, float maxDistance = float.PositiveInfinity)
		{
			if (!_bounds.IntersectRay(checkRay, out var distance) || distance > maxDistance)
			{
				return false;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Bounds.IntersectRay(checkRay, out distance) && distance <= maxDistance)
				{
					return true;
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					if (_children[j].IsColliding(ref checkRay, maxDistance))
					{
						return true;
					}
				}
			}
			return false;
		}

		public void GetColliding(ref BoundingBox checkBounds, List<T> result)
		{
			if (!_bounds.Intersects(checkBounds))
			{
				return;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Bounds.Intersects(checkBounds))
				{
					result.Add(_objects[i].Obj);
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					_children[j].GetColliding(ref checkBounds, result);
				}
			}
		}

		public void GetColliding(ref Ray checkRay, List<T> result, float maxDistance = float.PositiveInfinity)
		{
			if (!_bounds.IntersectRay(checkRay, out var distance) || distance > maxDistance)
			{
				return;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Bounds.IntersectRay(checkRay, out distance) && distance <= maxDistance)
				{
					result.Add(_objects[i].Obj);
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					_children[j].GetColliding(ref checkRay, result, maxDistance);
				}
			}
		}

		public void SetChildren(Node[] childOctrees)
		{
			if (childOctrees.Length != 8)
			{
				throw new ArgumentException("Child octree array must be length 8. Was length: " + childOctrees.Length, "childOctrees");
			}
			_children = childOctrees;
		}

		public Node ShrinkIfPossible(float minLength)
		{
			if (BaseLength < 2f * minLength)
			{
				return this;
			}
			if (_objects.Count == 0 && (_children == null || _children.Length == 0))
			{
				return this;
			}
			int num = -1;
			for (int i = 0; i < _objects.Count; i++)
			{
				OctreeObject octreeObject = _objects[i];
				int num2 = BestFitChild(octreeObject.Bounds.Center);
				if (i == 0 || num2 == num)
				{
					if (Encapsulates(_childBounds[num2], octreeObject.Bounds))
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
			if (_children != null)
			{
				bool flag = false;
				for (int j = 0; j < _children.Length; j++)
				{
					if (_children[j].HasAnyObjects())
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
			if (_children == null)
			{
				SetValues(BaseLength / 2f, _minSize, _looseness, _childBounds[num].Center);
				return this;
			}
			if (num == -1)
			{
				return this;
			}
			return _children[num];
		}

		public int BestFitChild(Vector3 objBoundsCenter)
		{
			return ((!(objBoundsCenter.X <= Center.X)) ? 1 : 0) + ((!(objBoundsCenter.Y >= Center.Y)) ? 4 : 0) + ((!(objBoundsCenter.Z <= Center.Z)) ? 2 : 0);
		}

		public bool HasAnyObjects()
		{
			if (_objects.Count > 0)
			{
				return true;
			}
			if (_children != null)
			{
				for (int i = 0; i < 8; i++)
				{
					if (_children[i].HasAnyObjects())
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
			_minSize = minSizeVal;
			_looseness = loosenessVal;
			Center = centerVal;
			_adjLength = _looseness * baseLengthVal;
			_bounds = new BoundingBox(size: new Vector3(_adjLength, _adjLength, _adjLength), center: Center);
			float num = BaseLength / 4f;
			float num2 = BaseLength / 2f * _looseness;
			Vector3 size = new Vector3(num2, num2, num2);
			_childBounds = new BoundingBox[8];
			_childBounds[0] = new BoundingBox(Center + new Vector3(0f - num, num, 0f - num), size);
			_childBounds[1] = new BoundingBox(Center + new Vector3(num, num, 0f - num), size);
			_childBounds[2] = new BoundingBox(Center + new Vector3(0f - num, num, num), size);
			_childBounds[3] = new BoundingBox(Center + new Vector3(num, num, num), size);
			_childBounds[4] = new BoundingBox(Center + new Vector3(0f - num, 0f - num, 0f - num), size);
			_childBounds[5] = new BoundingBox(Center + new Vector3(num, 0f - num, 0f - num), size);
			_childBounds[6] = new BoundingBox(Center + new Vector3(0f - num, 0f - num, num), size);
			_childBounds[7] = new BoundingBox(Center + new Vector3(num, 0f - num, num), size);
		}

		private void SubAdd(T obj, BoundingBox objBounds)
		{
			if (!HasChildren)
			{
				if (_objects.Count < 8 || BaseLength / 2f < _minSize)
				{
					OctreeObject item = new OctreeObject
					{
						Obj = obj,
						Bounds = objBounds
					};
					_objects.Add(item);
					return;
				}
				if (_children == null)
				{
					Split();
					if (_children == null)
					{
						throw new InvalidOperationException("Child creation failed for an unknown reason. Early exit.");
					}
					for (int num = _objects.Count - 1; num >= 0; num--)
					{
						OctreeObject octreeObject = _objects[num];
						int num2 = BestFitChild(octreeObject.Bounds.Center);
						if (Encapsulates(_children[num2]._bounds, octreeObject.Bounds))
						{
							_children[num2].SubAdd(octreeObject.Obj, octreeObject.Bounds);
							_objects.Remove(octreeObject);
						}
					}
				}
			}
			int num3 = BestFitChild(objBounds.Center);
			if (Encapsulates(_children[num3]._bounds, objBounds))
			{
				_children[num3].SubAdd(obj, objBounds);
				return;
			}
			OctreeObject item2 = new OctreeObject
			{
				Obj = obj,
				Bounds = objBounds
			};
			_objects.Add(item2);
		}

		private bool SubRemove(T obj, BoundingBox objBounds)
		{
			bool flag = false;
			for (int i = 0; i < _objects.Count; i++)
			{
				if (_objects[i].Obj.Equals(obj))
				{
					flag = _objects.Remove(_objects[i]);
					break;
				}
			}
			if (!flag && _children != null)
			{
				int num = BestFitChild(objBounds.Center);
				flag = _children[num].SubRemove(obj, objBounds);
			}
			if (flag && _children != null && ShouldMerge())
			{
				Merge();
			}
			return flag;
		}

		private void Split()
		{
			float num = BaseLength / 4f;
			float baseLengthVal = BaseLength / 2f;
			_children = new Node[8];
			_children[0] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(0f - num, num, 0f - num));
			_children[1] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(num, num, 0f - num));
			_children[2] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(0f - num, num, num));
			_children[3] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(num, num, num));
			_children[4] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(0f - num, 0f - num, 0f - num));
			_children[5] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(num, 0f - num, 0f - num));
			_children[6] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(0f - num, 0f - num, num));
			_children[7] = new Node(baseLengthVal, _minSize, _looseness, Center + new Vector3(num, 0f - num, num));
		}

		private void Merge()
		{
			for (int i = 0; i < 8; i++)
			{
				Node node = _children[i];
				for (int num = node._objects.Count - 1; num >= 0; num--)
				{
					OctreeObject item = node._objects[num];
					_objects.Add(item);
				}
			}
			_children = null;
		}

		private static bool Encapsulates(BoundingBox outerBounds, BoundingBox innerBounds)
		{
			if (outerBounds.Contains(innerBounds.Min))
			{
				return outerBounds.Contains(innerBounds.Max);
			}
			return false;
		}

		private bool ShouldMerge()
		{
			int num = _objects.Count;
			if (_children != null)
			{
				Node[] children = _children;
				foreach (Node node in children)
				{
					if (node._children != null)
					{
						return false;
					}
					num += node._objects.Count;
				}
			}
			return num <= 8;
		}
	}

	private Node _rootNode;

	private readonly float _looseness;

	private readonly float _initialSize;

	private readonly float _minSize;

	public int Count { get; private set; }

	public BoundingBox MaxBounds => _rootNode.Bounds;

	public BoundingBox[] GetChildBounds()
	{
		List<BoundingBox> list = new List<BoundingBox>();
		_rootNode.GetChildBounds(list);
		return list.ToArray();
	}

	public BoundsOctree(float initialWorldSize, Vector3 initialWorldPos, float minNodeSize, float loosenessVal)
	{
		if (minNodeSize > initialWorldSize)
		{
			throw new ArgumentException("Minimum node size must be at least as big as the initial world size.", "minNodeSize");
		}
		Count = 0;
		_initialSize = initialWorldSize;
		_minSize = minNodeSize;
		_looseness = MathExtensions.Clamp(loosenessVal, 1f, 2f);
		_rootNode = new Node(_initialSize, _minSize, _looseness, initialWorldPos);
	}

	public void Add(T obj, BoundingBox objBounds)
	{
		int num = 0;
		while (!_rootNode.Add(obj, objBounds))
		{
			Grow(objBounds.Center - _rootNode.Center);
			if (++num > 20)
			{
				throw new InvalidOperationException("Aborted Add operation as it seemed to be going on forever " + $"({num - 1} attempts at growing the octree).");
			}
		}
		Count++;
	}

	public bool Remove(T obj)
	{
		bool num = _rootNode.Remove(obj);
		if (num)
		{
			Count--;
			Shrink();
		}
		return num;
	}

	public bool Remove(T obj, BoundingBox objBounds)
	{
		bool num = _rootNode.Remove(obj, objBounds);
		if (num)
		{
			Count--;
			Shrink();
		}
		return num;
	}

	public bool IsColliding(BoundingBox checkBounds)
	{
		return _rootNode.IsColliding(ref checkBounds);
	}

	public bool IsColliding(Ray checkRay, float maxDistance)
	{
		return _rootNode.IsColliding(ref checkRay, maxDistance);
	}

	public T[] GetColliding(BoundingBox checkBounds)
	{
		List<T> list = new List<T>();
		_rootNode.GetColliding(ref checkBounds, list);
		return list.ToArray();
	}

	public T[] GetColliding(Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		List<T> list = new List<T>();
		_rootNode.GetColliding(ref checkRay, list, maxDistance);
		return list.ToArray();
	}

	public bool GetCollidingNonAlloc(List<T> collidingWith, BoundingBox checkBounds)
	{
		collidingWith.Clear();
		_rootNode.GetColliding(ref checkBounds, collidingWith);
		return collidingWith.Count > 0;
	}

	public bool GetCollidingNonAlloc(List<T> collidingWith, Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		collidingWith.Clear();
		_rootNode.GetColliding(ref checkRay, collidingWith, maxDistance);
		return collidingWith.Count > 0;
	}

	private void Grow(Vector3 direction)
	{
		int num = ((direction.X >= 0f) ? 1 : (-1));
		int num2 = ((direction.Y >= 0f) ? 1 : (-1));
		int num3 = ((direction.Z >= 0f) ? 1 : (-1));
		Node rootNode = _rootNode;
		float num4 = _rootNode.BaseLength / 2f;
		float baseLengthVal = _rootNode.BaseLength * 2f;
		Vector3 vector = _rootNode.Center + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4);
		_rootNode = new Node(baseLengthVal, _minSize, _looseness, vector);
		if (!rootNode.HasAnyObjects())
		{
			return;
		}
		int num5 = _rootNode.BestFitChild(rootNode.Center);
		Node[] array = new Node[8];
		for (int i = 0; i < 8; i++)
		{
			if (i == num5)
			{
				array[i] = rootNode;
				continue;
			}
			num = ((i % 2 != 0) ? 1 : (-1));
			num2 = ((i <= 3) ? 1 : (-1));
			num3 = ((i >= 2 && (i <= 3 || i >= 6)) ? 1 : (-1));
			array[i] = new Node(rootNode.BaseLength, _minSize, _looseness, vector + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4));
		}
		_rootNode.SetChildren(array);
	}

	private void Shrink()
	{
		_rootNode = _rootNode.ShrinkIfPossible(_initialSize);
	}
}
