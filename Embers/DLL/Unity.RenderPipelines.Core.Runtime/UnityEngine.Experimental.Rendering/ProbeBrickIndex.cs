using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

internal class ProbeBrickIndex
{
	[Serializable]
	[DebuggerDisplay("Brick [{position}, {subdivisionLevel}]")]
	public struct Brick : IEquatable<Brick>
	{
		public Vector3Int position;

		public int subdivisionLevel;

		internal Brick(Vector3Int position, int subdivisionLevel)
		{
			this.position = position;
			this.subdivisionLevel = subdivisionLevel;
		}

		public bool Equals(Brick other)
		{
			if (position == other.position)
			{
				return subdivisionLevel == other.subdivisionLevel;
			}
			return false;
		}
	}

	[DebuggerDisplay("Brick [{brick.position}, {brick.subdivisionLevel}], {flattenedIdx}")]
	private struct ReservedBrick
	{
		public Brick brick;

		public int flattenedIdx;
	}

	private struct VoxelMeta
	{
		public ProbeReferenceVolume.RegId id;

		public List<ushort> brickIndices;
	}

	private struct BrickMeta
	{
		public HashSet<Vector3Int> voxels;

		public List<ReservedBrick> bricks;
	}

	public struct CellIndexUpdateInfo
	{
		public int firstChunkIndex;

		public int numberOfChunks;

		public int minSubdivInCell;

		public Vector3Int minValidBrickIndexForCellAtMaxRes;

		public Vector3Int maxValidBrickIndexForCellAtMaxResPlusOne;

		public Vector3Int cellPositionInBricksAtMaxRes;
	}

	internal const int kMaxSubdivisionLevels = 7;

	internal const int kIndexChunkSize = 243;

	private BitArray m_IndexChunks;

	private int m_IndexInChunks;

	private int m_NextFreeChunk;

	private ComputeBuffer m_PhysicalIndexBuffer;

	private int[] m_PhysicalIndexBufferData;

	private Vector3Int m_CenterRS;

	private Dictionary<Vector3Int, List<VoxelMeta>> m_VoxelToBricks;

	private Dictionary<ProbeReferenceVolume.RegId, BrickMeta> m_BricksToVoxels;

	private bool m_NeedUpdateIndexComputeBuffer;

	internal int estimatedVMemCost { get; private set; }

	private int GetVoxelSubdivLevel()
	{
		return Mathf.Min(3, ProbeReferenceVolume.instance.GetMaxSubdivision() - 1);
	}

	private int SizeOfPhysicalIndexFromBudget(ProbeVolumeTextureMemoryBudget memoryBudget)
	{
		return memoryBudget switch
		{
			ProbeVolumeTextureMemoryBudget.MemoryBudgetLow => 16000000, 
			ProbeVolumeTextureMemoryBudget.MemoryBudgetMedium => 32000000, 
			ProbeVolumeTextureMemoryBudget.MemoryBudgetHigh => 64000000, 
			_ => 32000000, 
		};
	}

	internal ProbeBrickIndex(ProbeVolumeTextureMemoryBudget memoryBudget)
	{
		m_CenterRS = new Vector3Int(0, 0, 0);
		m_VoxelToBricks = new Dictionary<Vector3Int, List<VoxelMeta>>();
		m_BricksToVoxels = new Dictionary<ProbeReferenceVolume.RegId, BrickMeta>();
		m_NeedUpdateIndexComputeBuffer = false;
		m_IndexInChunks = Mathf.CeilToInt((float)SizeOfPhysicalIndexFromBudget(memoryBudget) / 243f);
		m_IndexChunks = new BitArray(Mathf.Max(1, m_IndexInChunks));
		int num = m_IndexInChunks * 243;
		m_PhysicalIndexBufferData = new int[num];
		m_PhysicalIndexBuffer = new ComputeBuffer(num, 4, ComputeBufferType.Structured);
		m_NextFreeChunk = 0;
		estimatedVMemCost = num * 4;
		Clear();
	}

	internal void UploadIndexData()
	{
		m_PhysicalIndexBuffer.SetData(m_PhysicalIndexBufferData);
		m_NeedUpdateIndexComputeBuffer = false;
	}

	internal void Clear()
	{
		for (int i = 0; i < m_PhysicalIndexBufferData.Length; i++)
		{
			m_PhysicalIndexBufferData[i] = -1;
		}
		m_NeedUpdateIndexComputeBuffer = true;
		m_NextFreeChunk = 0;
		m_IndexChunks.SetAll(value: false);
		m_VoxelToBricks.Clear();
		m_BricksToVoxels.Clear();
	}

	private void MapBrickToVoxels(Brick brick, HashSet<Vector3Int> voxels)
	{
		int subdivisionLevel = brick.subdivisionLevel;
		int num = (int)Mathf.Pow(3f, Mathf.Max(0, subdivisionLevel - GetVoxelSubdivLevel()));
		Vector3Int vector3Int = brick.position;
		int num2 = ProbeReferenceVolume.CellSize(brick.subdivisionLevel);
		int num3 = ProbeReferenceVolume.CellSize(GetVoxelSubdivLevel());
		if (num <= 1)
		{
			Vector3 vector = brick.position;
			vector *= 1f / (float)num3;
			vector3Int = new Vector3Int(Mathf.FloorToInt(vector.x) * num3, Mathf.FloorToInt(vector.y) * num3, Mathf.FloorToInt(vector.z) * num3);
		}
		for (int i = vector3Int.z; i < vector3Int.z + num2; i += num3)
		{
			for (int j = vector3Int.y; j < vector3Int.y + num2; j += num3)
			{
				for (int k = vector3Int.x; k < vector3Int.x + num2; k += num3)
				{
					voxels.Add(new Vector3Int(k, j, i));
				}
			}
		}
	}

	private void ClearVoxel(Vector3Int pos, CellIndexUpdateInfo cellInfo)
	{
		ClipToIndexSpace(pos, GetVoxelSubdivLevel(), out var outMinpos, out var outMaxpos, cellInfo);
		UpdatePhysicalIndex(outMinpos, outMaxpos, -1, cellInfo);
	}

	internal void GetRuntimeResources(ref ProbeReferenceVolume.RuntimeResources rr)
	{
		if (m_NeedUpdateIndexComputeBuffer)
		{
			UploadIndexData();
		}
		rr.index = m_PhysicalIndexBuffer;
	}

	internal void Cleanup()
	{
		CoreUtils.SafeRelease(m_PhysicalIndexBuffer);
		m_PhysicalIndexBuffer = null;
	}

	private int MergeIndex(int index, int size)
	{
		return (index & -1879048193) | ((size & 7) << 28);
	}

	internal bool AssignIndexChunksToCell(ProbeReferenceVolume.Cell cell, int bricksCount, ref CellIndexUpdateInfo cellUpdateInfo)
	{
		int num = Mathf.CeilToInt((float)bricksCount / 243f);
		int num2 = -1;
		for (int i = 0; i < m_IndexInChunks; i++)
		{
			if (!m_IndexChunks[i] && i + num < m_IndexInChunks)
			{
				int num3 = 0;
				for (int j = i; j < i + num && !m_IndexChunks[j]; j++)
				{
					num3++;
				}
				if (num3 == num)
				{
					num2 = i;
					break;
				}
			}
		}
		if (num2 < 0)
		{
			return false;
		}
		cellUpdateInfo.firstChunkIndex = num2;
		cellUpdateInfo.numberOfChunks = num;
		for (int k = num2; k < num2 + num; k++)
		{
			m_IndexChunks[k] = true;
		}
		m_NextFreeChunk += Mathf.Max(0, num2 + num - m_NextFreeChunk);
		return true;
	}

	public void AddBricks(ProbeReferenceVolume.RegId id, List<Brick> bricks, List<ProbeBrickPool.BrickChunkAlloc> allocations, int allocationSize, int poolWidth, int poolHeight, CellIndexUpdateInfo cellInfo)
	{
		int a = ProbeReferenceVolume.CellSize(7);
		BrickMeta value = new BrickMeta
		{
			voxels = new HashSet<Vector3Int>(),
			bricks = new List<ReservedBrick>(bricks.Count)
		};
		m_BricksToVoxels.Add(id, value);
		int num = 0;
		VoxelMeta item2 = default(VoxelMeta);
		for (int i = 0; i < allocations.Count; i++)
		{
			ProbeBrickPool.BrickChunkAlloc brickChunkAlloc = allocations[i];
			int num2 = Mathf.Min(allocationSize, bricks.Count - num);
			int num3 = 0;
			while (num3 < num2)
			{
				Brick brick = bricks[num];
				int b = ProbeReferenceVolume.CellSize(brick.subdivisionLevel);
				a = Mathf.Min(a, b);
				MapBrickToVoxels(brick, value.voxels);
				ReservedBrick item = new ReservedBrick
				{
					brick = brick,
					flattenedIdx = MergeIndex(brickChunkAlloc.flattenIndex(poolWidth, poolHeight), brick.subdivisionLevel)
				};
				value.bricks.Add(item);
				foreach (Vector3Int voxel in value.voxels)
				{
					if (!m_VoxelToBricks.TryGetValue(voxel, out var value2))
					{
						value2 = new List<VoxelMeta>(1);
						m_VoxelToBricks.Add(voxel, value2);
					}
					int num4 = value2.FindIndex((VoxelMeta lhs) => lhs.id == id);
					if (num4 == -1)
					{
						item2.id = id;
						item2.brickIndices = new List<ushort>(4);
						value2.Add(item2);
					}
					else
					{
						item2 = value2[num4];
					}
					item2.brickIndices.Add((ushort)num);
				}
				num3++;
				num++;
				brickChunkAlloc.x += 4;
			}
		}
		foreach (Vector3Int voxel2 in value.voxels)
		{
			UpdateIndexForVoxel(voxel2, cellInfo);
		}
	}

	public void RemoveBricks(ProbeReferenceVolume.RegId id, CellIndexUpdateInfo cellInfo)
	{
		if (!m_BricksToVoxels.ContainsKey(id))
		{
			return;
		}
		foreach (Vector3Int voxel in m_BricksToVoxels[id].voxels)
		{
			List<VoxelMeta> list = m_VoxelToBricks[voxel];
			int num = list.FindIndex((VoxelMeta lhs) => lhs.id == id);
			if (num >= 0)
			{
				list.RemoveAt(num);
				if (list.Count > 0)
				{
					UpdateIndexForVoxel(voxel, cellInfo);
					continue;
				}
				ClearVoxel(voxel, cellInfo);
				m_VoxelToBricks.Remove(voxel);
			}
		}
		m_BricksToVoxels.Remove(id);
		for (int num2 = cellInfo.firstChunkIndex; num2 < cellInfo.firstChunkIndex + cellInfo.numberOfChunks; num2++)
		{
			m_IndexChunks[num2] = false;
		}
	}

	private void UpdateIndexForVoxel(Vector3Int voxel, CellIndexUpdateInfo cellInfo)
	{
		ClearVoxel(voxel, cellInfo);
		foreach (VoxelMeta item in m_VoxelToBricks[voxel])
		{
			List<ReservedBrick> bricks = m_BricksToVoxels[item.id].bricks;
			List<ushort> brickIndices = item.brickIndices;
			UpdateIndexForVoxel(voxel, bricks, brickIndices, cellInfo);
		}
	}

	private void UpdatePhysicalIndex(Vector3Int brickMin, Vector3Int brickMax, int value, CellIndexUpdateInfo cellInfo)
	{
		brickMin -= cellInfo.cellPositionInBricksAtMaxRes;
		brickMax -= cellInfo.cellPositionInBricksAtMaxRes;
		brickMin /= ProbeReferenceVolume.CellSize(cellInfo.minSubdivInCell);
		brickMax /= ProbeReferenceVolume.CellSize(cellInfo.minSubdivInCell);
		ProbeReferenceVolume.CellSize(ProbeReferenceVolume.instance.GetMaxSubdivision() - 1 - cellInfo.minSubdivInCell);
		Vector3Int vector3Int = cellInfo.minValidBrickIndexForCellAtMaxRes / ProbeReferenceVolume.CellSize(cellInfo.minSubdivInCell);
		Vector3Int vector3Int2 = cellInfo.maxValidBrickIndexForCellAtMaxResPlusOne / ProbeReferenceVolume.CellSize(cellInfo.minSubdivInCell);
		brickMin -= vector3Int;
		brickMax -= vector3Int;
		Vector3Int vector3Int3 = vector3Int2 - vector3Int;
		int num = cellInfo.firstChunkIndex * 243;
		for (int i = brickMin.z; i < brickMax.z; i++)
		{
			for (int j = brickMin.y; j < brickMax.y; j++)
			{
				for (int k = brickMin.x; k < brickMax.x; k++)
				{
					int num2 = i * (vector3Int3.x * vector3Int3.y) + k * vector3Int3.y + j;
					int num3 = num + num2;
					m_PhysicalIndexBufferData[num3] = value;
				}
			}
		}
		m_NeedUpdateIndexComputeBuffer = true;
	}

	private void ClipToIndexSpace(Vector3Int pos, int subdiv, out Vector3Int outMinpos, out Vector3Int outMaxpos, CellIndexUpdateInfo cellInfo)
	{
		int num = ProbeReferenceVolume.CellSize(subdiv);
		Vector3Int vector3Int = cellInfo.cellPositionInBricksAtMaxRes + cellInfo.minValidBrickIndexForCellAtMaxRes;
		Vector3Int vector3Int2 = cellInfo.cellPositionInBricksAtMaxRes + cellInfo.maxValidBrickIndexForCellAtMaxResPlusOne - Vector3Int.one;
		int num2 = pos.x - m_CenterRS.x;
		int y = pos.y;
		int num3 = pos.z - m_CenterRS.z;
		int a = num2 + num;
		int a2 = y + num;
		int a3 = num3 + num;
		num2 = Mathf.Max(num2, vector3Int.x);
		y = Mathf.Max(y, vector3Int.y);
		num3 = Mathf.Max(num3, vector3Int.z);
		a = Mathf.Min(a, vector3Int2.x);
		a2 = Mathf.Min(a2, vector3Int2.y);
		a3 = Mathf.Min(a3, vector3Int2.z);
		outMinpos = new Vector3Int(num2, y, num3);
		outMaxpos = new Vector3Int(a, a2, a3);
	}

	private void UpdateIndexForVoxel(Vector3Int voxel, List<ReservedBrick> bricks, List<ushort> indices, CellIndexUpdateInfo cellInfo)
	{
		ClipToIndexSpace(voxel, GetVoxelSubdivLevel(), out var outMinpos, out var outMaxpos, cellInfo);
		foreach (ReservedBrick brick in bricks)
		{
			int num = ProbeReferenceVolume.CellSize(brick.brick.subdivisionLevel);
			Vector3Int position = brick.brick.position;
			Vector3Int brickMax = brick.brick.position + Vector3Int.one * num;
			position.x = Mathf.Max(outMinpos.x, position.x - m_CenterRS.x);
			position.y = Mathf.Max(outMinpos.y, position.y);
			position.z = Mathf.Max(outMinpos.z, position.z - m_CenterRS.z);
			brickMax.x = Mathf.Min(outMaxpos.x, brickMax.x - m_CenterRS.x);
			brickMax.y = Mathf.Min(outMaxpos.y, brickMax.y);
			brickMax.z = Mathf.Min(outMaxpos.z, brickMax.z - m_CenterRS.z);
			UpdatePhysicalIndex(position, brickMax, brick.flattenedIdx, cellInfo);
		}
	}
}
