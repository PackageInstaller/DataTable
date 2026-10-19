using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT;

public class ConfigWorldPartition_v2_SubworldData : LuminSerializedScriptableObject
{
	[SerializeField]
	private int _mapId;

	[OdinSerialize]
	private SceneChunk[] _chunks;

	[OdinSerialize]
	private List<InteractRule> _rules;

	[SerializeField]
	[HideInInspector]
	private List<int> _chunkBoundsIds = new List<int>();

	[SerializeField]
	[HideInInspector]
	private List<Bounds> _chunkBoundsDatas = new List<Bounds>();

	public List<InteractRule> Rules => _rules;

	public int Id => _mapId;

	public SceneChunk[] SceneChunks => _chunks;

	public List<int> ChunkBoundsIds => _chunkBoundsIds;

	public List<Bounds> ChunkBoundsDatas => _chunkBoundsDatas;
}
