using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.ECS.System;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Utility;
using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

public abstract class WorldBase : IWorld
{
	protected DateTime _worldStartTime;

	protected WorldData _worldData;

	protected float _runtime;

	private WorldChallengeState _worldChallengeState;

	public WorldDataHandle WorldDataHandle => new WorldDataHandle(_worldData);

	public ISceneChunkControl ActiveChunk => Singleton<GameManager>.instance.worldManager.ActiveChunk;

	internal abstract SceneStatus SceneStatus { get; }

	internal WorldChallengeState WorldChallengeState
	{
		get
		{
			return _worldChallengeState;
		}
		set
		{
			if (value != _worldChallengeState)
			{
				_worldChallengeState = value;
				switch (_worldChallengeState)
				{
				case WorldChallengeState.Fail:
					OnFail();
					break;
				case WorldChallengeState.Success:
					OnSuccess();
					break;
				}
			}
		}
	}

	public int WorldId => _worldData.WorldID;

	public virtual Vector3 GetSpawnPosition()
	{
		return Singleton<GameManager>.instance.worldManager.GetActiveWorldSpawnPosition();
	}

	public Dictionary<int, MaterialTrackTransferData> GetTransferRangeByEnemyType(int enemyType)
	{
		return Singleton<GameManager>.instance.worldManager.GetTransferRangeByEnemyType(enemyType);
	}

	internal abstract void InitWorldData(WorldData data);

	internal abstract void UninitWorldData();

	internal virtual async UniTask EnterWorld(SceneLoadProgressHandle progressHandle = null)
	{
		Singleton<GameState>.instance.SetWorldState(WorldState.Enter);
		AddListener();
		if (progressHandle == null)
		{
			await OnBeforeEnterWorld();
			await SpawnWorld();
			await SpawnCharacters();
			await SpawnPotion();
			await SpawnWorldBlueprint();
			await SceneChangeComplete();
			await OnAfterEnterWorld();
			await WaitNpcLoadComplete();
		}
		else
		{
			progressHandle.AddStep(OnBeforeEnterWorld, 0.5f);
			progressHandle.AddStep(SpawnWorld, 6f);
			progressHandle.AddStep(SpawnCharacters, 1.5f);
			progressHandle.AddStep(SpawnPotion, 0.5f);
			progressHandle.AddStep(SpawnWorldBlueprint);
			progressHandle.AddStep(SceneChangeComplete, 0.5f);
			progressHandle.AddStep(OnAfterEnterWorld, 0.5f);
			progressHandle.AddStep(WaitNpcLoadComplete, 2f);
			await progressHandle.ExecuteAll();
		}
		_worldStartTime = DateTime.Now;
		_runtime = 0f;
		Singleton<GameState>.instance.SetWorldState(WorldState.Normal);
	}

	internal virtual async UniTask LeaveWorld()
	{
		Singleton<GameState>.instance.SetWorldState(WorldState.Leave);
		DestroyWorldBlueprint();
		SceneLoadProgressHandle.ReportCurrentSubProgress(0.15f);
		await OnBeforeLeaveWorld();
		SceneLoadProgressHandle.ReportCurrentSubProgress(0.3f);
		await DestroyAllCharacter();
		SceneLoadProgressHandle.ReportCurrentSubProgress(0.5f);
		await DestroyPotion();
		SceneLoadProgressHandle.ReportCurrentSubProgress(0.55f);
		await DestroyWorld();
		SceneLoadProgressHandle.ReportCurrentSubProgress(1f);
		await OnAfterLeaveWorld();
		RemoveListener();
		Singleton<GameState>.instance.SetWorldState(WorldState.None);
	}

	internal virtual void Update()
	{
	}

	internal virtual void FixedUpdate()
	{
		if (!Singleton<LoadManager>.instance.InLoading)
		{
			_runtime += GameManager.timeSystem.GetWorldRuntimeDeltaTime();
			OnWorldRuntimeFixedTick();
		}
	}

	internal virtual void OnWorldRuntimeFixedTick()
	{
	}

	internal virtual void OnCharacterDie(Entity beahve)
	{
		if (TryChangeToAliveEntity(out var entityBehave) && entityBehave.IsValid)
		{
			MonoECS.instance.ChangeCharacter(entityBehave);
		}
	}

	protected virtual void AddListener()
	{
	}

	protected virtual void RemoveListener()
	{
	}

	protected virtual void OnFail()
	{
	}

	protected virtual void OnSuccess()
	{
	}

	protected virtual async UniTask OnBeforeEnterWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask OnAfterEnterWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask OnBeforeLeaveWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask OnAfterLeaveWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask OnBeforeReopenWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask OnAfterReopenWorld()
	{
		await UniTask.CompletedTask;
	}

	protected virtual bool NeedRemoveBeahve()
	{
		return true;
	}

	internal virtual async UniTask LastCheckPointRecovery(float hpPercent = 1f)
	{
		Vector3 vector = GetSpawnPos();
		await Singleton<RespawnManager>.instance.CoRespawn(hpPercent, SceneStatus);
		int activeChunkId = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = vector,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		await TeleportUtility.TeleportWithNone(activeChunkId, teleportParams);
		Singleton<BloodBottleHandler>.instance.RecoverItems();
	}

	internal virtual async UniTask CharacterRecovery()
	{
		Team teamInfo = _worldData.TeamInfo;
		foreach (Character item in CharacterDataHelper.GetAllCharactersByTeamInfo(SceneStatus, teamInfo))
		{
			item.Status.Hp = RuntimeConfigs.data.game.hpSync;
			item.Status.AssistPower = 0f;
			item.Status.EnergyPower = 0f;
			item.Status.ExPower = 0f;
			item.Status.SpecialEnergyPower = 0f;
		}
	}

	protected virtual async UniTask<bool> SpawnWorldV2()
	{
		return false;
	}

	protected virtual async UniTask SpawnWorld()
	{
		int partitionConfigId = _worldData.WorldConfigId;
		if (RuntimeConfigs.data.gameWorlds.TryGetValue(_worldData.WorldID, out var value))
		{
			partitionConfigId = value.config;
		}
		ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await Singleton<GameManager>.instance.worldManager.ResetWorld(partitionConfigId, SceneStatus);
		if (!loadPartitionResult.Success)
		{
			throw new Exception($"【异常】无法找到({_worldData.WorldID})世界所对应的场景配置: {partitionConfigId}");
		}
		ConfigWorldPartition_v2 data = loadPartitionResult.Data;
		Vector3 pos = ((_worldData.UseWorldSpawnPosition && data.UseSpawnPosition) ? data.SpawnPosition : _worldData.SpawnPosition);
		int chunkId = _worldData.ChunkId;
		IPreparePosResult preparePosResult = await Singleton<GameManager>.instance.worldManager.PreparePos(chunkId, pos);
		if (preparePosResult.Invalid)
		{
			if (WorldUtils.InGameWorldIdRange(_worldData.WorldConfigId))
			{
				Debug.LogError($"【错误】场景失败！！目标 [ World:{_worldData.WorldID}, Chunk:{chunkId} ]，请检查配置或存档数据！");
			}
		}
		else if (preparePosResult.Success)
		{
			_worldData.SpawnPosition = preparePosResult.FixedPosition;
		}
	}

	protected virtual async UniTask SpawnCharacters()
	{
		Team teamInfo = _worldData.TeamInfo;
		int battleIndex = GetRuntimeBattleIndex(teamInfo.BattleCharacterIdx);
		List<Character> allCharacters = CharacterDataHelper.GetAllCharactersByTeamInfo(SceneStatus, teamInfo);
		for (int i = 0; i < allCharacters.Count; i++)
		{
			Character character = allCharacters[i];
			character.SetCharacterElement();
			await SpawnTeamCharacter(character, i, battleIndex, isLeft: false, _worldData.SpawnPosition);
			SceneLoadProgressHandle.ReportCurrentSubProgress(((float)i + 1f) / (float)allCharacters.Count);
		}
		SetBattleTeamInfo(allCharacters, battleIndex);
		SystemCamera cameraSystem = GameManager.cameraSystem;
		cameraSystem.SetCameraPosition(_worldData.SpawnPosition);
		cameraSystem.CameraTp(_worldData.SpawnPosition);
	}

	protected virtual async UniTask WaitNpcLoadComplete()
	{
		if (Singleton<RuntimeNpcManager>.HasInstance())
		{
			await Singleton<RuntimeNpcManager>.instance.WaitAllNpcLoadCompleteAsync(SceneLoadProgressHandle.ReportCurrentSubProgress);
		}
	}

	private int GetRuntimeBattleIndex(int configuredBattleIndex)
	{
		if (SceneStatus != SceneStatus.Main || MPPlayer.local == null)
		{
			return configuredBattleIndex;
		}
		RepeatedField<int> repeatedField = _worldData?.TeamInfo?.CharacterIds;
		int normalRuntimeBattleIndex = MPPlayer.local.GetNormalRuntimeBattleIndex(configuredBattleIndex);
		return MPPlayer.local.SelectAliveMemberIndex(repeatedField?.Count ?? 0, normalRuntimeBattleIndex, configuredBattleIndex, configuredBattleIndex, IsMainTeamCharacterAlive);
	}

	private bool IsMainTeamCharacterAlive(int index)
	{
		RepeatedField<int> repeatedField = _worldData?.TeamInfo?.CharacterIds;
		if (repeatedField == null || index < 0 || index >= repeatedField.Count || repeatedField[index] == 0)
		{
			return false;
		}
		if (CharacterDataHelper.TryGetCharacter(SceneStatus.Main, repeatedField[index], out var character))
		{
			return character.IsRuntimeAlive();
		}
		return false;
	}

	protected virtual async UniTask SpawnPotion()
	{
		int equipPotionId = _worldData.TeamInfo.EquipPotionId;
		if (_worldData.TeamInfo.EquippedTrialPotion)
		{
			int num = equipPotionId;
			CharacterDataHelper.GetCharacterRepository(SceneStatus).TrialPotions.TryGetValue(num, out var value);
			if (Model<BloodBottleModel>.Interface.TryCreateTrialBloodBottle(num, value, out var _))
			{
				Model<BloodBottleModel>.Interface.ChangeWorldLocalPotion(num);
			}
			return;
		}
		Model<BloodBottleModel>.Interface.ChangeWorldPotion(SceneStatus, equipPotionId);
		Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(equipPotionId);
		Singleton<BloodBottleBuffHandler>.instance.UpdateBuffData(equipPotionId);
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			Singleton<BloodBottleBuffHandler>.instance.ApplyAllBuffsToEntity(mainEntity);
		}
	}

	protected virtual async UniTask SceneChangeComplete()
	{
		MonoECS.instance.SceneChangeComplete(SceneStatus);
		await UniTask.CompletedTask;
	}

	protected virtual async UniTask SpawnWorldBlueprint()
	{
		await Singleton<GameManager>.instance.worldManager.CreateWorldBlueprint();
	}

	protected virtual void DestroyWorldBlueprint()
	{
		Singleton<GameManager>.instance.worldManager.ReleaseWorldBlueprint();
	}

	protected virtual async UniTask DestroyAllCharacter()
	{
		if ((Singleton<GameState>.instance.WorldLoadState & WorldLoadState.Reopening) > WorldLoadState.None || _worldData.TeamCharacters == null || _worldData.TeamCharacters.Count == 0)
		{
			return;
		}
		for (int i = _worldData.TeamCharacters.Count - 1; i >= 0; i--)
		{
			Character character = _worldData.TeamCharacters[i];
			if (character != null)
			{
				await RemoveTeamCharacter(character);
			}
		}
		GameManager.effectSystem?.CleanAllEffect();
	}

	protected virtual async UniTask DestroyWorld()
	{
		await Singleton<GameManager>.instance.worldManager.Release();
	}

	protected virtual async UniTask DestroyPotion()
	{
	}

	protected virtual Vector3 GetLastPos()
	{
		return G.localPlayer.GetLastPos(SceneStatus);
	}

	protected virtual Vector3 GetSpawnPos()
	{
		return G.localPlayer.GetSpawnPos(SceneStatus);
	}

	internal abstract Character GetCharacter(int characterId);

	internal virtual async UniTask RemoveTeamCharacter(Character character)
	{
		if (character != null)
		{
			if (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
			{
				Singleton<GameManager>.instance.ecsManager.systemCamera.DestroyCharacterVCam(entity.Id);
				MonoECS.instance.ReleaseCharacterBattleEntity(entity);
			}
			if (_worldData.TeamCharacters != null)
			{
				_worldData.TeamCharacters.Remove(character);
			}
		}
	}

	internal UniTask ReleaseCharacterBattleEntity(Character character)
	{
		if (character != null && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			Singleton<GameManager>.instance.ecsManager.systemCamera.DestroyCharacterVCam(entity.Id);
			MonoECS.instance.ReleaseCharacterBattleEntity(entity);
		}
		return UniTask.CompletedTask;
	}

	internal void SetBattleTeamInfo(List<Character> characters, int battleIndex)
	{
		EntityId[] array = new EntityId[BattleConsts.TEAMCAPITAL];
		for (int i = 0; i < array.Length; i++)
		{
			Character character = ((i < characters.Count) ? characters[i] : null);
			if (character != null && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
			{
				array[i] = entity.Id;
			}
			else
			{
				array[i] = EntityId.Invalid;
			}
		}
		MPPlayer.local.SetTeamCharacters(array, battleIndex, characters, _worldData.TeamInfo?.EquipPotionId ?? (-1));
	}

	internal virtual async UniTask SpawnTeamCharacter(Character character, int index, int battleIndex, bool isLeft = false, Vector3 position = default(Vector3), bool isLoadSave = false)
	{
		if (character == null)
		{
			return;
		}
		if ((await MonoECS.instance.SpawnOwnerCharacter(MPEntityType.Character, character.Id, index, character, isLeft, position, isLoadSave, battleIndex)).IsValid)
		{
			WorldData worldData = _worldData;
			if (worldData.TeamCharacters == null)
			{
				worldData.TeamCharacters = new List<Character>();
			}
			if (!_worldData.TeamCharacters.Contains(character))
			{
				_worldData.TeamCharacters.Add(character);
			}
		}
	}

	internal void ResetTeamCharacters(List<int> characters, int battleCharacterIdx = -1)
	{
		Team teamInfo = _worldData.TeamInfo;
		teamInfo.CharacterIds.Clear();
		teamInfo.CharacterIds.AddRange(characters);
		if (battleCharacterIdx >= 0)
		{
			teamInfo.BattleCharacterIdx = battleCharacterIdx;
		}
	}

	internal void ResetTeamPotion(int potionId)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity != null)
		{
			Singleton<BloodBottleBuffHandler>.instance.RemoveAllBuffsFromEntity(mainEntity);
		}
		_worldData.TeamInfo.EquipPotionId = potionId;
		Model<BloodBottleModel>.Interface.ChangeWorldPotion(SceneStatus, potionId);
		Singleton<BloodBottleBuffHandler>.instance.UpdateBuffData(potionId);
		if (mainEntity != null)
		{
			Singleton<BloodBottleBuffHandler>.instance.ApplyAllBuffsToEntity(mainEntity);
		}
		Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(potionId);
	}

	protected bool TryChangeToAliveEntity(out Entity entityBehave)
	{
		entityBehave = default;
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		Entity switchCharacter = localPlayer.GetSwitchCharacter(0);
		Entity switchCharacter2 = localPlayer.GetSwitchCharacter(1);
		ClearCharacter(MonoECS.instance.mainEntity);
		if (switchCharacter.IsAlive())
		{
			entityBehave = switchCharacter;
			return true;
		}
		if (switchCharacter2.IsAlive())
		{
			entityBehave = switchCharacter2;
			return true;
		}
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Die)
		{
			Singleton<GameState>.instance.SetPlayerAliveState(PlayerLiveState.DieAnimationEnd);
		}
		return false;
	}

	private void ClearCharacter(Entity entity)
	{
		CompMotion? compMotion = entity.GetCompMotion();
		compMotion.DeActiveVolume();
		foreach (ACT.Battle.Skill skill in compMotion.skills)
		{
			if (skill.config.name == "switchSkillCD")
			{
				skill.SetSkillCount(0);
				skill.SetSkillCd(20f, exceeds: false);
			}
		}
		entity.SetChangeCd(0f);
	}

	public float GetRuntime()
	{
		return _runtime;
	}

	public virtual RoadMaterial GetRoadMaterialByWorldPos(Vector3 pos)
	{
		return RoadMaterial.Normal;
	}
}
