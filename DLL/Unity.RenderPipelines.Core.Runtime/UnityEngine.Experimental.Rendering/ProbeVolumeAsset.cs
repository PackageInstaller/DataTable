using System;
using System.Collections.Generic;

namespace UnityEngine.Experimental.Rendering;

[PreferBinarySerialization]
internal class ProbeVolumeAsset : ScriptableObject
{
	[Serializable]
	internal enum AssetVersion
	{
		First = 0,
		AddProbeVolumesAtlasEncodingModes = 1,
		PV2 = 2,
		ChunkBasedIndex = 3,
		Max = 4,
		Current = ChunkBasedIndex
	}

	[SerializeField]
	protected internal int m_Version = 3;

	[SerializeField]
	internal List<ProbeReferenceVolume.Cell> cells = new List<ProbeReferenceVolume.Cell>();

	[SerializeField]
	internal Vector3Int maxCellPosition;

	[SerializeField]
	internal Vector3Int minCellPosition;

	[SerializeField]
	internal Bounds globalBounds;

	[SerializeField]
	internal ProbeVolumeSHBands bands;

	[SerializeField]
	private string m_AssetFullPath = "UNINITIALIZED!";

	[SerializeField]
	internal int cellSizeInBricks;

	[SerializeField]
	internal float minDistanceBetweenProbes;

	[SerializeField]
	internal int simplificationLevels;

	[SerializeField]
	public int Version => m_Version;

	internal int maxSubdivision => simplificationLevels + 1;

	internal float minBrickSize => Mathf.Max(0.01f, minDistanceBetweenProbes * 3f);

	internal bool CompatibleWith(ProbeVolumeAsset otherAsset)
	{
		if (maxSubdivision == otherAsset.maxSubdivision && minBrickSize == otherAsset.minBrickSize)
		{
			return cellSizeInBricks == otherAsset.cellSizeInBricks;
		}
		return false;
	}

	public string GetSerializedFullPath()
	{
		return m_AssetFullPath;
	}
}
