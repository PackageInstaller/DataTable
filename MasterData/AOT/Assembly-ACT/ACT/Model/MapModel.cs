using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model.Jump;
using ACT.MultiPlayer;
using ACT.RichText;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Localization;
using UnityEngine.Rendering;

namespace ACT.Model;

public class MapModel : Model<MapModel>, IJumpable
{
	private enum ExploreFogSourceWaitResult
	{
		Ready,
		Invalidated
	}

	private readonly struct UnlockFogAnimationRequest(int unlockFogId, Vector2 characterUVPos)
	{
		public readonly int unlockFogId = unlockFogId;

		public readonly Vector2 characterUVPos = characterUVPos;
	}

	private readonly struct UnlockFogAnimationContext(int unlockFogId, AssetLoadHandle sourceTextureHandle, Texture2D sourceTexture, Vector4 sourcePointUV, Vector4 characterData)
	{
		public readonly int UnlockFogId = unlockFogId;

		public readonly AssetLoadHandle SourceTextureHandle = sourceTextureHandle;

		public readonly Texture2D SourceTexture = sourceTexture;

		public readonly Vector4 SourcePointUV = sourcePointUV;

		public readonly Vector4 CharacterData = characterData;
	}

	public class LayerExploreInfo
	{
		public Dictionary<Vector2Int, HashSet<Vector2Int>> gridInfo = new Dictionary<Vector2Int, HashSet<Vector2Int>>();

		public bool IsComplete;

		public int ChunkId;
	}

	public class AreaExploreInfo
	{
		public Dictionary<int, LayerExploreInfo> Chunks = new Dictionary<int, LayerExploreInfo>();

		public bool IsComplete;

		public int AreaId;

		public LayerExploreInfo GetOrCreateChunkExploreInfo(int chunkId)
		{
			if (!Chunks.TryGetValue(chunkId, out var value))
			{
				value = new LayerExploreInfo
				{
					ChunkId = chunkId,
					IsComplete = false
				};
				Chunks.Add(chunkId, value);
			}
			return value;
		}

		public LayerExploreInfo GetChunkExploreInfo(int chunkId)
		{
			return Chunks.GetValueOrDefault(chunkId);
		}

		public bool TryGetNearbyGridInfo(Vector2Int gridId, float maxDistance, out HashSet<Vector2Int> gridInfo)
		{
			if (maxDistance <= 0f)
			{
				foreach (LayerExploreInfo value in Chunks.Values)
				{
					if (value.gridInfo.TryGetValue(gridId, out gridInfo))
					{
						return true;
					}
				}
				gridInfo = null;
				return false;
			}
			foreach (LayerExploreInfo value2 in Chunks.Values)
			{
				foreach (KeyValuePair<Vector2Int, HashSet<Vector2Int>> item in value2.gridInfo)
				{
					if (Vector2Int.Distance(gridId, item.Key) <= maxDistance)
					{
						gridInfo = item.Value;
						return true;
					}
				}
			}
			gridInfo = null;
			return false;
		}
	}

	public int m_DisableTPButtonCounter;

	private bool mainWoldDataInitFinish;

	private bool _mapExploreInfoReady;

	private CancellationTokenSource _cts;

	public int MAX_FRAME_DISPATCH_COUNT = 100;

	public const int canReceiveBranchTaskspriteId = 10909;

	private MapPointTraceInfo _currentTraceMapPoint;

	private MapPointTraceInfo _currentGuideMapPoint;

	private Dictionary<int, int> _mapNpcIdToSpriteId;

	private Dictionary<int, int> _mapIconIdToStateObjectMap;

	private Dictionary<int, Texture2D> _mapAreaToExploreFogMap;

	private Dictionary<int, AssetLoadHandle> _mapAreaToExploreFogHandleMap;

	private int _mapExploreFogLoadVersion;

	private int _pendingExploreFogSourceLoadCount;

	private int _pendingSpecialExploreFogMaskLoadCount;

	private bool _isInitialExploreFogRestore;

	private HashSet<(ACT.World.MapArea area, int fogId)> _unlockedSpecialExploreFogIds;

	private bool _showRewardBoxIcon;

	private Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture> eachAreaLayerUnlockFog;

	private readonly Queue<UnlockFogAnimationRequest> _unlockFogAnimationQueue = new Queue<UnlockFogAnimationRequest>();

	private bool _isUnlockFogAnimationPlaying;

	private Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture> eachAreaLayerExploreFog;

	private Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture> eachAreaLayerSpecialExploreFogMask;

	private int _fogOfWarUpdateKernelIndex = -1;

	private int _specialExploreFogMaskUpdateKernelIndex = -1;

	private int _exploreCompleteCheckKernelIndex = -1;

	private int _explorePosCheckKernelIndex = -1;

	private Dictionary<(ACT.World.MapArea, MapLayer), (int threadGroupX, int threadGroupY)> _areaLayerDispatchCache;

	private Dictionary<ACT.World.MapArea, Vector2> _areaLeftBottomPosCache;

	private HashSet<long> _exploreCompleteCheckPendingChunkIds;

	private Dictionary<ACT.World.MapArea, Texture2D> _areaExploreFogCpuMaskCache;

	private HashSet<ACT.World.MapArea> _dirtyAreaExploreFogCpuMaskCache;

	private Dictionary<ACT.World.MapArea, int> _areaExploreFogVersion;

	private const float ExploreCompleteRatioThreshold = 0.9f;

	private const byte ExploreCompleteMaskThreshold = 128;

	private const int MaxExploreFogRestoreRetryCount = 5;

	private MapViewRecordParam needSyncMapViewRecordParam = new MapViewRecordParam();

	private Vector2 lastPlayerWorldPos = Vector2.zero;

	private Dictionary<ACT.World.MapArea, AreaExploreInfo> mapExploreInfo = new Dictionary<ACT.World.MapArea, AreaExploreInfo>();

	private float areaRtCreateRatio = 0.125f;

	private List<int> unlockInteractObjectId;

	private Dictionary<MapLayer, List<int>> eachLayerUnlockInteractObjId;

	private HashSet<int> hasUnlockFog = new HashSet<int>();

	private Dictionary<(ACT.World.MapArea area, MapLayer layer), Dictionary<Vector2Int, MapGridData>> mapAreaLayerGridData;

	private Dictionary<int, MapGridData> dynamicNpcId2MapGridData;

	private Dictionary<int, MapGridData> missionPointId2MapGridData;

	private Dictionary<(ACT.World.MapArea area, MapLayer layer), HashSet<MissionPointData>> mapAreaLayerMissionPointData;

	private Action<MapModelDynamicNpcData, Vector2Int> m_OnMapModelDynamicNpcStateUpdate;

	private Action m_OnMapModelMissionPointUpdate;

	private Dictionary<ACT.World.MapArea, AreaExploreData> allAreaExploreDataDic = new Dictionary<ACT.World.MapArea, AreaExploreData>();

	private Dictionary<int, List<ExplorationReward>> allAreaExploreRewardDic;

	private HashSet<int> validExploreObjectType;

	public MapPointTraceInfo CurrentTraceMapPoint => _currentTraceMapPoint;

	public MapPointTraceInfo CurrentGuideMapPoint => _currentGuideMapPoint;

	public bool ShowRewardBoxIcon
	{
		get
		{
			return _showRewardBoxIcon;
		}
		set
		{
			_showRewardBoxIcon = value;
		}
	}

	public IReadOnlyDictionary<int, int> MapIconIdToStateObjectMap => _mapIconIdToStateObjectMap;

	public Dictionary<int, int> MapNpcIdToSpriteId => _mapNpcIdToSpriteId;

	public bool MainWorldDataInitFinish => mainWoldDataInitFinish;

	private MapConfig mapConfig => GameLoader.meta.mapConfig;

	public List<int> UnlockInteractObjectId => unlockInteractObjectId;

	public bool DisableTPButton => m_DisableTPButtonCounter > 0;

	public LuminModelType JumpSourceType => LuminModelType.Map;

	public event Action<MapModelDynamicNpcData, Vector2Int> OnMapModelDynamicNpcStateUpdate
	{
		add
		{
			m_OnMapModelDynamicNpcStateUpdate = (Action<MapModelDynamicNpcData, Vector2Int>)Delegate.Combine(m_OnMapModelDynamicNpcStateUpdate, value);
		}
		remove
		{
			m_OnMapModelDynamicNpcStateUpdate = (Action<MapModelDynamicNpcData, Vector2Int>)Delegate.Remove(m_OnMapModelDynamicNpcStateUpdate, value);
		}
	}

	public event Action OnMapModelMissionPointUpdate
	{
		add
		{
			m_OnMapModelMissionPointUpdate = (Action)Delegate.Combine(m_OnMapModelMissionPointUpdate, value);
		}
		remove
		{
			m_OnMapModelMissionPointUpdate = (Action)Delegate.Remove(m_OnMapModelMissionPointUpdate, value);
		}
	}

	protected override void Init()
	{
		m_DisableTPButtonCounter = 0;
		_cts = new CancellationTokenSource();
		_mapIconIdToStateObjectMap = DictionaryPool<int, int>.Get();
		_mapNpcIdToSpriteId = DictionaryPool<int, int>.Get();
		_mapAreaToExploreFogMap = DictionaryPool<int, Texture2D>.Get();
		_mapAreaToExploreFogHandleMap = DictionaryPool<int, AssetLoadHandle>.Get();
		_unlockedSpecialExploreFogIds = new HashSet<(ACT.World.MapArea, int)>();
		_showRewardBoxIcon = false;
		Interlocked.Exchange(ref _pendingExploreFogSourceLoadCount, 0);
		_mapExploreInfoReady = false;
		Interlocked.Exchange(ref _pendingSpecialExploreFogMaskLoadCount, 0);
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		worldManager.RegisterOnMapChangedCallback(OnMapChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Accept, OnMissionAccept);
	}

	private void OnMissionAccept(BaseEventContent content)
	{
		if (content is MissionNAcceptEvt missionNAcceptEvt)
		{
			MapPointTraceInfo currentTraceMapPoint = CurrentTraceMapPoint;
			if (currentTraceMapPoint != null && currentTraceMapPoint.pointId == missionNAcceptEvt.missionId && currentTraceMapPoint.iconType == MapIconType.SideMission && Singleton<MissionManager>.instance.GetMissionConfig(missionNAcceptEvt.missionId).IsValid)
			{
				MapSetupTracePoint((int)currentTraceMapPoint.mapArea, currentTraceMapPoint.pointId, (int)currentTraceMapPoint.iconType, isCancel: true);
			}
		}
	}

	public void OnMapChanged(int mapId, int oldMapId)
	{
		_mapExploreFogLoadVersion++;
		ReleaseCachedExploreFogHandles();
		_mapAreaToExploreFogMap?.Clear();
		Interlocked.Exchange(ref _pendingExploreFogSourceLoadCount, 0);
		if (_mapAreaToExploreFogMap == null || _mapAreaToExploreFogHandleMap == null || !mapConfig.chunkBoundData.TryGetValue((ACT.World.MapArea)mapId, out var value))
		{
			return;
		}
		int currentLoadVersion = _mapExploreFogLoadVersion;
		foreach (int chunkId in value.Keys)
		{
			string assetID = NameUtility.GetChunkUnlockFogAddress(chunkId) + ".png";
			if (!AssetStationManager.BattleStation.AssetExists(assetID))
			{
				continue;
			}
			Interlocked.Increment(ref _pendingExploreFogSourceLoadCount);
			try
			{
				AssetLoadHandle value2 = AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID, (AssetLoadHandle result) =>
				{
					bool flag = false;
					try
					{
						if (currentLoadVersion == _mapExploreFogLoadVersion)
						{
							Texture2D texture2D = result.As<Texture2D>();
							if (!(texture2D == null))
							{
								_mapAreaToExploreFogMap[chunkId] = texture2D;
								flag = true;
								if (!_isInitialExploreFogRestore)
								{
									RefreshExploreFogForChunk((ACT.World.MapArea)mapId, chunkId, Singleton<GameManager>.instance.worldManager.ActiveChunkId == chunkId);
								}
							}
						}
					}
					finally
					{
						if (currentLoadVersion == _mapExploreFogLoadVersion)
						{
							Interlocked.Decrement(ref _pendingExploreFogSourceLoadCount);
						}
						if (!flag)
						{
							if (currentLoadVersion == _mapExploreFogLoadVersion)
							{
								_mapAreaToExploreFogHandleMap.Remove(chunkId);
							}
							AssetStationManager.BattleStation.Release(result, showError: false);
						}
					}
				});
				_mapAreaToExploreFogHandleMap[chunkId] = value2;
			}
			catch
			{
				Interlocked.Decrement(ref _pendingExploreFogSourceLoadCount);
				throw;
			}
		}
	}

	private void EnsureExploreFogSourceLoadStarted(ACT.World.MapArea area)
	{
		if (area == ACT.World.MapArea.None || Volatile.Read(ref _pendingExploreFogSourceLoadCount) > 0 || !mapConfig.chunkBoundData.TryGetValue(area, out var value) || value.Count == 0)
		{
			return;
		}
		foreach (int key in value.Keys)
		{
			if (!_mapAreaToExploreFogMap.ContainsKey(key))
			{
				OnMapChanged((int)area, (int)area);
				break;
			}
		}
	}

	public void OnChunkChanged(int chunkId, int oldChunkId)
	{
		if (mainWoldDataInitFinish && _cts != null)
		{
			ACT.World.MapArea currentWorldMapAreaByChunkId = Singleton<GameManager>.instance.worldManager.GetCurrentWorldMapAreaByChunkId(chunkId);
			if (currentWorldMapAreaByChunkId != ACT.World.MapArea.None)
			{
				RefreshExploreFogForChunk(currentWorldMapAreaByChunkId, chunkId, includeCurrentPosition: true);
			}
		}
	}

	public void MainWorldDataInit()
	{
		try
		{
			if (mainWoldDataInitFinish)
			{
				return;
			}
			foreach (KeyValuePair<int, StateWorldAssetData> item in Singleton<GameManager>.instance.worldManager.ActiveWorldStateAssetTable)
			{
				if (item.Value is PortalData portalData)
				{
					_mapIconIdToStateObjectMap[portalData.iconDataId] = item.Value.stateWorldAssetUid;
				}
			}
			if (unlockInteractObjectId == null)
			{
				unlockInteractObjectId = new List<int>();
			}
			if (eachLayerUnlockInteractObjId == null)
			{
				eachLayerUnlockInteractObjId = new Dictionary<MapLayer, List<int>>();
			}
			MapUtility.AddUnlockIndex();
			InitMapAreaLayerGridData();
			CreateAllUnlockFogRt();
			InitUnlockFog();
			CreateAllExploreFogRt();
			InitSpecialExploreFogMasks();
			InitSpecialExploreFog();
			AsyncUpdateExploreFogAfterSourceReady(_cts.Token).Forget();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnServiceSaveRefresh);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, CheckExploreRatioOnServiceSaveRefresh);
			mainWoldDataInitFinish = true;
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	private async UniTaskVoid AsyncUpdateExploreFogAfterSourceReady(CancellationToken token)
	{
		while (!token.IsCancellationRequested && !_mapExploreInfoReady)
		{
			await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
		}
		if (token.IsCancellationRequested)
		{
			return;
		}
		WorldManager worldMgr = Singleton<GameManager>.instance.worldManager;
		while (!token.IsCancellationRequested && worldMgr.ActiveMapId == 0)
		{
			await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
		}
		if (token.IsCancellationRequested)
		{
			return;
		}
		ACT.World.MapArea activeArea = (ACT.World.MapArea)worldMgr.ActiveMapId;
		EnsureExploreFogSourceLoadStarted(activeArea);
		if (await WaitForExploreFogSourcesAsync(activeArea, _mapExploreFogLoadVersion, token) == ExploreFogSourceWaitResult.Invalidated)
		{
			await RetryRestoreExploreFogAsync(worldMgr, BuildExploreFogRestoreAreas(activeArea), token);
			return;
		}
		while (!token.IsCancellationRequested && Volatile.Read(ref _pendingSpecialExploreFogMaskLoadCount) > 0)
		{
			await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
		}
		if (!token.IsCancellationRequested)
		{
			activeArea = (ACT.World.MapArea)worldMgr.ActiveMapId;
			if (activeArea != ACT.World.MapArea.None)
			{
				UpdateExploreFog(activeArea, worldMgr.ActiveChunkId, MapUtility.playerPos);
			}
			HashSet<ACT.World.MapArea> areasToRestore = BuildExploreFogRestoreAreas(activeArea);
			if (!(await RestoreExploreFogForAllAreas(activeArea, worldMgr.ActiveChunkId, areasToRestore, token)))
			{
				await RetryRestoreExploreFogAsync(worldMgr, areasToRestore, token);
			}
		}
	}

	private async UniTask RetryRestoreExploreFogAsync(WorldManager worldMgr, HashSet<ACT.World.MapArea> areasToRestore, CancellationToken token)
	{
		for (int retryCount = 0; retryCount < 5; retryCount++)
		{
			if (token.IsCancellationRequested)
			{
				break;
			}
			if (areasToRestore.Count <= 0)
			{
				break;
			}
			await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
			if (token.IsCancellationRequested)
			{
				break;
			}
			ACT.World.MapArea activeArea = (ACT.World.MapArea)worldMgr.ActiveMapId;
			if (activeArea == ACT.World.MapArea.None)
			{
				continue;
			}
			EnsureExploreFogSourceLoadStarted(activeArea);
			int mapExploreFogLoadVersion = _mapExploreFogLoadVersion;
			if (await WaitForExploreFogSourcesAsync(activeArea, mapExploreFogLoadVersion, token) == ExploreFogSourceWaitResult.Invalidated)
			{
				OnMapChanged((int)activeArea, (int)activeArea);
				continue;
			}
			while (!token.IsCancellationRequested && Volatile.Read(ref _pendingSpecialExploreFogMaskLoadCount) > 0)
			{
				await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
			}
			if (token.IsCancellationRequested || await RestoreExploreFogForAllAreas(activeArea, worldMgr.ActiveChunkId, areasToRestore, token))
			{
				break;
			}
		}
	}

	private async UniTask<ExploreFogSourceWaitResult> WaitForExploreFogSourcesAsync(ACT.World.MapArea area, int loadVersion, CancellationToken token)
	{
		if (_mapAreaToExploreFogMap == null || _mapAreaToExploreFogHandleMap == null || !mapConfig.chunkBoundData.TryGetValue(area, out var value))
		{
			return ExploreFogSourceWaitResult.Invalidated;
		}
		foreach (int chunkId in value.Keys)
		{
			string text = NameUtility.GetChunkUnlockFogAddress(chunkId) + ".png";
			if (!AssetStationManager.BattleStation.AssetExists(text))
			{
				Debug.LogWarning($"Explore fog source asset is missing, skip chunk. area={area}, chunkId={chunkId}, assetId={text}");
				continue;
			}
			if (token.IsCancellationRequested || loadVersion != _mapExploreFogLoadVersion)
			{
				return ExploreFogSourceWaitResult.Invalidated;
			}
			if (!_mapAreaToExploreFogMap.ContainsKey(chunkId) && !_mapAreaToExploreFogHandleMap.ContainsKey(chunkId))
			{
				return ExploreFogSourceWaitResult.Invalidated;
			}
			Texture2D value2;
			while (!token.IsCancellationRequested && loadVersion == _mapExploreFogLoadVersion && (!_mapAreaToExploreFogMap.TryGetValue(chunkId, out value2) || value2 == null))
			{
				if (!_mapAreaToExploreFogHandleMap.ContainsKey(chunkId))
				{
					return ExploreFogSourceWaitResult.Invalidated;
				}
				await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
			}
			if (!token.IsCancellationRequested && loadVersion == _mapExploreFogLoadVersion)
			{
				continue;
			}
			return ExploreFogSourceWaitResult.Invalidated;
		}
		if (token.IsCancellationRequested || loadVersion != _mapExploreFogLoadVersion)
		{
			return ExploreFogSourceWaitResult.Invalidated;
		}
		return ExploreFogSourceWaitResult.Ready;
	}

	private HashSet<ACT.World.MapArea> BuildExploreFogRestoreAreas(ACT.World.MapArea activeArea)
	{
		HashSet<ACT.World.MapArea> hashSet = ((mapExploreInfo == null) ? new HashSet<ACT.World.MapArea>() : new HashSet<ACT.World.MapArea>(mapExploreInfo.Keys));
		if (!hashSet.Contains(activeArea))
		{
			hashSet.Add(activeArea);
		}
		return hashSet;
	}

	private async UniTask<bool> RestoreExploreFogForAllAreas(ACT.World.MapArea activeArea, int activeChunkId, HashSet<ACT.World.MapArea> areasToRestore, CancellationToken token)
	{
		List<ACT.World.MapArea> restoreAreas = new List<ACT.World.MapArea>(areasToRestore);
		_isInitialExploreFogRestore = true;
		try
		{
			foreach (ACT.World.MapArea area in restoreAreas)
			{
				if (token.IsCancellationRequested)
				{
					return false;
				}
				OnMapChanged((int)area, (int)area);
				int mapExploreFogLoadVersion = _mapExploreFogLoadVersion;
				if (await WaitForExploreFogSourcesAsync(area, mapExploreFogLoadVersion, token) == ExploreFogSourceWaitResult.Invalidated)
				{
					return false;
				}
				if (token.IsCancellationRequested || mapExploreInfo == null || !mapExploreInfo.TryGetValue(area, out var value))
				{
					areasToRestore.Remove(area);
					continue;
				}
				if (value.IsComplete)
				{
					UpdateExploreFogAreaComplete(area);
					areasToRestore.Remove(area);
					continue;
				}
				foreach (LayerExploreInfo value2 in value.Chunks.Values)
				{
					if (token.IsCancellationRequested)
					{
						return false;
					}
					await AsyncUpdateExploreFogForChunk(area, value2.ChunkId, token);
				}
				areasToRestore.Remove(area);
			}
		}
		finally
		{
			_isInitialExploreFogRestore = false;
		}
		if (token.IsCancellationRequested || activeArea == ACT.World.MapArea.None)
		{
			return false;
		}
		if (restoreAreas.Count == 0 || restoreAreas[restoreAreas.Count - 1] != activeArea)
		{
			OnMapChanged((int)activeArea, (int)activeArea);
			int mapExploreFogLoadVersion2 = _mapExploreFogLoadVersion;
			if (await WaitForExploreFogSourcesAsync(activeArea, mapExploreFogLoadVersion2, token) == ExploreFogSourceWaitResult.Invalidated)
			{
				return false;
			}
		}
		if (!token.IsCancellationRequested)
		{
			UpdateExploreFog(activeArea, activeChunkId, MapUtility.playerPos);
		}
		return !token.IsCancellationRequested;
	}

	private async UniTask AsyncUpdateExploreFogForChunk(ACT.World.MapArea area, int chunkId, CancellationToken token)
	{
		if (mapExploreInfo == null || !mapExploreInfo.TryGetValue(area, out var value) || !value.Chunks.TryGetValue(chunkId, out var value2))
		{
			return;
		}
		if (value.IsComplete)
		{
			UpdateExploreFogAreaComplete(area);
			return;
		}
		if (value2.IsComplete)
		{
			UpdateExploreFogChunkComplete(area, chunkId);
			return;
		}
		Dictionary<Vector2Int, List<Vector2Int>> dictionary = new Dictionary<Vector2Int, List<Vector2Int>>();
		foreach (var (key, collection) in value2.gridInfo)
		{
			dictionary[key] = new List<Vector2Int>(collection);
		}
		List<Vector2> positionsBatch = new List<Vector2>(MAX_FRAME_DISPATCH_COUNT);
		foreach (List<Vector2Int> value3 in dictionary.Values)
		{
			foreach (Vector2Int item in value3)
			{
				if (token.IsCancellationRequested)
				{
					return;
				}
				positionsBatch.Add(item);
				if (positionsBatch.Count >= MAX_FRAME_DISPATCH_COUNT)
				{
					UpdateExploreFogBatch(area, chunkId, positionsBatch);
					positionsBatch.Clear();
					await UniTask.NextFrame().AttachExternalCancellation(token).SuppressCancellationThrow();
				}
			}
		}
		if (positionsBatch.Count > 0)
		{
			UpdateExploreFogBatch(area, chunkId, positionsBatch);
		}
	}

	private void RefreshExploreFogForChunk(ACT.World.MapArea area, int chunkId, bool includeCurrentPosition)
	{
		if (mainWoldDataInitFinish && _cts != null && _mapAreaToExploreFogMap.ContainsKey(chunkId))
		{
			if (includeCurrentPosition)
			{
				UpdateExploreFog(area, chunkId, MapUtility.playerPos);
			}
			AsyncUpdateExploreFogForChunk(area, chunkId, _cts.Token).Forget();
		}
	}

	protected override void UnInit()
	{
		m_DisableTPButtonCounter = 0;
		_mapExploreFogLoadVersion++;
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		unlockInteractObjectId?.Clear();
		eachLayerUnlockInteractObjId?.Clear();
		mapExploreInfo?.Clear();
		_currentTraceMapPoint = null;
		_currentGuideMapPoint = null;
		allAreaExploreRewardDic = null;
		allAreaExploreDataDic.Clear();
		_showRewardBoxIcon = false;
		_areaLayerDispatchCache?.Clear();
		_areaLeftBottomPosCache?.Clear();
		_exploreCompleteCheckPendingChunkIds?.Clear();
		ReleaseExploreFogCpuMaskCache();
		_unlockedSpecialExploreFogIds?.Clear();
		_unlockedSpecialExploreFogIds = null;
		_fogOfWarUpdateKernelIndex = -1;
		_specialExploreFogMaskUpdateKernelIndex = -1;
		_exploreCompleteCheckKernelIndex = -1;
		_explorePosCheckKernelIndex = -1;
		_unlockFogAnimationQueue.Clear();
		_isUnlockFogAnimationPlaying = false;
		Interlocked.Exchange(ref _pendingSpecialExploreFogMaskLoadCount, 0);
		_mapExploreInfoReady = false;
		ReleaseRenderTextureDictionary(eachAreaLayerUnlockFog);
		ReleaseRenderTextureDictionary(eachAreaLayerExploreFog);
		ReleaseRenderTextureDictionary(eachAreaLayerSpecialExploreFogMask);
		eachAreaLayerUnlockFog = null;
		eachAreaLayerExploreFog = null;
		eachAreaLayerSpecialExploreFogMask = null;
		mainWoldDataInitFinish = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnServiceSaveRefresh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, CheckExploreRatioOnServiceSaveRefresh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Accept, OnMissionAccept);
		if (_mapIconIdToStateObjectMap != null)
		{
			DictionaryPool<int, int>.Release(_mapIconIdToStateObjectMap);
		}
		_mapIconIdToStateObjectMap = null;
		if (_mapNpcIdToSpriteId != null)
		{
			DictionaryPool<int, int>.Release(_mapNpcIdToSpriteId);
		}
		_mapNpcIdToSpriteId = null;
		if (_mapAreaToExploreFogMap != null)
		{
			ReleaseCachedExploreFogHandles();
			DictionaryPool<int, Texture2D>.Release(_mapAreaToExploreFogMap);
		}
		_mapAreaToExploreFogMap = null;
		if (_mapAreaToExploreFogHandleMap != null)
		{
			DictionaryPool<int, AssetLoadHandle>.Release(_mapAreaToExploreFogHandleMap);
		}
		_mapAreaToExploreFogHandleMap = null;
	}

	private void ReleaseCachedExploreFogHandles()
	{
		if (_mapAreaToExploreFogHandleMap == null)
		{
			return;
		}
		foreach (KeyValuePair<int, AssetLoadHandle> item in _mapAreaToExploreFogHandleMap)
		{
			if (AssetLoadHandleExtensions.IsValid(item.Value))
			{
				AssetStationManager.BattleStation.Release(item.Value);
			}
		}
		_mapAreaToExploreFogHandleMap.Clear();
	}

	private RenderTexture CreateAreaLayerUnlockFogRt(ACT.World.MapArea area, MapLayer layer)
	{
		var (width, height) = GetTextureSize(area);
		RenderTexture renderTexture;
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			renderTexture = new RenderTexture(1, 1, GraphicsFormat.R8_UNorm, GraphicsFormat.None);
		}
		else
		{
			renderTexture = new RenderTexture(width, height, GetFogRenderTextureFormat(), GraphicsFormat.None);
			renderTexture.enableRandomWrite = true;
		}
		renderTexture.name = $"{area}_{layer}_UnlockFog";
		renderTexture.Create();
		ClearRenderTexture(renderTexture);
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			Graphics.Blit(Texture2D.whiteTexture, renderTexture);
		}
		return renderTexture;
	}

	private void CreateAllUnlockFogRt()
	{
		ReleaseRenderTextureDictionary(eachAreaLayerUnlockFog);
		eachAreaLayerUnlockFog = new Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture>();
		foreach (var item in mapConfig.GetAllAreaLayer())
		{
			eachAreaLayerUnlockFog.Add(item, CreateAreaLayerUnlockFogRt(item.area, item.layer));
		}
	}

	public RenderTexture GetAreaLayerUnlockFogRt(ACT.World.MapArea area, MapLayer layer)
	{
		return eachAreaLayerUnlockFog?.GetValueOrDefault((area, layer));
	}

	public void UpdateUnlockFogWithoutUI(int unlockFogId)
	{
		(ACT.World.MapArea, MapLayer) unlockFogAreaLayer = mapConfig.GetUnlockFogAreaLayer(unlockFogId);
		if (mapConfig.IsDefaultUnlockArea(unlockFogAreaLayer.Item1) || !eachAreaLayerUnlockFog.TryGetValue(unlockFogAreaLayer, out var areaLayerRt))
		{
			return;
		}
		string assetID = NameUtility.GetChunkUnlockFogAddress(unlockFogId) + ".png";
		if (AssetStationManager.BattleStation.AssetExists(assetID))
		{
			AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID, (AssetLoadHandle result) =>
			{
				Texture2D texture = result.As<Texture2D>();
				ComputeShader mapFogCs = mapConfig.mapFogCs;
				int kernelIndex = mapFogCs.FindKernel("UnlockMistUpdate");
				mapFogCs.SetTexture(kernelIndex, "FogMask", areaLayerRt);
				mapFogCs.SetVector("_TargetResolution", new Vector4(areaLayerRt.width, areaLayerRt.height, 0f, 0f));
				mapFogCs.SetTexture(kernelIndex, "_Source", texture);
				Vector2[] unlockFogCornerUVPos = mapConfig.GetUnlockFogCornerUVPos(unlockFogId);
				mapFogCs.SetVector("_SourcePointUV", new Vector4(unlockFogCornerUVPos[0].x, unlockFogCornerUVPos[0].y, unlockFogCornerUVPos[2].x, unlockFogCornerUVPos[2].y));
				mapFogCs.SetTexture(kernelIndex, "_DissolveMap", Texture2D.whiteTexture);
				mapFogCs.SetFloat("_DissolveValue", 1f);
				mapFogCs.SetVector("_CharacterData", new Vector4(0f, 0f, 1f, 1f));
				mapFogCs.Dispatch(kernelIndex, Mathf.CeilToInt(areaLayerRt.width / 8), Mathf.CeilToInt(areaLayerRt.height / 8), 1);
				AssetStationManager.BattleStation.Release(result);
			});
		}
	}

	private void InitUnlockFog()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (StateWorldAssetData item in (from d in worldManager.FetchActiveWorldStateAssetDatas()
			where d is LightHouseData && d.stateId == -2
			select d).ToHashSet())
		{
			LightHouseData lightHouseData = item as LightHouseData;
			List<int> normalUnlockFogIds = lightHouseData.normalUnlockFogIds;
			bool flag = (normalUnlockFogIds == null || normalUnlockFogIds.Count <= 0) && lightHouseData.unlockFogId == 0;
			if ((lightHouseData == null) | flag)
			{
				continue;
			}
			if (lightHouseData.HasUnlockFog() && lightHouseData.normalUnlockFogIds != null)
			{
				foreach (int normalUnlockFogId in lightHouseData.normalUnlockFogIds)
				{
					if (normalUnlockFogId != 0)
					{
						AddUnlockFog(normalUnlockFogId);
						UpdateUnlockFogWithoutUI(normalUnlockFogId);
					}
				}
			}
			if (lightHouseData.hiddenRoomUids == null)
			{
				continue;
			}
			int[] hiddenRoomUids = lightHouseData.hiddenRoomUids;
			foreach (int num2 in hiddenRoomUids)
			{
				if (!StateWorldAssetData.IsValidID(num2))
				{
					continue;
				}
				StateWorldAssetData worldStateAssetDataBySGOID = worldManager.GetWorldStateAssetDataBySGOID(num2);
				if (worldStateAssetDataBySGOID == null)
				{
					continue;
				}
				HiddenRoomData hiddenRoomData = worldStateAssetDataBySGOID as HiddenRoomData;
				if (hiddenRoomData.stateId != 1)
				{
					continue;
				}
				foreach (int unlockChunkId in hiddenRoomData.unlockChunkIds)
				{
					if (unlockChunkId != 0)
					{
						AddUnlockFog(unlockChunkId);
						UpdateUnlockFogWithoutUI(unlockChunkId);
					}
				}
			}
		}
	}

	public void UpdateUnlockFogOnUnlockAnimationStart(int unlockFogId, Vector2 characterUVPos)
	{
		(ACT.World.MapArea, MapLayer) unlockFogAreaLayer = mapConfig.GetUnlockFogAreaLayer(unlockFogId);
		if (!mapConfig.IsDefaultUnlockArea(unlockFogAreaLayer.Item1) && eachAreaLayerUnlockFog.ContainsKey(unlockFogAreaLayer))
		{
			string assetID = NameUtility.GetChunkUnlockFogAddress(unlockFogId) + ".png";
			if (AssetStationManager.BattleStation.AssetExists(assetID))
			{
				_unlockFogAnimationQueue.Enqueue(new UnlockFogAnimationRequest(unlockFogId, characterUVPos));
				TryPlayNextUnlockFogAnimation();
			}
		}
	}

	private void TryPlayNextUnlockFogAnimation()
	{
		if (!_isUnlockFogAnimationPlaying && _unlockFogAnimationQueue.Count != 0)
		{
			UnlockFogAnimationRequest unlockFogAnimationRequest = _unlockFogAnimationQueue.Dequeue();
			_isUnlockFogAnimationPlaying = true;
			StartUnlockFogAnimation(unlockFogAnimationRequest.unlockFogId, unlockFogAnimationRequest.characterUVPos);
		}
	}

	private void CompleteUnlockFogAnimation()
	{
		_isUnlockFogAnimationPlaying = false;
		TryPlayNextUnlockFogAnimation();
	}

	private void StartUnlockFogAnimation(int unlockFogId, Vector2 characterUVPos)
	{
		(ACT.World.MapArea, MapLayer) unlockFogAreaLayer = mapConfig.GetUnlockFogAreaLayer(unlockFogId);
		if (mapConfig.IsDefaultUnlockArea(unlockFogAreaLayer.Item1))
		{
			CompleteUnlockFogAnimation();
			return;
		}
		if (!eachAreaLayerUnlockFog.ContainsKey(unlockFogAreaLayer))
		{
			CompleteUnlockFogAnimation();
			return;
		}
		string assetID = NameUtility.GetChunkUnlockFogAddress(unlockFogId) + ".png";
		if (!AssetStationManager.BattleStation.AssetExists(assetID))
		{
			CompleteUnlockFogAnimation();
			return;
		}
		AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID, (AssetLoadHandle result) =>
		{
			Texture2D texture2D = result.As<Texture2D>();
			if (texture2D == null)
			{
				AssetStationManager.BattleStation.Release(result);
				CompleteUnlockFogAnimation();
			}
			else
			{
				Vector2[] unlockFogCornerUVPos = mapConfig.GetUnlockFogCornerUVPos(unlockFogId);
				Vector4 sourcePointUV = new Vector4(unlockFogCornerUVPos[0].x, unlockFogCornerUVPos[0].y, unlockFogCornerUVPos[2].x, unlockFogCornerUVPos[2].y);
				float num = float.MinValue;
				Vector2 vector = Vector2.zero;
				Vector2[] unlockFogCornerUVPos2 = mapConfig.GetUnlockFogCornerUVPos(unlockFogId);
				foreach (Vector2 vector2 in unlockFogCornerUVPos2)
				{
					float num2 = Vector2.Distance(characterUVPos, vector2);
					if (num2 > num)
					{
						num = num2;
						vector = vector2;
					}
				}
				UnlockFogAnimationContext context = new UnlockFogAnimationContext(characterData: new Vector4(characterUVPos.x, characterUVPos.y, vector.x, vector.y), unlockFogId: unlockFogId, sourceTextureHandle: result, sourceTexture: texture2D, sourcePointUV: sourcePointUV);
				DoUpdateUnlockFog(context);
			}
		});
	}

	private async void DoUpdateUnlockFog(UnlockFogAnimationContext context)
	{
		try
		{
			float elapsedTime = 0f;
			while (elapsedTime < 0.5f)
			{
				UpdateUnlockFogOnAnimationPerFrame(context, elapsedTime / 0.5f);
				elapsedTime += Time.deltaTime;
				await UniTask.Yield();
			}
			UpdateUnlockFogOnAnimationPerFrame(context, 1f);
		}
		finally
		{
			if (AssetLoadHandleExtensions.IsValid(context.SourceTextureHandle))
			{
				AssetStationManager.BattleStation.Release(context.SourceTextureHandle);
			}
			CompleteUnlockFogAnimation();
		}
	}

	private void UpdateUnlockFogOnAnimationPerFrame(UnlockFogAnimationContext context, float ratio)
	{
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		int kernelIndex = mapFogCs.FindKernel("UnlockMistUpdate");
		(ACT.World.MapArea, MapLayer) unlockFogAreaLayer = mapConfig.GetUnlockFogAreaLayer(context.UnlockFogId);
		if (!mapConfig.IsDefaultUnlockArea(unlockFogAreaLayer.Item1) && eachAreaLayerUnlockFog.TryGetValue(unlockFogAreaLayer, out var value))
		{
			mapFogCs.SetTexture(kernelIndex, "FogMask", value);
			mapFogCs.SetVector("_TargetResolution", new Vector4(value.width, value.height, 0f, 0f));
			mapFogCs.SetTexture(kernelIndex, "_Source", context.SourceTexture);
			mapFogCs.SetVector("_SourcePointUV", context.SourcePointUV);
			mapFogCs.SetTexture(kernelIndex, "_DissolveMap", mapConfig.unlockAnimationTestTexture);
			mapFogCs.SetVector("_DissolveMap_ST", new Vector4(40f, 10f, 0f, 0f));
			mapFogCs.SetVector("_CharacterData", context.CharacterData);
			mapFogCs.SetFloat("_DissolveValue", ratio);
			mapFogCs.Dispatch(kernelIndex, Mathf.CeilToInt(value.width / 8), Mathf.CeilToInt(value.height / 8), 1);
		}
	}

	private RenderTexture CreateAreaLayerExploreFogRt(ACT.World.MapArea area, MapLayer layer)
	{
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			return null;
		}
		(int width, int height) textureSize = GetTextureSize(area);
		int item = textureSize.width;
		int item2 = textureSize.height;
		RenderTexture renderTexture = new RenderTexture(item, item2, GetFogRenderTextureFormat(), GraphicsFormat.None);
		renderTexture.name = $"{area}_{layer}_ExploreFog";
		renderTexture.enableRandomWrite = true;
		renderTexture.Create();
		ClearRenderTexture(renderTexture);
		return renderTexture;
	}

	private RenderTexture CreateAreaLayerSpecialExploreFogMaskRt(ACT.World.MapArea area, MapLayer layer)
	{
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			return null;
		}
		(int, int) textureSize = GetTextureSize(area);
		RenderTexture renderTexture = new RenderTexture(textureSize.Item1, textureSize.Item2, GetFogRenderTextureFormat(), GraphicsFormat.None);
		renderTexture.name = $"{area}_{layer}_SpecialExploreFogMask";
		renderTexture.enableRandomWrite = true;
		renderTexture.Create();
		ClearRenderTexture(renderTexture);
		return renderTexture;
	}

	private void CreateAllExploreFogRt()
	{
		ReleaseRenderTextureDictionary(eachAreaLayerExploreFog);
		ReleaseRenderTextureDictionary(eachAreaLayerSpecialExploreFogMask);
		ReleaseExploreFogCpuMaskCache();
		eachAreaLayerExploreFog = new Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture>();
		eachAreaLayerSpecialExploreFogMask = new Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture>();
		_areaLayerDispatchCache = new Dictionary<(ACT.World.MapArea, MapLayer), (int, int)>();
		_areaLeftBottomPosCache = new Dictionary<ACT.World.MapArea, Vector2>();
		_exploreCompleteCheckPendingChunkIds = new HashSet<long>();
		_areaExploreFogCpuMaskCache = new Dictionary<ACT.World.MapArea, Texture2D>();
		_dirtyAreaExploreFogCpuMaskCache = new HashSet<ACT.World.MapArea>();
		_areaExploreFogVersion = new Dictionary<ACT.World.MapArea, int>();
		if (mapConfig.mapFogCs != null)
		{
			_fogOfWarUpdateKernelIndex = mapConfig.mapFogCs.FindKernel("FogOfWarUpdate");
			_specialExploreFogMaskUpdateKernelIndex = mapConfig.mapFogCs.FindKernel("SpecialExploreFogMaskUpdate");
			_exploreCompleteCheckKernelIndex = mapConfig.mapFogCs.FindKernel("ExploreCompleteCheck");
			_explorePosCheckKernelIndex = mapConfig.mapFogCs.FindKernel("ExplorePosCheck");
		}
		foreach (var item3 in mapConfig.GetAllAreaLayer())
		{
			RenderTexture renderTexture = CreateAreaLayerExploreFogRt(item3.area, item3.layer);
			eachAreaLayerExploreFog.Add(item3, renderTexture);
			eachAreaLayerSpecialExploreFogMask.Add(item3, CreateAreaLayerSpecialExploreFogMaskRt(item3.area, item3.layer));
			if (renderTexture != null)
			{
				int item = Mathf.CeilToInt((float)renderTexture.width / 8f);
				int item2 = Mathf.CeilToInt((float)renderTexture.height / 8f);
				_areaLayerDispatchCache.Add(item3, (item, item2));
			}
			if (!_areaLeftBottomPosCache.ContainsKey(item3.area))
			{
				_areaLeftBottomPosCache.Add(item3.area, mapConfig.GetAreaLeftBottomWorldPos(item3.area));
			}
		}
	}

	public RenderTexture GetAreaLayerExploreFogRt(ACT.World.MapArea area, MapLayer layer)
	{
		return eachAreaLayerExploreFog?.GetValueOrDefault((area, layer));
	}

	private bool TryGetAreaExploreFogRt(ACT.World.MapArea area, out RenderTexture areaLayerRt)
	{
		(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
		if (eachAreaLayerExploreFog != null && eachAreaLayerExploreFog.TryGetValue(key, out areaLayerRt) && areaLayerRt != null)
		{
			return true;
		}
		areaLayerRt = null;
		return false;
	}

	public bool IsPosExploredByFogMask(ACT.World.MapArea area, Vector2 worldPos)
	{
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			return true;
		}
		if (!TryGetAreaExploreFogRt(area, out var areaLayerRt) || !TryGetAreaExploreFogCpuMaskCache(area, areaLayerRt, out var cpuMask))
		{
			return false;
		}
		Vector2 vector = (_areaLeftBottomPosCache.TryGetValue(area, out var value) ? value : mapConfig.GetAreaLeftBottomWorldPos(area));
		Vector2 vector2 = (worldPos + mapConfig.worldExploreFogOffset - vector) * (mapConfig.largeMapRatio * areaRtCreateRatio);
		int num = Mathf.FloorToInt(vector2.x);
		int num2 = Mathf.FloorToInt(vector2.y);
		if (num < 0 || num >= cpuMask.width || num2 < 0 || num2 >= cpuMask.height)
		{
			return false;
		}
		return cpuMask.GetPixel(num, num2).r >= 128f / 255f;
	}

	private async UniTask ProcessExplorePosReadbackAsync(AsyncGPUReadbackRequest request, ComputeBuffer queryBuffer, ComputeBuffer resultBuffer, int count, Action<bool[]> callback)
	{
		bool[] explored = null;
		Exception readbackException = null;
		try
		{
			await UniTask.WaitUntil(() => request.done);
			if (request.hasError)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("批量探索检测失败，GPU=" + SystemInfo.graphicsDeviceName + ", " + $"API={SystemInfo.graphicsDeviceType}, " + $"Compute={SystemInfo.supportsComputeShaders}, " + $"AsyncReadback={SystemInfo.supportsAsyncGPUReadback}");
				}
			}
			else
			{
				NativeArray<uint> data = request.GetData<uint>();
				if (data.Length >= count)
				{
					explored = new bool[count];
					for (int num = 0; num < count; num++)
					{
						explored[num] = data[num] != 0;
					}
				}
			}
		}
		catch (Exception ex)
		{
			readbackException = ex;
		}
		finally
		{
			queryBuffer?.Release();
			resultBuffer?.Release();
		}
		if (readbackException != null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(readbackException);
			}
			callback?.Invoke(null);
		}
		else
		{
			callback?.Invoke(explored);
		}
	}

	public void RequestIsPosExploredByFogMaskBatch(ACT.World.MapArea area, IReadOnlyList<Vector2> worldPositions, Action<bool[]> callback)
	{
		if (callback == null)
		{
			return;
		}
		int num = worldPositions?.Count ?? 0;
		if (num == 0)
		{
			callback?.Invoke(Array.Empty<bool>());
			return;
		}
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			bool[] array = new bool[num];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = true;
			}
			callback?.Invoke(array);
			return;
		}
		if (_explorePosCheckKernelIndex < 0 || mapConfig.mapFogCs == null || !TryGetAreaExploreFogRt(area, out var areaLayerRt))
		{
			callback(null);
			return;
		}
		Vector2 vector = ((_areaLeftBottomPosCache != null && _areaLeftBottomPosCache.TryGetValue(area, out var value)) ? value : mapConfig.GetAreaLeftBottomWorldPos(area));
		float num2 = mapConfig.largeMapRatio * areaRtCreateRatio;
		Vector2Int[] array2 = new Vector2Int[num];
		for (int j = 0; j < num; j++)
		{
			Vector2 vector2 = (worldPositions[j] + mapConfig.worldExploreFogOffset - vector) * num2;
			array2[j] = new Vector2Int(Mathf.FloorToInt(vector2.x), Mathf.FloorToInt(vector2.y));
		}
		ComputeBuffer computeBuffer = null;
		ComputeBuffer computeBuffer2 = null;
		try
		{
			if (!SystemInfo.supportsAsyncGPUReadback)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("批量探索检测失败GPU=" + SystemInfo.graphicsDeviceName + "," + $"API={SystemInfo.graphicsDeviceType}, " + $"Compute={SystemInfo.supportsComputeShaders}, " + $"AsyncReadback={SystemInfo.supportsAsyncGPUReadback}");
				}
				callback(null);
			}
			else
			{
				computeBuffer = new ComputeBuffer(num, 8, ComputeBufferType.Structured);
				computeBuffer2 = new ComputeBuffer(num, 4, ComputeBufferType.Structured);
				computeBuffer.SetData(array2);
				ComputeShader mapFogCs = mapConfig.mapFogCs;
				mapFogCs.SetTexture(_explorePosCheckKernelIndex, "FogMask", areaLayerRt);
				mapFogCs.SetBuffer(_explorePosCheckKernelIndex, "ExplorePosPixels", computeBuffer);
				mapFogCs.SetBuffer(_explorePosCheckKernelIndex, "ExplorePosResult", computeBuffer2);
				mapFogCs.SetInt("_ExplorePosQueryCount", num);
				mapFogCs.SetFloat("_ExplorePosThreshold", 128f / 255f);
				mapFogCs.Dispatch(_explorePosCheckKernelIndex, (num + 63) / 64, 1, 1);
				AsyncGPUReadbackRequest request = AsyncGPUReadback.Request(computeBuffer2);
				ComputeBuffer queryBuffer = computeBuffer;
				ComputeBuffer resultBuffer = computeBuffer2;
				computeBuffer = null;
				computeBuffer2 = null;
				ProcessExplorePosReadbackAsync(request, queryBuffer, resultBuffer, num, callback).Forget();
			}
		}
		catch
		{
			computeBuffer?.Release();
			computeBuffer2?.Release();
			throw;
		}
	}

	public int GetAreaExploreFogVersion(ACT.World.MapArea area)
	{
		return _areaExploreFogVersion?.GetValueOrDefault(area) ?? 0;
	}

	private bool TryGetAreaExploreFogCpuMaskCache(ACT.World.MapArea area, RenderTexture areaLayerRt, out Texture2D cpuMask)
	{
		cpuMask = null;
		if (_areaExploreFogCpuMaskCache == null || _dirtyAreaExploreFogCpuMaskCache == null)
		{
			return false;
		}
		if (_areaExploreFogCpuMaskCache.TryGetValue(area, out cpuMask) && !(cpuMask == null) && cpuMask.width == areaLayerRt.width && cpuMask.height == areaLayerRt.height && !_dirtyAreaExploreFogCpuMaskCache.Contains(area))
		{
			return true;
		}
		if (cpuMask == null || cpuMask.width != areaLayerRt.width || cpuMask.height != areaLayerRt.height)
		{
			if (cpuMask != null)
			{
				UnityEngine.Object.Destroy(cpuMask);
			}
			TextureFormat textureFormat = TextureFormat.R8;
			cpuMask = new Texture2D(areaLayerRt.width, areaLayerRt.height, textureFormat, mipChain: false, linear: true)
			{
				name = $"{area}_ExploreFogCpuMask"
			};
			_areaExploreFogCpuMaskCache[area] = cpuMask;
		}
		RenderTexture active = RenderTexture.active;
		try
		{
			RenderTexture.active = areaLayerRt;
			cpuMask.ReadPixels(new Rect(0f, 0f, areaLayerRt.width, areaLayerRt.height), 0, 0, recalculateMipMaps: false);
			cpuMask.Apply(updateMipmaps: false, makeNoLongerReadable: false);
			_dirtyAreaExploreFogCpuMaskCache.Remove(area);
			return true;
		}
		finally
		{
			RenderTexture.active = active;
		}
	}

	private void MarkAreaExploreFogCpuMaskCacheDirty(ACT.World.MapArea area)
	{
		_dirtyAreaExploreFogCpuMaskCache?.Add(area);
		if (_areaExploreFogVersion != null)
		{
			_areaExploreFogVersion[area] = GetAreaExploreFogVersion(area) + 1;
		}
	}

	private void ReleaseExploreFogCpuMaskCache()
	{
		if (_areaExploreFogCpuMaskCache != null)
		{
			foreach (Texture2D value in _areaExploreFogCpuMaskCache.Values)
			{
				if (value != null)
				{
					UnityEngine.Object.Destroy(value);
				}
			}
			_areaExploreFogCpuMaskCache.Clear();
		}
		_areaExploreFogCpuMaskCache = null;
		_dirtyAreaExploreFogCpuMaskCache?.Clear();
		_dirtyAreaExploreFogCpuMaskCache = null;
		_areaExploreFogVersion?.Clear();
		_areaExploreFogVersion = null;
	}

	private bool TryGetAreaSpecialExploreFogMaskRt(ACT.World.MapArea area, out RenderTexture specialFogMaskRt)
	{
		(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
		if (eachAreaLayerSpecialExploreFogMask != null && eachAreaLayerSpecialExploreFogMask.TryGetValue(key, out specialFogMaskRt) && specialFogMaskRt != null)
		{
			return true;
		}
		specialFogMaskRt = null;
		return false;
	}

	private void UpdateExploreFogAreaComplete(ACT.World.MapArea area)
	{
		if (mapConfig.IsDefaultUnlockArea(area) || !mapConfig.chunkBoundData.TryGetValue(area, out var value))
		{
			return;
		}
		foreach (int key in value.Keys)
		{
			UpdateExploreFogChunkComplete(area, key);
		}
	}

	private void UpdateExploreFogChunkComplete(ACT.World.MapArea area, int chunkId)
	{
		if (!mapConfig.IsDefaultUnlockArea(area) && _fogOfWarUpdateKernelIndex >= 0 && TryGetAreaExploreFogRt(area, out var areaLayerRt) && TrySetupExploreFogSourceMask(area, chunkId, areaLayerRt))
		{
			ComputeShader mapFogCs = mapConfig.mapFogCs;
			mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "FogMask", areaLayerRt);
			mapFogCs.SetFloat("_ExploreFogFullReveal", 1f);
			(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
			if (_areaLayerDispatchCache.TryGetValue(key, out (int, int) value))
			{
				mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, value.Item1, value.Item2, 1);
			}
			else
			{
				mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, Mathf.CeilToInt(areaLayerRt.width / 8), Mathf.CeilToInt(areaLayerRt.height / 8), 1);
			}
			mapFogCs.SetFloat("_ExploreFogFullReveal", 0f);
			MarkAreaExploreFogCpuMaskCacheDirty(area);
		}
	}

	private void InitSpecialExploreFogMasks()
	{
		if (mapConfig.specialFogConfigData == null)
		{
			return;
		}
		foreach (var (area, list2) in mapConfig.specialFogConfigData)
		{
			if (list2 == null)
			{
				continue;
			}
			foreach (SpecialFogOutPutData item in list2)
			{
				AddSpecialExploreFogMask(area, item);
			}
		}
	}

	private void AddSpecialExploreFogMask(ACT.World.MapArea area, SpecialFogOutPutData specialFogData)
	{
		if (specialFogData == null || specialFogData.specialUnlockFogId == 0 || mapConfig.IsDefaultUnlockArea(area) || !TryGetAreaSpecialExploreFogMaskRt(area, out var specialFogMaskRt))
		{
			return;
		}
		string assetID = NameUtility.GetChunkUnlockFogAddress(specialFogData.specialUnlockFogId) + ".png";
		if (!AssetStationManager.BattleStation.AssetExists(assetID))
		{
			return;
		}
		Interlocked.Increment(ref _pendingSpecialExploreFogMaskLoadCount);
		AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID, (AssetLoadHandle result) =>
		{
			try
			{
				(ACT.World.MapArea, int) item = (area, specialFogData.specialUnlockFogId);
				Texture2D texture2D = result.As<Texture2D>();
				if (texture2D != null && (_unlockedSpecialExploreFogIds == null || !_unlockedSpecialExploreFogIds.Contains(item)))
				{
					UpdateSpecialExploreFogMask(area, specialFogData, texture2D, specialFogMaskRt, isLocked: true);
				}
			}
			finally
			{
				DecrementPendingSpecialExploreFogMaskLoadCount();
				AssetStationManager.BattleStation.Release(result);
			}
		});
	}

	private void DecrementPendingSpecialExploreFogMaskLoadCount()
	{
		int num;
		do
		{
			num = Volatile.Read(ref _pendingSpecialExploreFogMaskLoadCount);
		}
		while (num > 0 && Interlocked.CompareExchange(ref _pendingSpecialExploreFogMaskLoadCount, num - 1, num) != num);
	}

	private bool TryGetSpecialExploreFogSourceRect(ACT.World.MapArea area, SpecialFogOutPutData specialFogData, out Vector2 sourceMin, out Vector2 sourceSize)
	{
		sourceMin = default;
		sourceSize = default;
		if (specialFogData == null || specialFogData.size.x <= 0f || specialFogData.size.y <= 0f)
		{
			return false;
		}
		sourceMin = (specialFogData.anchoredPosition - specialFogData.size * 0.5f) * areaRtCreateRatio;
		sourceSize = specialFogData.size * areaRtCreateRatio;
		return true;
	}

	private bool UpdateSpecialExploreFogMask(ACT.World.MapArea area, SpecialFogOutPutData specialFogData, Texture2D sourceTexture, RenderTexture specialFogMaskRt, bool isLocked)
	{
		if (_specialExploreFogMaskUpdateKernelIndex < 0 || sourceTexture == null || specialFogMaskRt == null || !TryGetSpecialExploreFogSourceRect(area, specialFogData, out var sourceMin, out var sourceSize))
		{
			return false;
		}
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		mapFogCs.SetTexture(_specialExploreFogMaskUpdateKernelIndex, "FogMask", specialFogMaskRt);
		mapFogCs.SetTexture(_specialExploreFogMaskUpdateKernelIndex, "_Source", sourceTexture);
		mapFogCs.SetVector("_TargetResolution", new Vector4(specialFogMaskRt.width, specialFogMaskRt.height, 0f, 0f));
		mapFogCs.SetVector("_SourcePointPS", new Vector4(sourceMin.x, sourceMin.y, sourceSize.x, sourceSize.y));
		mapFogCs.SetFloat("_SpecialFogMaskLock", isLocked ? 1f : 0f);
		mapFogCs.Dispatch(_specialExploreFogMaskUpdateKernelIndex, Mathf.CeilToInt((float)specialFogMaskRt.width / 8f), Mathf.CeilToInt((float)specialFogMaskRt.height / 8f), 1);
		return true;
	}

	private void InitSpecialExploreFog()
	{
		if (mapConfig.specialFogConfigData == null || mapConfig.specialFogConfigData.Count == 0)
		{
			return;
		}
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (var (area, list2) in mapConfig.specialFogConfigData)
		{
			if (list2 == null)
			{
				continue;
			}
			foreach (SpecialFogOutPutData item in list2)
			{
				if (item != null && StateWorldAssetData.IsValidID(item.stateObjectId))
				{
					StateWorldAssetData worldStateAssetDataBySGOID = worldManager.GetWorldStateAssetDataBySGOID(item.stateObjectId);
					if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID.stateId != worldStateAssetDataBySGOID.initialStateId)
					{
						UnlockSpecialExploreFog(area, item);
					}
				}
			}
		}
	}

	private void TryUnlockSpecialExploreFog(ACT.World.MapArea area, int stateObjectId)
	{
		List<SpecialFogOutPutData> mapAreaSpecialFog = mapConfig.GetMapAreaSpecialFog(area);
		if (mapAreaSpecialFog == null)
		{
			return;
		}
		foreach (SpecialFogOutPutData item in mapAreaSpecialFog)
		{
			if (item != null && item.stateObjectId == stateObjectId)
			{
				UnlockSpecialExploreFog(area, item);
			}
		}
	}

	private void UnlockSpecialExploreFog(ACT.World.MapArea area, SpecialFogOutPutData specialFogData)
	{
		if (specialFogData.specialUnlockFogId == 0 || mapConfig.IsDefaultUnlockArea(area) || !TryGetAreaExploreFogRt(area, out var areaLayerRt))
		{
			return;
		}
		(ACT.World.MapArea, int) item = (area, specialFogData.specialUnlockFogId);
		if (_unlockedSpecialExploreFogIds == null || !_unlockedSpecialExploreFogIds.Add(item))
		{
			return;
		}
		string assetID = NameUtility.GetChunkUnlockFogAddress(specialFogData.specialUnlockFogId) + ".png";
		if (!AssetStationManager.BattleStation.AssetExists(assetID))
		{
			return;
		}
		AssetStationManager.BattleStation.LoadAsync<Texture2D>(assetID, (AssetLoadHandle result) =>
		{
			try
			{
				Texture2D texture2D = result.As<Texture2D>();
				if (!(texture2D == null))
				{
					UpdateSpecialExploreFog(area, specialFogData, texture2D, areaLayerRt);
				}
			}
			finally
			{
				AssetStationManager.BattleStation.Release(result);
			}
		});
	}

	private bool UpdateSpecialExploreFog(ACT.World.MapArea area, SpecialFogOutPutData specialFogData, Texture2D sourceTexture, RenderTexture areaLayerRt)
	{
		if (_fogOfWarUpdateKernelIndex < 0 || sourceTexture == null || areaLayerRt == null || !TryGetSpecialExploreFogSourceRect(area, specialFogData, out var sourceMin, out var sourceSize))
		{
			return false;
		}
		if (TryGetAreaSpecialExploreFogMaskRt(area, out var specialFogMaskRt))
		{
			UpdateSpecialExploreFogMask(area, specialFogData, sourceTexture, specialFogMaskRt, isLocked: false);
		}
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "FogMask", areaLayerRt);
		mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "_Source", sourceTexture);
		mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "_SpecialFogMask", Texture2D.blackTexture);
		mapFogCs.SetVector("_TargetResolution", new Vector4(areaLayerRt.width, areaLayerRt.height, 0f, 0f));
		mapFogCs.SetVector("_SourcePointPS", new Vector4(sourceMin.x, sourceMin.y, sourceSize.x, sourceSize.y));
		mapFogCs.SetFloat("_IgnoreSpecialFogMask", 1f);
		mapFogCs.SetFloat("_ExploreFogFullReveal", 1f);
		(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
		if (_areaLayerDispatchCache.TryGetValue(key, out (int, int) value))
		{
			mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, value.Item1, value.Item2, 1);
		}
		else
		{
			mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, Mathf.CeilToInt((float)areaLayerRt.width / 8f), Mathf.CeilToInt((float)areaLayerRt.height / 8f), 1);
		}
		mapFogCs.SetFloat("_ExploreFogFullReveal", 0f);
		mapFogCs.SetFloat("_IgnoreSpecialFogMask", 0f);
		MarkAreaExploreFogCpuMaskCacheDirty(area);
		return true;
	}

	private bool TryApplyExploreCompleteState(ACT.World.MapArea area, int chunkId)
	{
		if (mapExploreInfo == null || !mapExploreInfo.TryGetValue(area, out var value))
		{
			return false;
		}
		if (value.IsComplete)
		{
			UpdateExploreFogAreaComplete(area);
			return true;
		}
		if (value.Chunks.TryGetValue(chunkId, out var value2) && value2.IsComplete)
		{
			UpdateExploreFogChunkComplete(area, chunkId);
			return true;
		}
		return false;
	}

	private bool TryGetExploreFogSourceRectByCornerUV(int chunkId, RenderTexture areaLayerRt, out Vector2 sourceMin, out Vector2 sourceSize)
	{
		sourceMin = default;
		sourceSize = default;
		if (areaLayerRt == null)
		{
			return false;
		}
		Vector2[] unlockFogCornerUVPos = mapConfig.GetUnlockFogCornerUVPos(chunkId);
		if (unlockFogCornerUVPos == null || unlockFogCornerUVPos.Length < 3)
		{
			return false;
		}
		Vector2 vector = new Vector2(areaLayerRt.width, areaLayerRt.height);
		Vector2 vector2 = Vector2.Min(unlockFogCornerUVPos[0], unlockFogCornerUVPos[2]);
		Vector2 vector3 = Vector2.Max(unlockFogCornerUVPos[0], unlockFogCornerUVPos[2]);
		sourceMin = vector2 * vector;
		sourceSize = (vector3 - vector2) * vector;
		if (sourceSize.x > 0f)
		{
			return sourceSize.y > 0f;
		}
		return false;
	}

	private bool TrySetupExploreFogSourceMask(ACT.World.MapArea area, int chunkId, RenderTexture areaLayerRt)
	{
		if (areaLayerRt == null || !_mapAreaToExploreFogMap.TryGetValue(chunkId, out var value) || value == null)
		{
			return false;
		}
		if (!mapConfig.chunkBoundData.TryGetValue(area, out var value2) || !value2.ContainsKey(chunkId))
		{
			return false;
		}
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		if (!TryGetExploreFogSourceRectByCornerUV(chunkId, areaLayerRt, out var sourceMin, out var sourceSize))
		{
			return false;
		}
		mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "_Source", value);
		mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "_SpecialFogMask", TryGetAreaSpecialExploreFogMaskRt(area, out var specialFogMaskRt) ? ((Texture)specialFogMaskRt) : ((Texture)Texture2D.blackTexture));
		mapFogCs.SetFloat("_IgnoreSpecialFogMask", 0f);
		mapFogCs.SetVector("_TargetResolution", new Vector4(areaLayerRt.width, areaLayerRt.height, 0f, 0f));
		mapFogCs.SetVector("_SourcePointPS", new Vector4(sourceMin.x, sourceMin.y, sourceSize.x, sourceSize.y));
		return true;
	}

	private static long GetExploreCompleteChunkKey(ACT.World.MapArea area, int chunkId)
	{
		return ((long)area << 32) ^ (uint)chunkId;
	}

	private bool TryGetExploreFogSourceRect(ACT.World.MapArea area, int chunkId, RenderTexture areaLayerRt, out Rect sourceRect)
	{
		sourceRect = default;
		if (areaLayerRt == null || !mapConfig.chunkBoundData.TryGetValue(area, out var value) || !value.ContainsKey(chunkId))
		{
			return false;
		}
		if (!TryGetExploreFogSourceRectByCornerUV(chunkId, areaLayerRt, out var sourceMin, out var sourceSize))
		{
			return false;
		}
		sourceRect = new Rect(sourceMin, sourceSize);
		return true;
	}

	private async UniTask ProcessExploreCompleteReadbackAsync(AsyncGPUReadbackRequest request, ComputeBuffer resultBuffer, ACT.World.MapArea area, int chunkId, long pendingKey)
	{
		try
		{
			await UniTask.WaitUntil(() => request.done);
			if (!request.hasError)
			{
				NativeArray<uint> data = request.GetData<uint>();
				if (data.Length >= 2 && data[0] != 0 && (ulong)((long)data[1] * 10L) > (ulong)((long)data[0] * 9L) && Model<MapModel>.HasInstance())
				{
					SetChunkExploreComplete(area, chunkId);
				}
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		finally
		{
			resultBuffer?.Release();
			_exploreCompleteCheckPendingChunkIds?.Remove(pendingKey);
		}
	}

	public void RequestExploreCompleteCheck(ACT.World.MapArea area, int chunkId)
	{
		long exploreCompleteChunkKey = GetExploreCompleteChunkKey(area, chunkId);
		if (mapConfig.IsDefaultUnlockArea(area) || _exploreCompleteCheckPendingChunkIds == null || _exploreCompleteCheckPendingChunkIds.Contains(exploreCompleteChunkKey) || !SystemInfo.supportsAsyncGPUReadback || !TryGetAreaExploreFogRt(area, out var areaLayerRt) || !TryGetAreaSpecialExploreFogMaskRt(area, out var specialFogMaskRt) || !_mapAreaToExploreFogMap.TryGetValue(chunkId, out var value) || !TryGetExploreFogSourceRect(area, chunkId, areaLayerRt, out var sourceRect))
		{
			return;
		}
		AreaExploreInfo orCreateAreaExploreInfo = GetOrCreateAreaExploreInfo(area);
		if (orCreateAreaExploreInfo.IsComplete || orCreateAreaExploreInfo.GetOrCreateChunkExploreInfo(chunkId).IsComplete)
		{
			return;
		}
		_exploreCompleteCheckPendingChunkIds.Add(exploreCompleteChunkKey);
		ComputeBuffer computeBuffer = null;
		try
		{
			computeBuffer = new ComputeBuffer(2, 4, ComputeBufferType.Structured);
			computeBuffer.SetData(new uint[2]);
			ComputeShader mapFogCs = mapConfig.mapFogCs;
			mapFogCs.SetTexture(_exploreCompleteCheckKernelIndex, "FogMask", areaLayerRt);
			mapFogCs.SetTexture(_exploreCompleteCheckKernelIndex, "_Source", value);
			mapFogCs.SetTexture(_exploreCompleteCheckKernelIndex, "_SpecialFogMask", specialFogMaskRt);
			mapFogCs.SetBuffer(_exploreCompleteCheckKernelIndex, "ExploreCompleteResult", computeBuffer);
			mapFogCs.SetVector("_TargetResolution", new Vector4(areaLayerRt.width, areaLayerRt.height, 0f, 0f));
			mapFogCs.SetVector("_SourcePointPS", new Vector4(sourceRect.xMin, sourceRect.yMin, sourceRect.width, sourceRect.height));
			mapFogCs.SetInts("_ExploreCompleteSourceResolution", value.width, value.height);
			mapFogCs.Dispatch(_exploreCompleteCheckKernelIndex, Mathf.CeilToInt((float)value.width / 8f), Mathf.CeilToInt((float)value.height / 8f), 1);
			AsyncGPUReadbackRequest request = AsyncGPUReadback.Request(computeBuffer);
			ComputeBuffer resultBuffer = computeBuffer;
			computeBuffer = null;
			ProcessExploreCompleteReadbackAsync(request, resultBuffer, area, chunkId, exploreCompleteChunkKey).Forget();
		}
		catch
		{
			computeBuffer?.Release();
			_exploreCompleteCheckPendingChunkIds.Remove(exploreCompleteChunkKey);
			throw;
		}
	}

	private void SetChunkExploreComplete(ACT.World.MapArea area, int chunkId)
	{
		AreaExploreInfo orCreateAreaExploreInfo = GetOrCreateAreaExploreInfo(area);
		LayerExploreInfo orCreateChunkExploreInfo = orCreateAreaExploreInfo.GetOrCreateChunkExploreInfo(chunkId);
		if (!orCreateChunkExploreInfo.IsComplete)
		{
			orCreateChunkExploreInfo.IsComplete = true;
			UpdateExploreFogChunkComplete(area, chunkId);
			G.service.MapExploreCompleteRequest((int)area, chunkId);
		}
		TrySetAreaExploreComplete(area, orCreateAreaExploreInfo);
	}

	private void TrySetAreaExploreComplete(ACT.World.MapArea area, AreaExploreInfo areaExploreInfo)
	{
		if (areaExploreInfo.IsComplete || !mapConfig.chunkBoundData.TryGetValue(area, out var value) || value.Count == 0)
		{
			return;
		}
		foreach (int key in value.Keys)
		{
			if (!areaExploreInfo.Chunks.TryGetValue(key, out var value2) || !value2.IsComplete)
			{
				return;
			}
		}
		areaExploreInfo.IsComplete = true;
		UpdateExploreFogAreaComplete(area);
		G.service.MapExploreCompleteRequest((int)area);
	}

	public void UpdateExploreFog(ACT.World.MapArea area, int chunkId, Vector2 pos)
	{
		if (mapConfig.IsDefaultUnlockArea(area) || Volatile.Read(ref _pendingSpecialExploreFogMaskLoadCount) > 0)
		{
			return;
		}
		(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
		if (!eachAreaLayerExploreFog.TryGetValue(key, out var value) || value == null || _fogOfWarUpdateKernelIndex < 0)
		{
			return;
		}
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		if (!TryApplyExploreCompleteState(area, chunkId) && TrySetupExploreFogSourceMask(area, chunkId, value))
		{
			mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "FogMask", value);
			if (_areaLeftBottomPosCache.TryGetValue(area, out var value2))
			{
				pos += mapConfig.worldExploreFogOffset;
				pos -= value2;
			}
			else
			{
				pos += mapConfig.worldExploreFogOffset;
				pos -= mapConfig.GetAreaLeftBottomWorldPos(area);
			}
			float num = mapConfig.largeMapRatio * areaRtCreateRatio;
			pos.x *= num;
			pos.y *= num;
			mapFogCs.SetVector("_CurrectPositionPS", new Vector4(pos.x, pos.y, 0f, 0f));
			mapFogCs.SetFloat("_ExploreFogFullReveal", 0f);
			if (_areaLayerDispatchCache.TryGetValue(key, out (int, int) value3))
			{
				mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, value3.Item1, value3.Item2, 1);
			}
			else
			{
				mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, Mathf.CeilToInt(value.width / 8), Mathf.CeilToInt(value.height / 8), 1);
			}
			MarkAreaExploreFogCpuMaskCacheDirty(area);
		}
	}

	public void UpdateExploreFogBatch(ACT.World.MapArea area, int chunkId, List<Vector2> positions)
	{
		if (positions == null || positions.Count == 0 || mapConfig.IsDefaultUnlockArea(area) || Volatile.Read(ref _pendingSpecialExploreFogMaskLoadCount) > 0)
		{
			return;
		}
		(ACT.World.MapArea, MapLayer) key = (area, MapLayer.L0);
		if (!eachAreaLayerExploreFog.TryGetValue(key, out var value) || value == null || _fogOfWarUpdateKernelIndex < 0)
		{
			return;
		}
		ComputeShader mapFogCs = mapConfig.mapFogCs;
		if (!TryApplyExploreCompleteState(area, chunkId) && TrySetupExploreFogSourceMask(area, chunkId, value))
		{
			mapFogCs.SetTexture(_fogOfWarUpdateKernelIndex, "FogMask", value);
			Vector2 vector = (_areaLeftBottomPosCache.TryGetValue(area, out var value2) ? value2 : mapConfig.GetAreaLeftBottomWorldPos(area));
			float num = mapConfig.largeMapRatio * areaRtCreateRatio;
			Vector2 vector2 = mapConfig.worldExploreFogOffset - vector;
			bool flag = _areaLayerDispatchCache.TryGetValue(key, out (int, int) value3);
			int num2;
			if (flag)
			{
				(num2, _) = value3;
			}
			else
			{
				num2 = Mathf.CeilToInt(value.width / 8);
			}
			int threadGroupsX = num2;
			int threadGroupsY = (flag ? value3.Item2 : Mathf.CeilToInt(value.height / 8));
			for (int i = 0; i < positions.Count; i++)
			{
				Vector2 vector3 = positions[i];
				vector3 += vector2;
				vector3.x *= num;
				vector3.y *= num;
				mapFogCs.SetVector("_CurrectPositionPS", new Vector4(vector3.x, vector3.y, 0f, 0f));
				mapFogCs.SetFloat("_ExploreFogFullReveal", 0f);
				mapFogCs.Dispatch(_fogOfWarUpdateKernelIndex, threadGroupsX, threadGroupsY, 1);
			}
			MarkAreaExploreFogCpuMaskCacheDirty(area);
		}
	}

	public MapViewRecordParam GetMapViewRecordParam()
	{
		return needSyncMapViewRecordParam;
	}

	public void AddSyncMapViewLogInfo(ACT.World.MapArea area, int chunkId, Vector2Int pos)
	{
		if (!needSyncMapViewRecordParam.Areas.TryGetValue((int)area, out var value))
		{
			value = new MapViewRecordChunkParam();
			needSyncMapViewRecordParam.Areas.Add((int)area, value);
		}
		if (!value.Chunks.TryGetValue(chunkId, out var value2))
		{
			value2 = new MapViewRecordPositionParam();
			value.Chunks.Add(chunkId, value2);
		}
		value2.Positions.Add(pos);
	}

	public void ClearAllMapViewRecordParam()
	{
		needSyncMapViewRecordParam.Areas.Clear();
	}

	public bool CanLogLocalExplorePos(ACT.World.MapArea area, Vector2 pos)
	{
		return Vector2.Distance(lastPlayerWorldPos, pos) > mapConfig.localExplorePosSpace;
	}

	public void AddLocalMapViewLogInfo(ACT.World.MapArea area, int chunkId, Vector2 pos)
	{
		lastPlayerWorldPos = pos;
		UpdateExploreFog(area, chunkId, pos);
	}

	public AreaExploreInfo GetAreaExploreInfo(ACT.World.MapArea area)
	{
		if (mapExploreInfo == null)
		{
			return null;
		}
		return mapExploreInfo.GetValueOrDefault(area);
	}

	private AreaExploreInfo GetOrCreateAreaExploreInfo(ACT.World.MapArea area)
	{
		if (!mapExploreInfo.TryGetValue(area, out var value))
		{
			value = new AreaExploreInfo
			{
				AreaId = (int)area,
				IsComplete = false
			};
			mapExploreInfo.Add(area, value);
		}
		return value;
	}

	public void AddAreaExploreInfo(ACT.World.MapArea area)
	{
		GetOrCreateAreaExploreInfo(area);
	}

	public LayerExploreInfo GetOrCreateChunkExploreInfo(ACT.World.MapArea area, int chunkId)
	{
		return GetOrCreateAreaExploreInfo(area).GetOrCreateChunkExploreInfo(chunkId);
	}

	public void AddLayerExploreInfo(ACT.World.MapArea area, MapLayer layer)
	{
		AddAreaExploreInfo(area);
	}

	public void MergeMapExploreInfo(MapViewInfo mapViewInfo, bool reset = true)
	{
	}

	public void MergeMapExploreInfo(MapViewFullInfo mapViewInfo, bool reset = true)
	{
		if (reset)
		{
			mapExploreInfo.Clear();
		}
		if (mapViewInfo == null)
		{
			_mapExploreInfoReady = true;
			return;
		}
		foreach (MapViewAreaInfo value in mapViewInfo.Areas.Values)
		{
			ACT.World.MapArea areaID = (ACT.World.MapArea)value.AreaID;
			AreaExploreInfo orCreateAreaExploreInfo = GetOrCreateAreaExploreInfo(areaID);
			orCreateAreaExploreInfo.IsComplete |= value.IsComplete;
			foreach (MapViewChunkInfo value2 in value.Chunks.Values)
			{
				LayerExploreInfo orCreateChunkExploreInfo = orCreateAreaExploreInfo.GetOrCreateChunkExploreInfo(value2.ChunkID);
				orCreateChunkExploreInfo.IsComplete |= value2.IsComplete;
				foreach (var (gridId, pBVector2IntList2) in value2.Grids)
				{
					Vector2Int gridIdByGridStringId = NameUtility.GetGridIdByGridStringId(gridId);
					if (!orCreateChunkExploreInfo.gridInfo.ContainsKey(gridIdByGridStringId))
					{
						orCreateChunkExploreInfo.gridInfo.Add(gridIdByGridStringId, new HashSet<Vector2Int>());
					}
					HashSet<Vector2Int> hashSet = orCreateChunkExploreInfo.gridInfo[gridIdByGridStringId];
					foreach (PBVector2Int vec in pBVector2IntList2.Vecs)
					{
						hashSet.Add(vec);
					}
				}
			}
		}
		_mapExploreInfoReady = true;
	}

	private static void ClearRenderTexture(RenderTexture rt)
	{
		if (!(rt == null))
		{
			RenderTexture active = RenderTexture.active;
			RenderTexture.active = rt;
			GL.Clear(clearDepth: true, clearColor: true, Color.clear);
			RenderTexture.active = active;
		}
	}

	private static void ReleaseRenderTextureDictionary(Dictionary<(ACT.World.MapArea, MapLayer), RenderTexture> renderTextures)
	{
		if (renderTextures == null)
		{
			return;
		}
		foreach (RenderTexture value in renderTextures.Values)
		{
			if (!(value == null))
			{
				if (value.IsCreated())
				{
					value.Release();
				}
				UnityEngine.Object.Destroy(value);
			}
		}
		renderTextures.Clear();
	}

	private static GraphicsFormat GetFogRenderTextureFormat()
	{
		IsFogRenderTextureFormatSupported(GraphicsFormat.R8G8B8A8_UNorm);
		return GraphicsFormat.R8G8B8A8_UNorm;
	}

	private static bool IsFogRenderTextureFormatSupported(GraphicsFormat format)
	{
		if (SystemInfo.supportsComputeShaders && SystemInfo.IsFormatSupported(format, FormatUsage.Render))
		{
			return SystemInfo.IsFormatSupported(format, FormatUsage.LoadStore);
		}
		return false;
	}

	private (int width, int height) GetTextureSize(ACT.World.MapArea area)
	{
		Vector2Int vector2Int = mapConfig.GetAreaWidthHeightCellNum(area) * mapConfig.cellPixelSize;
		int item = Mathf.CeilToInt((float)vector2Int.x * areaRtCreateRatio);
		int item2 = Mathf.CeilToInt((float)vector2Int.y * areaRtCreateRatio);
		return (width: item, height: item2);
	}

	public void MapSetupTracePoint(int mapArea, int id, int iconType, bool isCancel, Action callback = null)
	{
		G.service.MapSetupTracePoint(mapArea, id, iconType, isCancel, callback);
	}

	public void SetMapPointTraceInfo(int mapArea, int mapIconType, int id, bool isInit = false)
	{
		if (_currentTraceMapPoint == null)
		{
			_currentTraceMapPoint = new MapPointTraceInfo();
		}
		_currentTraceMapPoint.mapArea = (ACT.World.MapArea)mapArea;
		_currentTraceMapPoint.pointId = id;
		_currentTraceMapPoint.iconType = (MapIconType)mapIconType;
		if (!isInit)
		{
			MapPointTraceRefresh evt = Singleton<EventManager>.instance.GetEvt<MapPointTraceRefresh>();
			evt.iconType = mapIconType;
			evt.mapArea = mapArea;
			evt.id = id;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_MapPointTraceEvt, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void SetMapPointGuideInfo(int mapIconType, int id)
	{
		if (_currentGuideMapPoint == null)
		{
			_currentGuideMapPoint = new MapPointTraceInfo();
		}
		_currentGuideMapPoint.mapArea = ACT.World.MapArea.None;
		_currentGuideMapPoint.pointId = id;
		_currentGuideMapPoint.iconType = (MapIconType)mapIconType;
	}

	public void AddUnlockInteractObjId(MapLayer layer, int interactObjId)
	{
		if (!eachLayerUnlockInteractObjId.ContainsKey(layer))
		{
			eachLayerUnlockInteractObjId.Add(layer, new List<int>());
		}
		eachLayerUnlockInteractObjId[layer].TryAdd(interactObjId);
		unlockInteractObjectId.TryAdd(interactObjId);
	}

	public void AddNpcSpriteIdToDic(int uid, int spriteId)
	{
		if (_mapNpcIdToSpriteId.TryGetValue(uid, out var _))
		{
			_mapNpcIdToSpriteId[uid] = spriteId;
		}
		else
		{
			_mapNpcIdToSpriteId.Add(uid, spriteId);
		}
	}

	public bool UnlockFogHasUnlock(int unlockFogId)
	{
		return hasUnlockFog.Contains(unlockFogId);
	}

	public void AddUnlockFog(int unlockFogId)
	{
		if (unlockFogId != 0)
		{
			if (hasUnlockFog == null)
			{
				hasUnlockFog = new HashSet<int>();
			}
			hasUnlockFog.Add(unlockFogId);
		}
	}

	private void InitMapAreaLayerGridData()
	{
		mapAreaLayerGridData = new Dictionary<(ACT.World.MapArea, MapLayer), Dictionary<Vector2Int, MapGridData>>();
		foreach (var item in mapConfig.GetAllAreaLayer())
		{
			Dictionary<Vector2Int, MapGridData> dictionary = new Dictionary<Vector2Int, MapGridData>();
			mapAreaLayerGridData.Add(item, dictionary);
			HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(item.area);
			if (mapIconDataBy == null)
			{
				continue;
			}
			foreach (BakeStaticMapIconData item2 in mapIconDataBy)
			{
				Vector2Int areaGridId = MapUtility.GetAreaGridId(item.area, item2.initPos);
				if (!dictionary.ContainsKey(areaGridId))
				{
					dictionary.Add(areaGridId, new MapGridData
					{
						id = areaGridId,
						staticMapIconData = new HashSet<BakeStaticMapIconData> { item2 },
						dynamicNpcData = new HashSet<MapModelDynamicNpcData>(),
						missionPointData = new HashSet<MissionPointData>()
					});
				}
				else
				{
					dictionary[areaGridId].AddStaticInteractObjUid(item2);
				}
			}
		}
		missionPointId2MapGridData = new Dictionary<int, MapGridData>();
		mapAreaLayerMissionPointData = new Dictionary<(ACT.World.MapArea, MapLayer), HashSet<MissionPointData>>();
	}

	public bool TryGetGridDataByGridId(ACT.World.MapArea area, MapLayer layer, Vector2Int gridId, out MapGridData gridData)
	{
		if (!mapAreaLayerGridData.ContainsKey((area, layer)))
		{
			gridData = null;
			return false;
		}
		if (mapAreaLayerGridData[(area, layer)].TryGetValue(gridId, out var value))
		{
			gridData = value;
			return true;
		}
		gridData = null;
		return false;
	}

	private void OnServiceSaveRefresh(BaseEventContent obj)
	{
		ServiceStateRefresh serviceStateRefresh = obj as ServiceStateRefresh;
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(serviceStateRefresh.swid);
		if (worldStateAssetDataBySGOID == null)
		{
			return;
		}
		if (serviceStateRefresh.stateId != worldStateAssetDataBySGOID.initialStateId)
		{
			TryUnlockSpecialExploreFog(worldStateAssetDataBySGOID.mapArea, serviceStateRefresh.swid);
		}
		if (worldStateAssetDataBySGOID is LightHouseData lightHouseData && serviceStateRefresh.oldStateId == 0 && serviceStateRefresh.stateId == -2)
		{
			if (lightHouseData.openMapUI)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
				{
					unlockFogId = lightHouseData.unlockFogId,
					unlockFogIds = lightHouseData.normalUnlockFogIds
				});
			}
			UnlockLightHouse(lightHouseData);
			StateChangeTraceCancel(serviceStateRefresh, lightHouseData.mapArea, MapIconType.LightHouse);
		}
		else if (worldStateAssetDataBySGOID is HiddenRoomData hiddenRoomData && serviceStateRefresh.stateId == 1)
		{
			UnlockHiddenRoom(hiddenRoomData);
		}
		else if (worldStateAssetDataBySGOID is PortalData portalData && serviceStateRefresh.stateId == -2)
		{
			StateChangeTraceCancel(serviceStateRefresh, portalData.mapArea, MapIconType.Transfer);
		}
		else if (worldStateAssetDataBySGOID is TempleEnterData templeEnterData && serviceStateRefresh.stateId == 1)
		{
			StateChangeTraceCancel(serviceStateRefresh, templeEnterData.mapArea, MapIconType.Temple);
		}
		else
		{
			if (!(worldStateAssetDataBySGOID is InteractObjectData interactObjectData))
			{
				return;
			}
			if (interactObjectData.stateObjectType == 21 && serviceStateRefresh.stateId == 1)
			{
				StateChangeTraceCancel(serviceStateRefresh, interactObjectData.mapArea, MapIconType.BlockInteract);
			}
			else if (interactObjectData.stateObjectType == 26 && serviceStateRefresh.stateId == -99)
			{
				IconData data = ACT.Core.CoreUtils.GetData(interactObjectData.iconDataId, RuntimeConfigs.data.iconDatas);
				if (data != null)
				{
					MapIconType mapIcon = (MapIconType)data.mapIcon;
					StateChangeTraceCancel(serviceStateRefresh, interactObjectData.mapArea, mapIcon);
				}
			}
		}
	}

	private void StateChangeTraceCancel(ServiceStateRefresh evt, ACT.World.MapArea area, MapIconType iconType)
	{
		if (evt.swid == _currentTraceMapPoint.pointId && _currentTraceMapPoint.mapArea == area && _currentTraceMapPoint.iconType == iconType)
		{
			MapSetupTracePoint((int)area, evt.swid, (int)iconType, isCancel: true);
		}
	}

	private void UnlockLightHouse(LightHouseData lightHouseData)
	{
		foreach (LightHouseInteracts interactIcon in lightHouseData.interactIcons)
		{
			AddUnlockInteractObjId(lightHouseData.MapLayer, interactIcon.uid);
		}
		if (lightHouseData.HasUnlockFog())
		{
			foreach (int normalUnlockFogId in lightHouseData.normalUnlockFogIds)
			{
				AddUnlockFog(normalUnlockFogId);
			}
		}
		if (!lightHouseData.openMapUI && lightHouseData.HasUnlockFog())
		{
			foreach (int normalUnlockFogId2 in lightHouseData.normalUnlockFogIds)
			{
				UpdateUnlockFogWithoutUI(normalUnlockFogId2);
			}
		}
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		int[] hiddenRoomUids = lightHouseData.hiddenRoomUids;
		foreach (int num in hiddenRoomUids)
		{
			if (StateWorldAssetData.IsValidID(num))
			{
				StateWorldAssetData worldStateAssetDataBySGOID = worldManager.GetWorldStateAssetDataBySGOID(num);
				if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID is HiddenRoomData hiddenRoomData && worldStateAssetDataBySGOID.stateId == 1)
				{
					UnlockHiddenRoom(hiddenRoomData);
				}
			}
		}
	}

	private void UnlockHiddenRoom(HiddenRoomData hiddenRoomData)
	{
		if (!StateWorldAssetData.IsValidID(hiddenRoomData.lightHouseId))
		{
			return;
		}
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(hiddenRoomData.lightHouseId);
		if (worldStateAssetDataBySGOID == null || worldStateAssetDataBySGOID.stateId != -2)
		{
			return;
		}
		foreach (int unlockChunkId in hiddenRoomData.unlockChunkIds)
		{
			_ = unlockChunkId;
			AddUnlockFog(hiddenRoomData.unlockFogId);
			UpdateUnlockFogWithoutUI(hiddenRoomData.unlockFogId);
		}
	}

	public void OnTrackMissionGuidePointUpdate(List<MissionPointData> toRemove, List<MissionPointData> toAdd)
	{
		if (mainWoldDataInitFinish)
		{
			OnBattleMainApplyMissionArrows(toRemove, toAdd);
		}
	}

	public void OnBattleMainApplyMissionArrows(List<MissionPointData> toRemove, List<MissionPointData> toAdd)
	{
		if (!mainWoldDataInitFinish)
		{
			return;
		}
		if (toRemove != null)
		{
			foreach (MissionPointData item in toRemove)
			{
				RemoveMissionPointByPointId(item);
			}
		}
		if (toAdd != null)
		{
			foreach (MissionPointData item2 in toAdd)
			{
				AddMissionPointByMissionPointData(item2);
			}
		}
		if ((toRemove != null && toRemove.Count > 0) || (toAdd != null && toAdd.Count > 0))
		{
			m_OnMapModelMissionPointUpdate?.Invoke();
		}
	}

	private void RemoveMissionPointByPointId(MissionPointData missionPointData)
	{
		if (missionPointId2MapGridData.TryGetValue(missionPointData.PointId, out var value))
		{
			value.RemoveMissionPointData(missionPointData.PointId);
			missionPointId2MapGridData.Remove(missionPointData.PointId);
		}
		if (mapAreaLayerMissionPointData.TryGetValue((missionPointData.GetGuidePointMapArea(), missionPointData.GetGuidePointMapLayer()), out var value2))
		{
			value2.RemoveWhere((MissionPointData x) => x.Equals(missionPointData));
		}
	}

	private void AddMissionPointByMissionPointData(MissionPointData missionPointData)
	{
		if (missionPointId2MapGridData.ContainsKey(missionPointData.PointId))
		{
			return;
		}
		Vector3 guidePointPosition = missionPointData.GetGuidePointPosition();
		ACT.World.MapArea guidePointMapArea = missionPointData.GetGuidePointMapArea();
		MapLayer guidePointMapLayer = missionPointData.GetGuidePointMapLayer();
		if (guidePointMapArea == ACT.World.MapArea.None || guidePointMapArea == ACT.World.MapArea.None || guidePointMapLayer == MapLayer.None)
		{
			return;
		}
		Vector2Int areaGridId = MapUtility.GetAreaGridId(guidePointMapArea, guidePointPosition);
		if (!mapAreaLayerGridData.TryGetValue((guidePointMapArea, guidePointMapLayer), out var value))
		{
			return;
		}
		MapGridData mapGridData;
		if (!value.ContainsKey(areaGridId))
		{
			mapGridData = new MapGridData
			{
				id = areaGridId,
				staticMapIconData = new HashSet<BakeStaticMapIconData>(),
				dynamicNpcData = new HashSet<MapModelDynamicNpcData>(),
				missionPointData = new HashSet<MissionPointData> { missionPointData }
			};
			value.Add(areaGridId, mapGridData);
		}
		else
		{
			mapGridData = value[areaGridId];
			mapGridData.AddMissionPointData(missionPointData);
		}
		missionPointId2MapGridData.Add(missionPointData.PointId, mapGridData);
		ACT.World.MapArea actualMapArea = missionPointData.GetActualMapArea();
		MapLayer actualMapLayer = missionPointData.GetActualMapLayer();
		foreach (KeyValuePair<(ACT.World.MapArea, MapLayer), HashSet<MissionPointData>> mapAreaLayerMissionPointDatum in mapAreaLayerMissionPointData)
		{
			mapAreaLayerMissionPointDatum.Value.RemoveWhere((MissionPointData x) => x.PointId == missionPointData.PointId);
		}
		if (!mapAreaLayerMissionPointData.ContainsKey((actualMapArea, actualMapLayer)))
		{
			mapAreaLayerMissionPointData.Add((actualMapArea, actualMapLayer), new HashSet<MissionPointData> { missionPointData });
		}
		else
		{
			mapAreaLayerMissionPointData[(actualMapArea, actualMapLayer)].Add(missionPointData);
		}
	}

	public HashSet<MissionPointData> GetAreaLayerMissionPointData(ACT.World.MapArea area, MapLayer layer)
	{
		return mapAreaLayerMissionPointData.GetValueOrDefault((area, layer));
	}

	public bool AreaLayerHasMissionPointData(ACT.World.MapArea area, MapLayer layer)
	{
		HashSet<MissionPointData> areaLayerMissionPointData = GetAreaLayerMissionPointData(area, layer);
		if (areaLayerMissionPointData != null)
		{
			return areaLayerMissionPointData.Count > 0;
		}
		return false;
	}

	public bool AreaHasMissionPoint(ACT.World.MapArea area)
	{
		return mapAreaLayerMissionPointData.Any((KeyValuePair<(ACT.World.MapArea area, MapLayer layer), HashSet<MissionPointData>> pair) =>
		{
			if (pair.Key.area == area)
			{
				HashSet<MissionPointData> value = pair.Value;
				if (value != null)
				{
					return value.Count > 0;
				}
				return false;
			}
			return false;
		});
	}

	public bool OtherAreaHasMissionPoint(ACT.World.MapArea area)
	{
		return mapAreaLayerMissionPointData.Any((KeyValuePair<(ACT.World.MapArea area, MapLayer layer), HashSet<MissionPointData>> pair) =>
		{
			if (pair.Key.area != area)
			{
				HashSet<MissionPointData> value = pair.Value;
				if (value != null)
				{
					return value.Count > 0;
				}
				return false;
			}
			return false;
		});
	}

	public bool IsOtherAreaHasMissionPoint(ACT.World.MapArea area)
	{
		bool result = false;
		foreach (MissionPointData point in Model<BattleMainMarkModelV2>.Interface.Points)
		{
			if (point.MapArea != area)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	private bool IsExploreObj(int exploreObjType)
	{
		if (validExploreObjectType != null)
		{
			return validExploreObjectType.Contains(exploreObjType);
		}
		return false;
	}

	private int GetExploreGroupId(int exploreObjType)
	{
		if (RuntimeConfigs.data.stateObjectGroups.FirstOrDefault((KeyValuePair<int, StateObjectGroup> _) => _.Value.group.Contains(exploreObjType)).Value != null)
		{
			return RuntimeConfigs.data.stateObjectGroups.FirstOrDefault((KeyValuePair<int, StateObjectGroup> _) => _.Value.group.Contains(exploreObjType)).Value.id;
		}
		return 0;
	}

	public void InitMapExploreData(Dictionary<int, MapAreaExplore> areaExploreInfo)
	{
		InitMapExploreRewardData();
		foreach (MapAreaExplore value2 in areaExploreInfo.Values)
		{
			string nodeFullPath = string.Format(RedDotPathDefine.MapExploreReward + "|IsNew", value2.Id);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 1028);
			}
			foreach (MapSubAreaExplore value3 in value2.SubAreaExplore.Values)
			{
				string nodeFullPath2 = string.Format(RedDotPathDefine.MapExploreReward + "|{1}|IsNew", value2.Id, value3.Id);
				if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath2))
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath2, active: false, 1028);
				}
			}
			if (allAreaExploreDataDic.TryGetValue((ACT.World.MapArea)value2.Id, out var value))
			{
				value.UpdateAreaExploreData(value2);
			}
			else
			{
				allAreaExploreDataDic.Add((ACT.World.MapArea)value2.Id, new AreaExploreData(value2));
			}
		}
	}

	public void UpdateMapExploreData(MapAreaExplore areaExploreInfo)
	{
		if (allAreaExploreDataDic.TryGetValue((ACT.World.MapArea)areaExploreInfo.Id, out var value))
		{
			value.UpdateAreaExploreData(areaExploreInfo);
		}
		else
		{
			allAreaExploreDataDic.Add((ACT.World.MapArea)areaExploreInfo.Id, new AreaExploreData(areaExploreInfo));
		}
	}

	private void InitMapExploreRewardData()
	{
		if (allAreaExploreRewardDic != null)
		{
			return;
		}
		allAreaExploreRewardDic = new Dictionary<int, List<ExplorationReward>>();
		foreach (ExplorationReward value in RuntimeConfigs.data.explorationRewards.Values)
		{
			if (!allAreaExploreRewardDic.ContainsKey(value.areaId))
			{
				allAreaExploreRewardDic.Add(value.areaId, new List<ExplorationReward>());
				allAreaExploreRewardDic[value.areaId].Add(value);
			}
			else
			{
				allAreaExploreRewardDic[value.areaId].Add(value);
			}
		}
	}

	public List<ExplorationReward> GetMapExploreRewardData(int areaId)
	{
		if (allAreaExploreRewardDic.TryGetValue(areaId, out var value))
		{
			return value;
		}
		return null;
	}

	public float GetAreaGroupExploreRatio(ACT.World.MapArea area, int groupId)
	{
		allAreaExploreDataDic.TryGetValue(area, out var _);
		return 0f;
	}

	public float GetAreaGroupExploreRatio(ACT.World.MapArea area)
	{
		if (allAreaExploreDataDic.TryGetValue(area, out var value))
		{
			return value.GetAreaExploreRatio();
		}
		return 0f;
	}

	public AreaExploreData GetAreaGroupExploreData(ACT.World.MapArea area)
	{
		if (allAreaExploreDataDic.TryGetValue(area, out var value))
		{
			return value;
		}
		return null;
	}

	private void CheckExploreRatioOnServiceSaveRefresh(BaseEventContent obj)
	{
	}

	public void PushDisableTP()
	{
		m_DisableTPButtonCounter++;
	}

	public void PopDisableTP()
	{
		m_DisableTPButtonCounter--;
	}

	public TempleEnterData FindTempleEnterDataByInstanceId(int instanceId)
	{
		foreach (KeyValuePair<int, TempleEnterData> item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas<TempleEnterData>())
		{
			if (item.Value.id == instanceId)
			{
				return item.Value;
			}
		}
		return null;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (jumpData.JumpType == 1)
		{
			return CanJumpTransfer(jumpData);
		}
		if (jumpData.JumpType == 2)
		{
			return CanJumpLargeMap(jumpData);
		}
		return CreateHideJumpResult();
	}

	private JumpResult CanJumpTransfer(RuntimeJumpData jumpData)
	{
		if (!_mapIconIdToStateObjectMap.TryGetValue(jumpData.Params[1], out var value))
		{
			return CreateHideJumpResult();
		}
		if (MonoECS.instance.ruleManager.SharedGetState(value) == -2)
		{
			return CreateCanJumpResult();
		}
		return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.PortPointLock));
	}

	private JumpResult CanJumpLargeMap(RuntimeJumpData jumpData)
	{
		switch (jumpData.Params[1])
		{
		case 0:
			if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
			{
				return new JumpResult
				{
					ShowType = JumpResult.JumpShowType.CanJump
				};
			}
			break;
		case 1:
			return CanJumpMonsterPoint(jumpData);
		case 2:
			return CanJumpCollectionPoint(jumpData);
		case 3:
			return CanJumpMapArea(jumpData);
		case 4:
			return CanJumpNpc(jumpData);
		case 5:
			return CanJumpMapTemple(jumpData);
		}
		return CreateWaitingForRefreshJumpResult();
	}

	private JumpResult CanJumpMapArea(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return CreateWaitingForRefreshJumpResult();
		}
		if (MapUtility.AreaUnlock(jumpData.Params[2]))
		{
			return CreateCanJumpResult();
		}
		int unlock = ACT.Core.CoreUtils.GetData(jumpData.Params[2], RuntimeConfigs.data.mapAreas).Unlock;
		MissionGroup missionGroup = RuntimeConfigs.data.missionGroups[unlock];
		ACT.Config.Mission mission = RuntimeConfigs.data.missions[missionGroup.missionId[0]];
		string message = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
		return CreateForbiddenJumpResult(message);
	}

	private JumpResult CanJumpMapTemple(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return CreateWaitingForRefreshJumpResult();
		}
		if (jumpData.Params[2] == 0)
		{
			List<int> list = Fundamental.ListPool<int>.Get();
			foreach (InstanceDungeonMap value in RuntimeConfigs.data.instanceDungeonMaps.Values)
			{
				int[] instanceList = value.instanceList;
				foreach (int num in instanceList)
				{
					if (Model<TempleModel>.Interface.IsTempleUnlocked(num))
					{
						list.Add(num);
					}
				}
				if (list.Count > 0)
				{
					Fundamental.ListPool<int>.Release(list);
					return CreateCanJumpResult();
				}
			}
			Fundamental.ListPool<int>.Release(list);
			return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.NoAvailableTemple));
		}
		InstanceDungeon data = ACT.Core.CoreUtils.GetData(jumpData.Params[2], RuntimeConfigs.data.instanceDungeons);
		if (data != null && Model<TempleModel>.Interface.IsTempleUnlocked(data.id))
		{
			return CreateCanJumpResult();
		}
		return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.TempleDeActive));
	}

	private JumpResult CanJumpMonsterPoint(RuntimeJumpData jumpData)
	{
		List<string> list = Fundamental.ListPool<string>.Get();
		try
		{
			int num = jumpData.Params[3];
			int num2 = jumpData.Params[2];
			int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
			if (curWorldLevel < num)
			{
				list.Add(LocalizationUtility.GetLocalizeString("Common", 2564, new object[1] { num }));
			}
			if (ACT.Core.CoreUtils.GetData(num2, RuntimeConfigs.data.entityEnemyDatas).skipJumpTraverse)
			{
				return CreateHideJumpResult();
			}
			List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = Model<MaterialTrackModel>.Interface.GetAllMonsterTrackPointDataByEnemyId(num2);
			bool flag = allMonsterTrackPointDataByEnemyId != null && allMonsterTrackPointDataByEnemyId.Count > 0;
			if (!flag)
			{
				list.Add(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.CanNotGoTo));
			}
			if ((curWorldLevel >= num) & flag)
			{
				MonsterTrackPointData activeMinAreaIdMaterialTrackMonsterPointData = Model<MaterialTrackModel>.Interface.GetActiveMinAreaIdMaterialTrackMonsterPointData(num2);
				if (activeMinAreaIdMaterialTrackMonsterPointData == null)
				{
					list.Add(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.WaitingForRefreh));
				}
				else if (!MapUtility.AreaUnlock(activeMinAreaIdMaterialTrackMonsterPointData.mapArea))
				{
					int unlock = ACT.Core.CoreUtils.GetData((int)activeMinAreaIdMaterialTrackMonsterPointData.mapArea, RuntimeConfigs.data.mapAreas).Unlock;
					MissionGroup missionGroup = RuntimeConfigs.data.missionGroups[unlock];
					ACT.Config.Mission mission = RuntimeConfigs.data.missions[missionGroup.missionId[0]];
					string item = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
					list.Add(item);
				}
			}
			if (list.Count == 0)
			{
				return CreateCanJumpResult();
			}
			if (list.Count == 1)
			{
				return CreateForbiddenJumpResult(list[0]);
			}
			JumpResult result = new JumpResult(JumpResult.JumpShowType.Forbidden, null);
			result.SetMessages(list);
			return result;
		}
		finally
		{
			Fundamental.ListPool<string>.Release(list);
		}
	}

	private JumpResult CanJumpCollectionPoint(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return CreateWaitingForRefreshJumpResult();
		}
		CollectionTrackPointData activeMinAreaIdCollectionPointData = Model<MaterialTrackModel>.Interface.GetActiveMinAreaIdCollectionPointData(jumpData.Params[2]);
		if (activeMinAreaIdCollectionPointData != null)
		{
			if (!MapUtility.AreaUnlock(activeMinAreaIdCollectionPointData.mapArea))
			{
				int[] missionId = ACT.Core.CoreUtils.GetData(ACT.Core.CoreUtils.GetData((int)activeMinAreaIdCollectionPointData.mapArea, RuntimeConfigs.data.mapAreas).Unlock, RuntimeConfigs.data.missionGroups).missionId;
				ACT.Config.Mission mission = RuntimeConfigs.data.missions[missionId[0]];
				string message = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
				return CreateForbiddenJumpResult(message);
			}
			return CreateCanJumpResult();
		}
		return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.WaitingForRefreh));
	}

	private JumpResult CanJumpNpc(RuntimeJumpData jumpData)
	{
		if (Singleton<RuntimeNpcManager>.instance.IsNpcCanDisplay(jumpData.Params[2]))
		{
			return CreateCanJumpResult();
		}
		return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.SystemLock));
	}

	private JumpResult CreateCanJumpResult()
	{
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	private JumpResult CreateHideJumpResult()
	{
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Hide
		};
	}

	private JumpResult CreateForbiddenJumpResult(string message)
	{
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Forbidden,
			Message = message
		};
	}

	private JumpResult CreateWaitingForRefreshJumpResult()
	{
		return CreateForbiddenJumpResult(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.WaitingForRefreh));
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		if (jumpData.JumpType == 1)
		{
			int key = jumpData.Params[1];
			if (!_mapIconIdToStateObjectMap.TryGetValue(key, out var value))
			{
				return;
			}
			StateWorldAssetData stateWorldAssetData = MonoECS.instance.ruleManager.GetStateWorldAssetData(value);
			if (stateWorldAssetData != null)
			{
				TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
				evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
				evt.targetPosition = ((PortalData)stateWorldAssetData).SitPos;
				EventTrackSolver.Instance.Dispatch(evt);
				TeleportUtility.TeleportWithInteractObject(stateWorldAssetData).Forget();
				Singleton<BloodBottleHandler>.instance.RecoverItems();
				if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
				{
					Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(MPPlayer.local.CurrentActiveBattlePotionId);
				}
			}
		}
		else
		{
			if (jumpData.JumpType != 2)
			{
				return;
			}
			switch (jumpData.Params[1])
			{
			case 1:
			case 2:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
				{
					wantTrackMonsterPointId = ((jumpData.Params[1] == 1) ? jumpData.Params[2] : 0),
					collectionPointId = ((jumpData.Params[1] == 2) ? jumpData.Params[2] : 0)
				});
				break;
			case 3:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
				{
					AreaOpen = true,
					initMapArea = (ACT.World.MapArea)jumpData.Params[2]
				});
				break;
			case 4:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
				{
					AreaOpen = true,
					jumpNpcId = jumpData.Params[2]
				});
				break;
			case 5:
			{
				if (jumpData.Params[2] == 0)
				{
					List<int> list = Fundamental.ListPool<int>.Get();
					{
						foreach (InstanceDungeonMap value2 in RuntimeConfigs.data.instanceDungeonMaps.Values)
						{
							int[] instanceList = value2.instanceList;
							foreach (int num in instanceList)
							{
								if (Model<TempleModel>.Interface.IsTempleUnlocked(num))
								{
									list.Add(num);
								}
							}
							if (list.Count > 0)
							{
								list.Sort();
								InstanceDungeon data = ACT.Core.CoreUtils.GetData(list[0], RuntimeConfigs.data.instanceDungeons);
								if (data != null)
								{
									Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
									{
										templeDungeonId = data.id,
										initMapArea = (ACT.World.MapArea)data.area
									});
								}
								Fundamental.ListPool<int>.Release(list);
								break;
							}
						}
						break;
					}
				}
				InstanceDungeon data2 = ACT.Core.CoreUtils.GetData(jumpData.Params[2], RuntimeConfigs.data.instanceDungeons);
				if (data2 != null)
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
					{
						templeDungeonId = data2.id,
						initMapArea = (ACT.World.MapArea)data2.area
					});
				}
				break;
			}
			default:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP);
				break;
			}
		}
	}
}
