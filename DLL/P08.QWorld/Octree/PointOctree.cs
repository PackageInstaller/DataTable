using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;

namespace Octree;

public class PointOctree<T>
{
	private class Node
	{
		private class OctreeObject
		{
			public T Obj;

			public Vector3 Pos;
		}

		private float _minSize;

		private BoundingBox _bounds;

		private readonly List<OctreeObject> _objects = new List<OctreeObject>();

		private Node[] _children;

		private BoundingBox[] _childBounds;

		private const int NumObjectsAllowed = 8;

		private Vector3 _actualBoundsSize;

		public Vector3 Center { get; private set; }

		public float SideLength { get; private set; }

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

		public Node(float baseLengthVal, float minSizeVal, Vector3 centerVal)
		{
			SetValues(baseLengthVal, minSizeVal, centerVal);
		}

		public bool Add(T obj, Vector3 objPos)
		{
			if (!Encapsulates(_bounds, objPos))
			{
				return false;
			}
			SubAdd(obj, objPos);
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

		public bool Remove(T obj, Vector3 objPos)
		{
			if (!Encapsulates(_bounds, objPos))
			{
				return false;
			}
			return SubRemove(obj, objPos);
		}

		public void GetNearby(ref Ray ray, float maxDistance, List<T> result)
		{
			_bounds.Expand(new Vector3(maxDistance * 2f, maxDistance * 2f, maxDistance * 2f));
			bool num = _bounds.IntersectRay(ray);
			_bounds.Size = _actualBoundsSize;
			if (!num)
			{
				return;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (SqrDistanceToRay(ray, _objects[i].Pos) <= maxDistance * maxDistance)
				{
					result.Add(_objects[i].Obj);
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					_children[j].GetNearby(ref ray, maxDistance, result);
				}
			}
		}

		public void GetNearby(ref Vector3 position, float maxDistance, List<T> result)
		{
			_bounds.Expand(new Vector3(maxDistance * 2f, maxDistance * 2f, maxDistance * 2f));
			bool num = _bounds.Contains(position);
			_bounds.Size = _actualBoundsSize;
			if (!num)
			{
				return;
			}
			for (int i = 0; i < _objects.Count; i++)
			{
				if (Vector3.Distance(position, _objects[i].Pos) <= maxDistance)
				{
					result.Add(_objects[i].Obj);
				}
			}
			if (_children != null)
			{
				for (int j = 0; j < 8; j++)
				{
					_children[j].GetNearby(ref position, maxDistance, result);
				}
			}
		}

		public void GetAll(List<T> result)
		{
			result.AddRange(_objects.Select((OctreeObject o) => o.Obj));
			if (_children != null)
			{
				for (int num = 0; num < 8; num++)
				{
					_children[num].GetAll(result);
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
			if (SideLength < 2f * minLength)
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
				int num2 = BestFitChild(octreeObject.Pos);
				if (i == 0 || num2 == num)
				{
					if (num < 0)
					{
						num = num2;
					}
					continue;
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
				SetValues(SideLength / 2f, _minSize, _childBounds[num].Center);
				return this;
			}
			return _children[num];
		}

		public int BestFitChild(Vector3 objPos)
		{
			return ((!(objPos.X <= Center.X)) ? 1 : 0) + ((!(objPos.Y >= Center.Y)) ? 4 : 0) + ((!(objPos.Z <= Center.Z)) ? 2 : 0);
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

		public static float SqrDistanceToRay(Ray ray, Vector3 point)
		{
			return Vector3.Cross(ray.Direction, point - ray.Origin).LengthSquared();
		}

		private void SetValues(float baseLengthVal, float minSizeVal, Vector3 centerVal)
		{
			SideLength = baseLengthVal;
			_minSize = minSizeVal;
			Center = centerVal;
			_actualBoundsSize = new Vector3(SideLength, SideLength, SideLength);
			_bounds = new BoundingBox(Center, _actualBoundsSize);
			float num = SideLength / 4f;
			float num2 = SideLength / 2f;
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

		private void SubAdd(T obj, Vector3 objPos)
		{
			if (!HasChildren)
			{
				if (_objects.Count < 8 || SideLength / 2f < _minSize)
				{
					OctreeObject item = new OctreeObject
					{
						Obj = obj,
						Pos = objPos
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
						int num2 = BestFitChild(octreeObject.Pos);
						_children[num2].SubAdd(octreeObject.Obj, octreeObject.Pos);
						_objects.Remove(octreeObject);
					}
				}
			}
			int num3 = BestFitChild(objPos);
			_children[num3].SubAdd(obj, objPos);
		}

		private bool SubRemove(T obj, Vector3 objPos)
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
				int num = BestFitChild(objPos);
				flag = _children[num].SubRemove(obj, objPos);
			}
			if (flag && _children != null && ShouldMerge())
			{
				Merge();
			}
			return flag;
		}

		private void Split()
		{
			float num = SideLength / 4f;
			float baseLengthVal = SideLength / 2f;
			_children = new Node[8];
			_children[0] = new Node(baseLengthVal, _minSize, Center + new Vector3(0f - num, num, 0f - num));
			_children[1] = new Node(baseLengthVal, _minSize, Center + new Vector3(num, num, 0f - num));
			_children[2] = new Node(baseLengthVal, _minSize, Center + new Vector3(0f - num, num, num));
			_children[3] = new Node(baseLengthVal, _minSize, Center + new Vector3(num, num, num));
			_children[4] = new Node(baseLengthVal, _minSize, Center + new Vector3(0f - num, 0f - num, 0f - num));
			_children[5] = new Node(baseLengthVal, _minSize, Center + new Vector3(num, 0f - num, 0f - num));
			_children[6] = new Node(baseLengthVal, _minSize, Center + new Vector3(0f - num, 0f - num, num));
			_children[7] = new Node(baseLengthVal, _minSize, Center + new Vector3(num, 0f - num, num));
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

		private static bool Encapsulates(BoundingBox outerBounds, Vector3 point)
		{
			return outerBounds.Contains(point);
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

	private readonly float _initialSize;

	private readonly float _minSize;

	public int Count { get; private set; }

	public BoundingBox MaxBounds => new BoundingBox(_rootNode.Center, new Vector3(_rootNode.SideLength, _rootNode.SideLength, _rootNode.SideLength));

	public BoundingBox[] GetChildBounds()
	{
		List<BoundingBox> list = new List<BoundingBox>();
		_rootNode.GetChildBounds(list);
		return list.ToArray();
	}

	public PointOctree(float initialWorldSize, Vector3 initialWorldPos, float minNodeSize)
	{
		if (minNodeSize > initialWorldSize)
		{
			throw new ArgumentException("Minimum node size must be at least as big as the initial world size.", "minNodeSize");
		}
		Count = 0;
		_initialSize = initialWorldSize;
		_minSize = minNodeSize;
		_rootNode = new Node(_initialSize, _minSize, initialWorldPos);
	}

	public void Add(T obj, Vector3 objPos)
	{
		int num = 0;
		while (!_rootNode.Add(obj, objPos))
		{
			Grow(objPos - _rootNode.Center);
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

	public bool Remove(T obj, Vector3 objPos)
	{
		bool num = _rootNode.Remove(obj, objPos);
		if (num)
		{
			Count--;
			Shrink();
		}
		return num;
	}

	public T[] GetNearby(Ray ray, float maxDistance)
	{
		List<T> list = new List<T>();
		_rootNode.GetNearby(ref ray, maxDistance, list);
		return list.ToArray();
	}

	public T[] GetNearby(Vector3 position, float maxDistance)
	{
		List<T> list = new List<T>();
		_rootNode.GetNearby(ref position, maxDistance, list);
		return list.ToArray();
	}

	public bool GetNearbyNonAlloc(Ray ray, float maxDistance, List<T> nearby)
	{
		nearby.Clear();
		_rootNode.GetNearby(ref ray, maxDistance, nearby);
		return nearby.Count > 0;
	}

	public bool GetNearbyNonAlloc(Vector3 position, float maxDistance, List<T> nearby)
	{
		nearby.Clear();
		_rootNode.GetNearby(ref position, maxDistance, nearby);
		return nearby.Count > 0;
	}

	public ICollection<T> GetAll()
	{
		List<T> result = new List<T>(Count);
		_rootNode.GetAll(result);
		return result;
	}

	private void Grow(Vector3 direction)
	{
		int num = ((direction.X >= 0f) ? 1 : (-1));
		int num2 = ((direction.Y >= 0f) ? 1 : (-1));
		int num3 = ((direction.Z >= 0f) ? 1 : (-1));
		Node rootNode = _rootNode;
		float num4 = _rootNode.SideLength / 2f;
		float baseLengthVal = _rootNode.SideLength * 2f;
		Vector3 vector = _rootNode.Center + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4);
		_rootNode = new Node(baseLengthVal, _minSize, vector);
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
			array[i] = new Node(rootNode.SideLength, _minSize, vector + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4));
		}
		_rootNode.SetChildren(array);
	}

	private void Shrink()
	{
		_rootNode = _rootNode.ShrinkIfPossible(_initialSize);
	}
}
