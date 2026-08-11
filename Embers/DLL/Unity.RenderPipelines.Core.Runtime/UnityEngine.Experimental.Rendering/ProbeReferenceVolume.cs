using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

public class ProbeReferenceVolume
{
	[Serializable]
	internal class Cell
	{
		public int index;

		public Vector3Int position;

		public List<ProbeBrickIndex.Brick> bricks;

		public Vector3[] probePositions;

		public SphericalHarmonicsL2[] sh;

		public float[] validity;

		public int minSubdiv;

		[NonSerialized]
		public int flatIdxInCellIndices = -1;

		[NonSerialized]
		public bool loaded;
	}

	private class CellChunkInfo
	{
		public List<ProbeBrickPool.BrickChunkAlloc> chunks;
	}

	private class CellSortInfo : IComparable
	{
		internal string sourceAsset;

		internal Cell cell;

		internal float distanceToCamera;

		internal Vector3 position;

		public int CompareTo(object obj)
		{
			CellSortInfo cellSortInfo = obj as CellSortInfo;
			if (distanceToCamera < cellSortInfo.distanceToCamera)
			{
				return 1;
			}
			if (distanceToCamera > cellSortInfo.distanceToCamera)
			{
				return -1;
			}
			return 0;
		}
	}

	internal struct Volume : IEquatable<Volume>
	{
		internal Vector3 corner;

		internal Vector3 X;

		internal Vector3 Y;

		internal Vector3 Z;

		internal float maxSubdivisionMultiplier;

		internal float minSubdivisionMultiplier;

		public Volume(Matrix4x4 trs, float maxSubdivision, float minSubdivision)
		{
			X = trs.GetColumn(0);
			Y = trs.GetColumn(1);
			Z = trs.GetColumn(2);
			corner = (Vector3)trs.GetColumn(3) - X * 0.5f - Y * 0.5f - Z * 0.5f;
			maxSubdivisionMultiplier = maxSubdivision;
			minSubdivisionMultiplier = minSubdivision;
		}

		public Volume(Vector3 corner, Vector3 X, Vector3 Y, Vector3 Z, float maxSubdivision = 1f, float minSubdivision = 0f)
		{
			this.corner = corner;
			this.X = X;
			this.Y = Y;
			this.Z = Z;
			maxSubdivisionMultiplier = maxSubdivision;
			minSubdivisionMultiplier = minSubdivision;
		}

		public Volume(Volume copy)
		{
			X = copy.X;
			Y = copy.Y;
			Z = copy.Z;
			corner = copy.corner;
			maxSubdivisionMultiplier = copy.maxSubdivisionMultiplier;
			minSubdivisionMultiplier = copy.minSubdivisionMultiplier;
		}

		public Bounds CalculateAABB()
		{
			Vector3 vector = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
			Vector3 vector2 = new Vector3(float.MinValue, float.MinValue, float.MinValue);
			for (int i = 0; i < 2; i++)
			{
				for (int j = 0; j < 2; j++)
				{
					for (int k = 0; k < 2; k++)
					{
						Vector3 vector3 = new Vector3(i, j, k);
						Vector3 rhs = corner + X * vector3.x + Y * vector3.y + Z * vector3.z;
						vector = Vector3.Min(vector, rhs);
						vector2 = Vector3.Max(vector2, rhs);
					}
				}
			}
			return new Bounds((vector + vector2) / 2f, vector2 - vector);
		}

		public void CalculateCenterAndSize(out Vector3 center, out Vector3 size)
		{
			size = new Vector3(X.magnitude, Y.magnitude, Z.magnitude);
			center = corner + X * 0.5f + Y * 0.5f + Z * 0.5f;
		}

		public void Transform(Matrix4x4 trs)
		{
			corner = trs.MultiplyPoint(corner);
			X = trs.MultiplyVector(X);
			Y = trs.MultiplyVector(Y);
			Z = trs.MultiplyVector(Z);
		}

		public override string ToString()
		{
			return $"Corner: {corner}, X: {X}, Y: {Y}, Z: {Z}, MaxSubdiv: {maxSubdivisionMultiplier}";
		}

		public bool Equals(Volume other)
		{
			if (corner == other.corner && X == other.X && Y == other.Y && Z == other.Z && minSubdivisionMultiplier == other.minSubdivisionMultiplier)
			{
				return maxSubdivisionMultiplier == other.maxSubdivisionMultiplier;
			}
			return false;
		}
	}

	internal struct RefVolTransform
	{
		public Matrix4x4 refSpaceToWS;

		public Vector3 posWS;

		public Quaternion rot;

		public float scale;
	}

	public struct RuntimeResources
	{
		public ComputeBuffer index;

		public ComputeBuffer cellIndices;

		public Texture3D L0_L1rx;

		public Texture3D L1_G_ry;

		public Texture3D L1_B_rz;

		public Texture3D L2_0;

		public Texture3D L2_1;

		public Texture3D L2_2;

		public Texture3D L2_3;
	}

	internal struct RegId
	{
		internal int id;

		public bool IsValid()
		{
			return id != 0;
		}

		public void Invalidate()
		{
			id = 0;
		}

		public static bool operator ==(RegId lhs, RegId rhs)
		{
			return lhs.id == rhs.id;
		}

		public static bool operator !=(RegId lhs, RegId rhs)
		{
			return lhs.id != rhs.id;
		}

		public override bool Equals(object obj)
		{
			if (obj == null || !GetType().Equals(obj.GetType()))
			{
				return false;
			}
			return (RegId)obj == this;
		}

		public override int GetHashCode()
		{
			return id;
		}
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct ExtraDataActionInput
	{
	}

	private struct InitInfo
	{
		public Vector3Int pendingMinCellPosition;

		public Vector3Int pendingMaxCellPosition;
	}

	private class CellInstancedDebugProbes
	{
		public List<Matrix4x4[]> probeBuffers;

		public List<MaterialPropertyBlock> props;

		public Hash128 cellHash;

		public Vector3 cellPosition;
	}

	private const int kProbeIndexPoolAllocationSize = 128;

	private bool m_IsInitialized;

	private int m_ID;

	private RefVolTransform m_Transform;

	private int m_MaxSubdivision;

	private ProbeBrickPool m_Pool;

	private ProbeBrickIndex m_Index;

	private ProbeCellIndices m_CellIndices;

	private List<ProbeBrickPool.BrickChunkAlloc> m_TmpSrcChunks = new List<ProbeBrickPool.BrickChunkAlloc>();

	private float[] m_PositionOffsets = new float[4];

	private Dictionary<RegId, List<ProbeBrickPool.BrickChunkAlloc>> m_Registry = new Dictionary<RegId, List<ProbeBrickPool.BrickChunkAlloc>>();

	private Bounds m_CurrGlobalBounds;

	internal Dictionary<int, Cell> cells = new Dictionary<int, Cell>();

	private Dictionary<int, CellChunkInfo> m_ChunkInfo = new Dictionary<int, CellChunkInfo>();

	internal ProbeVolumeSceneData sceneData;

	public Action<ExtraDataActionInput> retrieveExtraDataAction;

	private bool m_BricksLoaded;

	private Dictionary<Cell, RegId> m_CellToBricks = new Dictionary<Cell, RegId>();

	private Dictionary<RegId, ProbeBrickIndex.CellIndexUpdateInfo> m_BricksToCellUpdateInfo = new Dictionary<RegId, ProbeBrickIndex.CellIndexUpdateInfo>();

	private Dictionary<string, ProbeVolumeAsset> m_PendingAssetsToBeLoaded = new Dictionary<string, ProbeVolumeAsset>();

	private Dictionary<string, ProbeVolumeAsset> m_PendingAssetsToBeUnloaded = new Dictionary<string, ProbeVolumeAsset>();

	private Dictionary<string, ProbeVolumeAsset> m_ActiveAssets = new Dictionary<string, ProbeVolumeAsset>();

	private List<CellSortInfo> m_CellsToBeLoaded = new List<CellSortInfo>();

	private Dictionary<int, int> m_CellRefCounting = new Dictionary<int, int>();

	private bool m_NeedLoadAsset;

	private bool m_ProbeReferenceVolumeInit;

	private bool m_EnabledBySRP;

	private InitInfo m_PendingInitInfo;

	private bool m_NeedsIndexRebuild;

	private bool m_HasChangedIndex;

	private int m_CBShaderID = Shader.PropertyToID("ShaderVariablesProbeVolumes");

	private int m_NumberOfCellsLoadedPerFrame = 2;

	private ProbeVolumeTextureMemoryBudget m_MemoryBudget;

	private ProbeVolumeSHBands m_SHBands;

	internal bool clearAssetsOnVolumeClear;

	private static ProbeReferenceVolume _instance = new ProbeReferenceVolume();

	private const int kProbesPerBatch = 1023;

	private DebugUI.Widget[] m_DebugItems;

	private Mesh m_DebugMesh;

	private Material m_DebugMaterial;

	private List<CellInstancedDebugProbes> m_CellDebugData = new List<CellInstancedDebugProbes>();

	private Plane[] m_DebugFrustumPlanes = new Plane[6];

	internal float dilationValidtyThreshold = 0.25f;

	internal Dictionary<Volume, List<ProbeBrickIndex.Brick>> realtimeSubdivisionInfo = new Dictionary<Volume, List<ProbeBrickIndex.Brick>>();

	internal bool isInitialized => m_ProbeReferenceVolumeInit;

	internal bool enabledBySRP => m_EnabledBySRP;

	public ProbeVolumeSHBands shBands => m_SHBands;

	public ProbeVolumeTextureMemoryBudget memoryBudget => m_MemoryBudget;

	public static ProbeReferenceVolume instance => _instance;

	internal ProbeVolumeDebug debugDisplay { get; } = new ProbeVolumeDebug();

	public Color[] subdivisionDebugColors { get; } = new Color[7];

	private void InvalidateAllCellRefs()
	{
		m_CellRefCounting.Clear();
	}

	public void SetNumberOfCellsLoadedPerFrame(int numberOfCells)
	{
		m_NumberOfCellsLoadedPerFrame = Mathf.Max(1, numberOfCells);
	}

	public void Initialize(in ProbeVolumeSystemParameters parameters)
	{
		if (m_IsInitialized)
		{
			Debug.LogError("Probe Volume System has already been initialized.");
			return;
		}
		m_MemoryBudget = parameters.memoryBudget;
		m_SHBands = parameters.shBands;
		InitializeDebug(parameters.probeDebugMesh, parameters.probeDebugShader);
		InitProbeReferenceVolume(128, m_MemoryBudget, m_SHBands);
		m_IsInitialized = true;
		m_NeedsIndexRebuild = true;
		sceneData = parameters.sceneData;
		m_EnabledBySRP = true;
	}

	public void SetEnableStateFromSRP(bool srpEnablesPV)
	{
		m_EnabledBySRP = srpEnablesPV;
	}

	internal void ForceSHBand(ProbeVolumeSHBands shBands)
	{
		if (m_ProbeReferenceVolumeInit)
		{
			CleanupLoadedData();
		}
		m_SHBands = shBands;
		m_ProbeReferenceVolumeInit = false;
		InitProbeReferenceVolume(128, m_MemoryBudget, shBands);
	}

	public void Cleanup()
	{
		if (m_ProbeReferenceVolumeInit)
		{
			if (!m_IsInitialized)
			{
				Debug.LogError("Probe Volume System has not been initialized first before calling cleanup.");
				return;
			}
			CleanupLoadedData();
			CleanupDebug();
			m_IsInitialized = false;
		}
	}

	public int GetVideoMemoryCost()
	{
		if (!m_ProbeReferenceVolumeInit)
		{
			return 0;
		}
		return m_Pool.estimatedVMemCost + m_Index.estimatedVMemCost + m_CellIndices.estimatedVMemCost;
	}

	private void RemoveCell(Cell cell)
	{
		if (cell.loaded)
		{
			bool flag = true;
			if (m_CellRefCounting.ContainsKey(cell.index))
			{
				m_CellRefCounting[cell.index]--;
				flag = m_CellRefCounting[cell.index] <= 0;
				if (flag)
				{
					m_CellRefCounting[cell.index] = 0;
				}
			}
			if (flag)
			{
				if (cells.ContainsKey(cell.index))
				{
					cells.Remove(cell.index);
				}
				if (m_ChunkInfo.ContainsKey(cell.index))
				{
					m_ChunkInfo.Remove(cell.index);
				}
				if (cell.flatIdxInCellIndices >= 0)
				{
					m_CellIndices.MarkCellAsUnloaded(cell.flatIdxInCellIndices);
				}
				RegId value = default(RegId);
				if (m_CellToBricks.TryGetValue(cell, out value))
				{
					ReleaseBricks(value);
					m_CellToBricks.Remove(cell);
				}
			}
		}
		cell.loaded = false;
	}

	private void AddCell(Cell cell, List<ProbeBrickPool.BrickChunkAlloc> chunks)
	{
		if (m_CellRefCounting.ContainsKey(cell.index))
		{
			m_CellRefCounting[cell.index]++;
		}
		else
		{
			m_CellRefCounting.Add(cell.index, 1);
		}
		cell.loaded = true;
		cells[cell.index] = cell;
		CellChunkInfo cellChunkInfo = new CellChunkInfo();
		cellChunkInfo.chunks = chunks;
		m_ChunkInfo[cell.index] = cellChunkInfo;
	}

	private bool CheckCompatibilityWithCollection(ProbeVolumeAsset asset, Dictionary<string, ProbeVolumeAsset> collection)
	{
		if (collection.Count > 0)
		{
			foreach (ProbeVolumeAsset value in collection.Values)
			{
				if (!m_PendingAssetsToBeUnloaded.ContainsKey(value.GetSerializedFullPath()))
				{
					return value.CompatibleWith(asset);
				}
			}
		}
		return true;
	}

	internal void AddPendingAssetLoading(ProbeVolumeAsset asset)
	{
		string serializedFullPath = asset.GetSerializedFullPath();
		if (m_PendingAssetsToBeLoaded.ContainsKey(serializedFullPath))
		{
			m_PendingAssetsToBeLoaded.Remove(serializedFullPath);
		}
		if (!CheckCompatibilityWithCollection(asset, m_ActiveAssets))
		{
			Debug.LogError("Trying to load Probe Volume data for a scene that has been baked with different settings than currently loaded ones. Please make sure all loaded scenes are in the same baking set.");
			return;
		}
		if (!CheckCompatibilityWithCollection(asset, m_PendingAssetsToBeLoaded))
		{
			Debug.LogError("Trying to load Probe Volume data for a scene that has been baked with different settings from other scenes that are being loaded. Please make sure all loaded scenes are in the same baking set.");
			return;
		}
		m_PendingAssetsToBeLoaded.Add(serializedFullPath, asset);
		m_NeedLoadAsset = true;
		_ = Vector3Int.zero;
		Vector3Int vector3Int = Vector3Int.zero;
		Vector3Int vector3Int2 = Vector3Int.zero;
		bool flag = true;
		foreach (ProbeVolumeAsset value in m_PendingAssetsToBeLoaded.Values)
		{
			vector3Int = Vector3Int.Min(vector3Int, value.minCellPosition);
			vector3Int2 = Vector3Int.Max(vector3Int2, value.maxCellPosition);
			if (flag)
			{
				m_CurrGlobalBounds = value.globalBounds;
				flag = false;
			}
			else
			{
				m_CurrGlobalBounds.Encapsulate(value.globalBounds);
			}
		}
		foreach (ProbeVolumeAsset value2 in m_ActiveAssets.Values)
		{
			vector3Int = Vector3Int.Min(vector3Int, value2.minCellPosition);
			vector3Int2 = Vector3Int.Max(vector3Int2, value2.maxCellPosition);
			if (flag)
			{
				m_CurrGlobalBounds = value2.globalBounds;
				flag = false;
			}
			else
			{
				m_CurrGlobalBounds.Encapsulate(value2.globalBounds);
			}
		}
		m_NeedsIndexRebuild |= m_Index == null || m_PendingInitInfo.pendingMinCellPosition != vector3Int || m_PendingInitInfo.pendingMaxCellPosition != vector3Int2;
		m_PendingInitInfo.pendingMinCellPosition = vector3Int;
		m_PendingInitInfo.pendingMaxCellPosition = vector3Int2;
	}

	internal void AddPendingAssetRemoval(ProbeVolumeAsset asset)
	{
		string serializedFullPath = asset.GetSerializedFullPath();
		if (m_PendingAssetsToBeUnloaded.ContainsKey(serializedFullPath))
		{
			m_PendingAssetsToBeUnloaded.Remove(serializedFullPath);
		}
		m_PendingAssetsToBeUnloaded.Add(asset.GetSerializedFullPath(), asset);
	}

	internal void RemovePendingAsset(ProbeVolumeAsset asset)
	{
		string serializedFullPath = asset.GetSerializedFullPath();
		for (int num = m_CellsToBeLoaded.Count - 1; num >= 0; num--)
		{
			if (m_CellsToBeLoaded[num].sourceAsset == serializedFullPath)
			{
				m_CellsToBeLoaded.RemoveAt(num);
			}
		}
		if (m_ActiveAssets.ContainsKey(serializedFullPath))
		{
			m_ActiveAssets.Remove(serializedFullPath);
		}
		foreach (Cell cell in asset.cells)
		{
			RemoveCell(cell);
		}
		ClearDebugData();
	}

	private void PerformPendingIndexChangeAndInit()
	{
		if (m_NeedsIndexRebuild)
		{
			CleanupLoadedData();
			InitProbeReferenceVolume(128, m_MemoryBudget, m_SHBands);
			m_HasChangedIndex = true;
			m_NeedsIndexRebuild = false;
		}
		else
		{
			m_HasChangedIndex = false;
		}
	}

	internal void SetMinBrickAndMaxSubdiv(float minBrickSize, int maxSubdiv)
	{
		SetTRS(Vector3.zero, Quaternion.identity, minBrickSize);
		SetMaxSubdivision(maxSubdiv);
	}

	private void LoadAsset(ProbeVolumeAsset asset)
	{
		if (asset.Version != 3)
		{
			Debug.LogWarning("Trying to load an asset " + asset.GetSerializedFullPath() + " that has been baked with a previous version of the system. Please re-bake the data.");
			return;
		}
		asset.GetSerializedFullPath();
		SetMinBrickAndMaxSubdiv(asset.minBrickSize, asset.maxSubdivision);
		for (int i = 0; i < asset.cells.Count; i++)
		{
			Cell cell = asset.cells[i];
			CellSortInfo cellSortInfo = new CellSortInfo();
			cellSortInfo.cell = cell;
			cellSortInfo.position = (Vector3)cell.position * MaxBrickSize() * 0.5f + m_Transform.posWS;
			cellSortInfo.sourceAsset = asset.GetSerializedFullPath();
			m_CellsToBeLoaded.Add(cellSortInfo);
		}
	}

	private void PerformPendingLoading()
	{
		if ((m_PendingAssetsToBeLoaded.Count == 0 && m_ActiveAssets.Count == 0) || !m_NeedLoadAsset || !m_ProbeReferenceVolumeInit)
		{
			return;
		}
		m_Pool.EnsureTextureValidity();
		if (m_HasChangedIndex)
		{
			InvalidateAllCellRefs();
			foreach (ProbeVolumeAsset value in m_ActiveAssets.Values)
			{
				LoadAsset(value);
			}
		}
		foreach (ProbeVolumeAsset value2 in m_PendingAssetsToBeLoaded.Values)
		{
			LoadAsset(value2);
			if (!m_ActiveAssets.ContainsKey(value2.GetSerializedFullPath()))
			{
				m_ActiveAssets.Add(value2.GetSerializedFullPath(), value2);
			}
		}
		m_PendingAssetsToBeLoaded.Clear();
		m_NeedLoadAsset = false;
	}

	private void PerformPendingDeletion()
	{
		if (!m_ProbeReferenceVolumeInit)
		{
			m_PendingAssetsToBeUnloaded.Clear();
		}
		foreach (ProbeVolumeAsset value in m_PendingAssetsToBeUnloaded.Values)
		{
			RemovePendingAsset(value);
		}
		m_PendingAssetsToBeUnloaded.Clear();
	}

	private int GetNumberOfBricksAtSubdiv(Cell cell, out Vector3Int minValidLocalIdxAtMaxRes, out Vector3Int sizeOfValidIndicesAtMaxRes)
	{
		minValidLocalIdxAtMaxRes = Vector3Int.zero;
		sizeOfValidIndicesAtMaxRes = Vector3Int.one;
		Vector3 vector = new Vector3((float)cell.position.x * MaxBrickSize(), (float)cell.position.y * MaxBrickSize(), (float)cell.position.z * MaxBrickSize());
		Bounds bounds = new Bounds
		{
			min = vector,
			max = vector + Vector3.one * MaxBrickSize()
		};
		Bounds bounds2 = new Bounds
		{
			min = Vector3.Max(bounds.min, m_CurrGlobalBounds.min),
			max = Vector3.Min(bounds.max, m_CurrGlobalBounds.max)
		};
		_ = bounds2.max - bounds2.min;
		Vector3 vector2 = bounds2.min - bounds.min;
		minValidLocalIdxAtMaxRes.x = Mathf.CeilToInt(vector2.x / MinBrickSize());
		minValidLocalIdxAtMaxRes.y = Mathf.CeilToInt(vector2.y / MinBrickSize());
		minValidLocalIdxAtMaxRes.z = Mathf.CeilToInt(vector2.z / MinBrickSize());
		Vector3 vector3 = bounds2.max - bounds.min;
		sizeOfValidIndicesAtMaxRes.x = Mathf.CeilToInt(vector3.x / MinBrickSize()) - minValidLocalIdxAtMaxRes.x + 1;
		sizeOfValidIndicesAtMaxRes.y = Mathf.CeilToInt(vector3.y / MinBrickSize()) - minValidLocalIdxAtMaxRes.y + 1;
		sizeOfValidIndicesAtMaxRes.z = Mathf.CeilToInt(vector3.z / MinBrickSize()) - minValidLocalIdxAtMaxRes.z + 1;
		Vector3Int vector3Int = default(Vector3Int);
		vector3Int = sizeOfValidIndicesAtMaxRes / CellSize(cell.minSubdiv);
		return vector3Int.x * vector3Int.y * vector3Int.z;
	}

	private bool GetCellIndexUpdate(Cell cell, out ProbeBrickIndex.CellIndexUpdateInfo cellUpdateInfo)
	{
		cellUpdateInfo = default(ProbeBrickIndex.CellIndexUpdateInfo);
		int numberOfBricksAtSubdiv = GetNumberOfBricksAtSubdiv(cell, out var minValidLocalIdxAtMaxRes, out var sizeOfValidIndicesAtMaxRes);
		cellUpdateInfo.cellPositionInBricksAtMaxRes = cell.position * CellSize(m_MaxSubdivision - 1);
		cellUpdateInfo.minSubdivInCell = cell.minSubdiv;
		cellUpdateInfo.minValidBrickIndexForCellAtMaxRes = minValidLocalIdxAtMaxRes;
		cellUpdateInfo.maxValidBrickIndexForCellAtMaxResPlusOne = sizeOfValidIndicesAtMaxRes + minValidLocalIdxAtMaxRes;
		return m_Index.AssignIndexChunksToCell(cell, numberOfBricksAtSubdiv, ref cellUpdateInfo);
	}

	private void LoadPendingCells(bool loadAll = false)
	{
		int num = Mathf.Min(m_NumberOfCellsLoadedPerFrame, m_CellsToBeLoaded.Count);
		num = (loadAll ? m_CellsToBeLoaded.Count : num);
		if (m_PendingInitInfo.pendingMinCellPosition == m_PendingInitInfo.pendingMaxCellPosition && num > 1)
		{
			return;
		}
		if (num != 0)
		{
			ClearDebugData();
		}
		for (int i = 0; i < num; i++)
		{
			CellSortInfo cellSortInfo = m_CellsToBeLoaded[0];
			Cell cell = cellSortInfo.cell;
			_ = cellSortInfo.sourceAsset;
			bool compressed = false;
			int allocatedBytes = 0;
			ProbeBrickPool.DataLocation loc = ProbeBrickPool.CreateDataLocation(cell.sh.Length, compressed, m_SHBands, out allocatedBytes);
			ProbeBrickPool.FillDataLocation(ref loc, cell.sh, m_SHBands);
			cell.flatIdxInCellIndices = m_CellIndices.GetFlatIdxForCell(cell.position);
			if (GetCellIndexUpdate(cell, out var cellUpdateInfo))
			{
				List<ProbeBrickIndex.Brick> list = new List<ProbeBrickIndex.Brick>();
				list.AddRange(cell.bricks);
				List<ProbeBrickPool.BrickChunkAlloc> ch_list = new List<ProbeBrickPool.BrickChunkAlloc>();
				RegId regId = AddBricks(list, loc, cellUpdateInfo, out ch_list);
				m_BricksToCellUpdateInfo.Add(regId, cellUpdateInfo);
				m_CellIndices.AddCell(cell.flatIdxInCellIndices, cellUpdateInfo);
				AddCell(cell, ch_list);
				m_CellToBricks[cell] = regId;
				loc.Cleanup();
				m_CellsToBeLoaded.RemoveAt(0);
				continue;
			}
			break;
		}
	}

	public void PerformPendingOperations(bool loadAllCells = false)
	{
		PerformPendingDeletion();
		PerformPendingIndexChangeAndInit();
		PerformPendingLoading();
		LoadPendingCells(loadAllCells);
	}

	private void InitProbeReferenceVolume(int allocationSize, ProbeVolumeTextureMemoryBudget memoryBudget, ProbeVolumeSHBands shBands)
	{
		Vector3Int pendingMinCellPosition = m_PendingInitInfo.pendingMinCellPosition;
		Vector3Int pendingMaxCellPosition = m_PendingInitInfo.pendingMaxCellPosition;
		if (!m_ProbeReferenceVolumeInit)
		{
			m_Pool = new ProbeBrickPool(allocationSize, memoryBudget, shBands);
			m_Index = new ProbeBrickIndex(memoryBudget);
			m_CellIndices = new ProbeCellIndices(pendingMinCellPosition, pendingMaxCellPosition, (int)Mathf.Pow(3f, m_MaxSubdivision - 1));
			m_PositionOffsets[0] = 0f;
			float num = 1f / 3f;
			for (int i = 1; i < 3; i++)
			{
				m_PositionOffsets[i] = (float)i * num;
			}
			m_PositionOffsets[m_PositionOffsets.Length - 1] = 1f;
			m_ProbeReferenceVolumeInit = true;
			ClearDebugData();
			m_NeedLoadAsset = true;
		}
	}

	public void SortPendingCells(Vector3 cameraPosition)
	{
		if (m_CellsToBeLoaded.Count > 0)
		{
			for (int i = 0; i < m_CellsToBeLoaded.Count; i++)
			{
				m_CellsToBeLoaded[i].distanceToCamera = Vector3.Distance(cameraPosition, m_CellsToBeLoaded[i].position);
			}
			m_CellsToBeLoaded.Sort();
		}
	}

	private ProbeReferenceVolume()
	{
		m_Transform.posWS = Vector3.zero;
		m_Transform.rot = Quaternion.identity;
		m_Transform.scale = 1f;
		m_Transform.refSpaceToWS = Matrix4x4.identity;
	}

	public RuntimeResources GetRuntimeResources()
	{
		if (!m_ProbeReferenceVolumeInit)
		{
			return default(RuntimeResources);
		}
		RuntimeResources rr = default(RuntimeResources);
		m_Index.GetRuntimeResources(ref rr);
		m_CellIndices.GetRuntimeResources(ref rr);
		m_Pool.GetRuntimeResources(ref rr);
		return rr;
	}

	internal void SetTRS(Vector3 position, Quaternion rotation, float minBrickSize)
	{
		m_Transform.posWS = position;
		m_Transform.rot = rotation;
		m_Transform.scale = minBrickSize;
		m_Transform.refSpaceToWS = Matrix4x4.TRS(m_Transform.posWS, m_Transform.rot, Vector3.one * m_Transform.scale);
	}

	internal void SetMaxSubdivision(int maxSubdivision)
	{
		m_MaxSubdivision = Math.Min(maxSubdivision, 7);
	}

	internal static int CellSize(int subdivisionLevel)
	{
		return (int)Mathf.Pow(3f, subdivisionLevel);
	}

	internal float BrickSize(int subdivisionLevel)
	{
		return m_Transform.scale * (float)CellSize(subdivisionLevel);
	}

	internal float MinBrickSize()
	{
		return m_Transform.scale;
	}

	internal float MaxBrickSize()
	{
		return BrickSize(m_MaxSubdivision - 1);
	}

	internal Matrix4x4 GetRefSpaceToWS()
	{
		return m_Transform.refSpaceToWS;
	}

	internal RefVolTransform GetTransform()
	{
		return m_Transform;
	}

	internal int GetMaxSubdivision()
	{
		return m_MaxSubdivision;
	}

	internal int GetMaxSubdivision(float multiplier)
	{
		return Mathf.CeilToInt((float)m_MaxSubdivision * multiplier);
	}

	internal float GetDistanceBetweenProbes(int subdivisionLevel)
	{
		return BrickSize(subdivisionLevel) / 3f;
	}

	internal float MinDistanceBetweenProbes()
	{
		return GetDistanceBetweenProbes(0);
	}

	public bool DataHasBeenLoaded()
	{
		return m_BricksLoaded;
	}

	internal void Clear()
	{
		if (m_ProbeReferenceVolumeInit)
		{
			m_Pool.Clear();
			m_Index.Clear();
			cells.Clear();
			m_ChunkInfo.Clear();
		}
		if (clearAssetsOnVolumeClear)
		{
			m_PendingAssetsToBeLoaded.Clear();
			m_ActiveAssets.Clear();
		}
	}

	private RegId AddBricks(List<ProbeBrickIndex.Brick> bricks, ProbeBrickPool.DataLocation dataloc, ProbeBrickIndex.CellIndexUpdateInfo cellUpdateInfo, out List<ProbeBrickPool.BrickChunkAlloc> ch_list)
	{
		int chunkSize = m_Pool.GetChunkSize();
		ch_list = new List<ProbeBrickPool.BrickChunkAlloc>((bricks.Count + chunkSize - 1) / chunkSize);
		m_Pool.Allocate(ch_list.Capacity, ch_list);
		m_TmpSrcChunks.Clear();
		m_TmpSrcChunks.Capacity = ch_list.Count;
		ProbeBrickPool.BrickChunkAlloc item = default(ProbeBrickPool.BrickChunkAlloc);
		item.x = 0;
		item.y = 0;
		item.z = 0;
		for (int i = 0; i < ch_list.Count; i++)
		{
			m_TmpSrcChunks.Add(item);
			item.x += chunkSize * 4;
			if (item.x >= dataloc.width)
			{
				item.x = 0;
				item.y += 4;
				if (item.y >= dataloc.height)
				{
					item.y = 0;
					item.z += 4;
				}
			}
		}
		m_Pool.Update(dataloc, m_TmpSrcChunks, ch_list, m_SHBands);
		m_BricksLoaded = true;
		m_ID++;
		RegId regId = default(RegId);
		regId.id = m_ID;
		m_Registry.Add(regId, ch_list);
		m_Index.AddBricks(regId, bricks, ch_list, m_Pool.GetChunkSize(), m_Pool.GetPoolWidth(), m_Pool.GetPoolHeight(), cellUpdateInfo);
		return regId;
	}

	private void ReleaseBricks(RegId id)
	{
		if (!m_Registry.TryGetValue(id, out var value))
		{
			Debug.Log("Tried to release bricks with id=" + id.id + " but no bricks were registered under this id.");
			return;
		}
		m_Index.RemoveBricks(id, m_BricksToCellUpdateInfo[id]);
		m_Pool.Deallocate(value);
		m_Registry.Remove(id);
		m_BricksToCellUpdateInfo.Remove(id);
	}

	public void UpdateConstantBuffer(CommandBuffer cmd, ProbeVolumeShadingParameters parameters)
	{
		float num = parameters.normalBias;
		float num2 = parameters.viewBias;
		if (parameters.scaleBiasByMinDistanceBetweenProbes)
		{
			num *= MinDistanceBetweenProbes();
			num2 *= MinDistanceBetweenProbes();
		}
		ShaderVariablesProbeVolumes data = default(ShaderVariablesProbeVolumes);
		data._NormalBias = num;
		data._PoolDim = m_Pool.GetPoolDimensions();
		data._ViewBias = num2;
		data._PVSamplingNoise = parameters.samplingNoise;
		data._CellInMinBricks = (int)Mathf.Pow(3f, m_MaxSubdivision - 1);
		data._CellIndicesDim = m_CellIndices.GetCellIndexDimension();
		data._MinCellPosition = m_CellIndices.GetCellMinPosition();
		data._MinBrickSize = MinBrickSize();
		data._IndexChunkSize = 243;
		data._CellInMeters = MaxBrickSize();
		ConstantBuffer.PushGlobal(cmd, in data, m_CBShaderID);
	}

	private void CleanupLoadedData()
	{
		m_BricksLoaded = false;
		if (m_ProbeReferenceVolumeInit)
		{
			m_Index.Cleanup();
			m_CellIndices.Cleanup();
			m_Pool.Cleanup();
		}
		m_ProbeReferenceVolumeInit = false;
		ClearDebugData();
	}

	public void RenderDebug(Camera camera)
	{
		if (camera.cameraType != CameraType.Reflection && camera.cameraType != CameraType.Preview && debugDisplay.drawProbes)
		{
			DrawProbeDebug(camera);
		}
	}

	private void InitializeDebug(Mesh debugProbeMesh, Shader debugProbeShader)
	{
		m_DebugMesh = debugProbeMesh;
		m_DebugMaterial = CoreUtils.CreateEngineMaterial(debugProbeShader);
		m_DebugMaterial.enableInstancing = true;
		subdivisionDebugColors[0] = new Color(1f, 0f, 0f);
		subdivisionDebugColors[1] = new Color(0f, 1f, 0f);
		subdivisionDebugColors[2] = new Color(0f, 0f, 1f);
		subdivisionDebugColors[3] = new Color(1f, 1f, 0f);
		subdivisionDebugColors[4] = new Color(1f, 0f, 1f);
		subdivisionDebugColors[5] = new Color(0f, 1f, 1f);
		subdivisionDebugColors[6] = new Color(0.5f, 0.5f, 0.5f);
		RegisterDebug();
	}

	private void CleanupDebug()
	{
		UnregisterDebug(destroyPanel: true);
		CoreUtils.Destroy(m_DebugMaterial);
	}

	private void RefreshDebug<T>(DebugUI.Field<T> field, T value)
	{
		UnregisterDebug(destroyPanel: false);
		RegisterDebug();
	}

	private void DebugCellIndexChanged<T>(DebugUI.Field<T> field, T value)
	{
		ClearDebugData();
	}

	private void RegisterDebug()
	{
		List<DebugUI.Widget> list = new List<DebugUI.Widget>();
		DebugUI.Container container = new DebugUI.Container
		{
			displayName = "Subdivision Visualization"
		};
		container.children.Add(new DebugUI.BoolField
		{
			displayName = "Display Cells",
			getter = () => debugDisplay.drawCells,
			setter = delegate(bool value)
			{
				debugDisplay.drawCells = value;
			},
			onValueChanged = RefreshDebug
		});
		container.children.Add(new DebugUI.BoolField
		{
			displayName = "Display Bricks",
			getter = () => debugDisplay.drawBricks,
			setter = delegate(bool value)
			{
				debugDisplay.drawBricks = value;
			},
			onValueChanged = RefreshDebug
		});
		if (debugDisplay.drawCells || debugDisplay.drawBricks)
		{
			container.children.Add(new DebugUI.FloatField
			{
				displayName = "Culling Distance",
				getter = () => debugDisplay.subdivisionViewCullingDistance,
				setter = delegate(float value)
				{
					debugDisplay.subdivisionViewCullingDistance = value;
				},
				min = () => 0f
			});
		}
		DebugUI.Container container2 = new DebugUI.Container
		{
			displayName = "Probe Visualization"
		};
		container2.children.Add(new DebugUI.BoolField
		{
			displayName = "Display Probes",
			getter = () => debugDisplay.drawProbes,
			setter = delegate(bool value)
			{
				debugDisplay.drawProbes = value;
			},
			onValueChanged = RefreshDebug
		});
		if (debugDisplay.drawProbes)
		{
			container2.children.Add(new DebugUI.EnumField
			{
				displayName = "Probe Shading Mode",
				getter = () => (int)debugDisplay.probeShading,
				setter = delegate(int value)
				{
					debugDisplay.probeShading = (DebugProbeShadingMode)value;
				},
				autoEnum = typeof(DebugProbeShadingMode),
				getIndex = () => (int)debugDisplay.probeShading,
				setIndex = delegate(int value)
				{
					debugDisplay.probeShading = (DebugProbeShadingMode)value;
				},
				onValueChanged = RefreshDebug
			});
			container2.children.Add(new DebugUI.FloatField
			{
				displayName = "Probe Size",
				getter = () => debugDisplay.probeSize,
				setter = delegate(float value)
				{
					debugDisplay.probeSize = value;
				},
				min = () => 0.1f,
				max = () => 10f
			});
			if (debugDisplay.probeShading == DebugProbeShadingMode.SH)
			{
				container2.children.Add(new DebugUI.FloatField
				{
					displayName = "Probe Exposure Compensation",
					getter = () => debugDisplay.exposureCompensation,
					setter = delegate(float value)
					{
						debugDisplay.exposureCompensation = value;
					}
				});
			}
			container2.children.Add(new DebugUI.FloatField
			{
				displayName = "Culling Distance",
				getter = () => debugDisplay.probeCullingDistance,
				setter = delegate(float value)
				{
					debugDisplay.probeCullingDistance = value;
				},
				min = () => 0f
			});
			container2.children.Add(new DebugUI.IntField
			{
				displayName = "Max subdivision displayed",
				getter = () => debugDisplay.maxSubdivToVisualize,
				setter = delegate(int v)
				{
					debugDisplay.maxSubdivToVisualize = Mathf.Min(v, instance.GetMaxSubdivision());
				},
				min = () => 0,
				max = () => instance.GetMaxSubdivision()
			});
		}
		list.Add(container);
		list.Add(container2);
		m_DebugItems = list.ToArray();
		DebugManager.instance.GetPanel("Probe Volume", createIfNull: true).children.Add(m_DebugItems);
	}

	private void UnregisterDebug(bool destroyPanel)
	{
		if (destroyPanel)
		{
			DebugManager.instance.RemovePanel("Probe Volume");
		}
		else
		{
			DebugManager.instance.GetPanel("Probe Volume").children.Remove(m_DebugItems);
		}
	}

	private bool ShouldCullCell(Vector3 cellPosition, Transform cameraTransform, Plane[] frustumPlanes)
	{
		float num = MaxBrickSize();
		Vector3 posWS = GetTransform().posWS;
		Vector3 vector = cellPosition * num + posWS + Vector3.one * (num / 2f);
		float num2 = (float)Mathf.CeilToInt(debugDisplay.probeCullingDistance / num) * num;
		if (Vector3.Distance(cameraTransform.position, vector) > num2)
		{
			return true;
		}
		Bounds bounds = new Bounds(vector, num * Vector3.one);
		return !GeometryUtility.TestPlanesAABB(frustumPlanes, bounds);
	}

	private void DrawProbeDebug(Camera camera)
	{
		if (!debugDisplay.drawProbes)
		{
			return;
		}
		if (m_CellDebugData.Count == 0)
		{
			CreateInstancedProbes();
		}
		GeometryUtility.CalculateFrustumPlanes(camera, m_DebugFrustumPlanes);
		m_DebugMaterial.shaderKeywords = null;
		if (m_SHBands == ProbeVolumeSHBands.SphericalHarmonicsL1)
		{
			m_DebugMaterial.EnableKeyword("PROBE_VOLUMES_L1");
		}
		else if (m_SHBands == ProbeVolumeSHBands.SphericalHarmonicsL2)
		{
			m_DebugMaterial.EnableKeyword("PROBE_VOLUMES_L2");
		}
		foreach (CellInstancedDebugProbes cellDebugDatum in m_CellDebugData)
		{
			if (!ShouldCullCell(cellDebugDatum.cellPosition, camera.transform, m_DebugFrustumPlanes))
			{
				for (int i = 0; i < cellDebugDatum.probeBuffers.Count; i++)
				{
					Matrix4x4[] array = cellDebugDatum.probeBuffers[i];
					MaterialPropertyBlock materialPropertyBlock = cellDebugDatum.props[i];
					materialPropertyBlock.SetInt("_ShadingMode", (int)debugDisplay.probeShading);
					materialPropertyBlock.SetFloat("_ExposureCompensation", debugDisplay.exposureCompensation);
					materialPropertyBlock.SetFloat("_ProbeSize", debugDisplay.probeSize);
					materialPropertyBlock.SetFloat("_CullDistance", debugDisplay.probeCullingDistance);
					materialPropertyBlock.SetInt("_MaxAllowedSubdiv", debugDisplay.maxSubdivToVisualize);
					materialPropertyBlock.SetFloat("_ValidityThreshold", dilationValidtyThreshold);
					Graphics.DrawMeshInstanced(m_DebugMesh, 0, m_DebugMaterial, array, array.Length, materialPropertyBlock, ShadowCastingMode.Off, receiveShadows: false, 0, camera, LightProbeUsage.Off, null);
				}
			}
		}
	}

	private void ClearDebugData()
	{
		m_CellDebugData.Clear();
		realtimeSubdivisionInfo.Clear();
	}

	private void CreateInstancedProbes()
	{
		int num = instance.GetMaxSubdivision() - 1;
		foreach (Cell value2 in instance.cells.Values)
		{
			if (value2.sh == null || value2.sh.Length == 0)
			{
				continue;
			}
			if (value2.bricks.Count != 0)
			{
				_ = value2.bricks[0];
			}
			List<Matrix4x4[]> list = new List<Matrix4x4[]>();
			List<MaterialPropertyBlock> list2 = new List<MaterialPropertyBlock>();
			if (!m_ChunkInfo.TryGetValue(value2.index, out var value))
			{
				continue;
			}
			Vector4[] array = new Vector4[1023];
			float[] array2 = new float[1023];
			float[] array3 = new float[1023];
			List<Matrix4x4> list3 = new List<Matrix4x4>();
			CellInstancedDebugProbes cellInstancedDebugProbes = new CellInstancedDebugProbes();
			cellInstancedDebugProbes.probeBuffers = list;
			cellInstancedDebugProbes.props = list2;
			cellInstancedDebugProbes.cellPosition = value2.position;
			int num2 = 0;
			for (int i = 0; i < value2.probePositions.Length; i++)
			{
				int subdivisionLevel = value2.bricks[i / 64].subdivisionLevel;
				int index = i / m_Pool.GetChunkSizeInProbeCount();
				ProbeBrickPool.BrickChunkAlloc brickChunkAlloc = value.chunks[index];
				int num3 = i % m_Pool.GetChunkSizeInProbeCount();
				int num4 = num3 / 64;
				int num5 = num3 % 64;
				Vector2Int vector2Int = new Vector2Int(brickChunkAlloc.x + num4 * 4, brickChunkAlloc.y);
				int num6 = num5 % 16;
				Vector3Int vector3Int = new Vector3Int(vector2Int.x + num6 % 4, vector2Int.y + num6 / 4, num5 / 16);
				list3.Add(Matrix4x4.TRS(value2.probePositions[i], Quaternion.identity, Vector3.one * (0.3f * (float)(subdivisionLevel + 1))));
				array2[num2] = value2.validity[i];
				array[num2] = new Vector4(vector3Int.x, vector3Int.y, vector3Int.z, subdivisionLevel);
				array3[num2] = (float)subdivisionLevel / (float)num;
				num2++;
				if (list3.Count >= 1023 || i == value2.probePositions.Length - 1)
				{
					num2 = 0;
					MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
					materialPropertyBlock.SetFloatArray("_Validity", array2);
					materialPropertyBlock.SetFloatArray("_RelativeSize", array3);
					materialPropertyBlock.SetVectorArray("_IndexInAtlas", array);
					list2.Add(materialPropertyBlock);
					list.Add(list3.ToArray());
					list3 = new List<Matrix4x4>();
				}
			}
			m_CellDebugData.Add(cellInstancedDebugProbes);
		}
	}

	private void OnClearLightingdata()
	{
		ClearDebugData();
	}
}
