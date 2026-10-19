using System;
using System.Collections.Generic;
using ACT.World.SceneChunks;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.World;

public abstract class ConfigWorldChunkStoreBase : LuminSerializedScriptableObject, IPartitionChunkBoundsInfo
{
	private const int s_WorldDefineFactor = 10000;

	private const int s_WorldDefineChunkFactor = 100;

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	protected SceneChunk[] _sceneChunks;

	[SerializeField]
	[HideInInspector]
	protected List<int> _chunkBoundsIds = new List<int>();

	[SerializeField]
	[HideInInspector]
	protected List<Bounds> _chunkBoundsDatas = new List<Bounds>();

	public SceneChunk[] SceneChunks => _sceneChunks;

	public static int FormatWorldDefine(int worldIndex, int mapIndex)
	{
		return worldIndex * 10000 + mapIndex;
	}

	public static int GetWorldIndex(int worldDefine)
	{
		return worldDefine / 10000;
	}

	public static int GetWorldMapIndex(int worldDefine)
	{
		return worldDefine % 10000;
	}

	public static int GetFixedChunkId(int worldDefine, int chunkIndex)
	{
		return worldDefine * 100 + chunkIndex;
	}

	public static int GetWorldDefine(int chunkId)
	{
		return chunkId / 100;
	}

	public bool TryGetChunkBounds(int chunkId, out Bounds bounds)
	{
		bounds = default;
		int num = _chunkBoundsIds.IndexOf(chunkId);
		if (num < 0)
		{
			return false;
		}
		bounds = _chunkBoundsDatas[num];
		return true;
	}
}
