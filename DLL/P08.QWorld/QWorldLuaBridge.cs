using System;
using LuaInterface;
using P08.QWorld.Misc;
using Qworld.Runtime.SceneDither;
using UnityEngine;

public static class QWorldLuaBridge
{
	public static bool WalkingPeopleGlobleCull
	{
		get
		{
			return QWorldWalkingPeopleGroup.globalCulledOverride;
		}
		set
		{
			QWorldWalkingPeopleGroup.globalCulledOverride = value;
		}
	}

	public static bool BirdsGlobleCull
	{
		get
		{
			return QWorldBirdsOnGround.globalCulledOverride;
		}
		set
		{
			QWorldBirdsOnGround.globalCulledOverride = value;
		}
	}

	public static event Action<object> onEntityEnterInteractRange;

	public static event Action<object> onEntityExitInteractRange;

	public static event Action<int, int> onEntityEnterZone;

	public static event Action<int, int> onEntityExitZone;

	public static void StartSeeker(QWorldMapEntity entity, Vector3[] routes, float stopRange, bool isRun, Action stopCallback, Action<int> arriveCallback, float pauseRadius = -1f, Action pausAction = null, bool enableInteract = false, int interactMode = 0)
	{
		if (entity.GetAgent() != null)
		{
			if (entity.GetComponent<QWLocomotionBehaviour>() != null)
			{
				QWMoveToTargetAction qWMoveToTargetAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.MoveToTarget) as QWMoveToTargetAction;
				qWMoveToTargetAction.moveType = QWMoveActionType.FindByRoute;
				qWMoveToTargetAction.routes = routes;
				qWMoveToTargetAction.testRadius = stopRange;
				qWMoveToTargetAction.stopCallback = stopCallback;
				qWMoveToTargetAction.arriveCallback = arriveCallback;
				qWMoveToTargetAction.pauseRadius = pauseRadius;
				qWMoveToTargetAction.pauseCallback = pausAction;
				qWMoveToTargetAction.isRun = isRun;
				qWMoveToTargetAction.needForward = false;
				qWMoveToTargetAction.enableInteraction = enableInteract;
				qWMoveToTargetAction.interactionMode = interactMode;
				entity.BlackBoard.ActionAdd(qWMoveToTargetAction);
			}
			else
			{
				Debug.LogError("实体不存在Locomotion行为: " + entity.name);
			}
		}
	}

	public static Vector3[] GetPatrolPath(int entityId)
	{
		return ((NScene.GetCurrentScene() as QWorldScene)?.GetMapManager())?.GetPatrolPath(entityId)?.patrolPath;
	}

	public static void StartStory(int talkId, QWorldMapEntity target)
	{
		NScene.GetCurrentScene();
		LuaHelper.CallFunction("QWorldPlayStory", talkId, target);
	}

	public static void StopStory()
	{
		NScene.GetCurrentScene();
		LuaHelper.CallFunction("QWorldEndStory");
	}

	public static void EntraceLauncher(string map, int heroId)
	{
		QWorldMap.MapPath = "QWWorld/Map/" + map;
		QWorldMap.HeroId = heroId;
		NScene.Load<QWorldScene>();
	}

	public static void Launcher(string sceneName)
	{
		NScene.Load<QWorldScene>().qwSceneName = sceneName;
	}

	public static void Restart(string sceneName)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.qwSceneName != sceneName)
		{
			qWorldScene.qwSceneName = sceneName;
			SceneDirector.Instance.Restart(0);
		}
	}

	public static QWorldBubbleManager GetBubbleMgr()
	{
		return (NScene.GetCurrentScene() as QWorldScene).bubbleMgr;
	}

	public static QWorldMapEntity CreateMapEntity(int entityId, int type)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (null != qWorldScene && qWorldScene.GetMapManager() != null)
		{
			QWorldMapManager mapManager = qWorldScene.GetMapManager();
			return type switch
			{
				1 => mapManager.CreateNpcEntity(entityId), 
				2 => mapManager.CreateFunitureEntity(entityId), 
				3 => mapManager.CreateZoneEntity(entityId), 
				_ => mapManager.CreateMapEntity(entityId), 
			};
		}
		return null;
	}

	public static bool RemoveMapEntity(int uniqueId)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (null != qWorldScene && qWorldScene.GetMapManager() != null)
		{
			return qWorldScene.GetMapManager().RemoveByUniqueId(uniqueId);
		}
		return false;
	}

	public static QWorldThingEntityData GetMapEntityData(int entityId)
	{
		if (QWorldScene.Scene != null && QWorldScene.Scene.GetMapManager() != null)
		{
			return QWorldScene.Scene.GetMapManager().GetMapEntityData(entityId);
		}
		return null;
	}

	public static void CullingAllDynamic(bool hideAll, int[] hiddenIds = null, int cullingLayer = 4095)
	{
		if (QWorldScene.Scene != null)
		{
			QWorldScene.Scene.CullingAll(hideAll, hiddenIds, (QWAgentLayer)cullingLayer);
		}
	}

	public static void HidePlayer(bool hide)
	{
		if (QWorldScene.Scene != null)
		{
			QWorldScene.Scene.Agent.CharacterBlackboard.playerHide = hide;
		}
	}

	public static void HideHud(bool hide)
	{
		QWorldScene.Scene.hudManager.HideAllHud(hide);
	}

	public static GameObject CreateQWorlEffect(string path, Vector3 position, Quaternion rotation)
	{
		GameObject gameObject = Asset.Instantiate(path);
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.position = position;
		gameObject.transform.rotation = rotation;
		gameObject.transform.localScale = Vector3.zero;
		EffectController component = gameObject.GetComponent<EffectController>();
		if (component != null)
		{
			component.Initialize(isLoop: true, float.MaxValue, 1f, BattleScene.AIQuality, null);
			component.EnableVirtualCameras();
			component.Simulator(0f);
		}
		return gameObject;
	}

	public static void DestroyQWorldAsset(GameObject obj, float time = 0f)
	{
		if (!(obj == null))
		{
			if (obj.activeSelf)
			{
				PooledAsset.DestroyOrReturn(obj, time);
			}
			else
			{
				obj.GetComponent<PooledAsset>().Return();
			}
		}
	}

	public static bool TrackMapEntity(int[] track_entity_list)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (null != qWorldScene && qWorldScene.GetMap() != null)
		{
			qWorldScene.GetMap().Track(track_entity_list);
			return true;
		}
		return false;
	}

	public static int GetFuniturePerformAction(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return -1;
		}
		return qWFurnitureBlackboard.InteractAction;
	}

	public static int GetFuniturePerformExitAction(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return -1;
		}
		return qWFurnitureBlackboard.ExitInteractAction;
	}

	public static bool GetFunitureNeedForceBack(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return false;
		}
		if (qWFurnitureBlackboard.dormTag.dontNeedMoveExit)
		{
			return qWFurnitureBlackboard.dormTag.needForceExit;
		}
		return false;
	}

	public static bool GetFurnitureCanAutoExit(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return false;
		}
		if (!qWFurnitureBlackboard.dormTag.dontNeedMoveExit)
		{
			return qWFurnitureBlackboard.ExitInteractAction == 0;
		}
		return false;
	}

	public static Transform GetFunitureFocusPoint(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return null;
		}
		if (!qWFurnitureBlackboard.dormTag.needFocus)
		{
			return null;
		}
		return qWFurnitureBlackboard.dormTag.focusPoint;
	}

	public static Transform GetFunitureExitPoint(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return null;
		}
		return qWFurnitureBlackboard.dormTag.forceExitPoint;
	}

	public static void HideBubble(bool active = true)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			if (active)
			{
				qWorldScene.bubbleMgr.HideBubble();
			}
			else
			{
				qWorldScene.bubbleMgr.StartBubble();
			}
		}
	}

	public static void StopControl(bool active = true, bool withCamera = true)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.Agent.CharacterBlackboard.disableMoveInput = active;
			qWorldScene.Agent.CharacterBlackboard.disablePosition = active;
			qWorldScene.Agent.CharacterBlackboard.inputMovement = new QWCharacterMovement(qWorldScene.Agent.Forward, 0f);
		}
	}

	public static void StopControlFrame(int frameCount)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.Agent.CharacterBlackboard.diablePositionFrame = frameCount;
			qWorldScene.Agent.CharacterBlackboard.inputMovement = new QWCharacterMovement(qWorldScene.Agent.Forward, 0f);
		}
	}

	public static void PauseSceneDither(bool pause)
	{
		if (QWSceneDitherSystem.Instance != null)
		{
			QWSceneDitherSystem.Instance.PauseSceneDither(pause);
		}
	}

	public static void CloseUI(bool active = true)
	{
		if (NScene.GetCurrentScene() as QWorldScene != null)
		{
			if (active)
			{
				LuaHelper.CallFunction("QWorldUIHide");
			}
			else
			{
				LuaHelper.CallFunction("QWorldUIShow");
			}
		}
	}

	public static void ActiveMiniMap(bool active)
	{
		(NScene.GetCurrentScene() as QWorldScene).GetMap().ActiveMiniMap(active);
	}

	public static void EntityShowQuest(QWorldMapEntity entity, int questType, bool isInTaskTracking = false)
	{
		if (NScene.GetCurrentScene() is QWorldScene)
		{
			entity.GetBlackBoard();
			if ((bool)entity.BlackBoard)
			{
				QWQuestShowAction qWQuestShowAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.ShowQuest) as QWQuestShowAction;
				qWQuestShowAction.questType = (EQuestType)questType;
				qWQuestShowAction.isInTaskTracking = isInTaskTracking;
				entity.BlackBoard.ActionAdd(qWQuestShowAction);
			}
		}
	}

	public static void EntityShowCommonHud(QWorldMapEntity entity, string commonHudPath, string baseBoardPath, string deputyName)
	{
		if (NScene.GetCurrentScene() is QWorldScene)
		{
			entity.GetBlackBoard();
			if ((bool)entity.BlackBoard)
			{
				QWCommonHudShowAction qWCommonHudShowAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.CommonHudShow) as QWCommonHudShowAction;
				qWCommonHudShowAction.iconName = commonHudPath;
				qWCommonHudShowAction.baseBoardName = baseBoardPath;
				qWCommonHudShowAction.jobName = deputyName;
				qWCommonHudShowAction.isAdd = commonHudPath.IsNotNullOrEmpty();
				entity.BlackBoard.ActionAdd(qWCommonHudShowAction);
			}
		}
	}

	[NoToLua]
	public static void ClearAllEvent()
	{
		onEntityEnterInteractRange = null;
		onEntityExitInteractRange = null;
		onEntityEnterZone = null;
		onEntityExitZone = null;
	}

	[NoToLua]
	public static void OnEntityEnterInteractRange(QWorldMapEntity entity)
	{
		onEntityEnterInteractRange(entity);
	}

	[NoToLua]
	public static void OnEntityExitInteractRange(QWorldMapEntity entity)
	{
		onEntityExitInteractRange(entity);
	}

	[NoToLua]
	public static void OnEntityEnterZone(int zoneId, QWorldMapEntity entity)
	{
		onEntityEnterZone(zoneId, entity.uniqueId);
	}

	[NoToLua]
	public static void OnEntityExitZone(int zoneId, QWorldMapEntity entity)
	{
		onEntityExitZone(zoneId, entity.uniqueId);
	}

	[NoToLua]
	public static void OnPlayerEnterZone(int zoneId, QWCharacterAgent agent)
	{
		onEntityEnterZone(zoneId, -1);
	}

	[NoToLua]
	public static void OnPlayerExitZone(int zoneId, QWCharacterAgent agent)
	{
		onEntityExitZone(zoneId, -1);
	}

	public static void Teleport(int teleportId, bool needReset = false)
	{
		QWorldHelper.Teleport(teleportId, needReset);
	}

	public static void TeleportToNearest(Vector3 positon, bool needReset = false)
	{
		QWorldScene.Scene.teleportManager.TeleportToNearest(positon);
	}

	public static void TeleportToCachePos(Vector3 position, Quaternion rotation, bool needReset = false, bool ignoreCamera = false)
	{
		QWorldHelper.TeleportToCachePos(position, rotation, needReset, ignoreCamera);
	}

	public static void TeleportToStageOrigin()
	{
		TeleportContext stageOriginTeleport = QWorldScene.Scene.teleportManager.GetStageOriginTeleport();
		TeleportToCachePos(stageOriginTeleport.position, stageOriginTeleport.rotation, needReset: true);
	}

	public static QWCharacterAgent GetPlayer()
	{
		return QWorldHelper.GetPlayer();
	}

	public static void EnableCamera(int flag, string path, int layer)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.cameraManager.EnableCamera(flag, path, layer);
		}
	}

	public static void ExitFocusCamera()
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.cameraManager.ExitFocusCamera();
		}
	}

	public static void ExitTopCustomCamera()
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.cameraManager.ExitTopCustomCamera();
		}
	}

	public static void ExitCustomCamera(string cameraPath)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.cameraManager.ExitCustomCamera(cameraPath);
		}
	}

	public static void SetCameraBlend(int style, float time)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			qWorldScene.cameraManager.SetCameraBlend(style, time);
		}
	}

	public static void SwitchControlCharacter(int charId)
	{
		QWChangeCharacterAction qWChangeCharacterAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeCharacter) as QWChangeCharacterAction;
		qWChangeCharacterAction.charId = charId;
		qWChangeCharacterAction.isLoad = true;
		QWorldScene.Scene.Agent.Blackboard.ActionAdd(qWChangeCharacterAction);
	}

	public static void EnterPlayerFocus(bool isEnter)
	{
		QWCharacterEnterPlayerFocusAction qWCharacterEnterPlayerFocusAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.EnterPlayerFocusState) as QWCharacterEnterPlayerFocusAction;
		qWCharacterEnterPlayerFocusAction.isEnter = isEnter;
		QWorldScene.Scene.Agent.Blackboard.ActionAdd(qWCharacterEnterPlayerFocusAction);
	}

	public static void ChangeInteractionMode(int mode)
	{
		QWorldScene.GetQWorldContext().ChangeInteractionMode((QWInteractionModeEnum)mode);
	}

	public static int GetInteractionMode()
	{
		return (int)QWorldScene.GetQWorldContext().InteractMode;
	}

	public static void ChangeSceneLodChangeRatio(float[] lods)
	{
		QWorldScene.Scene.ResetLODParams(lods);
	}

	public static void RebuildSceneLodGroups()
	{
		QWorldScene.Scene.RebuildLOD();
	}

	public static void EnableCameraCut(bool enable)
	{
	}
}
