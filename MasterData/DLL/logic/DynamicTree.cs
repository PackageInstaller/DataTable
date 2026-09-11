using System;
using System.Collections.Generic;
using Pathfinding.Util;

public class DynamicTree<T> where T : ISimShape
{
	internal const int NullNode = -1;

	private int _freeList;

	private int _insertionCount;

	private int _nodeCapacity;

	private int _nodeCount;

	private DynamicTreeNode<T>[] _nodes;

	private static VFactor SettingsAABBMultiplier = 2 * VFactor.one;

	private VFactor settingsRndExtension = new VFactor(1L, 10L);

	private int _root;

	private List<int> mInvalidNodes = new List<int>();

	private Stack<int> stack = new Stack<int>(16);

	private int _path;

	public int Root => _root;

	public DynamicTreeNode<T>[] Nodes => _nodes;

	public DynamicTree()
		: this(new VFactor(1L, 10L))
	{
	}

	public DynamicTree(VFactor rndExtension)
	{
		settingsRndExtension = rndExtension;
		_root = -1;
		_nodeCapacity = 512;
		_nodes = new DynamicTreeNode<T>[_nodeCapacity];
		for (int i = 0; i < _nodeCapacity - 1; i++)
		{
			_nodes[i] = new DynamicTreeNode<T>();
			_nodes[i].ParentOrNext = i + 1;
		}
		_nodes[_nodeCapacity - 1] = new DynamicTreeNode<T>();
		_nodes[_nodeCapacity - 1].ParentOrNext = -1;
	}

	private int AllocateNode()
	{
		if (_freeList == -1)
		{
			XLogger.Assert(_nodeCount == _nodeCapacity, "_nodeCount != _nodeCapacity");
			DynamicTreeNode<T>[] nodes = _nodes;
			_nodeCapacity *= 2;
			_nodes = new DynamicTreeNode<T>[_nodeCapacity];
			Array.Copy(nodes, _nodes, _nodeCount);
			for (int i = _nodeCount; i < _nodeCapacity - 1; i++)
			{
				_nodes[i] = new DynamicTreeNode<T>();
				_nodes[i].ParentOrNext = i + 1;
			}
			_nodes[_nodeCapacity - 1] = new DynamicTreeNode<T>();
			_nodes[_nodeCapacity - 1].ParentOrNext = -1;
			_freeList = _nodeCount;
		}
		int freeList = _freeList;
		_freeList = _nodes[freeList].ParentOrNext;
		_nodes[freeList].ParentOrNext = -1;
		_nodes[freeList].Child1 = -1;
		_nodes[freeList].Child2 = -1;
		_nodes[freeList].LeafCount = 0;
		_nodeCount++;
		return freeList;
	}

	public int AddProxy(ref ABOX aabb, T userData)
	{
		int num = AllocateNode();
		_nodes[num].MinorRandomExtension = VFactor.half * settingsRndExtension;
		Int obj = (Int)_nodes[num].MinorRandomExtension;
		Int3 @int = new Int3(obj.i, obj.i, obj.i);
		_nodes[num].AABB.min = aabb.min - @int;
		_nodes[num].AABB.max = aabb.max + @int;
		_nodes[num].UserData = userData;
		_nodes[num].LeafCount = 1;
		InsertLeaf(num);
		return num;
	}

	public void UpdateProxy(T userData)
	{
		_nodes[userData.ID].MinorRandomExtension = VFactor.half * settingsRndExtension;
		Int obj = (Int)_nodes[userData.ID].MinorRandomExtension;
		Int3 @int = new Int3(obj.i, obj.i, obj.i);
		_nodes[userData.ID].AABB.min = userData.GetABBB().min - @int;
		_nodes[userData.ID].AABB.max = userData.GetABBB().max + @int;
	}

	public int AddProxy(T shape)
	{
		ABOX aabb = shape.GetABBB();
		shape.ID = AddProxy(ref aabb, shape);
		return shape.ID;
	}

	public void RemoveProxy(T shape)
	{
		RemoveLeaf(shape.ID);
	}

	public void Update()
	{
		mInvalidNodes.Clear();
		if (_root != -1)
		{
			UpdateNodeHelper(_root);
			int num = -1;
			for (int i = 0; i < mInvalidNodes.Count; i++)
			{
				num = mInvalidNodes[i];
				T userData = GetUserData(num);
				RemoveLeaf(num);
				AddProxy(userData);
			}
			mInvalidNodes.Clear();
		}
	}

	private void UpdateNodeHelper(int index)
	{
		if (_nodes[index].IsLeaf())
		{
			if (_nodes[index].AABB.Contains(_nodes[index].UserData.GetABBB()) != ABOX.IntersectType.Contains)
			{
				mInvalidNodes.Add(index);
			}
		}
		else
		{
			UpdateNodeHelper(_nodes[index].Child1);
			UpdateNodeHelper(_nodes[index].Child2);
		}
	}

	private void InsertLeaf(int leaf)
	{
		_insertionCount++;
		if (_root == -1)
		{
			_root = leaf;
			_nodes[_root].ParentOrNext = -1;
			return;
		}
		ABOX additional = _nodes[leaf].AABB;
		int num = _root;
		while (!_nodes[num].IsLeaf())
		{
			int child = _nodes[num].Child1;
			int child2 = _nodes[num].Child2;
			ABOX.CreateMerged(ref _nodes[num].AABB, ref additional, out _nodes[num].AABB);
			_nodes[num].LeafCount++;
			long perimeter = _nodes[num].AABB.Perimeter;
			ABOX result = default(ABOX);
			ABOX.CreateMerged(ref _nodes[num].AABB, ref additional, out result);
			long perimeter2 = result.Perimeter;
			long num2 = 2 * perimeter2;
			long num3 = 2 * (perimeter2 - perimeter);
			long num4 = 0L;
			if (_nodes[child].IsLeaf())
			{
				ABOX result2 = default(ABOX);
				ABOX.CreateMerged(ref additional, ref _nodes[child].AABB, out result2);
				num4 = result2.Perimeter + num3;
			}
			else
			{
				ABOX result3 = default(ABOX);
				ABOX.CreateMerged(ref additional, ref _nodes[child].AABB, out result3);
				long perimeter3 = _nodes[child].AABB.Perimeter;
				long perimeter4 = result3.Perimeter;
				num4 = perimeter4 - perimeter3 + num3;
			}
			long num5 = 0L;
			if (_nodes[child2].IsLeaf())
			{
				ABOX result4 = default(ABOX);
				ABOX.CreateMerged(ref additional, ref _nodes[child2].AABB, out result4);
				num5 = result4.Perimeter + num3;
			}
			else
			{
				ABOX result5 = default(ABOX);
				ABOX.CreateMerged(ref additional, ref _nodes[child2].AABB, out result5);
				long perimeter5 = _nodes[child2].AABB.Perimeter;
				long perimeter6 = result5.Perimeter;
				num5 = perimeter6 - perimeter5 + num3;
			}
			if (num2 < num4 && num2 < num5)
			{
				break;
			}
			ABOX.CreateMerged(ref additional, ref _nodes[num].AABB, out _nodes[num].AABB);
			num = ((num4 >= num5) ? child2 : child);
		}
		int parentOrNext = _nodes[num].ParentOrNext;
		int num6 = AllocateNode();
		_nodes[num6].ParentOrNext = parentOrNext;
		_nodes[num6].UserData = default(T);
		ABOX.CreateMerged(ref additional, ref _nodes[num].AABB, out _nodes[num6].AABB);
		_nodes[num6].LeafCount = _nodes[num].LeafCount + 1;
		if (parentOrNext != -1)
		{
			if (_nodes[parentOrNext].Child1 == num)
			{
				_nodes[parentOrNext].Child1 = num6;
			}
			else
			{
				_nodes[parentOrNext].Child2 = num6;
			}
			_nodes[num6].Child1 = num;
			_nodes[num6].Child2 = leaf;
			_nodes[num].ParentOrNext = num6;
			_nodes[leaf].ParentOrNext = num6;
		}
		else
		{
			_nodes[num6].Child1 = num;
			_nodes[num6].Child2 = leaf;
			_nodes[num].ParentOrNext = num6;
			_nodes[leaf].ParentOrNext = num6;
			_root = num6;
		}
	}

	private void RemoveLeaf(int leaf)
	{
		if (leaf == _root)
		{
			_root = -1;
			return;
		}
		int parentOrNext = _nodes[leaf].ParentOrNext;
		int parentOrNext2 = _nodes[parentOrNext].ParentOrNext;
		int num = ((_nodes[parentOrNext].Child1 != leaf) ? _nodes[parentOrNext].Child1 : _nodes[parentOrNext].Child2);
		if (parentOrNext2 != -1)
		{
			if (_nodes[parentOrNext2].Child1 == parentOrNext)
			{
				_nodes[parentOrNext2].Child1 = num;
			}
			else
			{
				_nodes[parentOrNext2].Child2 = num;
			}
			_nodes[num].ParentOrNext = parentOrNext2;
			FreeNode(parentOrNext);
			for (parentOrNext = parentOrNext2; parentOrNext != -1; parentOrNext = _nodes[parentOrNext].ParentOrNext)
			{
				ABOX.CreateMerged(ref _nodes[_nodes[parentOrNext].Child1].AABB, ref _nodes[_nodes[parentOrNext].Child2].AABB, out _nodes[parentOrNext].AABB);
				_nodes[parentOrNext].LeafCount--;
			}
		}
		else
		{
			_root = num;
			_nodes[num].ParentOrNext = -1;
			FreeNode(parentOrNext);
		}
		FreeNode(leaf);
	}

	public void Query(Int3 origin, Int3 direction, List<int> collisions)
	{
		stack.Clear();
		stack.Push(_root);
		while (stack.Count > 0)
		{
			int num = stack.Pop();
			if (num == -1)
			{
				continue;
			}
			DynamicTreeNode<T> dynamicTreeNode = _nodes[num];
			if ((dynamicTreeNode.UserData == null || dynamicTreeNode.UserData.IsEnable) && dynamicTreeNode.AABB.RayIntersect(ref origin, ref direction))
			{
				if (dynamicTreeNode.IsLeaf())
				{
					collisions.Add(num);
					continue;
				}
				stack.Push(dynamicTreeNode.Child1);
				stack.Push(dynamicTreeNode.Child2);
			}
		}
	}

	public void Query(List<int> my, ref ABOX aabb)
	{
		stack.Clear();
		stack.Push(_root);
		while (stack.Count > 0)
		{
			int num = stack.Pop();
			if (num == -1)
			{
				continue;
			}
			DynamicTreeNode<T> dynamicTreeNode = _nodes[num];
			if ((dynamicTreeNode.UserData == null || dynamicTreeNode.UserData.IsEnable) && aabb.IsOverlay(ref dynamicTreeNode.AABB))
			{
				if (dynamicTreeNode.IsLeaf())
				{
					my.Add(num);
					continue;
				}
				stack.Push(dynamicTreeNode.Child1);
				stack.Push(dynamicTreeNode.Child2);
			}
		}
	}

	public void Query(List<int> other, List<int> my, DynamicTree<T> tree)
	{
		Stack<int> stack = StackPool<int>.Claim();
		Stack<int> stack2 = StackPool<int>.Claim();
		stack.Push(_root);
		stack2.Push(tree._root);
		while (stack.Count > 0)
		{
			int num = stack.Pop();
			int num2 = stack2.Pop();
			if (num != -1 && num2 != -1 && tree._nodes[num2].AABB.Contains(ref _nodes[num].AABB) != ABOX.IntersectType.Disjoint)
			{
				if (_nodes[num].IsLeaf() && tree._nodes[num2].IsLeaf())
				{
					my.Add(num);
					other.Add(num2);
					continue;
				}
				if (tree._nodes[num2].IsLeaf())
				{
					stack.Push(_nodes[num].Child1);
					stack2.Push(num2);
					stack.Push(_nodes[num].Child2);
					stack2.Push(num2);
					continue;
				}
				if (_nodes[num].IsLeaf())
				{
					stack.Push(num);
					stack2.Push(tree._nodes[num2].Child1);
					stack.Push(num);
					stack2.Push(tree._nodes[num2].Child2);
					continue;
				}
				stack.Push(_nodes[num].Child1);
				stack2.Push(tree._nodes[num2].Child1);
				stack.Push(_nodes[num].Child1);
				stack2.Push(tree._nodes[num2].Child2);
				stack.Push(_nodes[num].Child2);
				stack2.Push(tree._nodes[num2].Child1);
				stack.Push(_nodes[num].Child2);
				stack2.Push(tree._nodes[num2].Child2);
			}
		}
		StackPool<int>.Release(stack);
		StackPool<int>.Release(stack2);
	}

	public T GetUserData(int proxyId)
	{
		return _nodes[proxyId].UserData;
	}

	public void GetFatAABB(int proxyId, out ABOX fatAABB)
	{
		fatAABB = _nodes[proxyId].AABB;
	}

	private int CountLeaves(int nodeId)
	{
		if (nodeId == -1)
		{
			return 0;
		}
		XLogger.Assert(0 <= nodeId && nodeId < _nodeCapacity, "0 <= nodeId && nodeId < _nodeCapacity failed!");
		DynamicTreeNode<T> dynamicTreeNode = _nodes[nodeId];
		if (dynamicTreeNode.IsLeaf())
		{
			XLogger.Assert(dynamicTreeNode.LeafCount == 1, "node.LeafCount == 1 failed!");
			return 1;
		}
		int num = CountLeaves(dynamicTreeNode.Child1);
		int num2 = CountLeaves(dynamicTreeNode.Child2);
		int num3 = num + num2;
		XLogger.Assert(num3 == dynamicTreeNode.LeafCount, "count == node.LeafCount failed!");
		return num3;
	}

	private void Validate()
	{
		CountLeaves(_root);
	}

	public void QueryCollisionPair(ref List<ISimShape> pair)
	{
		pair.Clear();
		if (_root != -1 && !Nodes[_root].IsLeaf())
		{
			ClearChildrenCrossFlagHelper(_root);
			ComputePairsHelper(Nodes[_root].Child1, Nodes[_root].Child2, ref pair);
		}
	}

	private void ComputePairsHelper(int lh, int rh, ref List<ISimShape> pair)
	{
		if (Nodes[lh].IsLeaf())
		{
			if (Nodes[rh].IsLeaf())
			{
				if (Nodes[lh].UserData.Intersects(Nodes[rh].UserData))
				{
					pair.Add(Nodes[lh].UserData);
					pair.Add(Nodes[rh].UserData);
				}
			}
			else
			{
				CrossChildren(rh, ref pair);
				ComputePairsHelper(lh, Nodes[rh].Child1, ref pair);
				ComputePairsHelper(lh, Nodes[rh].Child2, ref pair);
			}
		}
		else if (Nodes[rh].IsLeaf())
		{
			CrossChildren(lh, ref pair);
			ComputePairsHelper(Nodes[lh].Child1, rh, ref pair);
			ComputePairsHelper(Nodes[lh].Child2, rh, ref pair);
		}
		else
		{
			CrossChildren(lh, ref pair);
			CrossChildren(rh, ref pair);
			ComputePairsHelper(Nodes[lh].Child1, Nodes[rh].Child1, ref pair);
			ComputePairsHelper(Nodes[lh].Child1, Nodes[rh].Child2, ref pair);
			ComputePairsHelper(Nodes[lh].Child2, Nodes[rh].Child1, ref pair);
			ComputePairsHelper(Nodes[lh].Child2, Nodes[rh].Child2, ref pair);
		}
	}

	private void CrossChildren(int index, ref List<ISimShape> pair)
	{
		if (!Nodes[index].childrenCrossed)
		{
			ComputePairsHelper(Nodes[index].Child1, Nodes[index].Child2, ref pair);
			Nodes[index].childrenCrossed = true;
		}
	}

	private void ClearChildrenCrossFlagHelper(int index)
	{
		Nodes[index].childrenCrossed = false;
		if (!Nodes[index].IsLeaf())
		{
			ClearChildrenCrossFlagHelper(Nodes[index].Child1);
			ClearChildrenCrossFlagHelper(Nodes[index].Child2);
		}
	}

	private int ComputeHeight(int nodeId)
	{
		if (nodeId == -1)
		{
			return 0;
		}
		DynamicTreeNode<T> dynamicTreeNode = _nodes[nodeId];
		int val = ComputeHeight(dynamicTreeNode.Child1);
		int val2 = ComputeHeight(dynamicTreeNode.Child2);
		return 1 + Math.Max(val, val2);
	}

	private void FreeNode(int nodeId)
	{
		_nodes[nodeId].ParentOrNext = _freeList;
		_freeList = nodeId;
		_nodeCount--;
	}

	public void Rebalance(int iterations)
	{
		if (Root == -1)
		{
			return;
		}
		for (int i = 0; i < iterations; i++)
		{
			int num = _root;
			int num2 = 0;
			while (!_nodes[num].IsLeaf())
			{
				num = ((((_path >> num2) & 1) == 0) ? _nodes[num].Child1 : _nodes[num].Child2);
				num2 = (num2 + 1) & 0x1F;
			}
			_path++;
			RemoveLeaf(num);
			InsertLeaf(num);
		}
	}
}
