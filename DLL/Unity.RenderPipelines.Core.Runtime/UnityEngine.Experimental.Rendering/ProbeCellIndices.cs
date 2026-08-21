using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

internal class ProbeCellIndices
{
	internal struct IndexMetaData
	{
		internal Vector3Int minLocalIdx;

		internal Vector3Int maxLocalIdx;

		internal int firstChunkIndex;

		internal int minSubdiv;

		internal void Pack(out uint[] vals)
		{
			vals = new uint[3];
			for (int i = 0; i < 3; i++)
			{
				vals[i] = 0u;
			}
			vals[0] = (uint)(firstChunkIndex & 0x1FFFFFFF);
			vals[0] |= (uint)((minSubdiv & 7) << 29);
			vals[1] = (uint)(minLocalIdx.x & 0x3FF);
			vals[1] |= (uint)((minLocalIdx.y & 0x3FF) << 10);
			vals[1] |= (uint)((minLocalIdx.z & 0x3FF) << 20);
			vals[2] = (uint)(maxLocalIdx.x & 0x3FF);
			vals[2] |= (uint)((maxLocalIdx.y & 0x3FF) << 10);
			vals[2] |= (uint)((maxLocalIdx.z & 0x3FF) << 20);
		}
	}

	private const int kUintPerEntry = 3;

	private ComputeBuffer m_IndexOfIndicesBuffer;

	private uint[] m_IndexOfIndicesData;

	private Vector3Int m_CellCount;

	private Vector3Int m_CellMin;

	private int m_CellSizeInMinBricks;

	private bool m_NeedUpdateComputeBuffer;

	internal int estimatedVMemCost { get; private set; }

	internal Vector3Int GetCellIndexDimension()
	{
		return m_CellCount;
	}

	internal Vector3Int GetCellMinPosition()
	{
		return m_CellMin;
	}

	private int GetFlatIndex(Vector3Int normalizedPos)
	{
		return normalizedPos.z * (m_CellCount.x * m_CellCount.y) + normalizedPos.y * m_CellCount.x + normalizedPos.x;
	}

	internal ProbeCellIndices(Vector3Int cellMin, Vector3Int cellMax, int cellSizeInMinBricks)
	{
		Vector3Int vector3Int = (m_CellCount = new Vector3Int(Mathf.Abs(cellMax.x - cellMin.x), Mathf.Abs(cellMax.y - cellMin.y), Mathf.Abs(cellMax.z - cellMin.z)));
		m_CellMin = cellMin;
		m_CellSizeInMinBricks = cellSizeInMinBricks;
		int num = vector3Int.x * vector3Int.y * vector3Int.z;
		num = ((num == 0) ? 1 : num);
		int num2 = 3 * num;
		m_IndexOfIndicesBuffer = new ComputeBuffer(num, 12);
		m_IndexOfIndicesData = new uint[num2];
		m_NeedUpdateComputeBuffer = false;
		estimatedVMemCost = num * 3 * 4;
	}

	internal int GetFlatIdxForCell(Vector3Int cellPosition)
	{
		Vector3Int normalizedPos = cellPosition - m_CellMin;
		return GetFlatIndex(normalizedPos);
	}

	internal void AddCell(int cellFlatIdx, ProbeBrickIndex.CellIndexUpdateInfo cellUpdateInfo)
	{
		int num = ProbeReferenceVolume.CellSize(cellUpdateInfo.minSubdivInCell);
		IndexMetaData indexMetaData = default(IndexMetaData);
		indexMetaData.minSubdiv = cellUpdateInfo.minSubdivInCell;
		indexMetaData.minLocalIdx = cellUpdateInfo.minValidBrickIndexForCellAtMaxRes / num;
		indexMetaData.maxLocalIdx = cellUpdateInfo.maxValidBrickIndexForCellAtMaxResPlusOne / num;
		indexMetaData.firstChunkIndex = cellUpdateInfo.firstChunkIndex;
		indexMetaData.Pack(out var vals);
		for (int i = 0; i < 3; i++)
		{
			m_IndexOfIndicesData[cellFlatIdx * 3 + i] = vals[i];
		}
		m_NeedUpdateComputeBuffer = true;
	}

	internal void MarkCellAsUnloaded(int cellFlatIdx)
	{
		for (int i = 0; i < 3; i++)
		{
			m_IndexOfIndicesData[cellFlatIdx * 3 + i] = uint.MaxValue;
		}
		m_NeedUpdateComputeBuffer = true;
	}

	internal void PushComputeData()
	{
		m_IndexOfIndicesBuffer.SetData(m_IndexOfIndicesData);
		m_NeedUpdateComputeBuffer = false;
	}

	internal void GetRuntimeResources(ref ProbeReferenceVolume.RuntimeResources rr)
	{
		if (m_NeedUpdateComputeBuffer)
		{
			PushComputeData();
		}
		rr.cellIndices = m_IndexOfIndicesBuffer;
	}

	internal void Cleanup()
	{
		CoreUtils.SafeRelease(m_IndexOfIndicesBuffer);
		m_IndexOfIndicesBuffer = null;
	}
}
