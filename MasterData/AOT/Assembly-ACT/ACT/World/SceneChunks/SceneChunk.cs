using System;
using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.Data.SceneRouters;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.SceneChunks;

[Serializable]
public class SceneChunk : SceneOverrideAudioData, IDataToBake, WorldManager.IWorldStateAssetHolder
{
	[SerializeField]
	[HideInInspector]
	private SceneChunkType _blukMode;

	[SerializeField]
	private string _debugName;

	[FormerlySerializedAs("_worldId")]
	[FormerlySerializedAs("_partitionId")]
	[SerializeField]
	[HideInInspector]
	private int worldConfigId;

	[SerializeField]
	private int _mapId;

	[SerializeField]
	private int _areaId;

	[FormerlySerializedAs("_guid")]
	[SerializeField]
	private int chunkId;

	[SerializeField]
	private SceneChunkRouterData[] _sceneRouters;

	[FormerlySerializedAs("_sceneBlocks")]
	[SerializeField]
	private SceneBlock[] sceneStates;

	[SerializeReference]
	[OdinSerialize]
	private StateWorldAssetData[] _stateWorldAssetDatas;

	private Dictionary<int, StateWorldAssetData> _dict;

	internal SceneChunkType BulkMode => _blukMode;

	public string DebugName => _debugName;

	public int WorldConfigId => worldConfigId;

	public int MapId => _mapId;

	public int AreaId => _areaId;

	public int ChunkId => chunkId;

	internal SceneChunkRouterData[] SceneRouters => _sceneRouters;

	public SceneBlock[] SubScenes => sceneStates;

	public StateWorldAssetData[] StateWorldAssetDatas => _stateWorldAssetDatas;

	Dictionary<int, StateWorldAssetData> WorldManager.IWorldStateAssetHolder.StateWorldAssetDataDict
	{
		get
		{
			if (_dict != null)
			{
				return _dict;
			}
			if (_dict == null)
			{
				_dict = new Dictionary<int, StateWorldAssetData>();
			}
			_dict.Clear();
			StateWorldAssetData[] stateWorldAssetDatas = _stateWorldAssetDatas;
			foreach (StateWorldAssetData stateWorldAssetData in stateWorldAssetDatas)
			{
				_dict[stateWorldAssetData.stateWorldAssetUid] = stateWorldAssetData;
			}
			SceneBlock[] array = sceneStates;
			for (int i = 0; i < array.Length; i++)
			{
				stateWorldAssetDatas = array[i].StateWorldAssetDatas;
				foreach (StateWorldAssetData stateWorldAssetData2 in stateWorldAssetDatas)
				{
					_dict[stateWorldAssetData2.stateWorldAssetUid] = stateWorldAssetData2;
				}
			}
			return _dict;
		}
	}

	public SceneChunk()
	{
		_stateWorldAssetDatas = Array.Empty<StateWorldAssetData>();
		sceneStates = Array.Empty<SceneBlock>();
		_sceneRouters = Array.Empty<SceneChunkRouterData>();
	}
}
