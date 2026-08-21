using System.Collections.Generic;
using Config;
using Entitas;

public class SpawnSystem : IInitializeSystem, ISystem
{
	private SimContext mSimContext;

	public SpawnSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnEntityEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnEntityEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityTriggerEvent>(OnTriggerEventHandler);
	}

	private void OnTriggerEventHandler(EntityTriggerEvent eventReceived)
	{
		if (eventReceived.mEventType == TriggerEventType.MapInit)
		{
			DRandom.ResetSeed((uint)(mSimContext.sEntityWorldState.status.mBattleID % int.MaxValue));
			SpawnLevelObstacles();
			SpawnSourceSpaceEntity();
			SpawnPlayerGroup();
			SpawnTriggerGroup();
		}
	}

	private void SpawnSourceSpaceEntity()
	{
		if (!mSimContext.hasEntitySourceSpace)
		{
			mSimContext.SetEntitySourceSpace(newEnable: true, 0, 0, 0, 0, 0, 0, newManualMode: false);
			SimEntity entitySourceSpaceEntity = mSimContext.entitySourceSpaceEntity;
			entitySourceSpaceEntity.AddEntityPositon(new Int3(0, 0, 0), new Int3(0, 0, 1), 0, new Int3(0, 1, 0), newIsTeleport: false);
			entitySourceSpaceEntity.AddEntityCamp(256u);
			entitySourceSpaceEntity.AddEntityConfig(ConfigHelper.GetInstance().GetConfig<RoleConfig>(65535), 65535);
			entitySourceSpaceEntity.AddEntityRemotePlayer(0, 0, newMIsLocalPlayer: false);
			entitySourceSpaceEntity.AddEntityBlackboard(new SimBlackboard());
			entitySourceSpaceEntity.entityBlackboard.var.mEntityID = entitySourceSpaceEntity.creationIndex;
			entitySourceSpaceEntity.entityBlackboard.var.mAttributeID = mSimContext.mService.mAttributeService.CreateAttribute(entitySourceSpaceEntity.creationIndex, out var _);
			EntityBlackboard entityBlackboard = entitySourceSpaceEntity.entityBlackboard;
			entityBlackboard.var.mHP = 2147483647L;
			entityBlackboard.var.mMaxHP = 2147483647L;
			mSimContext.entitySourceSpaceEntity.entitySourceSpace.Enable = false;
		}
	}

	private void SpawnPlayerGroup()
	{
		Int3 zero = Int3.zero;
		Int3 forward = Int3.forward;
		Int3 up = Int3.up;
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mSimContext.sEntityWorldState.status.mRoomMembers.GetEnumerator();
		SimEntity simEntity = null;
		GameMode gameMode = mSimContext.simStatus.gameMode;
		while (enumerator.MoveNext())
		{
			RemoteMember value = enumerator.Current.Value;
			bool flag = value.IsLocalMember(mSimContext.sEntityWorldState.status.mLocalPlayerNetID);
			RoleType camp = RoleType.Player;
			if (CommonProcessor.IsSinglePlayerGameMode(mSimContext))
			{
				SimEntity simEntity2 = SpawnProcessor.SpawnUnit(value.mNetID, zero, forward, up, camp, value.roleData.AI_ID, flag, value.roleData.ID, 0, value.mEntityPosition, 1000, 8000, 1, value, SetEntityDataFromRoleData);
				if (flag)
				{
					if (mSimContext.sEntityWorldState.status.needResurrect)
					{
						AttributeProcessor.SetAttributeWithIntName(simEntity2.entityBlackboard.var.mAttributeID, 2190, 1L, 0L, 0L);
					}
					else
					{
						AttributeProcessor.SetAttributeWithIntName(simEntity2.entityBlackboard.var.mAttributeID, 2190, 0L, 0L, 0L);
					}
					mSimContext.sEntityWorldState.status.mLocalPlayerID = simEntity2.creationIndex;
				}
				value.mEntityID = simEntity2.creationIndex;
				continue;
			}
			SimEntity simEntity3 = null;
			simEntity3 = SpawnProcessor.SpawnUnit(value.mNetID, zero, forward, up, camp, 0, flag, value.roleData.ID, 0, value.mEntityPosition, 1000, 8000, 1, value, SetEntityDataFromRoleData);
			if (flag)
			{
				mSimContext.sEntityWorldState.status.mLocalPlayerID = simEntity3.creationIndex;
				simEntity = simEntity3;
			}
			if (mSimContext.sEntityWorldState.status.needResurrect)
			{
				AttributeProcessor.SetAttributeWithIntName(simEntity3.entityBlackboard.var.mAttributeID, 2190, 1L, 0L, 0L);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(simEntity3.entityBlackboard.var.mAttributeID, 2190, 0L, 0L, 0L);
			}
			simEntity3.entityBlackboard.var.mMaxSpeed = new VFactor((simEntity3.entityConfig.mConfig as RoleConfig).Speed, 1000L);
			value.mEntityID = simEntity3.creationIndex;
		}
		if (CommonProcessor.IsMultiplePlayerGameMode(gameMode) && simEntity.entityRemotePlayer.mIsLocalPlayer)
		{
			if (!CommonProcessor.IsReplayGameMode(gameMode))
			{
				SpawnProcessor.SpawnLocalUnit(simEntity);
				mSimContext.sEntityWorldState.status.mLocalPlayerNetID = simEntity.creationIndex;
				mSimContext.sEntityWorldState.status.mLocalPlayerID = simEntity.creationIndex;
				mSimContext.sEntityWorldState.status.mRoleID = simEntity.entityConfig.mId;
			}
			else
			{
				SimEntity simEntity4 = mSimContext.CreateEntity();
			}
		}
	}

	public static void SetEntityDataFromRoleData(SimEntity entity, RoleData roleData)
	{
		int mAttributeID = entity.entityBlackboard.var.mAttributeID;
		if (roleData.attribute != null)
		{
			Dictionary<int, long>.Enumerator enumerator = roleData.attribute.GetEnumerator();
			while (enumerator.MoveNext())
			{
				AttributeProcessor.SetAttributeWithIntName(mAttributeID, enumerator.Current.Key, enumerator.Current.Value, 0L, 0L);
			}
		}
		if (roleData.astrolabe != null)
		{
			int num = 2023;
			for (int i = 0; i < roleData.astrolabe.Length; i++)
			{
				AttributeProcessor.SetAttributeWithIntName(mAttributeID, num, roleData.astrolabe[i], 0L, 0L);
				num++;
			}
		}
		if (roleData.equipment != null)
		{
			int num2 = 2100;
			for (int j = 0; j < roleData.equipment.Length; j++)
			{
				AttributeProcessor.SetAttributeWithIntName(mAttributeID, num2, roleData.equipment[j], 0L, 0L);
				num2++;
			}
		}
		if (roleData.skillLevel != null)
		{
			int num3 = 2120;
			for (int k = 0; k < roleData.skillLevel.Length; k++)
			{
				AttributeProcessor.SetAttributeWithIntName(mAttributeID, num3, roleData.skillLevel[k], 0L, 0L);
				num3++;
			}
		}
		AttributeProcessor.UpdateMaxHp(entity.creationIndex);
		if (entity.entityBlackboard.var.mHP == 0L)
		{
			entity.entityBlackboard.var.mHP = entity.entityBlackboard.var.mMaxHP;
		}
		entity.entityBlackboard.var.mFightLevel = roleData.level;
		AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2011, roleData.weaponEffectID, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2012, roleData.weaponEffectLevel, 0L, 0L);
		if (roleData.AIEffect != null)
		{
			int num4 = 2130;
			for (int l = 0; l < roleData.AIEffect.Length; l++)
			{
				AttributeProcessor.SetAttributeWithIntName(mAttributeID, num4, roleData.AIEffect[l], 0L, 0L);
				num4++;
			}
		}
		entity.entityBlackboard.var.mEquipLv = roleData.equipLv;
	}

	private void SpawnTriggerGroup()
	{
		ProtoMapdata mMapTrigger = mSimContext.sEntityWorldState.status.mMapTrigger;
		IEnumerator<ProtoEntityData> enumerator = mMapTrigger.EntityDatas.GetEnumerator();
		while (enumerator.MoveNext())
		{
			SpawnProcessor.SpawnTrigger(enumerator.Current);
		}
	}

	private void SpawnLevelObstacles()
	{
		SpawnProcessor.SpawnLevelObstacles();
	}

	public bool DoEventHandler()
	{
		return false;
	}

	private void OnDespawnEntityEventHandler(EntityDespawnedEvent eventReceived)
	{
	}

	private void OnSpawnEntityEventHandler(EntitySpawnedEvent eventReceived)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(eventReceived.NewEntity);
		if (entityWithEntityID != null && mSimContext.sEntityWorldState.status.mRoomMembers.TryGetValue(eventReceived.mRolePosition, out var value))
		{
			value.mEntityID = entityWithEntityID.creationIndex;
		}
	}
}
