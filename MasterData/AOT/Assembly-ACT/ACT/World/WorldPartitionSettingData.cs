using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World;

[CreateAssetMenu]
public class WorldPartitionSettingData : ScriptableObject
{
	private struct LoadResult<T>(bool success, T data) : ILoadPartitionResult<T> where T : IBakedWorldData
	{
		private T _data = data;

		private bool _success = success;

		public bool Success => _success;

		public T Data => _data;
	}

	[SerializeField]
	[HideInInspector]
	private List<int> _subWorldIds = new List<int>();

	[SerializeField]
	[HideInInspector]
	private List<SubWorldPartitionReference> _subWorldRefs = new List<SubWorldPartitionReference>();

	[SerializeField]
	[HideInInspector]
	private List<int> _instanceLevelIds = new List<int>();

	[SerializeField]
	[HideInInspector]
	private List<InstancePartitionReference> _instanceLevelRefs = new List<InstancePartitionReference>();

	[SerializeField]
	[HideInInspector]
	private List<int> _graphDataIds = new List<int>();

	[SerializeField]
	[HideInInspector]
	private List<WorldMapGraphDataReference> _graphDatas = new List<WorldMapGraphDataReference>();

	private readonly Dictionary<int, MainWorldPartition> _mainWorldPartitions = new Dictionary<int, MainWorldPartition>();

	private async UniTask<ILoadPartitionResult<ConfigWorldPartition_v2>> GetMainWorldPartition(int worldId)
	{
		if (_mainWorldPartitions.TryGetValue(worldId, out var value))
		{
			return new LoadResult<ConfigWorldPartition_v2>(value != null, value);
		}
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, ACT.Config.MapArea> mapArea in RuntimeConfigs.data.mapAreas)
		{
			ACT.Config.MapArea value2 = mapArea.Value;
			if (value2.worldId == worldId)
			{
				list.Add(value2.id);
			}
		}
		if (list.Count == 0)
		{
			_mainWorldPartitions[worldId] = null;
			return new LoadResult<ConfigWorldPartition_v2>(success: false, null);
		}
		LuminApplication.APM.AnalyserPushSample($"MergeMainWorldPartition[{worldId}]");
		List<ConfigWorldPartition_v2_SubworldData> subWorldDatas = new List<ConfigWorldPartition_v2_SubworldData>();
		foreach (int item2 in list)
		{
			int num = _subWorldIds.IndexOf(item2);
			if (num >= 0)
			{
				SubWorldPartitionReference assetID = _subWorldRefs[num];
				AssetLoadHandle subWorldLoadProcess = AssetStationManager.SceneStation.LoadAsync<ConfigWorldPartition_v2_SubworldData>(assetID);
				await subWorldLoadProcess;
				if (subWorldLoadProcess.IsValid && subWorldLoadProcess.IsDone && subWorldLoadProcess.Result is ConfigWorldPartition_v2_SubworldData item)
				{
					subWorldDatas.Add(item);
				}
			}
		}
		value = subWorldDatas.Merge(worldId);
		LuminApplication.APM.AnalyserPopSample($"GetMainWorldPartition[{worldId}]");
		_mainWorldPartitions[worldId] = value;
		return new LoadResult<ConfigWorldPartition_v2>(success: true, value);
	}

	public async UniTask<ILoadPartitionResult<ConfigWorldPartition_v2>> TryLoadPartition(int id, bool isMainWorld)
	{
		if (isMainWorld)
		{
			ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await GetMainWorldPartition(id);
			if (loadPartitionResult.Success)
			{
				return loadPartitionResult;
			}
		}
		return await TryLoad<ConfigWorldPartition_v2, InstancePartitionReference>(id, _instanceLevelIds, _instanceLevelRefs);
	}

	public async UniTask<ILoadPartitionResult<ConfigWorldMapGraphData>> TryLoadGraphData(int id)
	{
		return await TryLoad<ConfigWorldMapGraphData, WorldMapGraphDataReference>(id, _graphDataIds, _graphDatas);
	}

	private async UniTask<ILoadPartitionResult<T>> TryLoad<T, T1>(int id, List<int> idList, List<T1> referenceList) where T : ScriptableObject, IBakedWorldData where T1 : YooAssetReference<T>
	{
		int num = idList.IndexOf(id);
		if (num < 0)
		{
			return new LoadResult<T>(success: false, null);
		}
		T1 assetID = referenceList[num];
		AssetLoadHandle loadProcess = AssetStationManager.SceneStation.LoadAsync<T>(assetID);
		await loadProcess;
		bool success = loadProcess.IsValid && loadProcess.IsDone;
		T data = loadProcess.Result as T;
		return new LoadResult<T>(success, data);
	}
}
