using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.SceneChunks;

namespace ACT.World;

internal static class ConfigWorldPartition_v2_Extension
{
	internal static Dictionary<int, StateWorldAssetDataInfo<StateWorldAssetData>> GetAllStateWorldAssetDataInPartition(this ConfigWorldPartition_v2 partition)
	{
		return partition.GetAllStateWorldAssetDataInPartition<StateWorldAssetData>();
	}

	internal static Dictionary<int, StateWorldAssetDataInfo<T>> GetAllStateWorldAssetDataInPartition<T>(this ConfigWorldPartition_v2 partition) where T : StateWorldAssetData
	{
		return partition.SceneChunks.GetAllStateWorldAssetDataInPartition<T>();
	}

	internal static Dictionary<int, StateWorldAssetDataInfo<T>> GetAllStateWorldAssetDataInPartition<T>(this SceneChunk[] chunks) where T : StateWorldAssetData
	{
		Dictionary<int, StateWorldAssetDataInfo<T>> dictionary = new Dictionary<int, StateWorldAssetDataInfo<T>>();
		foreach (SceneChunk sceneChunk in chunks)
		{
			int chunkId = sceneChunk.ChunkId;
			int mapId = sceneChunk.MapId;
			int areaId = sceneChunk.AreaId;
			StateWorldAssetData[] stateWorldAssetDatas = sceneChunk.StateWorldAssetDatas;
			for (int j = 0; j < stateWorldAssetDatas.Length; j++)
			{
				if (stateWorldAssetDatas[j] is T val)
				{
					dictionary[val.stateWorldAssetUid] = new StateWorldAssetDataInfo<T>(chunkId, areaId, mapId, val);
				}
			}
			SceneBlock[] subScenes = sceneChunk.SubScenes;
			for (int j = 0; j < subScenes.Length; j++)
			{
				stateWorldAssetDatas = subScenes[j].StateWorldAssetDatas;
				for (int k = 0; k < stateWorldAssetDatas.Length; k++)
				{
					if (stateWorldAssetDatas[k] is T val2)
					{
						dictionary[val2.stateWorldAssetUid] = new StateWorldAssetDataInfo<T>(chunkId, areaId, mapId, val2);
					}
				}
			}
		}
		return dictionary;
	}
}
