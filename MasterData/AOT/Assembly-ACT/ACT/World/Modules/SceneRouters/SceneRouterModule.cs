using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.ECS.System;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.Data.SceneRouters;
using ACT.World.SceneChunks;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Modules.SceneRouters;

internal class SceneRouterModule : WorldModuleBase
{
	private Dictionary<int, ChunkRouterMaintainer> _routerEntryControlMap;

	private int _worldConfigId;

	private ChunkRouterMaintainer _activeMaintainer;

	private static readonly Vector3 TransposeFix = new Vector3(0f, 0.022f, 0f);

	internal override bool NeedGotChunkChange => true;

	protected override void OnLeaveWorld(WorldBase world)
	{
		_worldConfigId = -1;
		ClearAllRouterEntries();
	}

	internal void SetupWorldPartition(ConfigWorldPartition_v2 partitionData)
	{
		if (partitionData == null || _worldConfigId == partitionData.Id)
		{
			return;
		}
		ClearAllRouterEntries();
		_worldConfigId = partitionData.Id;
		if (_routerEntryControlMap == null)
		{
			_routerEntryControlMap = new Dictionary<int, ChunkRouterMaintainer>();
		}
		_routerEntryControlMap.Clear();
		SceneChunk[] sceneChunks = partitionData.SceneChunks;
		int num = sceneChunks.Length;
		for (int i = 0; i < num; i++)
		{
			SceneChunk sceneChunk = sceneChunks[i];
			if (sceneChunk.SceneRouters.Length != 0)
			{
				_routerEntryControlMap[sceneChunk.ChunkId] = new ChunkRouterMaintainer(this, sceneChunk);
			}
		}
	}

	private async UniTask<(IPreparePosResult, SceneChunkRouterData)> PreparePos(int chunkId, int routerId, Func<UniTask> afterPreparePosCallback = null, bool clearLastChunk = true)
	{
		if (!_routerEntryControlMap.TryGetValue(chunkId, out var value) || !value.TryGetRouterData(routerId, out var routerData))
		{
			return (PreparePosResult.InvalidResult, null);
		}
		Vector3 pos = routerData.Position + routerData.SpawnOffset;
		return (await Singleton<GameManager>.instance.worldManager.PreparePos(value.ChunkId, pos, afterPreparePosCallback, clearLastChunk), routerData);
	}

	protected override void OnSwitchActiveChunk(int activeWorldId, SceneChunk chunkData, SceneBlock chunkActiveStateData)
	{
		int chunkId = chunkData.ChunkId;
		if (_activeMaintainer == null || _activeMaintainer.ChunkId != chunkId)
		{
			_activeMaintainer?.Unload();
			_activeMaintainer = _routerEntryControlMap.GetValueOrDefault(chunkId);
			_activeMaintainer?.Load();
		}
	}

	private void ClearAllRouterEntries()
	{
		_activeMaintainer = null;
		if (_routerEntryControlMap == null)
		{
			return;
		}
		foreach (KeyValuePair<int, ChunkRouterMaintainer> item in _routerEntryControlMap)
		{
			item.Value.Release();
		}
		_routerEntryControlMap.Clear();
		_routerEntryControlMap = null;
	}

	public List<SceneRouterTriggerEntryControl> GetActiveSceneRouterEntries()
	{
		return _activeMaintainer?.RouterEntryControls;
	}

	internal bool CantTeleport()
	{
		GameState instance = Singleton<GameState>.instance;
		if (instance.RunningState == GameRunningState.Playing && instance.PlayerAlive != PlayerLiveState.Die && instance.PlayerAlive != PlayerLiveState.DieAnimationEnd && instance.GameControlStateMachine.Current != GameControlState.Skill)
		{
			return instance.InBlackScreenTransition;
		}
		return true;
	}

	private static async UniTask SetPureBlackFadeEnable(bool enable, float duration)
	{
		if (enable)
		{
			Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Loading);
			Singleton<GameState>.instance.SetBlackScreenTransitionState(inBlackScreenTrans: true);
			MonoECS.instance.PushPauseAllInput();
			MonoECS.instance.PushPause();
			await Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: true, duration, Singleton<GameInputActionManager>.instance.CorrectPlayerInputs);
		}
		else
		{
			await Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: false, duration, Singleton<GameInputActionManager>.instance.CorrectPlayerInputs);
			MonoECS.instance.PopPause();
			MonoECS.instance.PopPauseAllInput();
			Singleton<GameState>.instance.SetBlackScreenTransitionState(inBlackScreenTrans: false);
			Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Playing);
		}
	}

	internal void ExecuteTransition(SceneChunkRouterData data)
	{
		DoTransition(data).Forget();
	}

	private static async UniTask DoTransition(SceneChunkRouterData data)
	{
		await SetPureBlackFadeEnable(enable: true, data.FadeDuration);
		var (preparePosResult, nextRouterData) = await Singleton<GameManager>.instance.worldManager.RouterModule.PreparePos(data.NextChunkGuid, data.NextRouterUid, null, clearLastChunk: false);
		if (preparePosResult == null || preparePosResult.Invalid || !preparePosResult.Success)
		{
			Debug.LogError("尝试进入下个场景路由点失败，找不到对应的路由点数据");
			await SetPureBlackFadeEnable(enable: false, data.FadeDuration);
			return;
		}
		if (preparePosResult.Success)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			CompTransform compTransform = mainEntity.GetCompTransform();
			Vector2 size = compTransform.size;
			Vector3 vector = preparePosResult.FixedPosition + new Vector3(0f, size.y * 0.5f - size.x, 0f);
			vector = PhysicsUtility.GetGroundPoint(vector + compTransform.center, compTransform.size) - compTransform.center + TransposeFix;
			mainEntity.Teleport(vector);
			GameManager.cameraSystem.CameraTp(vector);
			CompPhysics? compPhysics = mainEntity.GetCompPhysics();
			compPhysics.SetConstZ(vector.z);
			MonoECS.instance.ClearMainEntityInput();
			mainEntity.GetCompMotion().SetFloat("GroundDistance", 0f);
			MonoECS.instance.ForceToIdle(mainEntity);
			compPhysics.SetMovementMode(ACTMovementMode.Walking);
			compPhysics.SetDirImmediately();
			compPhysics.InitRotation(mainEntity.GetCompTransform().FaceDir == FaceDir.Left);
			await UniTask.NextFrame();
		}
		float duration = nextRouterData?.FadeDuration ?? data.FadeDuration;
		await SetPureBlackFadeEnable(enable: false, duration);
	}

	private static async UniTask CameraTp(Vector3 targetPos)
	{
		SystemCamera cameraSystem = GameManager.cameraSystem;
		cameraSystem.SetCameraBlend();
		await UniTask.NextFrame();
		cameraSystem.CameraTp(targetPos);
		await UniTask.NextFrame();
		cameraSystem.SetCameraBlend(isDefault: true);
	}
}
