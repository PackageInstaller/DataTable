using System;
using System.Collections.Generic;
using Config;
using UnityEngine;

public class SpawnProcessor
{
	public static SimContext mSimContext;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	public static long GetUnitPlayerID(int entityID)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mSimContext.sEntityWorldState.status.mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (entityID == enumerator.Current.Value.mEntityID)
			{
				return enumerator.Current.Value.mNetID;
			}
		}
		return 0L;
	}

	public static RemoteMember GetUnitPlayer(int entityID)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mSimContext.sEntityWorldState.status.mRoomMembers.GetEnumerator();
		if (enumerator.MoveNext())
		{
			return enumerator.Current.Value;
		}
		return null;
	}

	public static SimEntity SpawnUnit(long playerID, Int3 spawnPoint, Int3 forward, Int3 up, RoleType camp, int aiID, bool isLocalPlayer, int roleID, int aiThinkTimer, MemberPosition rolePositon, int hp = 1000, int moveSpeed = 8000, int hpStripCount = 1, RemoteMember remoteMember = null, Action<SimEntity, RoleData> SetEntityDataFromRoleData = null, int targetSkinID = 0)
	{
		uint roleCamp = 0u;
		RoleCampProcessor.Set(ref roleCamp, (uint)camp);
		if (RoleType.Player == camp)
		{
			mSimContext.sEntityWorldState.status.mCurrentAliveHeroCount++;
		}
		else if (RoleType.Enemy == camp)
		{
			mSimContext.sEntityWorldState.status.mCurrentAliveMonsterCount++;
		}
		SimEntity simEntity = mSimContext.CreateEntity();
		simEntity.AddEntityPositon(spawnPoint, forward, IntMath.AngleOfVector(forward), up, newIsTeleport: false);
		simEntity.AddEntityCamp(roleCamp);
		simEntity.AddEntityHealth(hp, hp, 0u);
		simEntity.AddEntityBlackboard(new SimBlackboard());
		simEntity.AddEntityCD(new HashSet<int>(new IntComparer()), new HashSet<int>(new IntComparer()), new List<AbilityCD>(16), new Dictionary<int, AbilityMaxCDInfo>(new IntComparer()), new Dictionary<int, int>(new IntComparer()));
		if (aiID != 0)
		{
			simEntity.AddEntityAIMovement(0, 0, 5000);
			simEntity.AddEntityAIThink(aiThinkTimer, new Dictionary<int, AICommand>(new IntComparer()), null, null, newMReevalute: false, newMForceMakeDecision: false, aiThinkTimer);
		}
		simEntity.entityBlackboard.var.mEntityID = simEntity.creationIndex;
		simEntity.entityBlackboard.var.mAttributeID = mSimContext.mService.mAttributeService.CreateAttribute(simEntity.creationIndex, out var _);
		simEntity.entityBlackboard.var.mFightLevel = 1;
		simEntity.entityBlackboard.var.mAIID = aiID;
		simEntity.entityBlackboard.var.mRolePostion = rolePositon;
		if (RoleCampProcessor.IsEnemy(simEntity.entityCamp.mRoleTypeCamp))
		{
			mSimContext.sEntityWorldState.status.mEnemys.Add(simEntity.creationIndex);
		}
		simEntity.entityBlackboard.var.enemyType = EnemyType.Other;
		simEntity.AddEntityRemotePlayer(0, 0, isLocalPlayer);
		int skinID = ((targetSkinID != 0) ? targetSkinID : roleID);
		if (remoteMember != null && SetEntityDataFromRoleData != null)
		{
			SetEntityDataFromRoleData(simEntity, remoteMember.roleData);
			skinID = remoteMember.roleData.SkinID;
		}
		simEntity.entityBlackboard.var.mHpStripCount = hpStripCount;
		CommonProcessor.UpdateRoleID(simEntity, roleID);
		EntitySpawnedEvent entitySpawnedEvent = EntitySpawnedEvent.Claim(simEntity.creationIndex, simEntity.entityCamp.mRoleTypeCamp, EntitySpawnedEvent.SimUnitReadyState.SpawnedInWorld, needRVO: true, spawnPoint, simEntity.entityPositon.mForward, lockWhenNotMoving: false, simEntity.entityConfig.mId, isLocalPlayer, playerID, hpStripCount, skinID);
		entitySpawnedEvent.AIID = aiID;
		entitySpawnedEvent.mRolePosition = rolePositon;
		mSimContext.PostEvent(entitySpawnedEvent);
		return simEntity;
	}

	public static int SpawnTrigger(ProtoEntityData triggerData)
	{
		SimEntity simEntity = CreateEmptyEntity();
		simEntity.AddEntityRemotePlayer(0, 0, newMIsLocalPlayer: false);
		simEntity.AddEntityTrigger(triggerData.Id, triggerData.IsEnable, triggerData, new Dictionary<string, SimVariable>(32), 0);
		simEntity.AddEntityPositon(Int3.zero, Int3.forward, 0, Int3.up, newIsTeleport: false);
		mSimContext.sEntityWorldState.status.triggerIDToEntityID[triggerData.Id] = simEntity.creationIndex;
		mSimContext.PostEvent(EntitySpawnedEvent.ClaimTrigger(simEntity.creationIndex, triggerData));
		return simEntity.creationIndex;
	}

	public static void SpawnLevelObstacles()
	{
		List<ISimShape> mLevelColliders = mSimContext.GetService().mLevelColliderService.mLevelColliders;
		if (mLevelColliders != null)
		{
			for (int i = 0; i < mLevelColliders.Count; i++)
			{
				SimEntity simEntity = mSimContext.CreateEntity();
				uint roleCamp = 0u;
				RoleCampProcessor.Set(ref roleCamp, 8u);
				simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, mLevelColliders[i], roleCamp, int.MaxValue, default(ShapePartInfo));
				mLevelColliders[i].OwnerID = simEntity.creationIndex;
			}
		}
	}

	public static SimEntity SpawnLocalUnit(SimEntity remoteEntity)
	{
		SimEntity simEntity = mSimContext.CreateEntity();
		Debug.Log((object)("=====>>>>> 创建本地预测对象的EntityID为:" + simEntity.creationIndex + " for " + remoteEntity.creationIndex));
		int[] componentIndices = remoteEntity.GetComponentIndices();
		for (int i = 0; i < componentIndices.Length; i++)
		{
			if (componentIndices[i] != 52 && componentIndices[i] != 55 && componentIndices[i] != 28 && componentIndices[i] != 41)
			{
				remoteEntity.CloneTo(simEntity, componentIndices[i]);
			}
		}
		simEntity.AddEntityLocalPlayer(0, remoteEntity.creationIndex);
		remoteEntity.entityRemotePlayer.mLocalEntityID = simEntity.creationIndex;
		return simEntity;
	}

	public static void DestoryEntity(int id, int abilityID, int killingID = 0)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(id);
		if (entityWithEntityID != null)
		{
			mSimContext.PostEvent(EntityDespawnedEvent.Claim(CommanderID.None, killingID, id, skipDeathSequence: false, 0u, UnitRemoveReason.Despawn, isByCommanderEliminated: false, abilityID, mSimContext.simStatus.mServerFrame));
			if (entityWithEntityID.hasEntityRemotePlayer && entityWithEntityID.entityRemotePlayer.mLocalEntityID != 0)
			{
				SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(entityWithEntityID.entityRemotePlayer.mLocalEntityID);
				entityWithEntityID2.RemoveAllComponents();
			}
			entityWithEntityID.RemoveAllComponents();
			mSimContext.GetEntityWithEntityID(id);
		}
	}

	public static SimEntity CreateEmptyEntity()
	{
		return mSimContext.CreateEntity();
	}

	public static void DestoryEntity(SimEntity simEntity)
	{
		simEntity.Destroy();
	}

	public static int GetLocalPlayerID()
	{
		return mSimContext.sEntityWorldState.status.mLocalPlayerID;
	}

	public static List<int> GetAllEnemy()
	{
		return mSimContext.sEntityWorldState.status.mEnemys;
	}

	public static List<int> GetAllEnemy(SimContext simContext)
	{
		return simContext.sEntityWorldState.status.mEnemys;
	}
}
