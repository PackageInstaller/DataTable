#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using SceneStreamer;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class SceneSystem : BaseSystem
{
	private StoryWorld storyWorld;

	private BvhStreamer streamer;

	private GameObject playerVirtualTransform;

	private GameObject mapDataRoot;

	private int currentLevelId;

	private LevelMapData sceneMapData;

	private SceneSundryMapData sceneSundryMapData;

	private int playerLevelInfo = 1;

	private int maxStoryLevel = 1;

	private int rank = 1;

	private IMessenger mapDataMessenger;

	private ChangeTeamPropertyConfig _changeTeamPropertyConfig;

	private GameObject _screenEffectCapture;

	private GameObject _effectCameraShadow;

	private Material _cameraShadowMat;

	private Volume[] volumes;

	private ISubscription<GameSettingConfigHelper.SettingData> bloomSettingChanged;

	private ISubscription<GameSettingConfigHelper.SettingData> vignettingSettingChanged;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private Queue<BaseMapDataNode> waitLoadingNodesQueue = new Queue<BaseMapDataNode>();

	private int loadingCount = 3;

	private LevelRoom currentRoom;

	private readonly int _groundLayerMask = 1 << LayerMask.NameToLayer("Ground");

	private bool roomLerp;

	private bool loackSwitchRoom;

	protected override bool IsLogicSystem => false;

	private bool UsedStreamer
	{
		get
		{
			if (streamer != null)
			{
				return streamer.layer != null;
			}
			return false;
		}
	}

	public IMessenger MapDataMessenger => mapDataMessenger;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		volumes = Object.FindObjectsOfType<Volume>();
		if (volumes != null && volumes.Length != 0)
		{
			bloomSettingChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe("GameSetting_Bloom", delegate(GameSettingConfigHelper.SettingData setting)
			{
				OnBloomSettingChanged(setting.Value > 0f);
			});
			vignettingSettingChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe("GameSetting_暗角", delegate(GameSettingConfigHelper.SettingData setting)
			{
				OnVignettingSettingChanged(setting.Value > 0f);
			});
			subscription_UpdateLevel = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<RoleExpOrLevelUpNotifyMessager>(OnGetLevelNotify);
			OnBloomSettingChanged(GameEntry.Setting.GetBool("Bloom"));
			OnVignettingSettingChanged(GameEntry.Setting.GetBool("暗角"));
			_effectCameraShadow = GameEntry.Camera.EffectCameraShadow;
			_effectCameraShadow.SetActive(value: false);
			Material[] materials = _effectCameraShadow.GetComponent<MeshRenderer>().materials;
			if (materials != null && materials.Length == 1)
			{
				_cameraShadowMat = materials[0];
			}
			RestScreenEffect();
		}
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.EnterLevelDataReport();
			sceneMapData.OnStart(this);
		}
	}

	public int GetPlayerLevel()
	{
		return playerLevelInfo;
	}

	private void OnBloomSettingChanged(bool active)
	{
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].profile.TryGet<Bloom>(out Bloom component);
			if ((bool)(Object)(object)component)
			{
				((VolumeComponent)(object)component).active = active;
			}
		}
	}

	private void OnVignettingSettingChanged(bool active)
	{
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].profile.TryGet<Vignette>(out Vignette component);
			if ((bool)(Object)(object)component)
			{
				((VolumeComponent)(object)component).active = active;
			}
		}
	}

	public void StartCapture()
	{
		if (!(_screenEffectCapture == null))
		{
			GlassBreakScreenEffect component = _screenEffectCapture.GetComponent<GlassBreakScreenEffect>();
			if (component != null)
			{
				component.StartCapture();
			}
		}
	}

	public async void LoadGlassBreakScreenEffect(string path)
	{
		_screenEffectCapture = Object.Instantiate(await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(path), world.WorldRoot);
	}

	public void OpenCameraShadow(bool isOpen, float shadowValue, float time)
	{
		if (_effectCameraShadow == null || _cameraShadowMat == null)
		{
			return;
		}
		if (isOpen)
		{
			_effectCameraShadow.SetActive(value: true);
			_cameraShadowMat.DOFade(shadowValue, "_BaseColor", time).SetEase(Ease.Linear);
		}
		else
		{
			_cameraShadowMat.DOFade(shadowValue, "_BaseColor", time).SetEase(Ease.Linear).OnComplete(delegate
			{
				_effectCameraShadow.SetActive(value: false);
			});
		}
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (!(data is WorldData worldData))
		{
			Log.Error("worldData == null");
			return false;
		}
		if (!world.IsStoryWorld)
		{
			sceneSundryMapData = Object.FindObjectOfType<SceneSundryMapData>();
		}
		if (!string.IsNullOrEmpty(worldData.MapDataName) && !(await LoadMapData(worldData.MapDataName, worldData.BonfireKey)))
		{
			return false;
		}
		if (UsedStreamer)
		{
			streamer.InitStreamer();
			playerVirtualTransform = new GameObject("StreamerVirtualPlayer");
			playerVirtualTransform.transform.position = GetHeroBornPoint(worldData.BonfireKey, 0)?.transform.position ?? Vector3.zero;
			streamer.player = playerVirtualTransform.transform;
			streamer.showLoadingScreen = true;
			streamer.StartStreamer();
			await UniTask.WaitUntil(() => streamer.LoadingProgress >= 1f);
		}
		world.BattleConfig.TeamRebornValue = (GetIsInTeachGuideLevel() ? int.MaxValue : 0);
		return true;
	}

	private async Task<bool> LoadMapData(string mapDataName, string bonfireKey)
	{
		if (world.IsStoryWorld)
		{
			mapDataMessenger = new Messenger();
			storyWorld = world as StoryWorld;
			if (!(await LoadSceneMapData(mapDataName)))
			{
				return false;
			}
			LoadPlayerLevelInfo();
			UpdateBonfireBornPoint(bonfireKey);
			return true;
		}
		return true;
	}

	private async Task<bool> LoadSceneMapData(string mapDataName)
	{
		await Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().EnterLevelGetSaveData(GetLevelId());
		mapDataRoot = ((Component)(object)Object.FindObjectOfType<LevelMapData>())?.gameObject;
		if (mapDataRoot == null)
		{
			mapDataRoot = await GetSystem<GameResourceSystem>().InstantiateAsync(AssetUtility.GetLevelMapDataAsset(mapDataName), world.WorldRoot);
		}
		_changeTeamPropertyConfig = await GetSystem<GameResourceSystem>().LoadAssetAsync<ChangeTeamPropertyConfig>(AssetUtility.GetBattleViewConfigAsset("LevelConfig/ChangeTeamConfig.asset"));
		mapDataRoot.name = "------ MapData ------";
		sceneMapData = mapDataRoot.GetComponent<LevelMapData>();
		streamer = mapDataRoot.GetComponent<BvhStreamer>();
		sceneMapData.OnInit(this);
		return true;
	}

	public override void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
		base.OnGameSpeedChanged(beforeTheChangeSpeed, gameSpeed);
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.OnGameSpeedChanged(gameSpeed);
		}
	}

	public async UniTask LevelStart()
	{
		if ((Object)(object)sceneMapData != null)
		{
			PlayBGM();
		}
	}

	private void LoadPlayerLevelInfo()
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null)
		{
			RoleViewModel roleData = service.GetRoleData();
			if (roleData != null && roleData.PlayerInfo != null)
			{
				playerLevelInfo = roleData.PlayerInfo.Level;
				maxStoryLevel = roleData.PlayerInfo.MaxStoryLevel;
				rank = roleData.PlayerInfo.Rank;
			}
		}
	}

	private void OnGetLevelNotify(RoleExpOrLevelUpNotifyMessager messager)
	{
		if (messager.MessageEnum.Equals(RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp))
		{
			LoadPlayerLevelInfo();
			Context.GetApplicationContext().GetService<IMessenger>().Publish(new LevelChangeNotifyMessager(this));
		}
	}

	public int GetMaxStoryLevel()
	{
		return maxStoryLevel;
	}

	public int GetPlayerRank()
	{
		return rank;
	}

	public bool IsFinishCurrentLevel()
	{
		if (world.IsStoryWorld)
		{
			return maxStoryLevel >= currentLevelId;
		}
		return false;
	}

	public LevelMapData GetLevelMapData()
	{
		return sceneMapData;
	}

	public int GetLevelId()
	{
		if (!world.IsStoryWorld)
		{
			return 0;
		}
		if (currentLevelId == 0)
		{
			currentLevelId = storyWorld.LevelId;
		}
		return currentLevelId;
	}

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		if ((Object)(object)sceneMapData != null)
		{
			return sceneMapData.GetHeroBornPoint(heroBornPointKey, index);
		}
		return null;
	}

	public ScenePoint GetScenePoint(string key)
	{
		if ((Object)(object)sceneMapData != null)
		{
			return sceneMapData.GetScenePoint(key);
		}
		return null;
	}

	public Vector3 GetSceneRotate(string key)
	{
		if ((Object)(object)sceneMapData == null)
		{
			Log.Error("没有找到 [MapData] 配置..");
			return Vector3.zero;
		}
		return Vector3.zero;
	}

	public WorldBase GetWorld()
	{
		return world;
	}

	public void RebornAllHero()
	{
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		for (int i = 0; i < teamHero.Count; i++)
		{
			if (teamHero[i] != null)
			{
				teamHero[i].GetComponent<ReBornComponent>().EntityForceReborn();
				if (teamHero[i].InPause && !teamHero[i].GetWorld().IsSoftPaused)
				{
					teamHero[i].OnResume();
				}
			}
		}
	}

	public async UniTask Teleport(string bornPointKey, bool updateBornPointKey = true)
	{
		if (updateBornPointKey)
		{
			UpdateBonfireBornPoint(bornPointKey);
		}
		OnTelepotStart();
		List<int> teamEntityId = GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true);
		for (int i = 0; i < teamEntityId.Count; i++)
		{
			ScenePoint heroBornPoint = GetHeroBornPoint(bornPointKey, i);
			if (heroBornPoint == null)
			{
				return;
			}
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(teamEntityId[i]);
			if (entity != null)
			{
				entity.GetComponent<ClimbMovementComponent>().StopClimbMove();
				entity.GetComponent<KinematicMoveComponent>().Teleport(heroBornPoint.transform.position, heroBornPoint.transform.rotation);
			}
		}
		ListPool<int>.Release(teamEntityId);
		await StreamerForceUpdate();
		GetSystem<GameResourceSystem>().UnloadUnusedAssets(performGCCollect: false);
		OnTelepotFinish();
	}

	public void OnChangeTeamFinish()
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.OnChangeTeamFinish();
		}
	}

	public void OnTelepotStart()
	{
		GetSystem<InputSystem>().SetPaused(paused: true);
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.OnTelepotStart();
		}
	}

	public bool CheckIsTeleporting()
	{
		if ((Object)(object)sceneMapData != null)
		{
			return sceneMapData.CheckIsTeleporting();
		}
		return false;
	}

	public void OnTelepotFinish()
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.OnTelepotFinish();
		}
		GetSystem<InputSystem>().SetPaused(paused: false);
		GetSystem<VirtualCameraSystem>().CloseLevelTriggerVirtualCamera();
	}

	public async Task RevertLevel(bool rebornHero = false, bool teleport = false, string teleportId = null, bool blackOpen = true, bool isResetTeam = true, bool forceEnterRoom = false)
	{
		if (!((Object)(object)sceneMapData != null))
		{
			return;
		}
		BlackScreen blackScreen = null;
		if (blackOpen)
		{
			blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
		}
		if (this == null)
		{
			return;
		}
		GetSystem<BattleStateSystem>()?.ResetLevelHandle();
		GetSystem<TeachGuideSystem>()?.CloseTeachGuideWindow();
		GetSystem<EntitySystem>()?.OnLevelFail();
		GetSystem<TaskSystem>()?.OnRevertLevel();
		BattleSystem battleSystem = GetSystem<BattleSystem>();
		if (battleSystem == null)
		{
			return;
		}
		battleSystem.SetLockMiniMap(lockMiniMap: false);
		battleSystem.TaskBtnCanClick(lockLick: false);
		battleSystem.SetMiniMapVisible(visible: true);
		sceneMapData.RevertAllArea(rebornHero, teleport);
		BaseEntity baseEntity = GetSystem<EntitySystem>()?.GetEntity(GetWorld().ActorId);
		GetSystem<CameraSystem>()?.ResetBattleCamera(baseEntity);
		await sceneMapData.RebornTeleport(teleport, teleportId);
		if (this != null)
		{
			battleSystem.HideInteractiveView();
			if (isResetTeam)
			{
				storyWorld.RestTeam();
			}
			if (blackOpen)
			{
				blackScreen.Dispose();
			}
			if (forceEnterRoom)
			{
				ForceRefrshRoomArea();
			}
			if (!teleport)
			{
				GetSystem<GameResourceSystem>()?.UnloadUnusedAssets(performGCCollect: false);
			}
			Singleton<MathTriggerSystem>.Instance?.ResetTriggerDatas();
		}
	}

	public void ResetMovingPlatform()
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.ResetMovingPlatform();
		}
	}

	public void ForceRefrshRoomArea()
	{
		sceneMapData.RefreshArea(isRefresh: true);
		BaseEntity entity = world.GetSystem<EntitySystem>().GetEntity(world.ActorId);
		if (currentRoom != null)
		{
			EnterRoom(currentRoom, entity);
		}
	}

	public void UpdateBonfireBornPoint(string bornPointKey)
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.UpdateBonfireBornPoint(bornPointKey);
		}
	}

	private void StreamerUpdate()
	{
		if (UsedStreamer)
		{
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(world.ActorId);
			if (entity != null)
			{
				playerVirtualTransform.transform.position = entity.transform.position;
			}
		}
	}

	public async Task StreamerForceUpdate()
	{
		if (UsedStreamer)
		{
			await UniTask.WaitForFixedUpdate();
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(world.ActorId);
			if (entity != null)
			{
				playerVirtualTransform.transform.position = entity.transform.position;
			}
			streamer.showLoadingScreen = true;
			streamer.CheckPositionTiles();
			await UniTask.WaitUntil(() => streamer.tilesToLoad <= 0 || streamer.LoadingProgress >= 1f);
			await UpdateLightProbes();
		}
	}

	public void SetCavesState(CavesTransform cavesTransform, int canvesId)
	{
		switch (cavesTransform)
		{
		case CavesTransform.Enter:
			EnterCaves(canvesId);
			break;
		case CavesTransform.Exit:
			ExitCaves();
			break;
		}
	}

	private void EnterCaves(int canves)
	{
		if (UsedStreamer)
		{
			streamer.SetCanTetrahedralize(canTetrahedralize: true);
		}
		sceneMapData.EnterCanvesCopyBornPoint(canves);
		GetSystem<BattleSystem>().SetIsInCaves(canves);
	}

	public int GetCavesId()
	{
		if ((Object)(object)sceneMapData != null)
		{
			return sceneMapData.GetCanvesId();
		}
		return 0;
	}

	private void ExitCaves()
	{
		if (UsedStreamer)
		{
			streamer.SetCanTetrahedralize(canTetrahedralize: false);
		}
		sceneMapData.ExitCanvesDeleteBornPoint();
		GetSystem<BattleSystem>().SetIsInCaves(0);
	}

	public void TeleportIsExitCaves()
	{
		sceneMapData.ExitCanvesDeleteBornPoint();
		GetSystem<BattleSystem>().SetIsInCaves(0);
	}

	public async Task UpdateLightProbes()
	{
		if (GetSystem<BattleSystem>().GetIsInCaves())
		{
			AsyncResult<bool> asyncResult = new AsyncResult<bool>(cancelable: true);
			LightProbes.TetrahedralizeAsync();
			LightProbes.tetrahedralizationCompleted += delegate
			{
				asyncResult.SetResult(result: true);
			};
			await asyncResult;
		}
		else
		{
			LightmapSettings.lightProbes = null;
		}
	}

	public async void LeaveCaves()
	{
		GamePause(transition: true);
		BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
		await new WaitForSecondsRealtime(1f);
		string enterCavesBornPointKey = sceneMapData.GetEnterCavesBornPointKey();
		ExitCaves();
		await Teleport(enterCavesBornPointKey, updateBornPointKey: false);
		await UniTask.WaitForEndOfFrame();
		blackScreen.Dispose();
		GameResume();
	}

	public void PlayBGM()
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.PlayBGM();
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		OnVisibelCheckUodate(deltaTime);
		LoadNodeLoop();
		CheckCurrentRoom();
		StreamerUpdate();
	}

	public List<int> GetAllActiveAreaMonsterEntity(List<int> entityIds)
	{
		if ((Object)(object)sceneMapData == null)
		{
			return null;
		}
		sceneMapData.areaCtrl.GetActiveAreaEntity(entityIds);
		return entityIds;
	}

	public void OnVisibelCheckUodate(float deltaTime)
	{
		sceneMapData?.OnTreeCheckUpdate(deltaTime);
	}

	public void AddObjectInOcTree(BaseMapDataNode area, Bounds bounds)
	{
		sceneMapData?.AddObjectInOcTree(area, bounds);
	}

	public void RemoveObjectInOcTree(BaseMapDataNode area)
	{
		sceneMapData?.RemoveObjectInOcTree(area);
	}

	public void ClearObjectInOcTree()
	{
		sceneMapData?.ClearObjectInOcTree();
	}

	public override void OnDispose()
	{
		GameResourceSystem system = GetSystem<GameResourceSystem>();
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.OnDispose();
		}
		if (bloomSettingChanged != null)
		{
			bloomSettingChanged.Dispose();
			bloomSettingChanged = null;
		}
		if (vignettingSettingChanged != null)
		{
			vignettingSettingChanged.Dispose();
			vignettingSettingChanged = null;
		}
		if (subscription_UpdateLevel != null)
		{
			subscription_UpdateLevel.Dispose();
			subscription_UpdateLevel = null;
		}
		if (mapDataRoot != null)
		{
			Object.Destroy(mapDataRoot);
			mapDataRoot = null;
		}
		sceneMapData = null;
		if (playerVirtualTransform != null)
		{
			Object.Destroy(playerVirtualTransform);
		}
		system?.UnloadAsset(AssetUtility.GetEntityAsset("ScreenEffect/GlassBreakScreenEffect"));
		if (_changeTeamPropertyConfig != null)
		{
			system?.UnloadAsset(AssetUtility.GetBattleViewConfigAsset("LevelConfig/ChangeTeamConfig.asset"));
			_changeTeamPropertyConfig = null;
		}
		if (_effectCameraShadow != null)
		{
			_effectCameraShadow.SetActive(value: false);
		}
		_cameraShadowMat = null;
		_effectCameraShadow = null;
		system = null;
		RestScreenEffect();
		base.OnDispose();
	}

	public void GamePause(bool transition = false)
	{
		world.GamePause(transition);
	}

	public void GameResume()
	{
		world.GameResume();
	}

	public List<PeripheryHeroData> GetOriginTeam()
	{
		if (storyWorld != null)
		{
			return storyWorld.GetOriginTeam();
		}
		return new List<PeripheryHeroData>();
	}

	public List<int> GetOriginTeamIds()
	{
		if (storyWorld != null)
		{
			return storyWorld.GetOriginTeamIds();
		}
		return new List<int>();
	}

	public void SwitchTeamClearData(bool changeOriginTeam)
	{
		if (storyWorld != null)
		{
			storyWorld.SwitchTeamClearData(changeOriginTeam);
		}
	}

	public void SwitchTeamVirCameraFollowSet(Transform followTrans)
	{
		if (currentRoom != null)
		{
			currentRoom.VriCameraFollowSet(followTrans);
		}
	}

	public void SwitchTeamVirCameraFollowNull()
	{
		if (currentRoom != null && world.GetSystem<EntitySystem>().GetEntity(world.ActorId) != null)
		{
			currentRoom.VirCameraFollowNull();
		}
	}

	public void SwitchTeamAddData(HeroEntity entity, bool changeOriginTeam)
	{
		if (storyWorld != null)
		{
			storyWorld.SwitchTeamAddData(entity, changeOriginTeam);
		}
	}

	public void RequestLoadNode(BaseMapDataNode baseMapDataNode)
	{
		if (!waitLoadingNodesQueue.Contains(baseMapDataNode))
		{
			waitLoadingNodesQueue.Enqueue(baseMapDataNode);
		}
	}

	private void LoadNodeLoop()
	{
		while (loadingCount > 0 && waitLoadingNodesQueue.Count > 0)
		{
			waitLoadingNodesQueue.Dequeue().StartLoadNode();
			loadingCount--;
		}
		loadingCount = 3;
	}

	private void CheckCurrentRoom()
	{
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		if (!world.IsStoryWorld || roomLerp || loackSwitchRoom)
		{
			return;
		}
		BaseEntity entity = world.GetSystem<EntitySystem>().GetEntity(world.ActorId);
		if (entity == null)
		{
			return;
		}
		PhysicsScene physicsScene = world.GetPhysicsScene();
		RaycastHit val = default(RaycastHit);
		if (!((PhysicsScene)(ref physicsScene)).Raycast(entity.transform.position, Vector3.down, ref val, float.MaxValue, _groundLayerMask, (QueryTriggerInteraction)0))
		{
			return;
		}
		Transform parent = ((RaycastHit)(ref val)).transform.parent;
		if ((!(parent == null) && parent.TryGetComponent<LevelRoom>(out var component)) || (!(parent.parent == null) && parent.parent.TryGetComponent<LevelRoom>(out component)))
		{
			if (currentRoom == null)
			{
				EnterRoom(component, entity);
			}
			else if (currentRoom != component)
			{
				SwitchRoom(component, entity);
			}
		}
	}

	private async void SwitchRoom(LevelRoom levelRoom, BaseEntity entity)
	{
		if (levelRoom.subSceneConnect && currentRoom.subSceneConnect && !roomLerp)
		{
			roomLerp = true;
			await DoTaskScreenEffect(active: true);
			ExitRoom();
			EnterRoom(levelRoom, entity);
			await DoTaskScreenEffect(active: false);
			roomLerp = false;
		}
		else
		{
			ExitRoom();
			EnterRoom(levelRoom, entity);
		}
	}

	public List<string> GetSwitchTeamProertyConfig()
	{
		if (_changeTeamPropertyConfig != null)
		{
			return _changeTeamPropertyConfig.RetentionPropertyKeys;
		}
		return null;
	}

	private async UniTask DoTaskScreenEffect(bool active)
	{
		if (active)
		{
			float alpha = 0f;
			while (alpha != 1f)
			{
				alpha = Mathf.Min(1f, alpha + Time.deltaTime * 6f);
				SetScreenEffectAlpha(alpha);
				await new WaitForFixedUpdate();
			}
		}
		else
		{
			float alpha = 1f;
			while (alpha != 0f)
			{
				alpha = Mathf.Max(0f, alpha - Time.deltaTime * 3f);
				SetScreenEffectAlpha(alpha);
				await new WaitForFixedUpdate();
			}
		}
	}

	private void SetScreenEffectAlpha(float alpha)
	{
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].profile.TryGet<ColorAdjustments>(out ColorAdjustments component);
			if ((bool)(Object)(object)component)
			{
				component.colorFilter.SetValue(new ColorParameter(Color.white * (1f - alpha)));
			}
		}
	}

	private void RestScreenEffect()
	{
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		foreach (Volume volume in array)
		{
			if (volume != null)
			{
				volume.profile.TryGet<ColorAdjustments>(out ColorAdjustments component);
				if ((bool)(Object)(object)component)
				{
					component.colorFilter.SetValue(new ColorParameter(Color.white));
				}
			}
		}
	}

	private void EnterRoom(LevelRoom room, BaseEntity entity)
	{
		if (room == null || entity == null)
		{
			return;
		}
		GameObject entityObject = entity.GetEntityObject();
		if (entityObject == null)
		{
			return;
		}
		room.OnEnterRoom(entityObject.transform);
		currentRoom = room;
		if (currentRoom.LevelAreaIndex != null)
		{
			for (int i = 0; i < currentRoom.LevelAreaIndex.Length; i++)
			{
				LevelArea levelArea = sceneMapData.areaCtrl.GetLevelArea(currentRoom.LevelAreaIndex[i]);
				if (levelArea != null)
				{
					levelArea.EnterRoomEvent();
				}
			}
		}
		UpdateRoomSubScene(currentRoom, active: true);
	}

	private void ExitRoom()
	{
		if (currentRoom == null)
		{
			return;
		}
		currentRoom.OnExitRoom();
		if (currentRoom.LevelAreaIndex != null)
		{
			for (int i = 0; i < currentRoom.LevelAreaIndex.Length; i++)
			{
				LevelArea levelArea = sceneMapData.areaCtrl.GetLevelArea(currentRoom.LevelAreaIndex[i]);
				if (levelArea != null)
				{
					levelArea.ExitRoomEvent();
				}
			}
		}
		UpdateRoomSubScene(currentRoom, active: false);
	}

	public void UpdateRoomSubScene(LevelRoom room, bool active)
	{
		if (UsedStreamer && room != null && room.subSceneConnect)
		{
			if (active)
			{
				streamer.OnSceneActive(room.SceneName);
			}
			else
			{
				streamer.OnSceneInActive(room.SceneName);
			}
		}
	}

	public void OnBossRelease(bool closeBossBloodBar = false)
	{
		if (storyWorld != null)
		{
			storyWorld.OnBossRelease(closeBossBloodBar);
		}
	}

	public void OnBossCreate()
	{
		if (storyWorld != null)
		{
			storyWorld.OnBossCreate();
		}
	}

	public void LockSwitchRoom(bool b)
	{
		loackSwitchRoom = b;
	}

	public async UniTask CloseStreamer()
	{
		if (UsedStreamer)
		{
			streamer.streamerActive = false;
			streamer.UnloadAllScenes();
			await UniTask.WaitUntil(() => streamer.CheckUnLoadAllFinish());
		}
	}

	public void ChangeMaterialMagicBlend(int dicKey, int index, float changeValue)
	{
		if (!((Object)(object)sceneSundryMapData == null))
		{
			sceneSundryMapData.ChangeMaterialMagicBlend(dicKey, index, changeValue);
		}
	}

	public void ChangeSceneGobjActive(int dicKey, bool active)
	{
		if (!((Object)(object)sceneSundryMapData == null))
		{
			sceneSundryMapData.ChangeSceneGobjActive(dicKey, active);
		}
	}

	public void GetTeachGuideBanSkillEnum()
	{
		if (!((Object)(object)sceneMapData != null) || !sceneMapData.TeachGuideLevel)
		{
			return;
		}
		foreach (KeyValuePair<int, (string, HeroSkillTypeEnum)> teachGuideCtrUI in MapDataHelper.TeachGuideCtrUIs)
		{
			if (teachGuideCtrUI.Value.Item2 == HeroSkillTypeEnum.None && UIWindowHelper.UIControls.TryGetValue(teachGuideCtrUI.Value.Item1, out var value))
			{
				value.gameObject.SetActive(value: false);
			}
		}
	}

	public bool GetIsInTeachGuideLevel()
	{
		if ((Object)(object)sceneMapData == null)
		{
			return false;
		}
		return sceneMapData.TeachGuideLevel;
	}

	public void TransPointInteract(int selectIndex, List<int> heroIds)
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.TransPointInteract(selectIndex, heroIds);
		}
	}

	public void ExitLevelDataReport()
	{
		if ((Object)(object)sceneMapData != null)
		{
			sceneMapData.ExitLevelDataReport();
		}
	}

	public void QuitLevel()
	{
		Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().QuitLevel();
	}

	private bool GetConditionResult(OpenCondition condition, int currentCopyOpen)
	{
		int playerLevel = GetPlayerLevel();
		bool result = false;
		if (condition.conditionType == 0)
		{
			result = GetSystem<TaskSystem>().CheckMapDataNodeActived(condition);
		}
		else if (condition.conditionType == 1)
		{
			switch (condition.checkType)
			{
			case CheckType.Equal:
				result = playerLevel == condition.checkValue;
				break;
			case CheckType.Greater:
				result = playerLevel > condition.checkValue;
				break;
			case CheckType.Less:
				result = playerLevel < condition.checkValue;
				break;
			case CheckType.GreaterEqual:
				result = playerLevel >= condition.checkValue;
				break;
			case CheckType.LessEqual:
				result = playerLevel <= condition.checkValue;
				break;
			}
		}
		else if (condition.conditionType == 2)
		{
			result = currentCopyOpen >= condition.copyOpenMin && currentCopyOpen <= condition.copyOpenMax;
		}
		return result;
	}

	public bool CheckCondition(List<OpenCondition> activeTaskCondition, bool meetAllconditions, bool invertCondition)
	{
		bool flag = false;
		if (activeTaskCondition == null || activeTaskCondition.Count <= 0)
		{
			return true;
		}
		int currentCopyOpen = GetSystem<TaskSystem>().GetCurrentCopyOpen();
		foreach (OpenCondition item in activeTaskCondition)
		{
			flag = GetConditionResult(item, currentCopyOpen);
			if ((!meetAllconditions & flag) || (meetAllconditions && !flag))
			{
				break;
			}
		}
		if (invertCondition)
		{
			flag = !flag;
		}
		return flag;
	}
}
