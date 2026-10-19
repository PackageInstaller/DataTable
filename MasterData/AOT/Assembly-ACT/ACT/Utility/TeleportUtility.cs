using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.World;
using ACT.World.Asset;
using ACT.World.Data.SceneRouters;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Utilities;
using UnityEngine;

namespace ACT.Utility;

public static class TeleportUtility
{
	private static bool _sameChunkBlackScreenOpened;

	public static Vector3 GetRecallPosition()
	{
		int checkPosUid = MonoECS.instance.checkPointManager.GetCurrentSceneInfo().CheckPosUid;
		int chunkIdBySGOID = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(checkPosUid);
		Vector3 vector = MonoECS.instance.checkPointManager.GetLastCheckPoint();
		if (vector == default(Vector3) || chunkIdBySGOID != Singleton<GameManager>.instance.worldManager.ActiveChunkId)
		{
			if (Singleton<GameManager>.instance.worldManager.ActiveRouterEntries == null || Singleton<GameManager>.instance.worldManager.ActiveRouterEntries.Count == 0)
			{
				vector = Singleton<GameManager>.instance.worldManager.ActiveWorld.GetSpawnPosition();
			}
			else
			{
				SceneChunkRouterData data = Singleton<GameManager>.instance.worldManager.ActiveRouterEntries[0].Data;
				vector = data.Position + data.SpawnOffset;
			}
		}
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		Physics.RaycastNonAlloc(vector, Vector3.down, cacheHits, 20f, BattleConsts.enviromentMask);
		cacheHits.Sort((RaycastHit x, RaycastHit y) => x.distance.CompareTo(y.distance));
		RaycastHit[] array = cacheHits;
		for (int num = 0; num < array.Length; num++)
		{
			RaycastHit raycastHit = array[num];
			if (!(raycastHit.collider == null))
			{
				vector = raycastHit.point;
				break;
			}
		}
		PhysicsUtility.Release(cacheHits);
		return vector;
	}

	public static bool IsSameChunkTeleport(int chunkId)
	{
		int activeChunkId = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		if (chunkId != 0)
		{
			return chunkId == activeChunkId;
		}
		return false;
	}

	public static void OpenSameChunkTeleportBlackScreen()
	{
		if (!_sameChunkBlackScreenOpened)
		{
			_sameChunkBlackScreenOpened = true;
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreen(1f);
		}
	}

	public static void CloseSameChunkTeleportBlackScreen()
	{
		if (_sameChunkBlackScreenOpened)
		{
			_sameChunkBlackScreenOpened = false;
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreen(0f);
		}
	}

	public static async UniTask SceneChangeTpWithLoader(int chunkId, int worldId, TeleportParams teleportParams)
	{
		if (Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal && !teleportParams.revive)
		{
			return;
		}
		MonoECS monoInstance = MonoECS.instance;
		GameRunningState lastRunningState = Singleton<GameState>.instance.RunningState;
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Loading);
		Vector3 pos = teleportParams.targetPos;
		MonoECS.instance.PushPause();
		SceneSpawnInfo spawnInfo = new SceneSpawnInfo
		{
			Pos = pos.ToPB(),
			ChunkID = chunkId,
			InteractionObjUID = -1
		};
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ClearHatred, null);
		float st = Time.time;
		GameWorld data = CoreUtils.GetData(worldId, RuntimeConfigs.data.gameWorlds);
		SceneStatus targetSceneStatus = (SceneStatus)data.type;
		ACT.World.MapArea mapAreaByChunkId = Singleton<GameManager>.instance.worldManager.GetMapAreaByChunkId(chunkId, targetSceneStatus);
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = targetSceneStatus,
			TargetMapArea = mapAreaByChunkId
		});
		SceneInfo sceneInfo = G.localPlayer.Profile.SceneInfos[(int)targetSceneStatus];
		if (targetSceneStatus == SceneStatus.Main && sceneInfo.WorldID != worldId)
		{
			bool sceneSwitchCompleted = false;
			G.service.SceneSwitch(pos, chunkId, worldId, targetSceneStatus, (int)mapAreaByChunkId, (bool _) =>
			{
				sceneSwitchCompleted = true;
			});
			await UniTask.WaitUntil(() => sceneSwitchCompleted || !Singleton<NetManager>.instance.IsConnected);
		}
		sceneInfo.LastPos = pos.ToPB();
		sceneInfo.ChunkID = chunkId;
		sceneInfo.WorldID = worldId;
		await Singleton<GameManager>.instance.worldManager.EnterWorld(targetSceneStatus);
		await UniTask.WaitUntil(() => Time.time >= st + 1f);
		monoInstance.SetUpMapData();
		monoInstance.SceneChangeComplete(SceneStatus.Main);
		Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, "跨世界TP完成设置复活点");
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_TP, null);
		MovementEvent evt = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt.pos = pos;
		evt.swid = -2f;
		evt.eventType = 2;
		evt.type = "WorldTP";
		EventTrackSolver.Instance.Dispatch(evt);
		MonoECS.instance.PopPause();
		Singleton<GameState>.instance.SetGameRunningState(lastRunningState);
	}

	public static async UniTask TeleportWithLoader(int chunkId, TeleportParams teleportParams, bool showLoadingView = true)
	{
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal || teleportParams.revive)
		{
			SceneStatus sceneStatus = MonoECS.instance.sceneStatus;
			ACT.World.MapArea mapAreaByChunkId = Singleton<GameManager>.instance.worldManager.GetMapAreaByChunkId(chunkId, sceneStatus);
			Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
			{
				TargetMapArea = mapAreaByChunkId,
				TargetSceneStatus = sceneStatus
			}, isBlack: false, null, null, showLoadingView);
			await Singleton<LoadManager>.instance.WaitLoadingViewFullyOpenedAsync();
			await TeleportCore(chunkId, teleportParams);
			await UniTask.WaitUntil(() => Singleton<LoadManager>.instance.IsComplete);
		}
		else
		{
			Singleton<LoadManager>.instance.FinishLoading();
			CloseSameChunkTeleportBlackScreen();
		}
	}

	public static void OpenCoverBeforeTransfer(StateWorldAssetData interactObjectData)
	{
		if (interactObjectData != null)
		{
			if (NeedSameChunkBlackScreenCover(interactObjectData, out var _))
			{
				OpenSameChunkTeleportBlackScreen();
			}
			else
			{
				Singleton<LoadManager>.instance.StartLoading();
			}
		}
	}

	private static bool NeedSameChunkBlackScreenCover(StateWorldAssetData interactObjectData, out int chunkId)
	{
		chunkId = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(interactObjectData.stateWorldAssetUid);
		if (interactObjectData is PortalData)
		{
			return IsSameChunkTeleport(chunkId);
		}
		return false;
	}

	public static async UniTask TeleportWithInteractObject(StateWorldAssetData interactObjectData)
	{
		PortalData portalData = interactObjectData as PortalData;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = interactObjectData.GetTeleportPos(),
			faceLeft = false,
			forceToFloor = true,
			revive = false,
			swid = interactObjectData.stateWorldAssetUid
		};
		bool flag = NeedSameChunkBlackScreenCover(interactObjectData, out var chunkId);
		MonoECS.PlayerTag targetTag = ((portalData != null) ? MonoECS.PlayerTag.TeleportRespawnAndTpMove : ((MonoECS.PlayerTag)0));
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal && Singleton<GameState>.instance.CanEnterPlayerOperation(targetTag))
		{
			OpenCoverBeforeTransfer(interactObjectData);
			SceneSpawnInfo spawnInfo = new SceneSpawnInfo
			{
				Pos = interactObjectData.GetSpawnPos().ToPB(),
				InteractionObjUID = interactObjectData.stateWorldAssetUid,
				ChunkID = chunkId
			};
			Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, "地图传送");
			try
			{
				if (portalData != null)
				{
					Singleton<TeleportMoveManager>.instance.BeginWebberCabinFlow();
					Singleton<TeleportMoveManager>.instance.SetData(portalData.initPos, portalData.SitPos, portalData.stateWorldAssetUid);
					Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: true);
				}
				await TeleportWithLoader(chunkId, teleportParams, !flag);
				if (portalData != null)
				{
					await UniTask.WaitUntil(() => !Model<TrialCharacterModel>.Interface.IsExitingTrialCharacterMode);
					Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreen(1f);
					_sameChunkBlackScreenOpened = false;
					await UniTask.WaitUntil(() => !Singleton<LoadManager>.instance.InLoading);
					Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: false);
					await UniTask.WaitUntil(() => Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.TeleportRespawnAndTpMove));
					MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.TeleportRespawnAndTpMove);
					GameManager.teleportMoveSystem.TryEnterTeleportMove();
					await UniTask.WaitUntil(() => Singleton<TeleportMoveManager>.instance.TimelineRespawnAndTpMove);
					Singleton<TeleportMoveManager>.instance.RespawnAndTpMoveTimelineComplete();
				}
				else if (interactObjectData is TempleEnterData)
				{
					GameUtility.TriggerTeleportPoint();
				}
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Map_TP, null);
				return;
			}
			finally
			{
				if (portalData != null)
				{
					Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: false);
					Singleton<TeleportMoveManager>.instance.EndWebberCabinFlow();
				}
			}
		}
		if (!flag)
		{
			Singleton<LoadManager>.instance.FinishLoading();
		}
		CloseSameChunkTeleportBlackScreen();
	}

	public static async UniTask TeleportWithPureBlackScreen(int chunkId, TeleportParams teleportParams, float fadeDuration = 0f, Action completeCallback = null)
	{
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal || teleportParams.revive)
		{
			if (fadeDuration <= 0f)
			{
				fadeDuration = 0.5f;
			}
			MonoECS.instance.PushPauseAllInput();
			await Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: true, fadeDuration);
			await TeleportCore(chunkId, teleportParams);
			await Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: false, fadeDuration);
			MonoECS.instance.PopPauseAllInput();
			completeCallback?.Invoke();
		}
	}

	public static async UniTask TeleportWithBlackScreen(int chunkId, TeleportParams teleportParams, BlackScreenParams blackScreenParams, Func<UniTask> afterBackEnable = null)
	{
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal || teleportParams.revive)
		{
			float beginTime = Time.time;
			MonoECS.instance.PushPauseAllInput();
			Singleton<NewUIManager>.instance.BlackScreen.ClearText();
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(blackScreenParams.fadeInDuration)
			});
			if (afterBackEnable != null)
			{
				await afterBackEnable();
			}
			await TeleportCore(chunkId, teleportParams);
			float num = Time.time - beginTime;
			if (num < blackScreenParams.leastDuration)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(blackScreenParams.leastDuration - num));
			}
			Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
			{
				fadeOutTime = TimeSpan.FromSeconds(blackScreenParams.fadeOutDuration)
			}).Forget();
			MonoECS.instance.PopPauseAllInput();
		}
	}

	public static async UniTask TeleportWithNone(int chunkId, TeleportParams teleportParams)
	{
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal || teleportParams.revive)
		{
			await TeleportCore(chunkId, teleportParams);
		}
	}

	private static async UniTask TeleportCore(int chunkId, TeleportParams teleportParams)
	{
		Vector3 pos = teleportParams.targetPos;
		MonoECS.instance.PushPause();
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Loading);
		if (Singleton<LoadManager>.instance.ActiveHandle is SceneLoadProgressHandle sceneLoadProgressHandle)
		{
			sceneLoadProgressHandle.AddStep(() => Singleton<GameManager>.instance.worldManager.PreparePos(chunkId, pos, teleportParams.afterPreparePosCallback));
			await sceneLoadProgressHandle.ExecuteAll();
		}
		else
		{
			await Singleton<GameManager>.instance.worldManager.PreparePos(chunkId, pos, teleportParams.afterPreparePosCallback);
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (teleportParams.forceToFloor)
		{
			CompTransform compTransform = mainEntity.GetCompTransform();
			pos = PhysicsUtility.GetGroundPoint(pos + compTransform.center, compTransform.size) - compTransform.center;
		}
		mainEntity.Teleport(pos);
		GameManager.cameraSystem.CameraTp(pos);
		CompPhysics? compPhysics = mainEntity.GetCompPhysics();
		compPhysics.SetConstZ(pos.z);
		MonoECS.instance.ClearMainEntityInput();
		mainEntity.SetFloat("GroundDistance", 0f);
		MonoECS.instance.ForceToIdle(mainEntity);
		compPhysics.SetMovementMode(ACTMovementMode.Walking);
		mainEntity.SetFaceLeft(teleportParams.faceLeft);
		compPhysics.SetDirImmediately();
		compPhysics.InitRotation(teleportParams.faceLeft);
		GameManager.monsterSystem.ClearAllMonsterHatred();
		MonoECS.instance.PopPause();
		MovementEvent evt = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt.pos = pos;
		evt.swid = teleportParams.swid;
		evt.eventType = (teleportParams.revive ? 3 : 2);
		evt.type = "Teleport";
		EventTrackSolver.Instance.Dispatch(evt);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_TP, null);
		await UniTask.NextFrame();
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Playing);
		MonoECS.instance.SyncGameInfos();
	}
}
