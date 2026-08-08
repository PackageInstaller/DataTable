using System;
using System.Collections.Generic;

namespace Pathfinding;

public class PointKDTree
{
	private struct Node
	{
		public List<GraphNode> data;

		public int split;

		public byte splitAxis;
	}

	private class CompareX : IComparer<GraphNode>
	{
		public int Compare(GraphNode lhs, GraphNode rhs)
		{
			return lhs.position.x.CompareTo(rhs.position.x);
		}
	}

	private class CompareY : IComparer<GraphNode>
	{
		public int Compare(GraphNode lhs, GraphNode rhs)
		{
			return lhs.position.y.CompareTo(rhs.position.y);
		}
	}

	private class CompareZ : IComparer<GraphNode>
	{
		public int Compare(GraphNode lhs, GraphNode rhs)
		{
			return lhs.position.z.CompareTo(rhs.position.z);
		}
	}

	public static int LeafSize = 10;

	private Node[] tree = new Node[16];

	private int numNodes;

	private readonly List<GraphNode> largeList = new List<GraphNode>();

	private readonly Stack<List<GraphNode>> listCache = new Stack<List<GraphNode>>();

	private static readonly IComparer<GraphNode>[] comparers = new IComparer<GraphNode>[3]
	{
		new CompareX(),
		new CompareY(),
		new CompareZ()
	};

	public PointKDTree()
	{
		tree[1] = new Node
		{
			data = GetOrCreateList()
		};
	}

	public void Add(GraphNode node)
	{
		numNodes++;
		Add(node, 1);
	}

	public void Rebuild(GraphNode[] nodes, int start, int end)
	{
		if (start < 0 || end < start || end > nodes.Length)
		{
			throw new ArgumentException();
		}
		for (int i = 0; i < tree.Length; i++)
		{
			if (tree[i].data != null)
			{
				tree[i].data.Clear();
				listCache.Push(tree[i].data);
				tree[i].data = null;
			}
		}
		numNodes = end - start;
		Build(1, new List<GraphNode>(nodes), start, end);
	}

	private List<GraphNode> GetOrCreateList()
	{
		if (listCache.Count <= 0)
		{
			return new List<GraphNode>(LeafSize * 2 + 1);
		}
		return listCache.Pop();
	}

	private int Size(int index)
	{
		if (tree[index].data == null)
		{
			return Size(2 * index) + Size(2 * index + 1);
		}
		return tree[index].data.Count;
	}

	private void CollectAndClear(int index, List<GraphNode> buffer)
	{
		List<GraphNode> data = tree[index].data;
		if (data != null)
		{
			tree[index] = default(Node);
			for (int i = 0; i < data.Count; i++)
			{
				buffer.Add(data[i]);
			}
			data.Clear();
			listCache.Push(data);
		}
		else
		{
			CollectAndClear(index * 2, buffer);
			CollectAndClear(index * 2 + 1, buffer);
		}
	}

	private static int MaxAllowedSize(int numNodes, int depth)
	{
		return Math.Min(5 * numNodes / 2 >> depth, 3 * numNodes / 4);
	}

	private void Rebalance(int index)
	{
		CollectAndClear(index, largeList);
		Build(index, largeList, 0, largeList.Count);
		largeList.Clear();
	}

	private void EnsureSize(int index)
	{
		if (index >= tree.Length)
		{
			Node[] array = new Node[Math.Max(index + 1, tree.Length * 2)];
			tree.CopyTo(array, 0);
			tree = array;
		}
	}

	private void Build(int index, List<GraphNode> nodes, int start, int end)
	{
		EnsureSize(index);
		if (end - start <= LeafSize)
		{
			tree[index].data = GetOrCreateList();
			for (int i = start; i < end; i++)
			{
				tree[index].data.Add(nodes[i]);
			}
			return;
		}
		Int3 int2;
		Int3 @int = (int2 = nodes[start].position);
		for (int j = start; j < end; j++)
		{
			Int3 position = nodes[j].position;
			@int = new Int3(Math.Min(@int.x, position.x), Math.Min(@int.y, position.y), Math.Min(@int.z, position.z));
			int2 = new Int3(Math.Max(int2.x, position.x), Math.Max(int2.y, position.y), Math.Max(int2.z, position.z));
		}
		Int3 int3 = int2 - @int;
		int num = ((int3.x <= int3.y) ? ((int3.y > int3.z) ? 1 : 2) : ((int3.x <= int3.z) ? 2 : 0));
		nodes.Sort(start, end - start, comparers[num]);
		int num2 = (start + end) / 2;
		tree[index].split = (nodes[num2 - 1].position[num] + nodes[num2].position[num] + 1) / 2;
		tree[index].splitAxis = (byte)num;
		Build(index * 2, nodes, start, num2);
		Build(index * 2 + 1, nodes, num2, end);
	}

	private void Add(GraphNode point, int index, int depth = 0)
	{
		while (tree[index].data == null)
		{
			index = 2 * index + ((point.position[tree[index].splitAxis] >= tree[index].split) ? 1 : 0);
			depth++;
		}
		tree[index].data.Add(point);
		if (tree[index].data.Count > LeafSize * 2)
		{
			int i;
			for (i = 0; depth - i > 0 && Size(index >> i) > MaxAllowedSize(numNodes, depth - i); i++)
			{
			}
			Rebalance(index >> i);
		}
	}

	public GraphNode GetNearest(Int3 point, NNConstraint constraint)
	{
		GraphNode best = null;
		long bestSqrDist = long.MaxValue;
		GetNearestInternal(1, point, constraint, ref best, ref bestSqrDist);
		return best;
	}

	private void GetNearestInternal(int index, Int3 point, NNConstraint constraint, ref GraphNode best, ref long bestSqrDist)
	{
		List<GraphNode> data = tree[index].data;
		if (data != null)
		{
			for (int num = data.Count - 1; num >= 0; num--)
			{
				long sqrMagnitudeLong = (data[num].position - point).sqrMagnitudeLong;
				if (sqrMagnitudeLong < bestSqrDist && (constraint == null || constraint.Suitable(data[num])))
				{
					bestSqrDist = sqrMagnitudeLong;
					best = data[num];
				}
			}
		}
		else
		{
			long num2 = point[tree[index].splitAxis] - tree[index].split;
			int num3 = 2 * index + ((num2 >= 0) ? 1 : 0);
			GetNearestInternal(num3, point, constraint, ref best, ref bestSqrDist);
			if (num2 * num2 < bestSqrDist)
			{
				GetNearestInternal(num3 ^ 1, point, constraint, ref best, ref bestSqrDist);
			}
		}
	}

	public void GetInRange(Int3 point, long sqrRadius, List<GraphNode> buffer)
	{
		GetInRangeInternal(1, point, sqrRadius, buffer);
	}

	private void GetInRangeInternal(int index, Int3 point, long sqrRadius, List<GraphNode> buffer)
	{
		List<GraphNode> data = tree[index].data;
		if (data != null)
		{
			for (int num = data.Count - 1; num >= 0; num--)
			{
				long sqrMagnitudeLong = (data[num].position - point).sqrMagnitudeLong;
				if (sqrMagnitudeLong < sqrRadius)
				{
					buffer.Add(data[num]);
				}
			}
		}
		else
		{
			long num2 = point[tree[index].splitAxis] - tree[index].split;
			int num3 = 2 * index + ((num2 >= 0) ? 1 : 0);
			GetInRangeInternal(num3, point, sqrRadius, buffer);
			if (num2 * num2 < sqrRadius)
			{
				GetInRangeInternal(num3 ^ 1, point, sqrRadius, buffer);
			}
		}
	}
}
