#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SceneStreamer;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Pool;

namespace Ase;

public class LevelMapData : MapDataBase, IInit
{
	private float startBattleTime = -1f;

	private float enterLevelTime;

	private int killBossCount;

	private int killMonsterCount;

	private int openChestCount;

	public static bool FrameLoading;

	public bool teleporting = true;

	[SerializeField]
	private int levelId;

	public HeroBornPointConfig HeroBornPointConfig;

	public ScenePointGroup scenePoint;

	public LevelAreaCtrl areaCtrl;

	[SerializeField]
	private Vector3 bvhDefaultCheckSize = new Vector3(90f, 0f, 90f);

	[SerializeField]
	private Vector3 bvhCavesCheckSize = new Vector3(50f, 0f, 50f);

	public string lastActiveBornPointKey = "Default";

	private string enterCavesBornPointKey;

	private int canvesId;

	public List<LevelRoom> levelRooms;

	public List<MovingPlatform> movingPlatforms;

	public List<RockerControl> RockerControls;

	private SceneSystem sceneSystem;

	private List<int> currentActiveAreaIds = new List<int>();

	private List<int> currentActiveAreaIdTemp = new List<int>();

	private List<BaseMapDataNode> visiableNodes = new List<BaseMapDataNode>();

	private BoundsOctree<BaseMapDataNode> areaOcTree;

	private Matrix4x4 pMatrix;

	private Camera battleCamera;

	private readonly List<BaseMapDataNode> _result = new List<BaseMapDataNode>();

	private float currentGameSpeed = 1f;

	public bool TeachGuideLevel;

	[SerializeField]
	private bool openGizoms;

	private ISubscription<LevelSaveMessage> _levelSaveSubscription;

	public void BonfireActive(int BonfireId)
	{
		TDAHandler.Instance.SendLevelActiveBorn(levelId, BonfireId);
	}

	public void TransPointInteract(int selectIndex, List<int> heroIds)
	{
		if (heroIds == null)
		{
			heroIds = sceneSystem.GetOriginTeamIds();
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(heroIds, dictionary);
		TDAHandler.Instance.TransPointInteract(levelId, selectIndex, dictionary);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void BattleDataKillMonster(bool isBoss)
	{
		if (isBoss)
		{
			killBossCount++;
		}
		killMonsterCount++;
	}

	public void ForceBattleStart(int monsterUID, int areaId)
	{
		List<int> originTeamIds = sceneSystem.GetOriginTeamIds();
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(originTeamIds, dictionary);
		TDAHandler.Instance.ForceBattleStart(levelId, monsterUID, areaId, dictionary);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
		startBattleTime = Time.realtimeSinceStartup;
	}

	public void ForceBattleEnd(int monsterUID, int areaId)
	{
		List<int> originTeamIds = sceneSystem.GetOriginTeamIds();
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(originTeamIds, dictionary);
		TDAHandler.Instance.ForceBattleEnd(levelId, monsterUID, areaId, dictionary, Time.realtimeSinceStartup - startBattleTime, "1");
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
		startBattleTime = -1f;
	}

	public void ForceBattleEnd(List<GlobalStatInfo.KillHeroEntityInfo> infos)
	{
		if (startBattleTime == -1f || infos == null || infos.Count == 0)
		{
			return;
		}
		int actorId = sceneSystem.GetWorld().ActorId;
		BaseEntity entity = sceneSystem.GetSystem<EntitySystem>().GetEntity(actorId);
		if (entity == null)
		{
			return;
		}
		BaseEntity baseEntity = null;
		for (int i = 0; i < infos.Count; i++)
		{
			if (infos[i].heroConfigId == entity.EntityId)
			{
				baseEntity = infos[i].AttackEntity;
				break;
			}
		}
		if (baseEntity != null && baseEntity.GetEntityType() == EntityType.MONSTER)
		{
			MonsterGroup data = baseEntity.GetData<MonsterGroup>(MonsterGroup.MONSTERGROUP_KEY);
			MonsterNode data2 = baseEntity.GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY);
			if (!((Object)(object)data == null) && !((Object)(object)data2 == null))
			{
				List<int> originTeamIds = sceneSystem.GetOriginTeamIds();
				Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
				Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(originTeamIds, dictionary);
				TDAHandler.Instance.ForceBattleEnd(levelId, data.Uid, data.levelArea.areaId, dictionary, Time.realtimeSinceStartup - startBattleTime, data2.monsterConfigId.ToString());
				CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
				startBattleTime = -1f;
			}
		}
	}

	public void EnterLevelDataReport()
	{
		List<int> originTeamIds = sceneSystem.GetOriginTeamIds();
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(originTeamIds, dictionary);
		TDAHandler.Instance.EnterLevel(levelId, lastActiveBornPointKey, dictionary);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void ExitLevelDataReport()
	{
		List<int> originTeamIds = sceneSystem.GetOriginTeamIds();
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(originTeamIds, dictionary);
		TDAHandler.Instance.ExitLevel(levelId, dictionary, Time.realtimeSinceStartup - enterLevelTime, openChestCount, killMonsterCount, killBossCount);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void OpenChestReport(MapItemNode mapItemNode)
	{
		openChestCount++;
		if ((Object)(object)mapItemNode != null)
		{
			TDAHandler.Instance.OpenChestReport(levelId, mapItemNode.Uid, mapItemNode.levelArea.areaId);
		}
	}

	private void OnDrawGizmos()
	{
		if (openGizoms)
		{
			Singleton<MathTriggerSystem>.Instance.DrawTree();
		}
	}

	public void OnTreeCheckUpdate(float deltaTime)
	{
		OnRoomTreeCheckUpdate();
		OnNodeTreeCheckUpdate();
	}

	private void InitMovingPlatform()
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if ((Object)(object)movingPlatform != null)
			{
				movingPlatform.OnInit(sceneSystem);
			}
			else
			{
				Log.Error("移动平台绑定有问题，重新绑定");
			}
		}
	}

	public void ResetMovingPlatform()
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			movingPlatform.ResetPlatform();
		}
	}

	public bool GetMovingPlatformPauseState(int movingPaltformId)
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if (movingPlatform.ID == movingPaltformId)
			{
				return movingPlatform.GetPauseState();
			}
		}
		return false;
	}

	public void SetMovingPlatPos(int movingPaltformId, Vector3 pos)
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if (movingPlatform.ID == movingPaltformId)
			{
				movingPlatform.SetPlatPos(pos);
				break;
			}
		}
	}

	public void SetHitVolumeParamCanHit(int platId, int index, bool isCanHit)
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if (movingPlatform.ID == platId)
			{
				HitMovingPlatform hitMovingPlatform = movingPlatform as HitMovingPlatform;
				if ((Object)(object)hitMovingPlatform != null)
				{
					hitMovingPlatform.SetHitVolumeParamCanHit(index, isCanHit);
				}
				break;
			}
		}
	}

	public void SetMovingPaltformPauseById(int movingPaltformId, bool isPause)
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if (movingPlatform.ID == movingPaltformId)
			{
				movingPlatform.SetPause(isPause);
				movingPlatform.SavePlatformData();
				break;
			}
		}
	}

	public void ChangeMovingPlatformParamById(int movingPaltformId, MovingPlatform.WrapMode warWrapMode, float time, AnimationCurve curveX, AnimationCurve curveY, AnimationCurve curveZ)
	{
		foreach (MovingPlatform movingPlatform in movingPlatforms)
		{
			if (movingPlatform.ID == movingPaltformId)
			{
				NormalMovingPlatform normalMovingPlatform = movingPlatform as NormalMovingPlatform;
				if ((Object)(object)normalMovingPlatform != null)
				{
					normalMovingPlatform.ChangePlatformParams(warWrapMode, time, curveX, curveY, curveZ);
				}
				break;
			}
		}
	}

	private void InitRockerControl()
	{
		if (RockerControls == null)
		{
			return;
		}
		foreach (RockerControl rockerControl in RockerControls)
		{
			int rockerControlValue = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetRockerControlValue(levelId, rockerControl.ID);
			rockerControl.OnInit(rockerControlValue);
		}
	}

	public void UpdateRockerControlData(int rockerId)
	{
		if (RockerControls == null)
		{
			return;
		}
		foreach (RockerControl rockerControl in RockerControls)
		{
			if (rockerControl.ID == rockerId)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateRockerControlValue(levelId, rockerId, rockerControl.GetRockerData());
				break;
			}
		}
	}

	private void CreateRoomTree()
	{
		foreach (LevelRoom levelRoom in levelRooms)
		{
			if (!(levelRoom == null))
			{
				levelRoom.Init(sceneSystem);
				Add(levelRoom.GetNavMeshBuildSource());
			}
		}
	}

	private void OnRoomTreeCheckUpdate()
	{
	}

	public void Add(List<NavMeshBuildSource> s)
	{
		sceneSystem.GetSystem<PathfindingSystem>().Add(s);
	}

	public void Remove(List<NavMeshBuildSource> s)
	{
		sceneSystem.GetSystem<PathfindingSystem>().Remove(s);
	}

	private void CreateNodeTree()
	{
		areaOcTree = new BoundsOctree<BaseMapDataNode>(15f, ((Component)(object)this).transform.position, 5f, 5f);
	}

	private void OnNodeTreeCheckUpdate()
	{
		pMatrix = Matrix4x4.Perspective(battleCamera.fieldOfView + 10f, battleCamera.aspect, battleCamera.nearClipPlane, battleCamera.farClipPlane);
		_result.Clear();
		areaOcTree.GetWithinFrustum(pMatrix, battleCamera.worldToCameraMatrix, in _result);
		if (_result.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < visiableNodes.Count; i++)
		{
			BaseMapDataNode baseMapDataNode = visiableNodes[i];
			if (!_result.Contains(baseMapDataNode))
			{
				baseMapDataNode.ReceiveMapDataEvent(LevelMapDataEvent.ExitView);
				visiableNodes.Remove(baseMapDataNode);
			}
		}
		for (int j = 0; j < _result.Count; j++)
		{
			BaseMapDataNode baseMapDataNode2 = _result[j];
			if (visiableNodes.Contains(baseMapDataNode2))
			{
				if (!baseMapDataNode2.IsLoaded && !baseMapDataNode2.IsLoading)
				{
					visiableNodes.Remove(baseMapDataNode2);
				}
				continue;
			}
			baseMapDataNode2.ReceiveMapDataEvent(LevelMapDataEvent.EnterView);
			if (baseMapDataNode2.IsLoaded || baseMapDataNode2.IsLoading)
			{
				visiableNodes.Add(baseMapDataNode2);
			}
		}
	}

	public void AddObjectInOcTree(BaseMapDataNode area, Bounds bounds)
	{
		areaOcTree.Add(area, bounds);
	}

	public void RemoveObjectInOcTree(BaseMapDataNode area)
	{
		areaOcTree.Remove(area);
	}

	public void ClearObjectInOcTree()
	{
		areaOcTree = null;
	}

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		CreateRoomTree();
		CreateNodeTree();
		areaCtrl.OnInit(data);
		areaCtrl.RegisterAreaCallback(OnEnterArea, OnExitArea);
		_levelSaveSubscription = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>()?.GetMessager().Subscribe<LevelSaveMessage>(OnLevelSaveChanged);
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().AddEquipNewBPListener(GetNewBP);
		SetBvhCheckSize(bvhDefaultCheckSize);
	}

	private void SetBvhCheckSize(Vector3 size)
	{
		((Component)(object)this).TryGetComponent(out BvhStreamer component);
		if (!(component == null))
		{
			component.layer.checkSize = size;
		}
	}

	public async void OnStart(object data = null)
	{
		battleCamera = sceneSystem.GetSystem<CameraSystem>().BattleCamera;
		areaCtrl.OnStart(data);
		InitMovingPlatform();
		InitRockerControl();
		foreach (LevelRoom levelRoom in levelRooms)
		{
			if (!(levelRoom == null))
			{
				levelRoom.OnStart();
			}
		}
		await UniTask.WaitForFixedUpdate();
		teleporting = false;
	}

	public void LevelStart()
	{
	}

	private void GetNewBP(BattleProps bpData)
	{
		if (sceneSystem != null)
		{
			sceneSystem.GetSystem<TouchSystem>()?.GetNewBP(bpData);
		}
	}

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		return HeroBornPointConfig.GetHeroBornPoint(heroBornPointKey, index);
	}

	public ScenePoint GetScenePoint(string key)
	{
		if ((Object)(object)scenePoint != null)
		{
			return scenePoint.GetScenePoint(key);
		}
		Log.Error("MapData中没有找到场景点配置..");
		return null;
	}

	public LevelArea GetLevelArea(int areaId)
	{
		if ((Object)(object)areaCtrl != null)
		{
			return areaCtrl.GetLevelArea(areaId);
		}
		return null;
	}

	public void RevertAllArea(bool rebornAllHero, bool teleport)
	{
		currentGameSpeed = 1f;
		Dictionary<int, LevelArea>.ValueCollection.Enumerator enumerator = areaCtrl.levelAreaList.Values.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.RestLevel();
			if (teleport)
			{
				enumerator.Current.RestLevelAreaState();
			}
		}
		enumerator.Dispose();
		if (rebornAllHero)
		{
			sceneSystem.RebornAllHero();
		}
	}

	public async UniTask RebornTeleport(bool teleport, string teleportId)
	{
		if (teleport)
		{
			bool flag = !string.IsNullOrEmpty(teleportId);
			teleportId = (flag ? teleportId : lastActiveBornPointKey);
			await sceneSystem.Teleport(teleportId, flag);
			await UniTask.WaitForEndOfFrame();
			await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
		}
		else
		{
			RefreshArea();
		}
		ResetMovingPlatform();
	}

	public void RefreshArea(bool isRefresh = false)
	{
		List<int>.Enumerator enumerator = currentActiveAreaIds.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (areaCtrl.levelAreaList.TryGetValue(enumerator.Current, out var value))
			{
				value.RefreshArea(isRefresh);
			}
		}
		enumerator.Dispose();
	}

	public void OnDispose()
	{
		_levelSaveSubscription?.Dispose();
		_levelSaveSubscription = null;
		areaCtrl?.OnDispose();
		StopAllBGM();
		ClearObjectInOcTree();
		battleCamera = null;
		startBattleTime = -1f;
		enterLevelTime = 0f;
		killBossCount = 0;
		killMonsterCount = 0;
		openChestCount = 0;
		canvesId = 0;
		sceneSystem = null;
	}

	public void OnEnterArea(object sender, LevelArea area)
	{
		if (!currentActiveAreaIds.Contains(area.areaId))
		{
			currentActiveAreaIds.Add(area.areaId);
		}
	}

	public void OnExitArea(object sender, LevelArea area)
	{
		if (currentActiveAreaIds.Contains(area.areaId))
		{
			currentActiveAreaIds.Remove(area.areaId);
		}
	}

	public void UpdateBonfireBornPoint(string bornPointKey)
	{
		lastActiveBornPointKey = bornPointKey;
	}

	public void EnterCanvesCopyBornPoint(int canvesId)
	{
		SetBvhCheckSize(bvhCavesCheckSize);
		enterCavesBornPointKey = lastActiveBornPointKey;
		this.canvesId = canvesId;
		DRCavern dataRow = GameEntry.DataTable.GetDataRow<DRCavern>(canvesId);
		MapConfigData miniMapData = ((dataRow == null) ? null : new MapConfigData(dataRow));
		sceneSystem.GetSystem<BattleSystem>().SetMiniMapData(miniMapData);
	}

	public void ExitCanvesDeleteBornPoint()
	{
		if (canvesId != 0)
		{
			SetBvhCheckSize(bvhDefaultCheckSize);
			lastActiveBornPointKey = enterCavesBornPointKey;
			enterCavesBornPointKey = null;
			canvesId = 0;
			sceneSystem.GetSystem<BattleSystem>().SetMiniMapData(null);
		}
	}

	public int GetCanvesId()
	{
		return canvesId;
	}

	public string GetEnterCavesBornPointKey()
	{
		return enterCavesBornPointKey;
	}

	public void OnChangeTeamFinish()
	{
		currentActiveAreaIdTemp.AddRange(currentActiveAreaIds);
		currentActiveAreaIds.Clear();
		foreach (int item in currentActiveAreaIdTemp)
		{
			if (areaCtrl.levelAreaList.TryGetValue(item, out var value))
			{
				value.OnEntityTriggerEnter(sceneSystem.GetSystem<EntitySystem>().GetEntity(sceneSystem.GetWorld().ActorId));
			}
		}
	}

	public void OnTelepotStart()
	{
		teleporting = true;
	}

	public bool CheckIsTeleporting()
	{
		return teleporting;
	}

	public void OnTelepotFinish()
	{
		teleporting = false;
	}

	private void OnLevelSaveChanged(LevelSaveMessage message)
	{
		if (message != null && message.MessageType == LevelSaveMessageType.BonfireActiveStateChange)
		{
			BonfireActive(message.ItemId);
		}
	}

	public void OnGameSpeedChanged(float gameSpeed)
	{
		if (currentGameSpeed != gameSpeed)
		{
			currentGameSpeed = gameSpeed;
			if ((Object)(object)areaCtrl != null)
			{
				areaCtrl.OnGameSpeedChanged(gameSpeed);
			}
		}
	}
}
