using System;

namespace Pathfinding;

public class BinaryHeap
{
	private struct Tuple(uint f, PathNode node)
	{
		public uint F = f;

		public PathNode node = node;
	}

	public int numberOfItems;

	public float growthFactor = 2f;

	private const int D = 4;

	private const bool SortGScores = true;

	private Tuple[] heap;

	public bool isEmpty => numberOfItems <= 0;

	private static int RoundUpToNextMultipleMod1(int v)
	{
		return v + (4 - (v - 1) % 4) % 4;
	}

	public BinaryHeap(int capacity)
	{
		capacity = RoundUpToNextMultipleMod1(capacity);
		heap = new Tuple[capacity];
		numberOfItems = 0;
	}

	public void Clear()
	{
		numberOfItems = 0;
	}

	internal PathNode GetNode(int i)
	{
		return heap[i].node;
	}

	internal void SetF(int i, uint f)
	{
		heap[i].F = f;
	}

	private void Expand()
	{
		int v = Math.Max(heap.Length + 4, (int)Math.Round((float)heap.Length * growthFactor));
		v = RoundUpToNextMultipleMod1(v);
		if (v > 262144)
		{
			throw new Exception("Binary Heap Size really large (2^18). A heap size this large is probably the cause of pathfinding running in an infinite loop. \nRemove this check (in BinaryHeap.cs) if you are sure that it is not caused by a bug");
		}
		Tuple[] array = new Tuple[v];
		for (int i = 0; i < heap.Length; i++)
		{
			array[i] = heap[i];
		}
		heap = array;
	}

	public void Add(PathNode node)
	{
		if (node == null)
		{
			throw new ArgumentNullException("node");
		}
		if (numberOfItems == heap.Length)
		{
			Expand();
		}
		int num = numberOfItems;
		uint f = node.F;
		uint g = node.G;
		while (num != 0)
		{
			int num2 = (num - 1) / 4;
			if (f >= heap[num2].F && (f != heap[num2].F || g <= heap[num2].node.G))
			{
				break;
			}
			heap[num] = heap[num2];
			num = num2;
		}
		heap[num] = new Tuple(f, node);
		numberOfItems++;
	}

	public PathNode Remove()
	{
		numberOfItems--;
		PathNode node = heap[0].node;
		Tuple tuple = heap[numberOfItems];
		uint g = tuple.node.G;
		int num = 0;
		while (true)
		{
			int num2 = num;
			uint num3 = tuple.F;
			int num4 = num2 * 4 + 1;
			if (num4 <= numberOfItems)
			{
				uint f = heap[num4].F;
				uint f2 = heap[num4 + 1].F;
				uint f3 = heap[num4 + 2].F;
				uint f4 = heap[num4 + 3].F;
				if (num4 < numberOfItems && (f < num3 || (f == num3 && heap[num4].node.G < g)))
				{
					num3 = f;
					num = num4;
				}
				if (num4 + 1 < numberOfItems && (f2 < num3 || (f2 == num3 && heap[num4 + 1].node.G < ((num == num2) ? g : heap[num].node.G))))
				{
					num3 = f2;
					num = num4 + 1;
				}
				if (num4 + 2 < numberOfItems && (f3 < num3 || (f3 == num3 && heap[num4 + 2].node.G < ((num == num2) ? g : heap[num].node.G))))
				{
					num3 = f3;
					num = num4 + 2;
				}
				if (num4 + 3 < numberOfItems && (f4 < num3 || (f4 == num3 && heap[num4 + 3].node.G < ((num == num2) ? g : heap[num].node.G))))
				{
					num = num4 + 3;
				}
			}
			if (num2 == num)
			{
				break;
			}
			heap[num2] = heap[num];
		}
		heap[num] = tuple;
		return node;
	}

	private void Validate()
	{
		for (int i = 1; i < numberOfItems; i++)
		{
			int num = (i - 1) / 4;
			if (heap[num].F > heap[i].F)
			{
				throw new Exception("Invalid state at " + i + ":" + num + " ( " + heap[num].F + " > " + heap[i].F + " ) ");
			}
		}
	}

	public void Rebuild()
	{
		for (int i = 2; i < numberOfItems; i++)
		{
			int num = i;
			Tuple tuple = heap[i];
			uint f = tuple.F;
			while (num != 1)
			{
				int num2 = num / 4;
				if (f >= heap[num2].F)
				{
					break;
				}
				heap[num] = heap[num2];
				heap[num2] = tuple;
				num = num2;
			}
		}
	}
}
