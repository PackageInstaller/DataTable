using System;
using System.Collections.Generic;
using System.Text;

namespace Pathfinding;

public class PathHandler
{
	private ushort pathID;

	public readonly int threadID;

	public readonly int totalThreadCount;

	public readonly BinaryHeap heap = new BinaryHeap(128);

	private const int BucketSizeLog2 = 10;

	private const int BucketSize = 1024;

	private const int BucketIndexMask = 1023;

	public PathNode[][] nodes = new PathNode[0][];

	private bool[] bucketNew = new bool[0];

	private bool[] bucketCreated = new bool[0];

	private Stack<PathNode[]> bucketCache = new Stack<PathNode[]>();

	private int filledBuckets;

	public readonly StringBuilder DebugStringBuilder = new StringBuilder();

	public ushort PathID => pathID;

	public PathHandler(int threadID, int totalThreadCount)
	{
		this.threadID = threadID;
		this.totalThreadCount = totalThreadCount;
	}

	public void InitializeForPath(Path p)
	{
		pathID = p.pathID;
		heap.Clear();
	}

	public void DestroyNode(GraphNode node)
	{
		PathNode pathNode = GetPathNode(node);
		pathNode.node = null;
		pathNode.parent = null;
		pathNode.pathID = 0;
		pathNode.G = 0u;
		pathNode.H = 0u;
	}

	public void InitializeNode(GraphNode node)
	{
		int nodeIndex = node.NodeIndex;
		int num = nodeIndex >> 10;
		int num2 = nodeIndex & 0x3FF;
		if (num >= nodes.Length)
		{
			PathNode[][] array = new PathNode[Math.Max(Math.Max(nodes.Length * 3 / 2, num + 1), nodes.Length + 2)][];
			for (int i = 0; i < nodes.Length; i++)
			{
				array[i] = nodes[i];
			}
			bool[] array2 = new bool[array.Length];
			for (int j = 0; j < nodes.Length; j++)
			{
				array2[j] = bucketNew[j];
			}
			bool[] array3 = new bool[array.Length];
			for (int k = 0; k < nodes.Length; k++)
			{
				array3[k] = bucketCreated[k];
			}
			nodes = array;
			bucketNew = array2;
			bucketCreated = array3;
		}
		if (nodes[num] == null)
		{
			PathNode[] array4;
			if (bucketCache.Count > 0)
			{
				array4 = bucketCache.Pop();
			}
			else
			{
				array4 = new PathNode[1024];
				for (int l = 0; l < 1024; l++)
				{
					array4[l] = new PathNode();
				}
			}
			nodes[num] = array4;
			if (!bucketCreated[num])
			{
				bucketNew[num] = true;
				bucketCreated[num] = true;
			}
			filledBuckets++;
		}
		PathNode pathNode = nodes[num][num2];
		pathNode.node = node;
	}

	public PathNode GetPathNode(int nodeIndex)
	{
		return nodes[nodeIndex >> 10][nodeIndex & 0x3FF];
	}

	public PathNode GetPathNode(GraphNode node)
	{
		int nodeIndex = node.NodeIndex;
		return nodes[nodeIndex >> 10][nodeIndex & 0x3FF];
	}

	public void ClearPathIDs()
	{
		for (int i = 0; i < nodes.Length; i++)
		{
			PathNode[] array = nodes[i];
			if (array != null)
			{
				for (int j = 0; j < 1024; j++)
				{
					array[j].pathID = 0;
				}
			}
		}
	}
}
