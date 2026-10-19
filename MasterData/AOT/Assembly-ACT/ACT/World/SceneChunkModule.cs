using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Game.Data;
using ACT.World.Modules;
using ACT.World.SceneChunks;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;
using Runtime.World.SceneChunks;
using UnityEngine;
using Utility;

namespace ACT.World;

internal class SceneChunkModule : WorldModuleBase
{
	private SceneStatus _activeSceneType;

	private SceneChunkRuntimeControlBase _activeChunkNode;

	private readonly Dictionary<int, SceneChunkRuntimeControlBase> _chunkNodeCaches = new Dictionary<int, SceneChunkRuntimeControlBase>();

	private readonly Dictionary<int, SceneChunk> _chunkDataMap = new Dictionary<int, SceneChunk>();

	private readonly Dictionary<int, SceneChunkNodeTempLoader> _tempChunkLoaders = new Dictionary<int, SceneChunkNodeTempLoader>();

	private ILoadPartitionResult<ConfigWorldPartition_v2> _lastLoadPartitionResult;

	private CancellationTokenSource _currLoadTokenSource;

	private AssetLoadHandle _currentWorldBlueprintHandle;

	internal override bool NeedGotChunkChange => false;

	public ConfigWorldPartition_v2 ActivePartition { get; private set; }

	public async UniTask<bool> LoadTempChunk(int chunkId, int stateIndex, bool loadStateObjects, bool loadMonster = false)
	{
		if (_tempChunkLoaders.ContainsKey(chunkId))
		{
			return false;
		}
		if (_chunkDataMap.TryGetValue(chunkId, out var value))
		{
			SceneBlock valueOrDefault = value.SubScenes.GetValueOrDefault(stateIndex, null);
			if (valueOrDefault != null)
			{
				SceneChunkNodeTempLoader sceneChunkNodeTempLoader = SceneChunkNodeTempLoader.Create(chunkId, valueOrDefault, value.StateWorldAssetDatas, loadStateObjects, loadMonster);
				_tempChunkLoaders[chunkId] = sceneChunkNodeTempLoader;
				return await sceneChunkNodeTempLoader.Load();
			}
		}
		return false;
	}

	public void UnloadTempChunk(int chunkId)
	{
		if (_tempChunkLoaders.Remove(chunkId, out var value))
		{
			value.Unload();
		}
	}

	private async UniTask ReleaseChunkCaches()
	{
		IEnumerable<UniTask> releaseTasks = _chunkNodeCaches.Select((KeyValuePair<int, SceneChunkRuntimeControlBase> nodeCache) => nodeCache.Value.Release());
		_chunkNodeCaches.Clear();
		await UniTask.WaitUntil(() =>
		{
			foreach (UniTask item in releaseTasks)
			{
				if (item.Status != UniTaskStatus.Succeeded)
				{
					return false;
				}
			}
			return true;
		});
	}

	private void AppendPartitionInteractTables(ConfigWorldPartition_v2 partition)
	{
		if (!(partition == null))
		{
			SceneChunk[] sceneChunks = partition.SceneChunks;
			foreach (SceneChunk holder in sceneChunks)
			{
				Singleton<GameManager>.instance.worldManager.AppendWorldStateAssetTable(holder);
			}
		}
	}

	private void RemovePartitionInteractTables(ConfigWorldPartition_v2 partition)
	{
		if (!(partition == null))
		{
			SceneChunk[] sceneChunks = partition.SceneChunks;
			foreach (SceneChunk holder in sceneChunks)
			{
				Singleton<GameManager>.instance.worldManager.RemoveWorldStateAssetTable(holder);
			}
		}
	}

	public async UniTask<ILoadPartitionResult<ConfigWorldPartition_v2>> SetupWorldPartition(int partitionConfigId, SceneStatus worldType)
	{
		if (ActivePartition == null || ActivePartition.Id != partitionConfigId)
		{
			ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = (_lastLoadPartitionResult = await WorldPartitionSetting.Data.TryLoadPartition(partitionConfigId, worldType == SceneStatus.Main));
			if (loadPartitionResult.Success)
			{
				SetupWorldPartition(loadPartitionResult.Data, worldType);
				SceneChunkLoadUnloadUtils.ReportSubProgress(0.05f);
			}
			else
			{
				Debug.LogError($"【错误】无法加载世界分区配置，ID:{partitionConfigId}");
			}
		}
		return _lastLoadPartitionResult;
	}

	private void SetupWorldPartition(ConfigWorldPartition_v2 partition, SceneStatus type)
	{
		if (ActivePartition != null)
		{
			ReleaseActivePartition().Forget();
		}
		AppendPartitionInteractTables(partition);
		_activeSceneType = type;
		ActivePartition = partition;
		Singleton<GameManager>.instance.worldManager.NotifyWorldChanged(partition);
		_chunkDataMap.Clear();
		SceneChunk[] sceneChunks = partition.SceneChunks;
		foreach (SceneChunk sceneChunk in sceneChunks)
		{
			_chunkDataMap[sceneChunk.ChunkId] = sceneChunk;
		}
		if (_chunkDataMap.Count == 0)
		{
			Debug.LogError($"【错误】当前世界[{partition.Id}]配置中, Chunk的数量为0，请关卡检查场景配置数据！！！！");
		}
	}

	public async UniTask<IPreparePosResult> PreparePos(int chunkId, Vector3 pos, bool clearLastChunk)
	{
		if (!TryGetChunkNode(chunkId, out var chunkNode))
		{
			return PreparePosResult.InvalidResult;
		}
		await SwitchActiveChunk(chunkNode, clearLastChunk);
		return MakePreparePosResult(_activeChunkNode, pos);
	}

	private PreparePosResult MakePreparePosResult(SceneChunkRuntimeControlBase chunkNodeControl, Vector3 fixedPos, bool success = true)
	{
		return new PreparePosResult(success, fixedPos, chunkNodeControl);
	}

	private async UniTask<bool> SwitchActiveChunk(SceneChunkRuntimeControlBase chunk, bool clearLastChunk, LoadInstruction instruction = null)
	{
		if (_activeChunkNode != null && _activeChunkNode.ChunkId == chunk.ChunkId && !_activeChunkNode.StateIsChanged)
		{
			return false;
		}
		string nextSceneName = GetSceneReportName(chunk);
		ReportStartChangeScene(nextSceneName);
		CancellationTokenSource currLoadTokenSource = _currLoadTokenSource;
		if (currLoadTokenSource != null && !currLoadTokenSource.IsCancellationRequested)
		{
			_currLoadTokenSource.Cancel();
		}
		UniTask unloadTask = UniTask.CompletedTask;
		if (_activeChunkNode != null)
		{
			unloadTask = _activeChunkNode.Unload();
		}
		if (clearLastChunk)
		{
			Singleton<GameManager>.instance.worldManager.ClearLastChunk();
		}
		CancellationTokenSource syncInit = new CancellationTokenSource();
		CancellationToken token = syncInit.Token;
		_currLoadTokenSource = new CancellationTokenSource();
		_activeChunkNode = chunk;
		UnityEngine.ThreadPriority lastLoadPriority = Application.backgroundLoadingPriority;
		bool needResetLoadPriority = false;
		if (lastLoadPriority < UnityEngine.ThreadPriority.High)
		{
			needResetLoadPriority = true;
			Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.High;
		}
		UniTask loadTask = chunk.Load(_currLoadTokenSource.Token, token, instruction);
		while (unloadTask.Status == UniTaskStatus.Pending || loadTask.Status == UniTaskStatus.Pending)
		{
			await UniTask.NextFrame();
		}
		Singleton<GameManager>.instance.worldManager.NotifyChunkChanged(chunk);
		ReportSceneChange(nextSceneName);
		AssetStationManager.RequestUnloadUnusedUnityAssets();
		if (needResetLoadPriority)
		{
			Application.backgroundLoadingPriority = lastLoadPriority;
		}
		syncInit.Cancel();
		await UniTask.NextFrame();
		ReportEndChangeScene();
		return true;
	}

	private string GetSceneReportName(SceneChunkRuntimeControlBase chunk)
	{
		string text = $"[{chunk.WorldConfigId}]" + chunk.Data.DebugName;
		SceneBlock conditionAvailableBlock = chunk.GetConditionAvailableBlock();
		if (conditionAvailableBlock != null && text != conditionAvailableBlock.DebugSceneName)
		{
			text = text + "(" + conditionAvailableBlock.DebugSceneName + ")";
		}
		return text;
	}

	private void ReportEndChangeScene()
	{
		try
		{
			LuminApplication.APM.GPM.EndSceneLoad();
			LuminApplication.APM.AnalyserDump();
		}
		catch (Exception ex)
		{
			Debug.LogError("上报UWA异常:" + ex);
		}
	}

	private void ReportStartChangeScene(string sceneName)
	{
		try
		{
			LuminApplication.APM.GPM.BeginSceneLoad(sceneName);
		}
		catch (Exception ex)
		{
			Debug.LogError("上报UWA异常:" + ex);
		}
	}

	private void ReportSceneChange(string sceneName)
	{
		try
		{
			LuminApplication.APM.GPM.ChangeScene(sceneName);
			LuminApplication.APM.AnalyserTag(sceneName);
		}
		catch (Exception ex)
		{
			Debug.LogError("上报UWA异常:" + ex);
		}
	}

	private bool TryGetChunkNode(int chunkId, out SceneChunkRuntimeControlBase chunkNode)
	{
		if (_activeSceneType == SceneStatus.Main)
		{
			if (chunkId <= 0)
			{
				chunkId = _activeChunkNode?.ChunkId ?? chunkId;
				if (_activeChunkNode != null)
				{
					chunkId = _activeChunkNode.ChunkId;
					Debug.LogWarning($"正在用当前场景的Chunk[{chunkId}]作为TP操作的目标Chunk");
				}
				else if (!WorldUtils.InGameWorldIdRange(ActivePartition.Id))
				{
					Debug.LogError("【错误】无法找到当前已经生效的场景。逻辑可能已经出错！！！");
				}
			}
		}
		else if (chunkId <= 0)
		{
			chunkId = _chunkDataMap.FirstOrDefault().Value.ChunkId;
			Debug.LogWarning($"正在用当前世界的第一个Chunk[{chunkId}]作为TP操作的目标Chunk");
		}
		if (_chunkNodeCaches.TryGetValue(chunkId, out chunkNode))
		{
			return true;
		}
		if (!_chunkDataMap.TryGetValue(chunkId, out var value))
		{
			return false;
		}
		if (value.BulkMode == SceneChunkType.BulkMode)
		{
			chunkNode = new SceneChunkRuntimeControl_BulkMode(value);
		}
		else
		{
			chunkNode = new SceneChunkRuntimeControl_NormalMode(value);
		}
		_chunkNodeCaches[chunkId] = chunkNode;
		return true;
	}

	internal ISceneChunkControl GetActiveChunk()
	{
		return _activeChunkNode;
	}

	internal async UniTask ReleaseActivePartition()
	{
		if (ActivePartition == null)
		{
			return;
		}
		ConfigWorldPartition_v2 releasePartition = ActivePartition;
		HashSet<UniTask> releaseTasks = new HashSet<UniTask>();
		if (_activeChunkNode != null)
		{
			releaseTasks.Add(_activeChunkNode.Unload());
			_activeChunkNode = null;
		}
		_chunkDataMap?.Clear();
		releaseTasks.Add(ReleaseChunkCaches());
		RemovePartitionInteractTables(releasePartition);
		ActivePartition = null;
		await UniTask.WaitUntil(() =>
		{
			foreach (UniTask item in releaseTasks)
			{
				if (item.Status != UniTaskStatus.Succeeded)
				{
					return false;
				}
			}
			return true;
		});
		Singleton<GameManager>.instance.worldManager.NotifyWorldReleased(releasePartition);
	}

	public MapArea GetMapAreaByChunkId(int chunkId)
	{
		return GetMapAreaByChunkId(chunkId, _activeSceneType);
	}

	public MapArea GetMapAreaByChunkId(int chunkId, SceneStatus sceneType)
	{
		if (sceneType == SceneStatus.Main)
		{
			return (MapArea)ConfigWorldChunkStoreBase.GetWorldMapIndex(ConfigWorldChunkStoreBase.GetWorldDefine(chunkId));
		}
		return MapArea.None;
	}

	public bool FindCurrentWorldChunk(int chunkId, out SceneChunk chunkData)
	{
		chunkData = null;
		if (ActivePartition != null)
		{
			return _chunkDataMap.TryGetValue(chunkId, out chunkData);
		}
		return false;
	}

	public async UniTask CreateWorldBlueprint()
	{
		if (!(ActivePartition != null) || !ActivePartition.HasWorldBlueprint || !ActivePartition.WorldBluePrintAssetID.IsValid())
		{
			await UniTask.CompletedTask;
			return;
		}
		_currentWorldBlueprintHandle = AssetStationManager.SceneStation.InstantiateAsync(ActivePartition.WorldBluePrintAssetID);
		await UniTask.WaitUntil(() => _currentWorldBlueprintHandle.IsDone);
		await UniTask.NextFrame();
	}

	public void ReleaseWorldBlueprint()
	{
		if (_currentWorldBlueprintHandle.IsValid)
		{
			AssetStationManager.SceneStation.ReleaseInstance(_currentWorldBlueprintHandle);
			_currentWorldBlueprintHandle = default;
		}
	}

	public Vector3 GetWorldSpawnPosition()
	{
		if (ActivePartition != null && ActivePartition.UseSpawnPosition)
		{
			return ActivePartition.SpawnPosition;
		}
		return Vector3.zero;
	}

	public void ReleaseAllTempChunks()
	{
		foreach (KeyValuePair<int, SceneChunkNodeTempLoader> tempChunkLoader in _tempChunkLoaders)
		{
			tempChunkLoader.Deconstruct(out var _, out var value);
			value.Unload();
		}
		_tempChunkLoaders.Clear();
	}
}
