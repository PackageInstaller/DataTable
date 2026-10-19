using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class RespawnManager : Singleton<RespawnManager>
{
	private UniTaskCompletionSource _respawnConfirmSource;

	private RespawnSetting _defaultRespawnSetting = new RespawnSetting_Normal();

	private List<RespawnSetting> _respawnSettings = new List<RespawnSetting>();

	public override void UnInit()
	{
		base.UnInit();
		_respawnSettings.Clear();
	}

	public void ConfirmRespawn()
	{
		_respawnConfirmSource?.TrySetResult();
	}

	public void AddRespawnSetting(RespawnSetting setting)
	{
		_respawnSettings.Add(setting);
	}

	public void RemoveRespawnSetting(RespawnSetting setting)
	{
		_respawnSettings.Remove(setting);
	}

	private RespawnSetting GetCurrentRespawnSetting()
	{
		if (_respawnSettings.Count <= 0)
		{
			return _defaultRespawnSetting;
		}
		List<RespawnSetting> respawnSettings = _respawnSettings;
		return respawnSettings[respawnSettings.Count - 1];
	}

	public async UniTask CoRespawn(float hpPercent = 1f, SceneStatus sceneType = SceneStatus.Main)
	{
		MonoECS.instance.localPlayer.battleStartTimeStamp = 0L;
		RespawnSetting respawnSetting = GetCurrentRespawnSetting();
		SceneTempArchiveInfo boosTmpArchiveInfo = G.localPlayer.Profile.SceneInfos[(int)sceneType].TmpArchiveInfo;
		SceneSpawnInfo spawnInfo = G.localPlayer.Profile.SceneInfos[(int)MonoECS.instance.sceneStatus].SpawnInfo;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		StateWorldAssetData data = worldManager.GetWorldStateAssetDataBySGOID(spawnInfo.InteractionObjUID);
		Entity mainEntity = MonoECS.instance.mainEntity;
		CompTransform compTransform = mainEntity.GetCompTransform();
		int chunkId = worldManager.ActiveChunkId;
		Vector3 respawnPos = compTransform.physicsPosition;
		if (!(respawnSetting is RespawnSetting_Normal))
		{
			if (!(respawnSetting is RespawnSetting_NoMove))
			{
				if (!(respawnSetting is RespawnSetting_ToRespawnPos))
				{
					if (respawnSetting is RespawnSetting_ToCustomPos respawnSetting_ToCustomPos)
					{
						chunkId = respawnSetting_ToCustomPos.chunkId;
						respawnPos = respawnSetting_ToCustomPos.position;
					}
				}
				else
				{
					chunkId = spawnInfo.ChunkID;
					respawnPos = spawnInfo.Pos.ToUnity();
				}
			}
			else
			{
				chunkId = worldManager.ActiveChunkId;
				respawnPos = compTransform.physicsPosition;
			}
		}
		else
		{
			chunkId = spawnInfo.ChunkID;
			if (sceneType == SceneStatus.Main)
			{
				if (boosTmpArchiveInfo != null)
				{
					chunkId = boosTmpArchiveInfo.ChunkID;
					respawnPos = G.localPlayer.GetTmpArchivePos();
				}
				else if (data != null)
				{
					Vector3 vector;
					if (data is PortalData portalData)
					{
						vector = portalData.GetTeleportPos();
					}
					else if (data is TempleEnterData templeEnterData)
					{
						vector = templeEnterData.GetSpawnPos();
					}
					else
					{
						vector = ((!(data is MonsterPointData { serviceSaveTag: ServiceSaveTag.WildBoss } monsterPointData)) ? G.localPlayer.GetSpawnPos(sceneType) : monsterPointData.GetSpawnPos());
					}
					respawnPos = vector;
				}
				else
				{
					respawnPos = G.localPlayer.GetSpawnPos(sceneType);
				}
			}
		}
		_ = mainEntity.GetCompTransform().physicsPosition;
		Transform rootTransform = mainEntity.GetRootTransform();
		if (!(rootTransform != null))
		{
			_ = Quaternion.identity;
		}
		else
		{
			_ = rootTransform.rotation;
		}
		if (Model<BloodstainModel>.HasInstance())
		{
			_ = MonoECS.instance.sceneStatus;
		}
		PortalData portalDataForRespawn = ((boosTmpArchiveInfo == null && respawnSetting is RespawnSetting_Normal) ? (data as PortalData) : null);
		if (portalDataForRespawn != null)
		{
			Singleton<TeleportMoveManager>.instance.SetData(portalDataForRespawn.initPos, portalDataForRespawn.SitPos, portalDataForRespawn.stateWorldAssetUid);
			Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: true);
		}
		_respawnConfirmSource = new UniTaskCompletionSource();
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_RESPAWN);
		await _respawnConfirmSource.Task;
		_respawnConfirmSource = null;
		SceneStatus sceneStatus = MonoECS.instance.sceneStatus;
		ACT.World.MapArea mapAreaByChunkId = Singleton<GameManager>.instance.worldManager.GetMapAreaByChunkId(chunkId, sceneStatus);
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetMapArea = mapAreaByChunkId,
			TargetSceneStatus = sceneStatus
		});
		await Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_RESPAWN);
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = respawnPos,
			faceLeft = false,
			forceToFloor = true,
			revive = true
		};
		if (portalDataForRespawn != null)
		{
			Singleton<TeleportMoveManager>.instance.BeginWebberCabinFlow();
		}
		try
		{
			await TeleportUtility.TeleportWithNone(chunkId, teleportParams);
			await UniTask.WaitUntil(() => !Model<TrialCharacterModel>.Interface.IsExitingTrialCharacterMode);
			for (int num = 0; num < 3; num++)
			{
				Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(num);
				if (teamCharacter != null)
				{
					LocalEntityReborn(teamCharacter, hpPercent);
				}
			}
			Singleton<BloodBottleHandler>.instance.RecoverItems();
			Singleton<GameState>.instance.SetPlayerAliveState(PlayerLiveState.Normal);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_RespawnCompelete, null);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
			await UniTask.WaitUntil(() => Singleton<LoadManager>.instance.IsComplete);
			if (!(respawnSetting is RespawnSetting_Normal))
			{
				return;
			}
			if (boosTmpArchiveInfo == null && data is PortalData)
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreen(1f);
				await UniTask.WaitUntil(() => !Singleton<LoadManager>.instance.InLoading);
				Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: false);
				await UniTask.WaitUntil(() => Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.TeleportRespawnAndTpMove));
				MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.TeleportRespawnAndTpMove);
				GameManager.teleportMoveSystem.TryEnterTeleportMove();
				await UniTask.WaitUntil(() => Singleton<TeleportMoveManager>.instance.TimelineRespawnAndTpMove);
				Singleton<TeleportMoveManager>.instance.RespawnAndTpMoveTimelineComplete();
			}
			else if (boosTmpArchiveInfo == null && data is TempleEnterData)
			{
				GameUtility.TriggerTeleportPointWorldReset();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			throw;
		}
		finally
		{
			if (portalDataForRespawn != null)
			{
				Singleton<TeleportMoveManager>.instance.SetForcePathCenterSync(force: false);
				Singleton<TeleportMoveManager>.instance.EndWebberCabinFlow();
			}
		}
	}

	public void LocalEntityReborn(Entity behave, float hpPercent = 1f)
	{
		RoleRebornMatEffect(behave, behave == MonoECS.instance.mainEntity);
		GameManager.behaveSystem.RebornForcedChangeToIdle(behave);
		CompAbility compAbility = behave.GetCompAbility();
		CompMotion? compMotion = behave.GetCompMotion();
		CompBehave compBehave = behave.GetCompBehave();
		compAbility.alive = true;
		compMotion.DieAnimationEnd = false;
		behave.SetFaceLeft(left: false);
		compAbility.ServerSetHP((int)((float)compAbility.maxHP * hpPercent));
		compAbility.ModifyNormalEnergy(0f);
		compAbility.ModifySpecialEnergy(0f);
		compAbility.CurrentUltimateSkillValue = 0f;
		GameManager.assistSystem.ClearAssistValueForCharacter(behave, CompAbility.AssistChangeReason.Reborn);
		compMotion.endureLevel = EndureType.None;
		compMotion.motionTags = 0uL;
		compMotion.SetBool("IsDead", b: false);
		compMotion.ResetTrigger("Die");
		compBehave.StartChangeCD(CoreUtils.GetChangeCD);
		foreach (Skill skill in compMotion.skills)
		{
			if (skill.config.name == "switchSkillCD")
			{
				skill.SetSkillCd(skill.Cd, exceeds: false);
				skill.SetSkillCount(0);
			}
		}
	}

	private void RoleRebornMatEffect(Entity entity, bool needShowRoot)
	{
		AniPartControl aniControl = entity.GetMono().aniControl;
		if (!(aniControl == null))
		{
			if (needShowRoot)
			{
				entity.ShowRoot();
			}
			else
			{
				entity.HideRoot();
			}
			aniControl.PlayVisible(AniPartControl.PartType.RoleDieEffect, 0.01f, entity, null, reset: true);
		}
	}

	public void RecordTmpArchivePos(SceneTempArchiveInfo tmpArchiveInfo, string reason)
	{
		G.service.RecordTmpArchivePos(tmpArchiveInfo);
	}

	public void RecordSpawnPos(SceneSpawnInfo spawnInfo, string reason)
	{
		G.service.CleanTmpArchivePos();
		if (Singleton<GameManager>.instance.worldManager.IsChunkInCurrentWorldPartition(spawnInfo.ChunkID))
		{
			G.service.RecordSpawnPos(spawnInfo);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"Record respawn point failed. Pos->{spawnInfo.Pos.X},{spawnInfo.Pos.Y},{spawnInfo.Pos.Z}, ChunkId->{spawnInfo.ChunkID}, ActiveWorldId->{Singleton<GameManager>.instance.worldManager.ActiveWorldId}");
		}
	}
}
