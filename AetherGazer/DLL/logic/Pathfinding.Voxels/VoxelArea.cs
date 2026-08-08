using System;
using UnityEngine;

namespace Pathfinding.Voxels;

public class VoxelArea
{
	public const uint MaxHeight = 65536u;

	public const int MaxHeightInt = 65536;

	public const uint InvalidSpanValue = uint.MaxValue;

	public const float AvgSpanLayerCountEstimate = 8f;

	public readonly int width;

	public readonly int depth;

	public CompactVoxelSpan[] compactSpans;

	public CompactVoxelCell[] compactCells;

	public int compactSpanCount;

	public ushort[] tmpUShortArr;

	public int[] areaTypes;

	public ushort[] dist;

	public ushort maxDistance;

	public int maxRegions;

	public int[] DirectionX;

	public int[] DirectionZ;

	public Vector3[] VectorDirection;

	private int linkedSpanCount;

	public LinkedVoxelSpan[] linkedSpans;

	private int[] removedStack;

	private int removedStackCount;

	public void Reset()
	{
		ResetLinkedVoxelSpans();
		for (int i = 0; i < compactCells.Length; i++)
		{
			compactCells[i].count = 0u;
			compactCells[i].index = 0u;
		}
	}

	private void ResetLinkedVoxelSpans()
	{
		int num = linkedSpans.Length;
		linkedSpanCount = width * depth;
		LinkedVoxelSpan linkedVoxelSpan = new LinkedVoxelSpan(uint.MaxValue, uint.MaxValue, -1, -1);
		int num2;
		for (num2 = 0; num2 < num; num2++)
		{
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
			num2++;
			linkedSpans[num2] = linkedVoxelSpan;
		}
		removedStackCount = 0;
	}

	public VoxelArea(int width, int depth)
	{
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		removedStack = new int[128];
		base._002Ector();
		this.width = width;
		this.depth = depth;
		int num = width * depth;
		compactCells = new CompactVoxelCell[num];
		linkedSpans = new LinkedVoxelSpan[((int)((float)num * 8f) + 15) & -16];
		ResetLinkedVoxelSpans();
		DirectionX = new int[4] { -1, 0, 1, 0 };
		DirectionZ = new int[4]
		{
			0,
			width,
			0,
			-width
		};
		VectorDirection = (Vector3[])(object)new Vector3[4]
		{
			Vector3.left,
			Vector3.forward,
			Vector3.right,
			Vector3.back
		};
	}

	public int GetSpanCountAll()
	{
		int num = 0;
		int num2 = width * depth;
		for (int i = 0; i < num2; i++)
		{
			int num3 = i;
			while (num3 != -1 && linkedSpans[num3].bottom != uint.MaxValue)
			{
				num++;
				num3 = linkedSpans[num3].next;
			}
		}
		return num;
	}

	public int GetSpanCount()
	{
		int num = 0;
		int num2 = width * depth;
		for (int i = 0; i < num2; i++)
		{
			int num3 = i;
			while (num3 != -1 && linkedSpans[num3].bottom != uint.MaxValue)
			{
				if (linkedSpans[num3].area != 0)
				{
					num++;
				}
				num3 = linkedSpans[num3].next;
			}
		}
		return num;
	}

	private void PushToSpanRemovedStack(int index)
	{
		if (removedStackCount == removedStack.Length)
		{
			int[] dst = new int[removedStackCount * 4];
			Buffer.BlockCopy(removedStack, 0, dst, 0, removedStackCount * 4);
			removedStack = dst;
		}
		removedStack[removedStackCount] = index;
		removedStackCount++;
	}

	public void AddLinkedSpan(int index, uint bottom, uint top, int area, int voxelWalkableClimb)
	{
		if (linkedSpans[index].bottom == uint.MaxValue)
		{
			linkedSpans[index] = new LinkedVoxelSpan(bottom, top, area);
			return;
		}
		int num = -1;
		int num2 = index;
		while (index != -1 && linkedSpans[index].bottom <= top)
		{
			if (linkedSpans[index].top < bottom)
			{
				num = index;
				index = linkedSpans[index].next;
				continue;
			}
			bottom = Math.Min(linkedSpans[index].bottom, bottom);
			top = Math.Max(linkedSpans[index].top, top);
			if (Math.Abs((int)(top - linkedSpans[index].top)) <= voxelWalkableClimb)
			{
				area = Math.Max(area, linkedSpans[index].area);
			}
			int next = linkedSpans[index].next;
			if (num != -1)
			{
				linkedSpans[num].next = next;
				PushToSpanRemovedStack(index);
				index = next;
				continue;
			}
			if (next != -1)
			{
				linkedSpans[num2] = linkedSpans[next];
				PushToSpanRemovedStack(next);
				continue;
			}
			linkedSpans[num2] = new LinkedVoxelSpan(bottom, top, area);
			return;
		}
		if (linkedSpanCount >= linkedSpans.Length)
		{
			LinkedVoxelSpan[] array = linkedSpans;
			int num3 = linkedSpanCount;
			int num4 = removedStackCount;
			linkedSpans = new LinkedVoxelSpan[linkedSpans.Length * 2];
			ResetLinkedVoxelSpans();
			linkedSpanCount = num3;
			removedStackCount = num4;
			for (int i = 0; i < linkedSpanCount; i++)
			{
				linkedSpans[i] = array[i];
			}
			Debug.Log((object)"Layer estimate too low, doubling size of buffer.\nThis message is harmless.");
		}
		int num5;
		if (removedStackCount > 0)
		{
			removedStackCount--;
			num5 = removedStack[removedStackCount];
		}
		else
		{
			num5 = linkedSpanCount;
			linkedSpanCount++;
		}
		if (num != -1)
		{
			linkedSpans[num5] = new LinkedVoxelSpan(bottom, top, area, linkedSpans[num].next);
			linkedSpans[num].next = num5;
		}
		else
		{
			linkedSpans[num5] = linkedSpans[num2];
			linkedSpans[num2] = new LinkedVoxelSpan(bottom, top, area, num5);
		}
	}
}
