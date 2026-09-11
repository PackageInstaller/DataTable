using System.Collections.Generic;
using Config;
using Entitas;
using UnityEngine;

public class BuffProcessor
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

	public static int GetBuffCount(SimEntity entity)
	{
		int num = 0;
		IComponent[] components = entity.GetComponents();
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i] is IEntityBuff)
			{
				num++;
			}
		}
		return num;
	}

	public static int IncreaseBuffID()
	{
		return mSimContext.sEntityWorldState.status.mBuffCreationIndex++;
	}

	public static bool TryAddBuff(int casterID, int targetID, int buffClass, int buffDelay, int buffAliveTime, int buffTick, bool isOnce, bool isLoop, bool isOverride, SimVar param1, SimVar param2, SimVar param3, SimVar param4, int buffConfigID, int buffFloor, out int buffID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(casterID);
		SimEntity simEntity = null;
		simEntity = ((targetID != casterID) ? mSimContext.GetEntityWithEntityID(targetID) : entityWithEntityID);
		buffID = 0;
		if (simEntity == null)
		{
			return false;
		}
		if (!CommonProcessor.IsAliveRole(simEntity))
		{
			return false;
		}
		if (!simEntity.hasEntityBuff)
		{
			simEntity.AddEntityBuff(FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<BuffParams>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10), FrameListPool<int>.Claim(10));
		}
		if (isOverride)
		{
			RemoveBuffClass(casterID, targetID, buffClass);
		}
		BuffParams buffParams = new BuffParams
		{
			v1 = param1,
			v2 = param2,
			v3 = param3,
			v4 = param4
		};
		buffID = AddBuffClassID(casterID, targetID, buffClass, buffDelay, buffAliveTime, buffTick, isOnce, isLoop, buffParams, buffConfigID, buffFloor);
		return buffID != 0;
	}

	public static int AddBuffClassID(int casterID, int targetID, int buffClass, int buffDelay, int buffAliveTime, int buffTick, bool isOnce, bool isLoop, BuffParams buffParams, int buffConfigID, int buffFloor)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff && mSimContext.GetSimInterface() != null)
		{
			int num = entityWithEntityID.entityBuff.Add(casterID, buffClass, (!isOnce) ? buffDelay : int.MaxValue, (!isLoop) ? buffAliveTime : int.MaxValue, (!isOnce) ? buffTick : int.MaxValue, buffParams, buffConfigID, buffFloor, (!isLoop) ? buffAliveTime : int.MaxValue);
			if (mSimContext.GetSimInterface().mUpdateBuffLogicEvent != null)
			{
				mSimContext.GetSimInterface().mUpdateBuffLogicEvent(targetID, num, entityWithEntityID.entityBuff.mBuffClassIDArray[num], EBuffLife.Bind, arg5: false);
			}
			return entityWithEntityID.entityBuff.mBuffID[num];
		}
		return 0;
	}

	public static void RemoveBuffByListIndex(SimEntity simEntity, int index)
	{
		if (!simEntity.hasEntityBuff)
		{
			return;
		}
		EntityBuff entityBuff = simEntity.entityBuff;
		if (index >= 0 && !entityBuff.IsInPendingRemoveArray(entityBuff.mBuffID[index]))
		{
			if (mSimContext.GetSimInterface().mUpdateBuffLogicEvent != null)
			{
				mSimContext.GetSimInterface().mUpdateBuffLogicEvent(simEntity.creationIndex, index, entityBuff.mBuffClassIDArray[index], EBuffLife.Leave, arg5: false);
			}
			entityBuff.AddPendingRemoveArray(entityBuff.mBuffID[index]);
		}
	}

	public static void RemoveBuffByConfigID(int entityID, int buffConfigID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		RemoveBuffByConfigID(entityWithEntityID, buffConfigID);
	}

	public static void RemoveBuffByConfigID(SimEntity entity, int buffConfigID)
	{
		if (entity != null && entity.hasEntityBuff)
		{
			int buffConfigIDIndex = entity.entityBuff.GetBuffConfigIDIndex(buffConfigID);
			RemoveBuffByListIndex(entity, buffConfigIDIndex);
		}
	}

	public static void RemoveBuffID(int ownerEnitytID, int targetEntityID, int buffID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(targetEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff && mSimContext.GetSimInterface() != null)
		{
			int buffIDIndex = entityWithEntityID.entityBuff.GetBuffIDIndex(buffID);
			RemoveBuffByListIndex(entityWithEntityID, buffIDIndex);
		}
	}

	public static void RemoveBuffClass(int ownerEnitytID, int targetEntityID, int buffClassID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(targetEntityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
		{
			return;
		}
		for (int num = entityWithEntityID.entityBuff.mBuffClassIDArray.Count - 1; num >= 0; num--)
		{
			if (entityWithEntityID.entityBuff.mBuffClassIDArray[num] == buffClassID)
			{
				RemoveBuffByListIndex(entityWithEntityID, num);
			}
		}
	}

	public static void RemoveTimer(int entityID, int timerName)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityTimer)
		{
			return;
		}
		for (int num = entityWithEntityID.entityTimer.entityTimers.Count - 1; num >= 0; num--)
		{
			if (entityWithEntityID.entityTimer.entityTimers[num].name == timerName && !entityWithEntityID.entityTimer.IsInPendingRemoveArray(entityWithEntityID.entityTimer.entityTimers[num].id))
			{
				mSimContext.PostEvent(EntityTimerEvent.Claim(entityWithEntityID.entityTimer.entityTimers[num], EBuffLife.Leave, entityID));
				entityWithEntityID.entityTimer.AddPendingRemoveArray(entityWithEntityID.entityTimer.entityTimers[num].id);
			}
		}
	}

	public static bool TryAddTimer(int entityID, int timerName, int delay, int duringTime, int intervalTime)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (!entityWithEntityID.hasEntityTimer)
		{
			entityWithEntityID.AddEntityTimer(FrameListPool<EntityTimerStruct>.Claim());
		}
		if (-1 == entityWithEntityID.entityTimer.GetFirstIDByName(timerName))
		{
			EntityTimerStruct timerStruct = default(EntityTimerStruct);
			timerStruct.duringTime = duringTime;
			timerStruct.id = IncreaseBuffID();
			timerStruct.intervalTime = intervalTime;
			timerStruct.name = timerName;
			timerStruct.runningTime = delay;
			int num = entityWithEntityID.entityTimer.Add(timerStruct);
			mSimContext.PostEvent(EntityTimerEvent.Claim(timerStruct, EBuffLife.Bind, entityID));
			return num >= 0;
		}
		return false;
	}

	public static bool HasBuff(SimEntity entity, BuffStatusType buffStatus)
	{
		IComponent[] components = entity.GetComponents();
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i] is IEntityBuff)
			{
				IEntityBuff entityBuff = components[i] as IEntityBuff;
				if (entityBuff.mBuffType == buffStatus)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool HasBuffBySubtype(SimEntity simEntity, string subType)
	{
		for (int i = 0; i < simEntity.entityBuff.mBuffConfigID.Count; i++)
		{
			if (simEntity.entityBuff.mBuffConfigID[i] != 0)
			{
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(simEntity.entityBuff.mBuffConfigID[i]);
				if (config.SubType == subType)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool HasTargetConfigIDBuff(SimEntity entity, int configID)
	{
		if (entity.hasEntityBuff)
		{
			int buffConfigIDIndex = entity.entityBuff.GetBuffConfigIDIndex(configID);
			return buffConfigIDIndex != -1;
		}
		return false;
	}

	public static bool HasBuffOfClassID(SimEntity simEntity, int buffClassID)
	{
		int buffOfClassID = GetBuffOfClassID(simEntity, buffClassID);
		return buffOfClassID != -1;
	}

	public static int GetBuffOfClassID(SimEntity simEntity, int buffClassID)
	{
		int result = -1;
		if (simEntity != null && simEntity.hasEntityBuff)
		{
			result = simEntity.entityBuff.GetBuffClassIDIndex(buffClassID);
		}
		return result;
	}

	public static bool TryGetBuffByConfigID(SimEntity entity, int configID, out int index)
	{
		index = -1;
		if (entity.hasEntityBuff)
		{
			index = entity.entityBuff.GetBuffConfigIDIndex(configID);
			return index >= 0;
		}
		return false;
	}

	public static bool RefreshBuffTimeByBuffConfigID(SimEntity entity, int buffConfigID, int time)
	{
		int buffConfigIDIndex = entity.entityBuff.GetBuffConfigIDIndex(buffConfigID);
		entity.entityBuff.mDuringArray[buffConfigIDIndex] = time;
		entity.entityBuff.mBuffRuntime[buffConfigIDIndex] = entity.entityBuff.mTickArray[buffConfigIDIndex];
		return true;
	}

	private static void AddBuffDamage(SimEntity target, BuffConfig buffConfig)
	{
		int damageEffectValue = buffConfig.DamageEffectValue;
		XLogger.Debug("输出一次buff伤害:  ", damageEffectValue);
		if (target.hasEntityActionModifyHP)
		{
			target.entityActionModifyHP.mStatus = EntityActionStatus.E_ACTIVE;
			target.entityActionModifyHP.mModifyInfoList.Add(new ModifyHPInfo
			{
				mAmount = -damageEffectValue,
				mDamageType = DamageType.Buff,
				mActionID = buffConfig.ID
			});
		}
		else
		{
			target.AddEntityActionModifyHP(EntityActionStatus.E_ACTIVE, new List<ModifyHPInfo>
			{
				new ModifyHPInfo
				{
					mAmount = -damageEffectValue,
					mDamageType = DamageType.Buff,
					mActionID = buffConfig.ID
				}
			});
		}
	}

	private static void ModifyAbility(SimEntity simEntity, BuffConfig buffConfig)
	{
		Debug.Log((object)"========== 影响能力");
		if ((buffConfig.LimitAbility & 4) != 0 && AbilitiesProcessor.TryStopSkill(simEntity))
		{
			Debug.Log((object)"========== 限制技能");
			simEntity.entityBlackboard.var.mActionBusy = false;
			MovementProcessor.EnableMovement(simEntity, isActive: true);
		}
		if ((buffConfig.LimitAbility & 2) != 0 && AbilitiesProcessor.TryStopAttack(simEntity))
		{
			Debug.Log((object)"========== 限制攻击");
			simEntity.entityBlackboard.var.mActionBusy = false;
			MovementProcessor.EnableMovement(simEntity, isActive: true);
		}
		if ((buffConfig.LimitAbility & 1) != 0)
		{
			Debug.Log((object)"========== 限制移动");
			MovementProcessor.Stop(simEntity);
			MovementProcessor.EnableMovement(simEntity, isActive: false);
		}
	}

	public static void RecoverAbility(SimEntity simEntity, BuffConfig buffConfig)
	{
		Debug.Log((object)"========== 恢复限制能力");
		int num = buffConfig.LimitAbility & 1;
		int num2 = buffConfig.LimitAbility & 2;
		int num3 = buffConfig.LimitAbility & 4;
		if (num != 0 && !simEntity.hasEntityActionAbility)
		{
			Debug.Log((object)"========== 恢复移动");
			MovementProcessor.EnableMovement(simEntity, isActive: true);
		}
	}

	public static void RemoveInputMovementAndAbility(SimEntity simEntity)
	{
		if (simEntity.hasEntityActionManualInput)
		{
			simEntity.RemoveEntityActionManualInput();
		}
		if (simEntity.hasEntityActionMoveDirection)
		{
			simEntity.RemoveEntityActionMoveDirection();
		}
		if (simEntity.hasEntityActionAbility)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityActionAbility.mAbilityID);
			if (!config.IsFinalAction)
			{
				AbilitiesProcessor.SetNextFrameAbility(simEntity, 0, forceBroken: true);
			}
		}
		if (simEntity.hasEntityBlackboard)
		{
			simEntity.entityBlackboard.var.meleeIndex = 0;
		}
	}

	public static void AddHitRecoverComponent(SimEntity simEntity, E_HitRecoverStatus hitRecoverType)
	{
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		int num = AbilitiesProcessor.CheckSlot(simEntity.entityBlackboard.var.mHitRecoverSlots[0], roleConfig.HitRecoverID.get_Item(0));
		int timelineDuration = AbilitiesProcessor.GetTimelineDuration(simEntity, num, hitRecoverType);
		Int3 mForward = simEntity.entityPositon.mForward;
		simEntity.AddEntityHitRecover(E_HitRecover.OnEnter, 0, num, mForward, mForward, 0, 0, null, 0, newMEnableMovement: true, 0, hitRecoverType, 0, num, 0, 0, 0, 100, 1, 0, 0, Int3.zero);
		if (simEntity.hasEntityBlackboard)
		{
			simEntity.entityBlackboard.var.mBeHitAbilitiID = num;
			simEntity.entityBlackboard.var.mBeHitIndex = 0;
		}
	}
}
