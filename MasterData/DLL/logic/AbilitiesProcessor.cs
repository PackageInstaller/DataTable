using System;
using System.Collections.Generic;
using Config;
using Pathfinding.Util;
using UnityEngine;
using UnityEngine.Profiling;

public class AbilitiesProcessor
{
	public static SimContext mSimContext;

	private static SEntityWorldState mWorldState;

	private static int ABILITY_STATUS_TYPE_INDEX = 1000000;

	private static int ABILITY_STATUS_TIME_INDEX = 100;

	private static int _hitLagCompensation = 0;

	private static int _kurtunLagCompensation = 0;

	private const int FORCE_INTERRUPTER = -1;

	private const int FORCE_CANNOT_INTERRUPTER = -2;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
		if (CommonProcessor.IsMultiplePlayerGameMode(mSimContext))
		{
			_hitLagCompensation = 0;
			_kurtunLagCompensation = 66;
		}
		mWorldState = mSimContext.sEntityWorldState;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
		mWorldState = null;
	}

	public static int GetTimelineDuration(SimEntity simEntity, int ID, E_HitRecoverStatus nextStatus)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(ID);
		int result = config?.Duration ?? 0;
		if (simEntity.hasEntityHitRecover && E_HitRecoverStatus.FloatDown == nextStatus)
		{
			Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityHitRecover.mHitAbilityID);
			if (config2 != null)
			{
				int mHitCount = simEntity.entityHitRecover.mHitCount;
				if (mHitCount >= 0 && mHitCount < config2.HitTimeList.Count)
				{
					HitCheckInfo hitCheckInfo = config2.HitTimeList.get_Item(mHitCount);
					int hitDownDuration = hitCheckInfo.HitDownDuration;
					result = (hitCheckInfo.UseHitDownDuration ? hitDownDuration : config.Duration);
				}
			}
		}
		return result;
	}

	public static void PostThrownEvent(Timeline timelineConfig, int time, int deltaTime, int caster, Int3 position, Int3 forward, ThrownState thrownState, int producerID, int thrownCreatedRootTimelineID, int attributeID)
	{
		Profiler.BeginSample("thrown spawn child");
		int num = time - deltaTime;
		for (int i = 0; i < timelineConfig.PostSpwanThrownEvents.Count; i++)
		{
			PostSpwanThrownEventInfo postSpwanThrownEventInfo = timelineConfig.PostSpwanThrownEvents.get_Item(i);
			if ((postSpwanThrownEventInfo.Start == 0 && num <= 0) || (num < postSpwanThrownEventInfo.Start && postSpwanThrownEventInfo.Start <= time))
			{
				ThrownProcessor.SpawnThrown(mSimContext, caster, timelineConfig.ID, i, position, forward, 0, postSpwanThrownEventInfo.UseCommon, producerID, thrownCreatedRootTimelineID, attributeID, out var _);
			}
		}
		Profiler.EndSample();
		Profiler.BeginSample("thrown despawn");
		for (int j = 0; j < timelineConfig.PostDespownThronEvents.Count; j++)
		{
			PostDespawnThrownEventInfo postDespawnThrownEventInfo = timelineConfig.PostDespownThronEvents.get_Item(j);
			if ((postDespawnThrownEventInfo.Start == 0 && num <= 0) || (num < postDespawnThrownEventInfo.Start && postDespawnThrownEventInfo.Start <= time))
			{
				ThrownProcessor.DestoryThrown(mSimContext, thrownState);
			}
		}
		Profiler.EndSample();
	}

	public static bool IsHitFrame(Timeline timelineConfig, int logicTime, int hitIndex, int logicStep, out HitCheckInfo hitCheckInfo)
	{
		if (hitIndex < 0 || hitIndex >= timelineConfig.HitTimeList.Count)
		{
			hitCheckInfo = null;
			return false;
		}
		int num = logicTime + _hitLagCompensation;
		int num2 = num - logicStep;
		int num3 = ((num2 - 1 < 0) ? (-1) : ((num2 - 1) / CommonProcessor.GetConfigInterval()));
		int num4 = ((num - 1 < 0) ? (-1) : ((num - 1) / CommonProcessor.GetConfigInterval()));
		bool flag = num3 != num4;
		hitCheckInfo = timelineConfig.HitTimeList.get_Item(hitIndex);
		return (hitCheckInfo.Start < num && num <= hitCheckInfo.Start + hitCheckInfo.Duration) & flag;
	}

	public static void HitCheck(int caster, int logicTime, int abilityID, int stateIndex, HitCheckInfo hitCheckInfo, uint layerMask, Int3 position, Int3 forward, Int3 aimDirection, ref int hitIndex, out int kurtunTime, int attributeIDOfAttacker, bool canBeParry, int thrownID = 0)
	{
		kurtunTime = 0;
		aimDirection = IntMath.VectorOfAngle(IntMath.AngleOfVector(aimDirection) - new Int(hitCheckInfo.OffsetOfFoward));
		Profiler.BeginSample("hitcheck overlap before by hit event");
		mSimContext.PostEvent(OverlapBeforeByHitEvent.Claim((thrownID != 0) ? thrownID : caster, abilityID, hitCheckInfo.HitCheckID, position, forward, aimDirection));
		Profiler.EndSample();
		Profiler.BeginSample("hitcheck try get collisions");
		List<ISimShape> list = ListPool<ISimShape>.Claim();
		CommonProcessor.TryGetCollisions(position, forward, aimDirection, hitCheckInfo, layerMask, list);
		Profiler.EndSample();
		int throwID = ((thrownID != 0) ? thrownID : caster);
		mWorldState.status.TryGetHitHistroy(throwID, out var history);
		Profiler.BeginSample("hitcheck hit item");
		List<int> list2 = ListPool<int>.Claim();
		for (int i = 0; i < list.Count; i++)
		{
			int ownerID = list[i].OwnerID;
			ISimShape simShape = list[i];
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(ownerID);
			if (!simShape.IsEnable || simShape.IgnoreHit)
			{
				continue;
			}
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (CommonProcessor.ParryingCheck(mSimContext, caster, simEntityByMultiColliders.creationIndex, abilityID, hitCheckInfo.HitCheckID, entityWithEntityID.entityShape.mShape.WorldPos, aimDirection, canBeParry, thrownID, !hitCheckInfo.IsOnlyReduceHP))
			{
				continue;
			}
			if (CommonProcessor.IsInUltimateAvoidOfTarget(mSimContext, caster, entityWithEntityID.creationIndex, abilityID, hitCheckInfo.HitCheckID, position, out var parentTargetID, thrownID, !hitCheckInfo.IsOnlyReduceHP))
			{
				if (history != null && !history.Contains(parentTargetID))
				{
					history.Add(parentTargetID);
				}
			}
			else if ((history == null || !CommonProcessor.HasSameShapeCollect(history, entityWithEntityID)) && !CommonProcessor.HasSameShapeCollect(list2, entityWithEntityID) && simEntityByMultiColliders.hasEntityRemotePlayer && simEntityByMultiColliders.hasEntityConfig && (!simEntityByMultiColliders.hasEntityBlackboard || simEntityByMultiColliders.entityBlackboard.var.mHP > 0) && !AttributeProcessor.IsIgnoreHit(simEntityByMultiColliders))
			{
				HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
				HitHeight validHitHeight = (HitHeight)hitCheckInfo.ValidHitHeight;
				if (curHitHeight == HitHeight.None || validHitHeight.HasFlag(curHitHeight))
				{
					list2?.Add(entityWithEntityID.creationIndex);
					Profiler.BeginSample("hitcheck process hitting");
					ProcessHitting(caster, thrownID, abilityID, stateIndex, attributeIDOfAttacker, hitIndex, hitCheckInfo, position, forward, aimDirection, simEntityByMultiColliders, entityWithEntityID);
					Profiler.EndSample();
				}
			}
		}
		Profiler.EndSample();
		if (mSimContext.GetSimInterface().mHitCheckEvent != null)
		{
			Profiler.BeginSample("hitcheck event");
			mSimContext.GetSimInterface().mHitCheckEvent((thrownID != 0) ? thrownID : caster, abilityID, hitIndex, list2.Count);
			Profiler.EndSample();
		}
		if (list2.Count > 0 && hitCheckInfo.AttackerKartunTime > 0)
		{
			kurtunTime = hitCheckInfo.AttackerKartunTime;
		}
		if (hitCheckInfo.IgnoreHitHistory)
		{
			mWorldState.status.AddHitHistory(throwID, list2);
		}
		ListPool<int>.Release(list2);
		ListPool<ISimShape>.Release(list);
	}

	public static void ProcessHitting(int caster, int thrownID, int abilityID, int stateIndex, int attributeIDOfAttacker, int hitIndex, HitCheckInfo hitCheckInfo, Int3 position, Int3 forward, Int3 aimDirection, SimEntity hitTarget, SimEntity hitTargetShape)
	{
		Profiler.BeginSample("processhitting beofre hit target event");
		if (mSimContext.GetSimInterface().mBeforeHitTargetEvent != null)
		{
			mSimContext.GetSimInterface().mBeforeHitTargetEvent(caster, hitTarget.creationIndex, hitTargetShape.creationIndex);
		}
		Profiler.EndSample();
		long num = 0L;
		long num2 = 1000L;
		num = num2 + AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 2007, AttributeCalcType.Add);
		if (hitTarget.hasEntityBlackboard)
		{
			num -= AttributeProcessor.GetFinalAttributeByAttributeID(hitTarget.entityBlackboard.var.mAttributeID, 2008, AttributeCalcType.Add);
		}
		if (DRandom.Random(1000u) < num)
		{
			AttributeProcessor.SetAttributeWithIntName(attributeIDOfAttacker, 2174, 1L, 0L, 0L);
			int hitCheckID = hitCheckInfo.HitCheckID;
			Profiler.BeginSample("processhitting hit target event");
			mSimContext.PostEvent(HitTargetEvent.Claim(caster, hitTarget.creationIndex, abilityID, thrownID, hitCheckID, position, hitTargetShape.creationIndex));
			Profiler.EndSample();
			if (thrownID != 0)
			{
				Profiler.BeginSample("processhitting thrown hit target event");
				mSimContext.PostEvent(HitTargetByThrownEvent.Claim(thrownID, hitTarget.creationIndex, abilityID, hitCheckID, hitTargetShape.creationIndex));
				Profiler.EndSample();
			}
			DamageEventParam obj = default(DamageEventParam);
			obj.casterID = caster;
			obj.targetID = hitTarget.creationIndex;
			obj.abilityID = abilityID;
			obj.hitIndex = hitCheckID;
			obj.thrownID = thrownID;
			obj.targetShapeID = hitTargetShape.creationIndex;
			Profiler.BeginSample("processhitting before calc damage event");
			if (mSimContext.GetSimInterface().mBeforeCalcDamageEvent != null)
			{
				mSimContext.GetSimInterface().mBeforeCalcDamageEvent(obj);
			}
			Profiler.EndSample();
			Profiler.BeginSample("processhitting calc damage event");
			if (mSimContext.GetSimInterface().mCalcDamageEvent != null)
			{
				mSimContext.GetSimInterface().mCalcDamageEvent(obj);
			}
			Profiler.EndSample();
			Profiler.BeginSample("processhitting after calc damage event");
			if (mSimContext.GetSimInterface().mAfterCalcDamageEvent != null)
			{
				mSimContext.GetSimInterface().mAfterCalcDamageEvent(obj);
			}
			Profiler.EndSample();
			Int3 @int = hitTarget.entityPositon.mPosition - position;
			@int.y = 0;
			Int3 hitDirection = @int.NormalizeTo(1000);
			if (1 >= hitDirection.sqrMagnitudeLong)
			{
				hitDirection = forward;
			}
			if (hitCheckInfo.IsUseAttackerDirection)
			{
				hitDirection = forward;
			}
			if (hitCheckInfo.UseCustomDirection)
			{
				hitDirection = IntMath.VectorOfAngle(IntMath.AngleOfVector(forward) - hitCheckInfo.CustomAngle);
			}
			DoHitRecoverAction(caster, thrownID, abilityID, stateIndex, hitIndex, hitCheckInfo, hitDirection, aimDirection, hitTarget);
		}
		else
		{
			AttributeProcessor.SetAttributeWithIntName(attributeIDOfAttacker, 2174, 0L, 0L, 0L);
			TryGetRootAbilityID(abilityID, thrownID, mSimContext, out var rootAbilityID);
			if (hitTarget.hasEntityActionModifyHP)
			{
				hitTarget.entityActionModifyHP.mStatus = EntityActionStatus.E_ACTIVE;
				hitTarget.entityActionModifyHP.mModifyInfoList.Add(new ModifyHPInfo
				{
					mAmount = 0L,
					mDamageType = DamageType.Missing,
					mActionID = abilityID,
					mCasterID = caster,
					mThrownID = thrownID,
					mRootAbilityID = rootAbilityID
				});
			}
			else
			{
				hitTarget.AddEntityActionModifyHP(EntityActionStatus.E_ACTIVE, new List<ModifyHPInfo>(64)
				{
					new ModifyHPInfo
					{
						mAmount = 0L,
						mDamageType = DamageType.Missing,
						mActionID = abilityID,
						mCasterID = caster,
						mThrownID = thrownID,
						mRootAbilityID = rootAbilityID
					}
				});
			}
		}
	}

	public static void AddEntityActionModifyHP(SimEntity simEntity, int addValue, DamageType damageType, int abilityID, int casterID, int thrownID)
	{
		TryGetRootAbilityID(abilityID, thrownID, mSimContext, out var rootAbilityID);
		if (simEntity.hasEntityActionModifyHP)
		{
			simEntity.entityActionModifyHP.mStatus = EntityActionStatus.E_ACTIVE;
			simEntity.entityActionModifyHP.mModifyInfoList.Add(new ModifyHPInfo
			{
				mAmount = addValue,
				mDamageType = damageType,
				mActionID = abilityID,
				mCasterID = casterID,
				mRealDamage = addValue,
				mThrownID = thrownID,
				mRootAbilityID = rootAbilityID
			});
		}
		else
		{
			List<ModifyHPInfo> list = FrameListPool<ModifyHPInfo>.Claim();
			list.Add(new ModifyHPInfo
			{
				mAmount = addValue,
				mDamageType = damageType,
				mActionID = abilityID,
				mCasterID = casterID,
				mRealDamage = addValue,
				mThrownID = thrownID,
				mRootAbilityID = rootAbilityID
			});
			simEntity.AddEntityActionModifyHP(EntityActionStatus.E_ACTIVE, list);
		}
	}

	public static bool TryGetRootAbilityID(int abilityID, int thrownID, SimContext simContext, out int rootAbilityID)
	{
		rootAbilityID = abilityID;
		if (thrownID != 0)
		{
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(simContext, thrownID, out thrownState))
			{
				rootAbilityID = thrownState.mCreatedRootTimelineID;
			}
		}
		bool flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(rootAbilityID, out var config);
		if (flag)
		{
			if (config.OriginAbility != 0)
			{
				rootAbilityID = config.OriginAbility;
			}
			else
			{
				flag = false;
			}
		}
		return flag;
	}

	public static void DoHitRecoverAction(int caster, int thrownID, int abilityID, int abilityStateIndex, int hitIndex, HitCheckInfo hitCheckInfo, Int3 hitDirection, Int3 aimDirection, SimEntity hitTarget)
	{
		hitTarget.entityBlackboard.var.mBeHitIndex = hitIndex;
		hitTarget.entityBlackboard.var.mBeHitAbilitiID = abilityID;
		hitTarget.entityBlackboard.var.mIsHitByThump = hitCheckInfo.IsThump;
		bool flag = false;
		long num = 0L;
		DamageType damageType = DamageType.Damage;
		if (hitTarget.hasEntityActionModifyHP && hitTarget.entityActionModifyHP.mModifyInfoList.Count > 0)
		{
			ModifyHPInfo modifyHPInfo = hitTarget.entityActionModifyHP.mModifyInfoList[hitTarget.entityActionModifyHP.mModifyInfoList.Count - 1];
			num = modifyHPInfo.mAmount;
			damageType = modifyHPInfo.mDamageType;
		}
		if (hitTarget.entityBlackboard.var.mIsStoic <= 0 && (num != 0L || damageType != DamageType.Defense))
		{
			if (!hitCheckInfo.IsOnlyReduceHP)
			{
				flag = InterruptCheck(caster, hitTarget, thrownID, abilityID, abilityStateIndex);
			}
		}
		else
		{
			int interruptAbilityID = abilityID;
			if (ThrownProcessor.TryGetThrown(mSimContext, thrownID, out var thrownState))
			{
				interruptAbilityID = thrownState.mAbilityID;
			}
			flag = PushInterruptEvent(caster, hitTarget, thrownID, interruptAbilityID);
		}
		int num2 = CalcualteHitTargetKurtun(hitTarget, flag, hitCheckInfo);
		if (!flag)
		{
			if (hitTarget.hasEntityActionAbility)
			{
				hitTarget.entityActionAbility.mKartunTime = num2;
			}
			return;
		}
		if (!hitTarget.entityBlackboard.var.mBeHitKeepForward)
		{
			hitTarget.entityPositon.mForward = -hitDirection;
			hitTarget.entityPositon.mForwardAngle = IntMath.AngleOfVector(hitTarget.entityPositon.mForward);
		}
		RoleConfig roleConfig = hitTarget.entityConfig.mConfig as RoleConfig;
		int newMHitRecoverActionID = 0;
		E_HitRecoverStatus e_HitRecoverStatus = (hitTarget.hasEntityHitRecover ? hitTarget.entityHitRecover.mHitRecoverStatus : E_HitRecoverStatus.HitReocver);
		if (hitCheckInfo.HitHeight != 0 && roleConfig.CanHitUp)
		{
			switch (e_HitRecoverStatus)
			{
			case E_HitRecoverStatus.FloatUp:
			case E_HitRecoverStatus.FloatDown:
			case E_HitRecoverStatus.HitAir:
				hitTarget.entityBlackboard.var.mHitRecoverIndex = hitTarget.entityBlackboard.var.mHitRecoverIndex % roleConfig.HitAirID.Count;
				newMHitRecoverActionID = CheckSlot(hitTarget.entityBlackboard.var.mHitAirSlot[hitTarget.entityBlackboard.var.mHitRecoverIndex], roleConfig.HitAirID.get_Item(hitTarget.entityBlackboard.var.mHitRecoverIndex));
				hitTarget.entityBlackboard.var.mHitRecoverIndex = (hitTarget.entityBlackboard.var.mHitRecoverIndex + 1) % roleConfig.HitAirID.Count;
				e_HitRecoverStatus = E_HitRecoverStatus.HitAir;
				break;
			case E_HitRecoverStatus.HitFloor:
			case E_HitRecoverStatus.GetUp:
			case E_HitRecoverStatus.HitReocver:
				newMHitRecoverActionID = CheckSlot(hitTarget.entityBlackboard.var.mHitUpSlot, roleConfig.HitUpID);
				e_HitRecoverStatus = E_HitRecoverStatus.FloatUp;
				break;
			}
			if (hitCheckInfo.UseHitDownDuration && hitCheckInfo.HitDownDuration == 0)
			{
				newMHitRecoverActionID = CheckSlot(hitTarget.entityBlackboard.var.mHitFloorSlot, roleConfig.HitFloorID);
				e_HitRecoverStatus = E_HitRecoverStatus.HitFloor;
			}
		}
		else
		{
			switch (e_HitRecoverStatus)
			{
			case E_HitRecoverStatus.FloatUp:
			case E_HitRecoverStatus.FloatDown:
			case E_HitRecoverStatus.HitAir:
				hitTarget.entityBlackboard.var.mHitRecoverIndex = hitTarget.entityBlackboard.var.mHitRecoverIndex % roleConfig.HitAirID.Count;
				newMHitRecoverActionID = CheckSlot(hitTarget.entityBlackboard.var.mHitAirSlot[hitTarget.entityBlackboard.var.mHitRecoverIndex], roleConfig.HitAirID.get_Item(hitTarget.entityBlackboard.var.mHitRecoverIndex));
				hitTarget.entityBlackboard.var.mHitRecoverIndex = (hitTarget.entityBlackboard.var.mHitRecoverIndex + 1) % roleConfig.HitAirID.Count;
				e_HitRecoverStatus = E_HitRecoverStatus.HitAir;
				break;
			case E_HitRecoverStatus.HitFloor:
			case E_HitRecoverStatus.GetUp:
			case E_HitRecoverStatus.HitReocver:
				if (hitCheckInfo.IsLargeHitBack)
				{
					newMHitRecoverActionID = ((roleConfig.RoleHitBackRecoverID != 0) ? roleConfig.RoleHitBackRecoverID : roleConfig.HitBackRecoverID);
				}
				else
				{
					hitTarget.entityBlackboard.var.mHitRecoverIndex = hitTarget.entityBlackboard.var.mHitRecoverIndex % roleConfig.HitRecoverID.Count;
					newMHitRecoverActionID = CheckSlot(hitTarget.entityBlackboard.var.mHitRecoverSlots[hitTarget.entityBlackboard.var.mHitRecoverIndex], roleConfig.HitRecoverID.get_Item(0));
					hitTarget.entityBlackboard.var.mHitRecoverIndex = (hitTarget.entityBlackboard.var.mHitRecoverIndex + 1) % roleConfig.HitRecoverID.Count;
				}
				e_HitRecoverStatus = E_HitRecoverStatus.HitReocver;
				break;
			}
		}
		if (hitTarget.hasEntityActionAbility)
		{
			hitTarget.RemoveEntityActionAbility();
		}
		if (!hitTarget.hasEntityHitRecover)
		{
			AttributeProcessor.SetAttributeWithIntName(hitTarget.entityBlackboard.var.mAttributeID, 2019, 0L, 0L, 0L);
			hitTarget.AddEntityHitRecover(E_HitRecover.OnEnter, 0, newMHitRecoverActionID, aimDirection, hitDirection, hitCheckInfo.HorizontalSpeed, hitCheckInfo.HorizontalAcceleratedASpeed, hitCheckInfo, 0, newMEnableMovement: true, 0, e_HitRecoverStatus, num2, abilityID, hitIndex, hitCheckInfo.HorizontalSpeedOnFloat, 0, 100, 1, 0, caster, Int3.zero);
			return;
		}
		AttributeProcessor.GetAttributeWithIntName(hitTarget.entityBlackboard.var.mAttributeID, 2019, out var baseValue, out var _, out var _);
		if (E_HitRecoverStatus.HitAir == e_HitRecoverStatus)
		{
			int num3 = 0;
			public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
			if (config != null && config.BalanceValueConsume.Count > 0)
			{
				num3 = ((config.BalanceValueConsume.Count > hitCheckInfo.HitCheckID) ? config.BalanceValueConsume.get_Item(hitCheckInfo.HitCheckID) : config.BalanceValueConsume.get_Item(config.BalanceValueConsume.Count - 1));
			}
			if (num3 < 0)
			{
				baseValue = 0L;
				baseValue -= num3;
			}
			else
			{
				baseValue += num3;
			}
			AttributeProcessor.SetAttributeWithIntName(hitTarget.entityBlackboard.var.mAttributeID, 2019, baseValue, 0L, 0L);
		}
		if (baseValue < (hitTarget.entityConfig.mConfig as RoleConfig).BalanceValue)
		{
			hitTarget.ReplaceEntityHitRecover(E_HitRecover.OnEnter, 0, newMHitRecoverActionID, aimDirection, hitDirection, hitCheckInfo.HorizontalSpeed, hitCheckInfo.HorizontalAcceleratedASpeed, hitCheckInfo, 0, newMEnableMovement: true, 0, e_HitRecoverStatus, num2, abilityID, hitIndex, hitCheckInfo.HorizontalSpeedOnFloat, 0, 100, 1, 0, caster, Int3.zero);
		}
	}

	public static void PredictionHitCheck(int caster, int logicTime, int abilityID, HitCheckInfo hitCheckInfo, uint layerMask, Int3 position, Int3 forward, Int3 aimDirection, ref int hitIndex, out int kurtunTime, int thrownID = 0)
	{
		kurtunTime = 0;
		List<int> list = ListPool<int>.Claim();
		aimDirection = IntMath.VectorOfAngle(IntMath.AngleOfVector(aimDirection) - new Int(hitCheckInfo.OffsetOfFoward));
		List<ISimShape> list2 = ListPool<ISimShape>.Claim();
		CommonProcessor.TryGetCollisions(position, forward, aimDirection, hitCheckInfo, layerMask, list2);
		int throwID = ((thrownID != 0) ? thrownID : caster);
		mWorldState.status.TryGetPredictionHitHistroy(throwID, out var history);
		for (int i = 0; i < list2.Count; i++)
		{
			int num = list2[i].OwnerID;
			ISimShape simShape = list2[i];
			SimEntity simEntity = mSimContext.GetEntityWithEntityID(num);
			if (simEntity.mTag == SimEntity.Tag.MultiColliders)
			{
				simEntity = simEntity.mParent;
				num = simEntity.creationIndex;
			}
			if ((history == null || !history.Contains(num)) && simShape.IsEnable && simEntity.hasEntityBlackboard && !simShape.IgnoreHit)
			{
				AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2020, out var baseValue, out var _, out var _);
				if (simEntity.hasEntityRemotePlayer && simEntity.hasEntityConfig && (!simEntity.hasEntityBlackboard || (simEntity.entityBlackboard.var.mHP > 0 && baseValue < 1)))
				{
					list?.Add(simEntity.creationIndex);
				}
			}
		}
		if (list.Count > 0 && hitCheckInfo.AttackerKartunTime > 0)
		{
			kurtunTime = hitCheckInfo.AttackerKartunTime;
		}
		mWorldState.status.AddPredictionHitHistory(throwID, list);
		ListPool<int>.Release(list);
		ListPool<ISimShape>.Release(list2);
	}

	public static int CalcualteHitTargetKurtun(SimEntity simEntity, bool canInterrrupt, HitCheckInfo hitCkeckInfo)
	{
		if (!canInterrrupt)
		{
			bool flag = true;
			if (simEntity.hasEntityActionAbility)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityActionAbility.mAbilityID);
				int abilityStateIndex = config.AbilityStateInfoList.get_Item(simEntity.entityActionAbility.mCurrentStateIndex).AbilityStateIndex;
				flag = 11 == abilityStateIndex % ABILITY_STATUS_TYPE_INDEX;
			}
			if (flag & (simEntity.entityBlackboard.var.mIsStoic <= 0))
			{
				return hitCkeckInfo.NoReoverHitKartunTime - _kurtunLagCompensation;
			}
			return 0;
		}
		return hitCkeckInfo.HitKartunTime - _kurtunLagCompensation;
	}

	private static int CalcAbilityTimeStep(SimEntity simEntity)
	{
		if (!simEntity.hasEntityActionAbility)
		{
			return 0;
		}
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		if (simEntity.entityActionAbility.mKartunTime > 0)
		{
			simEntity.entityActionAbility.mKartunTime -= logicConstTick;
			simEntity.entityActionAbility.mTimeStep = 0;
			return 0;
		}
		SimWorldState worldState = CommonProcessor.GetWorldState();
		worldState.UpdateCommonWorldTimeScaleValue();
		int num = (int)IntMath.Divide((long)logicConstTick * (long)simEntity.entityActionAbility.mAbilitySpeed * simEntity.entityBlackboard.var.mEntityTimeScale, 10000L);
		num = num * worldState.commonWorldTimeScaleValue / worldState.commonWorldTimeScaleBaseValue;
		simEntity.entityActionAbility.mTimeStep = num;
		return num;
	}

	public static void ProcessAbility(SimEntity attacker)
	{
		if (!attacker.hasEntityActionAbility)
		{
			return;
		}
		int num = CalcAbilityTimeStep(attacker);
		while (num > 0)
		{
			int num2 = num;
			if (num >= CommonProcessor.GetConfigInterval())
			{
				num2 = CommonProcessor.GetConfigInterval();
			}
			attacker.entityActionAbility.mLogicTime += num2;
			if (attacker.hasEntityActionAbility)
			{
				ProcessAbilityImpl(attacker, num2);
				ProcessAbilityMove(attacker, num2, CommonProcessor.GetConfigInterval());
			}
			if (attacker.hasEntityActionJump)
			{
				ProcessActionJumpMove(attacker, num2, CommonProcessor.GetConfigInterval());
			}
			num -= num2;
		}
	}

	public static void TryStartJump(SimEntity entity)
	{
		if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == entity.entityBlackboard.var.mJumpStartSlot)
		{
			entity.entityActionJump.mStatus = E_JumpActionStatus.Start;
			int num = entity.entityActionJump.mMaxHeight - entity.entityPositon.mPosition.y;
			int num2 = IntMath.Sqrt(2 * num / entity.entityActionJump.mG);
			int num3 = entity.entityActionJump.mMaxHeight - entity.entityActionJump.mTargetPos.y;
			int num4 = IntMath.Sqrt(2 * num3 / entity.entityActionJump.mG);
			int num5 = num2 + num4;
			Int3 mHSpeed = (entity.entityActionJump.mTargetPos - entity.entityPositon.mPosition) / num5;
			mHSpeed.y = 0;
			entity.entityActionJump.mHSpeed = mHSpeed;
			entity.entityActionJump.mVSpeed = entity.entityActionJump.mG * num2;
		}
	}

	public static void ProcessJumpStartAction(SimEntity entity, int step, int fixedTime)
	{
		if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == entity.entityBlackboard.var.mJumpStartSlot)
		{
			if (entity.entityActionAbility.mLogicTime > entity.entityActionJump.mStartActionReadyTime)
			{
				entity.entityPositon.mPosition += entity.entityActionJump.mHSpeed * step / fixedTime;
				entity.entityPositon.mPosition.y += entity.entityActionJump.mVSpeed * step / fixedTime;
				entity.entityPositon.mForward = (entity.entityActionJump.mTargetPos - entity.entityPositon.mPosition).NormalizeTo(1000);
				entity.entityPositon.mForwardAngle = IntMath.AngleOfVector(entity.entityPositon.mForward);
				SimShapeProcessor.UpdateShapeWorldPosition(entity);
				entity.entityActionJump.mVSpeed -= entity.entityActionJump.mG * step / fixedTime;
			}
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityActionAbility.mAbilityID);
			if (config == null)
			{
				Debug.LogError((object)("无法找到 == " + entity.entityActionAbility.mAbilityID));
			}
			else if (entity.entityActionAbility.mLogicTime >= config.Duration)
			{
				CheckAndAddAbilityOfSelf(entity, entity.entityBlackboard.var.mJumpUpLoopSlot, forceBorken: false);
				entity.entityActionJump.mStatus = E_JumpActionStatus.UpLoop;
			}
		}
	}

	public static void ProcessJumpUpLoopAction(SimEntity entity, int step, int fixedTime)
	{
		if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == entity.entityBlackboard.var.mJumpUpLoopSlot)
		{
			entity.entityPositon.mPosition += entity.entityActionJump.mHSpeed * step / fixedTime;
			entity.entityPositon.mForward = (entity.entityActionJump.mTargetPos - entity.entityPositon.mPosition).NormalizeTo(1000);
			entity.entityPositon.mForwardAngle = IntMath.AngleOfVector(entity.entityPositon.mForward);
			entity.entityPositon.mPosition.y += entity.entityActionJump.mVSpeed * step / fixedTime;
			SimShapeProcessor.UpdateShapeWorldPosition(entity);
			entity.entityActionJump.mVSpeed -= entity.entityActionJump.mG * step / fixedTime;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityBlackboard.var.mJumpAirSlot);
			if (config == null)
			{
				Debug.LogError((object)("无法找到 == " + entity.entityActionAbility.mAbilityID));
			}
			else if (entity.entityActionJump.mVSpeed <= entity.entityActionJump.mG * config.Duration / 2 / CommonProcessor.GetConfigInterval())
			{
				CheckAndAddAbilityOfSelf(entity, entity.entityBlackboard.var.mJumpAirSlot, forceBorken: false);
				entity.entityActionJump.mStatus = E_JumpActionStatus.Air;
			}
		}
	}

	public static void ProcessJumpAirAction(SimEntity entity, int step, int fixedTime)
	{
		if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == entity.entityBlackboard.var.mJumpAirSlot)
		{
			entity.entityPositon.mPosition += entity.entityActionJump.mHSpeed * step / fixedTime;
			entity.entityPositon.mPosition.y += entity.entityActionJump.mVSpeed * step / fixedTime;
			entity.entityPositon.mForward = (entity.entityActionJump.mTargetPos - entity.entityPositon.mPosition).NormalizeTo(1000);
			entity.entityPositon.mForwardAngle = IntMath.AngleOfVector(entity.entityPositon.mForward);
			SimShapeProcessor.UpdateShapeWorldPosition(entity);
			entity.entityActionJump.mVSpeed -= entity.entityActionJump.mG * step / fixedTime;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityBlackboard.var.mJumpAirSlot);
			if (config == null)
			{
				Debug.LogError((object)("无法找到 == " + entity.entityActionAbility.mAbilityID));
			}
			else if (entity.entityActionAbility.mLogicTime >= config.Duration)
			{
				CheckAndAddAbilityOfSelf(entity, entity.entityBlackboard.var.mJumpDownLoopSlot, forceBorken: false);
				entity.entityActionJump.mStatus = E_JumpActionStatus.DownLoop;
			}
		}
	}

	public static void ProcessJumpDownLoopAction(SimEntity entity, int step, int fixedTime)
	{
		if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == entity.entityBlackboard.var.mJumpDownLoopSlot)
		{
			entity.entityPositon.mPosition += entity.entityActionJump.mHSpeed * step / fixedTime;
			entity.entityPositon.mPosition.y += entity.entityActionJump.mVSpeed * step / fixedTime;
			SimShapeProcessor.UpdateShapeWorldPosition(entity);
			entity.entityActionJump.mVSpeed -= entity.entityActionJump.mG * step / fixedTime;
			if (entity.entityPositon.mPosition.y < entity.entityActionJump.mTargetPos.y)
			{
				entity.entityPositon.mPosition = entity.entityActionJump.mTargetPos;
				SimShapeProcessor.UpdateShapeWorldPosition(entity);
				entity.entityActionJump.mStatus = E_JumpActionStatus.Land;
				CheckAndAddAbilityOfSelf(entity, entity.entityBlackboard.var.mJumpLandSlot, forceBorken: false);
			}
		}
	}

	public static void ProcessActionJumpMove(SimEntity attacker, int step, int fixedTime)
	{
		switch (attacker.entityActionJump.mStatus)
		{
		case E_JumpActionStatus.None:
			TryStartJump(attacker);
			break;
		case E_JumpActionStatus.Start:
			ProcessJumpStartAction(attacker, step, fixedTime);
			break;
		case E_JumpActionStatus.UpLoop:
			ProcessJumpUpLoopAction(attacker, step, fixedTime);
			break;
		case E_JumpActionStatus.Air:
			ProcessJumpAirAction(attacker, step, fixedTime);
			break;
		case E_JumpActionStatus.DownLoop:
			ProcessJumpDownLoopAction(attacker, step, fixedTime);
			break;
		case E_JumpActionStatus.Land:
			break;
		}
	}

	public static void ProcessUltimateAvoidFrame(SimContext simContext, SimEntity entity)
	{
		if (!entity.hasEntityActionAbility)
		{
			return;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityActionAbility.mAbilityID);
		if (config == null || config.UltimateAvoidInfo == null)
		{
			return;
		}
		int num = config.UltimateAvoidInfo.Start + config.UltimateAvoidInfo.Duration - entity.entityActionAbility.mLogicTime;
		if (entity.entityActionAbility.mLogicTime <= config.UltimateAvoidInfo.Start || num <= 0 || entity.entityActionAbility.mInUltimateAvoidFrame)
		{
			return;
		}
		entity.entityActionAbility.mInUltimateAvoidFrame = true;
		if (!entity.hasEntityActionAvoidShadow)
		{
			entity.AddEntityActionAvoidShadow(entity.entityPositon.mPosition, newPosted: false, num);
		}
		else
		{
			if (simContext.GetSimInterface().mUltimateAvoidFrameEvent != null)
			{
				simContext.GetSimInterface().mUltimateAvoidFrameEvent(entity.creationIndex, 0, 0, UltimateAvoidFrameEventType.Exit);
			}
			entity.ReplaceEntityActionAvoidShadow(entity.entityPositon.mPosition, newPosted: false, num);
		}
		if (simContext.GetSimInterface().mUltimateAvoidFrameEvent != null)
		{
			simContext.GetSimInterface().mUltimateAvoidFrameEvent(entity.creationIndex, num, config.UltimateAvoidInfo.Duration, UltimateAvoidFrameEventType.Enter);
		}
	}

	public static void ProcessAbilityMove(SimEntity attacker, int step, int fixedTime)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(attacker.entityActionAbility.mAbilityID);
		int mAttributeID = attacker.entityBlackboard.var.mAttributeID;
		AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2022, out var baseValue, out var _, out var _);
		attacker.entityActionAbility.mEnableAbilityMovement = baseValue <= 0;
		if (!attacker.entityActionAbility.mEnableAbilityMovement)
		{
			return;
		}
		if (!config.UseFixedCurve)
		{
			if ((ConfigProcessor.IsMoveTurnState(attacker) || ConfigProcessor.IsMoveLockState(attacker) || ConfigProcessor.IsMoveLockStateBackwing(attacker) || ConfigProcessor.IsMoveUpdateLockState(attacker)) && attacker.hasEntityActionMoveDirection)
			{
				AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2226, out var baseValue2, out var _, out var _);
				VFactor vFactor = attacker.entityBlackboard.var.mMaxSpeed * new VFactor(step, 1000L);
				Int3 delta = ((baseValue2 == 0L) ? attacker.entityActionMoveDirection.mDirection : attacker.entityActionMoveDirection.mMovementDirection) * vFactor;
				MovementProcessor.PathfindingMove(attacker, delta, config.UseTangentMove, !config.UseTangentMove);
			}
			else if (attacker.entityActionAbility.mLogicTime < config.MoveActionTimelineNode.Duration * CommonProcessor.GetConfigInterval())
			{
				Int3 timelineDeltaMovement = MovementProcessor.GetTimelineDeltaMovement(config, attacker.entityActionAbility.mLogicTime, step);
				if (config.LockRootMotionX)
				{
					timelineDeltaMovement.x = 0;
				}
				Int3 forward = attacker.entityPositon.mForward;
				if (config.MoveActionTimelineNode.AngleOffsetList.Count > 0)
				{
					int timelineDeltaAngle = MovementProcessor.GetTimelineDeltaAngle(config, attacker.entityActionAbility.mLogicTime, step);
					MovementProcessor.Turn(attacker, -timelineDeltaAngle, out var _);
					forward = attacker.entityBlackboard.var.mAbilityStartFroward;
				}
				IntMath.LookAt(forward, Int3.up, out var axis_x, out var _, out var axis_z);
				axis_x *= timelineDeltaMovement.x;
				axis_z *= timelineDeltaMovement.z;
				Int3 delta2 = (axis_x + axis_z) / 1000f;
				Int3 @int = MovementProcessor.PathfindingMove(attacker, delta2, config.UseTangentMove, !config.UseTangentMove);
			}
		}
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(attacker.entityActionAbility.mTargetID);
		AttackApproachInfo attackApproachInfo = null;
		if (config.AttackApproachInfos != null)
		{
			for (int i = 0; i < config.AttackApproachInfos.Count; i++)
			{
				AttackApproachInfo attackApproachInfo2 = config.AttackApproachInfos.get_Item(i);
				if (attackApproachInfo2.Start <= attacker.entityActionAbility.mLogicTime && attackApproachInfo2.Start + attackApproachInfo2.Duration > attacker.entityActionAbility.mLogicTime)
				{
					if (attacker.entityActionAbility.mLogicTime - attackApproachInfo2.Start < step)
					{
						attacker.entityActionAbility.MAttackApproachSpeed = 0;
					}
					attackApproachInfo = attackApproachInfo2;
					break;
				}
			}
		}
		if (attackApproachInfo != null && attackApproachInfo.Duration > 0 && entityWithEntityID != null)
		{
			if (attacker.entityActionAbility.MAttackApproachSpeed == 0)
			{
				long a = MovementProcessor.SqrDistance(entityWithEntityID.entityShape.mShape.WorldPos, attacker.entityPositon.mPosition);
				a = IntMath.Sqrt(a) - entityWithEntityID.entityShape.mShape.AvgCollisionRadius;
				long num = a;
				if (num > attackApproachInfo.TargetDistance && num < attackApproachInfo.ValidDistance)
				{
					num -= attackApproachInfo.TargetDistance;
					if (num > attackApproachInfo.MaxDistance)
					{
						num = attackApproachInfo.MaxDistance;
					}
					attacker.entityActionAbility.MAttackApproachSpeed = (int)num * 1000 / attackApproachInfo.Duration;
				}
			}
			int newMagn = attacker.entityActionAbility.MAttackApproachSpeed * step / 1000;
			Int3 mForward = attacker.entityPositon.mForward;
			Int3 delta3 = mForward.NormalizeTo(newMagn);
			MovementProcessor.PathfindingMove(attacker, delta3, config.UseTangentMove, preventPenetration: true);
		}
		else
		{
			attacker.entityActionAbility.MAttackApproachSpeed = 0;
		}
	}

	public static void AbilityTransform(SimEntity attacker, int transformID, int appearAbilityID = 0)
	{
		int mId = attacker.entityConfig.mId;
		if (attacker.hasEntityActionAbility)
		{
			attacker.RemoveEntityActionAbility();
		}
		mSimContext.GetSimInterface().mTransfigurationBeofreEvent?.Invoke(attacker.creationIndex, mId, transformID);
		CommonProcessor.UpdateRoleID(attacker, transformID, appearAbilityID);
		mSimContext.GetSimInterface().mTransfigurationEvent?.Invoke(attacker.creationIndex, mId, transformID);
		attacker.RemoveEntityActionTransfiguration();
	}

	public static void ProcessAbilityImpl(SimEntity attacker, int deltaTime)
	{
		if (attacker.entityActionAbility.mStatus != EntityActionStatus.E_ACTIVE)
		{
			return;
		}
		attacker.entityBlackboard.var.mActionBusy = true;
		bool flag = false;
		int mLogicTime = attacker.entityActionAbility.mLogicTime;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(attacker.entityActionAbility.mAbilityID);
		if (config == null)
		{
			Debug.LogError((object)("无法找到 == " + attacker.entityActionAbility.mAbilityID));
		}
		for (int i = attacker.entityActionAbility.mCurrentStateIndex; i < config.AbilityStateInfoList.Count && mLogicTime >= config.AbilityStateInfoList.get_Item(i).Start; i++)
		{
			attacker.entityActionAbility.mCurrentStateIndex = i;
		}
		if (attacker.entityActionAbility.mCurrentStateIndex < 0 || attacker.entityActionAbility.mCurrentStateIndex >= config.AbilityStateInfoList.Count)
		{
			Debug.LogError((object)("Entity " + attacker.creationIndex + " Role " + attacker.entityConfig.mId + " Index " + attacker.entityActionAbility.mCurrentStateIndex + " Out of Range"));
		}
		AbilityStateInfo abilityStateInfo = config.AbilityStateInfoList.get_Item(attacker.entityActionAbility.mCurrentStateIndex);
		if (abilityStateInfo == null)
		{
			Debug.LogError((object)"无法找到 == AbilityStateInfo");
		}
		for (int j = 0; j < config.ShapeInfoList.Count; j++)
		{
			ShapeInfo shapeInfo = config.ShapeInfoList.get_Item(j);
			if (mLogicTime >= shapeInfo.Start && mLogicTime < shapeInfo.Start + shapeInfo.Duration)
			{
				SimShapeProcessor.UpdateShapeWorldPositionByConfig(mSimContext, attacker, shapeInfo);
			}
		}
		Int3 @int = attacker.entityPositon.mForward;
		if (IsDuringLockTime(attacker, config, mLogicTime))
		{
			@int = attacker.entityPositon.mForward;
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(attacker.entityActionAbility.mTargetID);
			if (AttributeProcessor.CanLockOfEntity(CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID)))
			{
				ISimShape mShape = entityWithEntityID.entityShape.mShape;
				if (mShape != null && (mShape.WorldPos - attacker.entityPositon.mPosition).sqrMagnitudeLong > 1)
				{
					@int = Int3.ProjectionToY(mShape.WorldPos - attacker.entityPositon.mPosition).NormalizeTo(1000);
				}
				else if (entityWithEntityID.hasEntityPositon && (entityWithEntityID.entityPositon.mPosition - attacker.entityPositon.mPosition).sqrMagnitudeLong > 1)
				{
					@int = Int3.ProjectionToY(entityWithEntityID.entityPositon.mPosition - attacker.entityPositon.mPosition).NormalizeTo(1000);
				}
			}
		}
		bool isActive = false;
		attacker.entityBlackboard.var.mActionBusy = false;
		if (ConfigProcessor.IsTurnState(attacker) && attacker.hasEntityActionMoveDirection)
		{
			MovementProcessor.LookAt(attacker, attacker.entityActionMoveDirection.mDirection, attacker.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var _);
			@int = attacker.entityPositon.mForward;
		}
		else if (ConfigProcessor.IsMoveTurnState(attacker))
		{
			if (attacker.hasEntityActionAbilityDirection)
			{
				MovementProcessor.LookAt(attacker, attacker.entityActionAbilityDirection.mDirection, attacker.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var _);
			}
			@int = attacker.entityPositon.mForward;
		}
		else if (ConfigProcessor.IsMoveLockState(attacker) || ConfigProcessor.IsMoveLockStateBackwing(attacker))
		{
			attacker.entityBlackboard.var.mIsMoveLock = true;
			SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(attacker.entityBlackboard.var.mAimTarget);
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID2);
			if (AttributeProcessor.CanLockOfEntity(simEntityByMultiColliders))
			{
				Int3 aimDirection = ((entityWithEntityID2.entityShape.mShape?.WorldPos ?? entityWithEntityID2.entityPositon.mPosition) - attacker.entityPositon.mPosition).NormalizeTo(1000);
				MovementProcessor.LookAt(attacker, aimDirection, attacker.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var _);
			}
			@int = attacker.entityPositon.mForward;
		}
		else if (ConfigProcessor.IsMoveUpdateLockState(attacker))
		{
			if (attacker.entityBlackboard.var.hasManualLock && attacker.entityBlackboard.var.mAimTarget != attacker.entityBlackboard.var.mLastTarget)
			{
				attacker.entityBlackboard.var.mAimTarget = attacker.entityBlackboard.var.mLastTarget;
			}
			SimEntity entityWithEntityID3 = mSimContext.GetEntityWithEntityID(attacker.entityBlackboard.var.mAimTarget);
			SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID3);
			if (simEntityByMultiColliders2 == null || simEntityByMultiColliders2.hasEntityActionDeath || simEntityByMultiColliders2.entityBlackboard.var.mHP <= 0 || (AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders2.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var _, out var _) && baseValue > 0))
			{
				public_skill config2 = ConfigHelper.GetInstance().GetConfig<public_skill>(config.ID);
				int mID = LockBestTarget(attacker, config2);
				entityWithEntityID3 = mSimContext.GetEntityWithEntityID(mID);
				simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID3);
			}
			if (simEntityByMultiColliders2 != null && !simEntityByMultiColliders2.hasEntityActionDeath && simEntityByMultiColliders2.entityBlackboard.var.mHP > 0)
			{
				Int3 aimDirection2 = ((entityWithEntityID3.entityShape.mShape?.WorldPos ?? entityWithEntityID3.entityPositon.mPosition) - attacker.entityPositon.mPosition).NormalizeTo(1000);
				MovementProcessor.LookAt(attacker, aimDirection2, attacker.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var _);
			}
			@int = attacker.entityPositon.mForward;
		}
		else if (config.CharacterTurnInfos.Count > 0)
		{
			int direction = 0;
			int index = -1;
			attacker.entityActionAbility.TryGetTurnDirectionAndIndex(out direction, out index);
			if (index < config.CharacterTurnInfos.Count)
			{
				CharacterTurnInfo characterTurnInfo = config.CharacterTurnInfos.get_Item(index);
				if (mLogicTime >= characterTurnInfo.Start)
				{
					if (mLogicTime < characterTurnInfo.Start + characterTurnInfo.Duration)
					{
						if (characterTurnInfo.TurnDirection != 0 && !characterTurnInfo.StopOnFace)
						{
							Int3 lookat5 = attacker.entityPositon.mForward;
							Int obj = IntMath.Divide(characterTurnInfo.RotationSpeed * deltaTime, 1000);
							Int angleSpeed = ((characterTurnInfo.TurnDirection < 0) ? obj : (0 - obj));
							MovementProcessor.Turn(attacker, angleSpeed, out lookat5);
							@int = attacker.entityPositon.mForward;
						}
						else
						{
							SimEntity entityWithEntityID4 = mSimContext.GetEntityWithEntityID(attacker.entityActionAbility.mTargetID);
							if (entityWithEntityID4 != null)
							{
								Int3 mForward = attacker.entityPositon.mForward;
								Int3 int2 = (entityWithEntityID4.entityShape.mShape.WorldPos - attacker.entityPositon.mPosition).NormalizeTo(1000);
								long num = Int3.Det(mForward, int2);
								int num2 = Int3.Dot(mForward, int2);
								if (num != 0L || num2 < 0)
								{
									Int obj2 = IntMath.Divide(characterTurnInfo.RotationSpeed * deltaTime, 1000);
									if (direction == 0)
									{
										direction = ((characterTurnInfo.TurnDirection == 0) ? ((num >= 0) ? 1 : (-1)) : characterTurnInfo.TurnDirection);
										attacker.entityActionAbility.SetTurnDirectionAndIndex(direction, index);
									}
									Int angleSpeed2 = ((direction < 0) ? obj2 : (0 - obj2));
									VFactor radians = new VFactor(angleSpeed2.i, 1000L) * IntMath.Deg2Rad;
									mForward = mForward.RotateY(ref radians);
									if (characterTurnInfo.StopOnFace && (num * Int3.Det(mForward, int2) < 0 || num * direction < 0) && Int3.Dot(mForward, int2) > 0)
									{
										mForward = int2;
										attacker.entityPositon.mForward = mForward;
										attacker.entityPositon.mForwardAngle = IntMath.AngleOfVector(mForward);
										attacker.entityActionAbility.SetTurnDirectionAndIndex(0, ++index);
										@int = attacker.entityPositon.mForward;
									}
									else
									{
										MovementProcessor.Turn(attacker, angleSpeed2, out mForward);
										@int = attacker.entityPositon.mForward;
									}
								}
								else
								{
									attacker.entityActionAbility.SetTurnDirectionAndIndex(0, ++index);
								}
							}
						}
					}
					else
					{
						attacker.entityActionAbility.SetTurnDirectionAndIndex(0, ++index);
					}
				}
			}
		}
		attacker.entityPositon.mForward = @int;
		attacker.entityPositon.mForwardAngle = IntMath.AngleOfVector(@int);
		if (attacker.hasEntityActionMoveDirection && attacker.entityActionAbility.mStatus == EntityActionStatus.E_ACTIVE)
		{
			MovementProcessor.EnableMovement(attacker, isActive);
		}
		attacker.entityActionAbility.mHitIndex = UpdateHitIndex(attacker.creationIndex, mLogicTime, config, attacker.entityActionAbility.mHitIndex);
		if (IsHitFrame(config, mLogicTime, attacker.entityActionAbility.mHitIndex, deltaTime, out var hitCheckInfo))
		{
			uint interestCamp = RoleCampProcessor.GetInterestCamp(attacker.entityCamp.mRoleTypeCamp);
			int kurtunTime = 0;
			if (attacker.hasEntityRemotePlayer)
			{
				HitCheck(attacker.creationIndex, mLogicTime, attacker.entityActionAbility.mAbilityID, attacker.entityActionAbility.mCurrentStateIndex, hitCheckInfo, interestCamp, attacker.entityPositon.mPosition, attacker.entityPositon.mForward, @int, ref attacker.entityActionAbility.mHitIndex, out kurtunTime, attacker.entityBlackboard.var.mAttributeID, attacker.entityActionAbility.mCanBeParry);
			}
			if (CommonProcessor.IsSinglePlayerGameMode(mSimContext))
			{
				attacker.entityActionAbility.mKartunTime = kurtunTime;
			}
		}
		attacker.entityBlackboard.var.mActionBusy = true;
		bool flag2 = mLogicTime >= config.Duration;
		Profiler.BeginSample("Call Flowcavans Ability UpdateAbilityLogicEvent Cost");
		if (mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mUpdateAbilityLogicEvent != null)
		{
			int num3 = (mLogicTime - deltaTime) / CommonProcessor.GetConfigInterval();
			int num4 = mLogicTime / CommonProcessor.GetConfigInterval();
			if (num3 != num4 && attacker.hasEntityRemotePlayer)
			{
				int num5 = mLogicTime - deltaTime;
				num5 = ((num5 >= CommonProcessor.GetConfigInterval()) ? num5 : 0);
				PostThrownEvent(config, mLogicTime, deltaTime, attacker.creationIndex, attacker.entityPositon.mPosition, @int, null, attacker.creationIndex, config.ID, attacker.entityBlackboard.var.mAttributeID);
				if (mSimContext.GetSimInterface().mUpdateAbilityBeginLogicEvent != null)
				{
					mSimContext.GetSimInterface().mUpdateAbilityBeginLogicEvent(attacker.creationIndex, attacker.entityActionAbility.mAbilityID, num5, deltaTime);
				}
				mSimContext.GetSimInterface().mUpdateAbilityLogicEvent(attacker.creationIndex, attacker.entityActionAbility.mAbilityID, num5, deltaTime);
				if (mSimContext.GetSimInterface().mUpdateAbilityEndLogicEvent != null)
				{
					mSimContext.GetSimInterface().mUpdateAbilityEndLogicEvent(attacker.creationIndex, attacker.entityActionAbility.mAbilityID, num5, deltaTime);
				}
			}
		}
		Profiler.EndSample();
		if (attacker.hasEntityRemotePlayer && config.TransformActionInfo != null && config.TransformActionInfo.TransformRoleID != 0 && mLogicTime >= config.TransformActionInfo.Start && mLogicTime <= config.TransformActionInfo.Start + CommonProcessor.GetConfigInterval())
		{
			attacker.AddEntityActionTransfiguration(config.TransformActionInfo.TransformRoleID, config.TransformActionInfo.TransformActionID);
			attacker.entityBlackboard.var.mLastAbilityID = attacker.entityActionAbility.mAbilityID;
			mWorldState.status.RemoveHitHistory(attacker.creationIndex);
			return;
		}
		if (config.AbilitySpeedInfoList.Count > 0)
		{
			UpdateAbilitySpeedByTimeline(attacker, mLogicTime, config);
		}
		if (flag | flag2)
		{
			attacker.entityBlackboard.var.mLastAbilityID = attacker.entityActionAbility.mAbilityID;
			if (attacker.hasEntityRemotePlayer)
			{
				mWorldState.status.RemoveHitHistory(attacker.creationIndex);
			}
		}
	}

	public static int UpdateHitIndex(int creationIndex, int logicTime, Timeline pTimelineConfig, int pHitIndex)
	{
		while (pHitIndex >= 0 && pHitIndex < pTimelineConfig.HitTimeList.Count)
		{
			HitCheckInfo hitCheckInfo = pTimelineConfig.HitTimeList.get_Item(pHitIndex);
			if (hitCheckInfo.Start - _hitLagCompensation >= logicTime || logicTime <= hitCheckInfo.Start + hitCheckInfo.Duration - _hitLagCompensation)
			{
				break;
			}
			pHitIndex++;
			if (mWorldState.status.TryGetHitHistroy(creationIndex, out var history))
			{
				history?.Clear();
			}
		}
		return pHitIndex;
	}

	private static void UpdateAbilitySpeedByTimeline(SimEntity attacker, int logicTime, Timeline timelineConfig)
	{
		if (logicTime > timelineConfig.AbilitySpeedInfoList.get_Item(timelineConfig.AbilitySpeedInfoList.Count - 1).Start + timelineConfig.AbilitySpeedInfoList.get_Item(timelineConfig.AbilitySpeedInfoList.Count - 1).Duration)
		{
			return;
		}
		for (int i = 0; i < timelineConfig.AbilitySpeedInfoList.Count; i++)
		{
			AbilitySpeedInfo abilitySpeedInfo = timelineConfig.AbilitySpeedInfoList.get_Item(i);
			if (logicTime >= abilitySpeedInfo.Start && logicTime < abilitySpeedInfo.Start + abilitySpeedInfo.Duration)
			{
				attacker.entityActionAbility.mAbilitySpeed = abilitySpeedInfo.AbilitySpeedByTimeline;
				break;
			}
		}
	}

	public static bool InterruptCheck(int casterID, SimEntity beInterrupterEntity, int thrownID, int abilityID, int stateIndex)
	{
		int interruptAbilityID = 0;
		bool isSelf = casterID == beInterrupterEntity.creationIndex;
		bool flag = true;
		int abilityStateCode = GetAbilityStateCode(beInterrupterEntity, out var abilityID2);
		if (-1 != abilityStateCode)
		{
			int num = 0;
			if (thrownID != 0 && ThrownProcessor.TryGetThrown(mSimContext, thrownID, out var thrownState))
			{
				num = GetAbilityStateCode(thrownState.mAbilityID, stateIndex);
				interruptAbilityID = thrownState.mAbilityID;
			}
			else if (abilityID > 0)
			{
				num = GetAbilityStateCode(abilityID, stateIndex);
				interruptAbilityID = abilityID;
			}
			if (-2 == num)
			{
				flag = false;
			}
			else
			{
				flag = ConfigProcessor.CanInterrupt(num, abilityStateCode, isSelf, out var error);
				if (error)
				{
					Debug.LogErrorFormat(abilityID2 + " 打断报错 新动作 " + abilityID, new object[0]);
				}
			}
		}
		if (beInterrupterEntity.hasEntityRemotePlayer)
		{
			beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt = flag;
			flag = PushInterruptEvent(casterID, beInterrupterEntity, thrownID, interruptAbilityID);
		}
		return flag;
	}

	public static bool PushInterruptEvent(int casterID, SimEntity beInterrupterEntity, int thrownID = 0, int interruptAbilityID = 0)
	{
		if (mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mUpdateAbilityInterruptLogicEvent != null)
		{
			DamageEventParam arg = new DamageEventParam
			{
				casterID = casterID,
				abilityID = interruptAbilityID,
				thrownID = thrownID
			};
			bool arg2 = casterID == beInterrupterEntity.creationIndex;
			mSimContext.GetSimInterface().mUpdateAbilityInterruptLogicEvent(arg, beInterrupterEntity.creationIndex, arg2, beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt);
		}
		bool mIsBeInterrupt = beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt;
		beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt = false;
		return mIsBeInterrupt;
	}

	public static bool PushLogicInterruptEvent(SimEntity beInterrupterEntity, int interruptAbilityID, int beInterruptAbilityID, bool canInterrupt)
	{
		beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt = canInterrupt;
		if (mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mAbilityLogicInputInterruptEvent != null)
		{
			mSimContext.GetSimInterface().mAbilityLogicInputInterruptEvent(beInterrupterEntity.creationIndex, interruptAbilityID, beInterruptAbilityID, beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt);
		}
		bool mIsBeInterrupt = beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt;
		beInterrupterEntity.entityBlackboard.var.mIsBeInterrupt = false;
		return mIsBeInterrupt;
	}

	private static int GetHitRecoverAbilityIDByStatus(SimEntity entity)
	{
		RoleConfig roleConfig = entity.entityConfig.mConfig as RoleConfig;
		return entity.entityHitRecover.mHitRecoverStatus switch
		{
			E_HitRecoverStatus.FloatUp => CheckSlot(entity.entityBlackboard.var.mHitUpSlot, roleConfig.HitUpID), 
			E_HitRecoverStatus.FloatDown => CheckSlot(entity.entityBlackboard.var.mHitDownSlot, roleConfig.HitDownID), 
			E_HitRecoverStatus.HitAir => CheckSlot(entity.entityBlackboard.var.mHitAirSlot[entity.entityBlackboard.var.mHitRecoverIndex], roleConfig.HitAirID.get_Item(entity.entityBlackboard.var.mHitRecoverIndex)), 
			E_HitRecoverStatus.HitReocver => CheckSlot(entity.entityBlackboard.var.mHitRecoverSlots[entity.entityBlackboard.var.mHitRecoverIndex], roleConfig.HitRecoverID.get_Item(entity.entityBlackboard.var.mHitRecoverIndex)), 
			E_HitRecoverStatus.HitFloor => CheckSlot(entity.entityBlackboard.var.mHitFloorSlot, roleConfig.HitFloorID), 
			E_HitRecoverStatus.GetUp => CheckSlot(entity.entityBlackboard.var.mGetUpSlot, roleConfig.GetUpID), 
			_ => 0, 
		};
	}

	public static int GetAbilityStateCode(SimEntity beInterrupterEntity, out int abilityID)
	{
		int num = 0;
		abilityID = 0;
		if (beInterrupterEntity.hasEntityHitRecover)
		{
			abilityID = GetHitRecoverAbilityIDByStatus(beInterrupterEntity);
		}
		else if (beInterrupterEntity.hasEntityActionAbility)
		{
			abilityID = beInterrupterEntity.entityActionAbility.mAbilityID;
		}
		else
		{
			num = -1;
		}
		if (num >= 0)
		{
			if (0 < abilityID)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
				if (config == null)
				{
					Debug.LogError((object)$"Can't Find Timeline By {abilityID}");
				}
				if (beInterrupterEntity.hasEntityHitRecover)
				{
					num = config.AbilityStateInfoList.get_Item(beInterrupterEntity.entityHitRecover.mCurrentStateIndex).AbilityStateIndex;
				}
				else if (beInterrupterEntity.hasEntityActionAbility)
				{
					num = config.AbilityStateInfoList.get_Item(beInterrupterEntity.entityActionAbility.mCurrentStateIndex).AbilityStateIndex;
				}
			}
			else
			{
				num = -1;
			}
		}
		return num;
	}

	public static int GetAbilityStateCode(int abilityID, int curAbilityStateIndex = 0)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
		if (config == null)
		{
			Debug.LogError((object)$"Can't Find Timeline By {abilityID} Frame {mSimContext.simStatus.mServerFrame} ");
			return -2;
		}
		int num = 0;
		if (curAbilityStateIndex >= config.AbilityStateInfoList.Count)
		{
			Debug.LogError((object)("Ability " + abilityID + " Index " + curAbilityStateIndex + " StateInfoList.Count " + config.AbilityStateInfoList.Count));
		}
		return config.AbilityStateInfoList.get_Item(curAbilityStateIndex).AbilityStateIndex;
	}

	public static bool InterruptSelfByAbilityID(SimContext simContext, int entityID, int abilityID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		int abilityStateCode = GetAbilityStateCode(entityWithEntityID, out var abilityID2);
		if (-1 == abilityStateCode)
		{
			return true;
		}
		int abilityStateCode2 = GetAbilityStateCode(abilityID);
		bool result = ConfigProcessor.CanInterrupt(abilityStateCode2, abilityStateCode, isSelf: true, out var error);
		if (error)
		{
			Debug.LogErrorFormat(abilityID2 + " 自我打断报错 新动作 " + abilityID, new object[0]);
		}
		return result;
	}

	public static int GetAbilityByInput(SimEntity simEntity, int input)
	{
		int num = 0;
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		if (5 == input)
		{
			num = simEntity.entityBlackboard.var.mMeleesSlots[simEntity.entityBlackboard.var.meleeIndex];
		}
		else if (6 == input)
		{
			if (roleConfig.AvoidAbility.Count <= 0)
			{
				return 0;
			}
			num = ((!simEntity.hasEntityActionMoveDirection) ? CheckSlot(simEntity.entityBlackboard.var.mAvoidBackSlots, roleConfig.AvoidAbility.get_Item(1)) : CheckSlot(simEntity.entityBlackboard.var.mAvoidForwardSlots, roleConfig.AvoidAbility.get_Item(0)));
		}
		else if (7 == input)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(roleConfig.ID, out var config))
			{
				num = config.AbilityId.get_Item(0);
			}
		}
		else
		{
			if (30 == input)
			{
				return 0;
			}
			if (input < roleConfig.Ability.Count)
			{
				num = roleConfig.Ability.get_Item(input);
				if (input < simEntity.entityBlackboard.var.mAbilitySlots.Length)
				{
					num = CheckSlot(simEntity.entityBlackboard.var.mAbilitySlots[input], num);
				}
			}
			else
			{
				int num2 = input - 16;
				if (roleConfig.ExtendAbilities.Count > 0 && num2 >= 0 && num2 < roleConfig.ExtendAbilities.Count)
				{
					num = roleConfig.ExtendAbilities.get_Item(num2);
				}
			}
		}
		return num;
	}

	public static bool TryAddAbilityByInput(SimEntity simEntity, int input, out int abilityID)
	{
		bool forceBorken = false;
		abilityID = GetAbilityByInput(simEntity, input);
		if (0 >= abilityID)
		{
			return false;
		}
		if (7 == input && CommonProcessor.IsSinglePlayerGameMode(mSimContext) && simEntity.creationIndex != mSimContext.sEntityWorldState.status.mLocalPlayerID)
		{
			forceBorken = true;
		}
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		if (!AttributeProcessor.IsEnableAbility(simEntity, abilityID) || (ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(roleConfig.ID, out var config) && config.AbilityId.Contains(abilityID) && simEntity.entityUniqueSkillEnergy.mValue < simEntity.entityUniqueSkillEnergy.mMaxValue))
		{
			return false;
		}
		return CheckAndAddAbilityOfSelf(simEntity, abilityID, forceBorken);
	}

	public static bool CheckAndAddAbilityOfSelf(SimEntity pSimEntity, int abilityID, bool forceBorken)
	{
		if (abilityID == 0)
		{
			if (pSimEntity.hasEntityActionAbility)
			{
				pSimEntity.RemoveEntityActionAbility();
			}
			return false;
		}
		if (pSimEntity.hasEntityActionAbility)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(pSimEntity.entityActionAbility.mAbilityID);
			if (config != null && config.IsFinalAction)
			{
				return false;
			}
		}
		if (forceBorken || ((!CDProcessor.InCD(pSimEntity, abilityID) || CDProcessor.IsIgnore(pSimEntity, abilityID) || CDProcessor.HasAward(pSimEntity, abilityID)) && AttributeProcessor.IsEnableAbility(pSimEntity, abilityID) && InterruptCheck(pSimEntity.creationIndex, pSimEntity, 0, abilityID, 0)))
		{
			public_skill config2 = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
			int newMTargetID = pSimEntity.entityBlackboard.var.mAimTarget;
			if (ConfigProcessor.AbilityHasLockTrack(abilityID))
			{
				newMTargetID = LockBestTarget(pSimEntity, config2);
			}
			int mNewAbilityStartFrame = pSimEntity.entityBlackboard.var.mNewAbilityStartFrame;
			pSimEntity.entityBlackboard.var.mNewAbilityStartFrame = -1;
			bool flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(abilityID, out var config3);
			if (flag)
			{
				flag = config3.CanBeParry;
			}
			if (pSimEntity.hasEntityActionAbility)
			{
				bool mIsPressing = pSimEntity.entityActionAbility.mIsPressing;
				pSimEntity.ReplaceEntityActionAbility(EntityActionStatus.E_ACTIVE, abilityID, 0, 0, newMTargetID, 0, mIsPressing, 0, pSimEntity.creationIndex, newMEnableAbilityMovement: true, 100, 0, 0, 0, newMInUltimateAvoidFrame: false, 0, flag, 0);
			}
			else
			{
				pSimEntity.AddEntityActionAbility(EntityActionStatus.E_ACTIVE, abilityID, 0, 0, newMTargetID, 0, newMIsPressing: true, 0, pSimEntity.creationIndex, newMEnableAbilityMovement: true, 100, 0, 0, 0, newMInUltimateAvoidFrame: false, 0, flag, 0);
			}
			if (ConfigHelper.GetInstance().TryGetConfig<Timeline>(abilityID, out var config4) && config4.MoveActionTimelineNode.AngleOffsetList.Count > 0)
			{
				pSimEntity.entityBlackboard.var.mAbilityStartFroward = pSimEntity.entityPositon.mForward;
			}
			JumpToFrame(pSimEntity, mNewAbilityStartFrame);
			return true;
		}
		return false;
	}

	public static void SetNextFrameAbility(SimEntity simEntity, int abilityID, bool forceBroken)
	{
		if (!forceBroken && simEntity.hasEntityActionAbilityLogicInput)
		{
			int mBrokenAbilityID = simEntity.entityActionAbilityLogicInput.mBrokenAbilityID;
			if (simEntity.entityActionAbilityLogicInput.mForceBroken)
			{
				return;
			}
			int abilityStateCode = GetAbilityStateCode(mBrokenAbilityID);
			int abilityStateCode2 = GetAbilityStateCode(abilityID);
			bool flag = PushLogicInterruptEvent(simEntity, abilityID, mBrokenAbilityID, ConfigProcessor.CanInterrupt(abilityStateCode2, abilityStateCode, isSelf: true, out var error));
			if (error)
			{
				Debug.LogErrorFormat(mBrokenAbilityID + " 逻辑打断报错 新动作 " + abilityID, new object[0]);
			}
			if (!flag)
			{
				return;
			}
		}
		if (simEntity.hasEntityActionAbilityLogicInput)
		{
			simEntity.ReplaceEntityActionAbilityLogicInput(abilityID, forceBroken);
		}
		else
		{
			simEntity.AddEntityActionAbilityLogicInput(abilityID, forceBroken);
		}
	}

	public static void UpdateHitRecoverStatus(SimEntity simEntity, int actionID, E_HitRecoverStatus status, int step)
	{
		simEntity.entityHitRecover.mHitRecoverStatus = status;
		simEntity.entityHitRecover.mHitRecoverActionID = actionID;
		simEntity.entityHitRecover.mHitRecoverTime = step;
		simEntity.entityHitRecover.mCurrentStateIndex = 0;
		simEntity.entityHitRecover.mHitRecover = E_HitRecover.OnChange;
		if (simEntity.hasEntityRemotePlayer)
		{
			mSimContext.PostEvent(EntityHitRecoverStatusEvent.Claim(simEntity.creationIndex, actionID, status, actionID, simEntity.entityHitRecover.mHitRecover, simEntity.entityHitRecover.mCasterID, simEntity.entityHitRecover.mHitCount));
		}
	}

	public static int CheckSlot(int slot, int config)
	{
		if (slot == 0)
		{
			return config;
		}
		return slot;
	}

	public static int GetHitRecoverActionID(SimEntity simEntity, E_HitRecoverStatus status, int index = 0)
	{
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		int result = 0;
		switch (status)
		{
		case E_HitRecoverStatus.FloatUp:
			result = CheckSlot(simEntity.entityBlackboard.var.mHitUpSlot, roleConfig.HitUpID);
			break;
		case E_HitRecoverStatus.FloatDown:
			result = CheckSlot(simEntity.entityBlackboard.var.mHitDownSlot, roleConfig.HitDownID);
			break;
		case E_HitRecoverStatus.HitAir:
			result = CheckSlot(simEntity.entityBlackboard.var.mHitAirSlot[index], roleConfig.HitAirID.get_Item(index));
			break;
		case E_HitRecoverStatus.HitFloor:
			result = CheckSlot(simEntity.entityBlackboard.var.mHitFloorSlot, roleConfig.HitFloorID);
			break;
		case E_HitRecoverStatus.GetUp:
			result = CheckSlot(simEntity.entityBlackboard.var.mGetUpSlot, roleConfig.GetUpID);
			break;
		case E_HitRecoverStatus.HitReocver:
			result = CheckSlot(simEntity.entityBlackboard.var.mHitRecoverSlots[index], roleConfig.HitRecoverID.get_Item(index));
			break;
		}
		return result;
	}

	public static void UpdateHitRecover(SimEntity simEntity, int deltaTime)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityHitRecover.mHitRecoverActionID);
		int mHitRecoverTime = simEntity.entityHitRecover.mHitRecoverTime;
		int num = 0;
		int timelineDuration = GetTimelineDuration(simEntity, simEntity.entityHitRecover.mHitRecoverActionID, simEntity.entityHitRecover.mHitRecoverStatus);
		if (mHitRecoverTime > timelineDuration)
		{
			RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
			switch (simEntity.entityHitRecover.mHitRecoverStatus)
			{
			case E_HitRecoverStatus.FloatUp:
				num = CheckSlot(simEntity.entityBlackboard.var.mHitDownSlot, roleConfig.HitDownID);
				UpdateHitRecoverStatus(simEntity, num, E_HitRecoverStatus.FloatDown, deltaTime);
				break;
			case E_HitRecoverStatus.FloatDown:
				num = CheckSlot(simEntity.entityBlackboard.var.mHitFloorSlot, roleConfig.HitFloorID);
				UpdateHitRecoverStatus(simEntity, num, E_HitRecoverStatus.HitFloor, deltaTime);
				break;
			case E_HitRecoverStatus.HitAir:
				num = CheckSlot(simEntity.entityBlackboard.var.mHitDownSlot, roleConfig.HitDownID);
				UpdateHitRecoverStatus(simEntity, num, E_HitRecoverStatus.FloatDown, deltaTime);
				break;
			case E_HitRecoverStatus.HitFloor:
				num = CheckSlot(simEntity.entityBlackboard.var.mGetUpSlot, roleConfig.GetUpID);
				UpdateHitRecoverStatus(simEntity, num, E_HitRecoverStatus.GetUp, deltaTime);
				break;
			}
		}
		if (simEntity.entityHitRecover.mHitRecoverTime > simEntity.entityHitRecover.mTimeStep)
		{
			simEntity.entityHitRecover.mHitRecover = E_HitRecover.OnUpdate;
		}
		if (simEntity.hasEntityRemotePlayer && mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mUpdateHitRecover != null)
		{
			mSimContext.GetSimInterface().mUpdateHitRecover(simEntity.creationIndex, simEntity.entityHitRecover.mHitRecoverStatus);
		}
		for (int i = simEntity.entityHitRecover.mCurrentStateIndex; i < config.AbilityStateInfoList.Count; i++)
		{
			AbilityStateInfo abilityStateInfo = config.AbilityStateInfoList.get_Item(i);
			int start = abilityStateInfo.Start;
			int num2 = start + abilityStateInfo.Duration;
			if (mHitRecoverTime >= start && mHitRecoverTime <= num2)
			{
				simEntity.entityHitRecover.mCurrentStateIndex = i;
				break;
			}
		}
		if (!simEntity.hasEntityRemotePlayer)
		{
			return;
		}
		for (int j = 0; j < config.ShapeInfoList.Count; j++)
		{
			ShapeInfo shapeInfo = config.ShapeInfoList.get_Item(j);
			int start2 = shapeInfo.Start;
			int num3 = start2 + shapeInfo.Duration;
			if (mHitRecoverTime >= start2 && mHitRecoverTime <= num3)
			{
				SimShapeProcessor.UpdateShapeWorldPositionByConfig(mSimContext, simEntity, shapeInfo);
				break;
			}
		}
	}

	public static void UpdateHitRecoverMovement(SimEntity simEntity, int step)
	{
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		int mAttributeID = simEntity.entityBlackboard.var.mAttributeID;
		AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2021, out var baseValue, out var _, out var _);
		simEntity.entityHitRecover.mEnableMovement = baseValue <= 0;
		int configInterval = CommonProcessor.GetConfigInterval();
		if (!simEntity.entityHitRecover.mEnableMovement)
		{
			return;
		}
		if (roleConfig.RoleHitBackRecoverID == simEntity.entityHitRecover.mHitRecoverActionID || E_HitRecoverStatus.GetUp == simEntity.entityHitRecover.mHitRecoverStatus || E_HitRecoverStatus.HitFloor == simEntity.entityHitRecover.mHitRecoverStatus)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityHitRecover.mHitRecoverActionID);
			if (config.MoveActionTimelineNode.Duration > 0 && simEntity.entityHitRecover.mHitRecoverTime < config.MoveActionTimelineNode.Duration * CommonProcessor.GetConfigInterval())
			{
				int mHitRecoverTime = simEntity.entityHitRecover.mHitRecoverTime;
				Int3 timelineDeltaMovement = MovementProcessor.GetTimelineDeltaMovement(config, mHitRecoverTime, step);
				IntMath.LookAt(simEntity.entityPositon.mForward, Int3.up, out var axis_x, out var _, out var axis_z);
				axis_x *= timelineDeltaMovement.x;
				axis_z *= timelineDeltaMovement.z;
				Int3 delta = (axis_x + axis_z) / 1000f;
				Int3 @int = MovementProcessor.PathfindingMove(simEntity, delta, config.UseTangentMove, !config.UseTangentMove);
			}
			return;
		}
		int num = simEntity.entityHitRecover.mHitSpeed;
		if (E_HitRecoverStatus.HitFloor != simEntity.entityHitRecover.mHitRecoverStatus && E_HitRecoverStatus.GetUp != simEntity.entityHitRecover.mHitRecoverStatus)
		{
			Int3 mHitDirection = simEntity.entityHitRecover.mHitDirection;
			E_HitRecoverStatus mHitRecoverStatus = simEntity.entityHitRecover.mHitRecoverStatus;
			if (E_HitRecoverStatus.HitAir == mHitRecoverStatus)
			{
				int num2 = 0;
				if (simEntity.entityHitRecover.mHitInfo != null)
				{
					num2 = simEntity.entityHitRecover.mHitInfo.HitAirBackDistance;
				}
				int newMagn = IntMath.Divide(num2 * step, configInterval);
				mHitDirection.NormalizeTo(newMagn);
				MovementProcessor.PathfindingMove(simEntity, mHitDirection);
			}
			else
			{
				if (mHitRecoverStatus == E_HitRecoverStatus.FloatUp || mHitRecoverStatus == E_HitRecoverStatus.FloatDown)
				{
					num = simEntity.entityHitRecover.mHitHorizontalSpeedOnFloat;
				}
				bool flag = (((E_HitRecoverStatus)7 & mHitRecoverStatus) != E_HitRecoverStatus.None || simEntity.entityHitRecover.mHitRecoverTime < roleConfig.HitBackValidTime.get_Item(simEntity.entityBlackboard.var.mHitRecoverIndex) || simEntity.entityHitRecover.mHitRecoverActionID == roleConfig.HitBackRecoverID) && roleConfig.CanHitBack;
				if (((num > 0) & flag) && simEntity.entityHitRecover.mEnableMovement)
				{
					int newMagn2 = IntMath.Divide(num * step, 1000);
					mHitDirection.NormalizeTo(newMagn2);
					MovementProcessor.PathfindingMove(simEntity, mHitDirection);
				}
			}
		}
		if (E_HitRecoverStatus.HitReocver == simEntity.entityHitRecover.mHitRecoverStatus)
		{
			int num3 = IntMath.Divide(simEntity.entityHitRecover.mHitAcceleration * step, 1000);
			int mHitSpeed = Math.Max(num - num3, 0);
			simEntity.entityHitRecover.mHitSpeed = mHitSpeed;
		}
	}

	private static int CalcHitRecoverTimeStep(SimEntity simEntity)
	{
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		int num = IntMath.Divide(logicConstTick * simEntity.entityHitRecover.mTimeScale * simEntity.entityBlackboard.var.mEntityTimeScale, 10000);
		SimWorldState worldState = CommonProcessor.GetWorldState();
		num = num * worldState.commonWorldTimeScaleValue / worldState.commonWorldTimeScaleBaseValue;
		if (simEntity.entityHitRecover.mHitRecover == E_HitRecover.OnUpdate && simEntity.entityHitRecover.mCanProcessVerticalTime > 0)
		{
			simEntity.entityHitRecover.mCanProcessVerticalTime -= num;
			simEntity.entityHitRecover.mTimeStep = 0;
			return 0;
		}
		simEntity.entityHitRecover.mTimeStep = num;
		return num;
	}

	public static void ProcessHitRecover(SimEntity simEntity)
	{
		if (simEntity.hasEntityActionManualInput)
		{
			simEntity.RemoveEntityActionManualInput();
		}
		if (simEntity.hasEntityActionMoveDirection)
		{
			if (ConfigProcessor.IsMoveRecover(simEntity))
			{
				simEntity.RemoveEntityHitRecover();
				return;
			}
			simEntity.RemoveEntityActionMoveDirection();
		}
		if (simEntity.hasEntityActionAbility)
		{
			simEntity.RemoveEntityActionAbility();
		}
		if (simEntity.hasEntityBlackboard)
		{
			simEntity.entityBlackboard.var.meleeIndex = 0;
		}
		int num = CalcHitRecoverTimeStep(simEntity);
		while (num > 0)
		{
			int num2 = num;
			if (num >= CommonProcessor.GetConfigInterval())
			{
				num2 = CommonProcessor.GetConfigInterval();
			}
			int num3 = simEntity.entityHitRecover.mHitRecoverTime / CommonProcessor.GetConfigInterval();
			simEntity.entityHitRecover.mHitRecoverTime += num2;
			int num4 = simEntity.entityHitRecover.mHitRecoverTime / CommonProcessor.GetConfigInterval();
			if (num4 != num3)
			{
				UpdateHitRecover(simEntity, num2);
			}
			UpdateHitRecoverMovement(simEntity, num2);
			num -= num2;
		}
	}

	public static bool TryStopAttack(SimEntity simEntity)
	{
		if (simEntity.hasEntityActionAbility)
		{
			int num = simEntity.entityActionAbility.mAbilityID % 1000 / 100;
			if (num == 1)
			{
				simEntity.RemoveEntityActionAbility();
				return true;
			}
		}
		return false;
	}

	public static bool TryStopSkill(SimEntity simEntity)
	{
		if (simEntity.hasEntityActionAbility)
		{
			int num = simEntity.entityActionAbility.mAbilityID % 1000 / 100;
			if (num == 2)
			{
				simEntity.RemoveEntityActionAbility();
				return true;
			}
		}
		return false;
	}

	public static bool IsDuringLockTime(SimEntity simEntity, Timeline timeline, int logicTime)
	{
		for (int i = 0; i < timeline.LockAcionList.Count; i++)
		{
			LockActionNode lockActionNode = timeline.LockAcionList.get_Item(i);
			if (lockActionNode.Start <= logicTime && logicTime <= lockActionNode.Start + lockActionNode.Duration)
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsDuringGrabTime(Timeline timeline, int logicTime)
	{
		if (timeline.AbilityGrabInfo == null || timeline.AbilityGrabInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityGrabInfo.Start;
		int num = start + timeline.AbilityGrabInfo.Duration;
		if (start <= logicTime && logicTime <= num)
		{
			return true;
		}
		return false;
	}

	public static bool OnAbilityGrabEnter(Timeline timeline, int logicTime, int logicTimeStep)
	{
		if (timeline.AbilityGrabInfo == null || timeline.AbilityGrabInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityGrabInfo.Start;
		int num = start + timeline.AbilityGrabInfo.Duration;
		if (start > logicTime - logicTimeStep && logicTime >= start)
		{
			return true;
		}
		return false;
	}

	public static bool OnAbilityGrabExit(Timeline timeline, int logicTime, int logicTimeStep)
	{
		if (timeline.AbilityGrabInfo == null || timeline.AbilityGrabInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityGrabInfo.Start;
		int num = start + timeline.AbilityGrabInfo.Duration;
		if (num >= logicTime - logicTimeStep && logicTime > num)
		{
			return true;
		}
		return false;
	}

	public static bool OnAbilityThrowEnter(Timeline timeline, int logicTime, int logicTimeStep)
	{
		if (timeline.AbilityThrowInfo == null || timeline.AbilityThrowInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityThrowInfo.Start;
		int num = start + timeline.AbilityThrowInfo.Duration;
		if (start > logicTime - logicTimeStep && logicTime >= start)
		{
			return true;
		}
		return false;
	}

	public static bool OnAbilityThrowExit(Timeline timeline, int logicTime, int logicTimeStep)
	{
		if (timeline.AbilityThrowInfo == null || timeline.AbilityThrowInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityThrowInfo.Start;
		int num = start + timeline.AbilityThrowInfo.Duration;
		if (num >= logicTime - logicTimeStep && logicTime > num)
		{
			return true;
		}
		return false;
	}

	public static int PlayerAutoChooseTargetRules(SimEntity attacker, int attackRange, int overlapRange)
	{
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.Overlap(attacker.entityPositon.mPosition, overlapRange, list, RoleCampProcessor.GetInterestCamp(attacker.entityCamp.mRoleTypeCamp));
		long num = 1000000L;
		long num2 = 100000L;
		long num3 = 20000L;
		long num4 = 10000L;
		long num5 = 10000L;
		long num6 = 100L;
		long num7 = 10L;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(attacker.entityBlackboard.var.mLastTarget);
		long num8 = long.MaxValue;
		ISimShape simShape = null;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			simShape = entityWithEntityID.entityShape.mShape;
			if (simShape.IsEnable)
			{
				long a = MovementProcessor.SqrDistance(simShape.WorldPos, attacker.entityPositon.mPosition);
				num8 = IntMath.Sqrt(a) - simShape.AvgCollisionRadius;
			}
		}
		int result = 0;
		long num9 = long.MinValue;
		long num10 = long.MaxValue;
		long num11 = attackRange * attackRange;
		charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(attacker.ENTITY_CONFIG_ID);
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(list[i]);
			SimEntity simEntity = entityWithEntityID2;
			if (simEntity.mTag == SimEntity.Tag.MultiColliders)
			{
				simEntity = simEntity.mParent;
			}
			if (simEntity == null || simEntity.hasEntityActionDeath || !simEntity.hasEntityBlackboard || (simEntity.hasEntityBlackboard && simEntity.entityBlackboard.var.mHP <= 0))
			{
				continue;
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var plusValue, out var tempPlusValue);
			if (baseValue != 0L)
			{
				continue;
			}
			long num12 = 0L;
			long sqrMagnitudeLong = (attacker.entityPositon.mPosition - entityWithEntityID2.entityShape.mShape.WorldPos).sqrMagnitudeLong;
			if (sqrMagnitudeLong < num11)
			{
				num12 = num;
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2172, out var baseValue2, out plusValue, out tempPlusValue);
			num12 += num2 * baseValue2;
			if (attacker.hasEntityActionMoveDirection && !attacker.hasEntityAIThink)
			{
				Int3 rhs = entityWithEntityID2.entityShape.mShape.WorldPos - attacker.entityPositon.mPosition;
				Int3 mDirection = attacker.entityActionMoveDirection.mDirection;
				long num13 = Int3.DotLong(mDirection.NormalizeTo(1000), rhs);
				if (num13 > 0)
				{
					VFactor vFactor = new VFactor(num13 * num13 / 1000, sqrMagnitudeLong * 1000);
					if (vFactor > new VFactor(3L, 4L))
					{
						num12 += num3;
					}
					else if (vFactor > new VFactor(1L, 4L))
					{
						num12 += num4;
					}
				}
			}
			if (config != null && config.TargetDebuffArray != null && config.TargetDebuffArray.Count > 0 && simEntity.hasEntityBuff)
			{
				for (int j = 0; j < config.TargetDebuffArray.Count; j++)
				{
					if (simEntity.entityBuff.mBuffConfigID.Contains(config.TargetDebuffArray.get_Item(j)))
					{
						num12 += num5;
						break;
					}
				}
			}
			if (entityWithEntityID != null && num8 < attackRange && entityWithEntityID.mParent != null && entityWithEntityID.mParent == simEntity.mParent)
			{
				num12 += num6;
			}
			if (simShape != null && simShape.OwnerID != 0 && num8 < attackRange && entityWithEntityID.creationIndex == simEntity.creationIndex)
			{
				num12 += num6;
			}
			Int3 lhs = IntMath.VectorOfAngle(attacker.entityBlackboard.var.mCameraAngle);
			Int3 @int = attacker.entityPositon.mPosition - lhs.NormalizeTo(8000);
			Int3 rhs2 = simEntity.entityPositon.mPosition - @int;
			if (Int3.DotXZLong(lhs, rhs2) > 0)
			{
				num12 += num7;
			}
			if (num12 > num9 || (num12 == num9 && sqrMagnitudeLong < num10))
			{
				result = list[i];
				num9 = num12;
				num10 = sqrMagnitudeLong;
			}
		}
		FrameListPool<int>.Release(list);
		return result;
	}

	public static int LookatNearestTarget(SimEntity attacker, int distance = 20000000)
	{
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.Overlap(attacker.entityPositon.mPosition, distance, list, RoleCampProcessor.GetInterestCamp(attacker.entityCamp.mRoleTypeCamp));
		SimEntity simEntity = null;
		long num = long.MaxValue;
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(list[i]);
			SimEntity simEntity2 = entityWithEntityID;
			if (simEntity2.mTag == SimEntity.Tag.MultiColliders)
			{
				simEntity2 = simEntity2.mParent;
			}
			if (simEntity2 == null || simEntity2.hasEntityActionDeath || !simEntity2.hasEntityBlackboard || (simEntity2.hasEntityBlackboard && simEntity2.entityBlackboard.var.mHP <= 0))
			{
				continue;
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity2.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var _, out var _);
			if (baseValue <= 0)
			{
				long sqrMagnitudeLong = (attacker.entityPositon.mPosition - entityWithEntityID.entityShape.mShape.WorldPos).sqrMagnitudeLong;
				if (sqrMagnitudeLong < num)
				{
					simEntity = entityWithEntityID;
					num = sqrMagnitudeLong;
				}
			}
		}
		FrameListPool<int>.Release(list);
		attacker[EntityVarName.ENTITY_AI_TARGET] = simEntity?.creationIndex ?? 0;
		return simEntity?.creationIndex ?? 0;
	}

	public static int LockBestTarget(SimEntity attacker, public_skill config = null)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(attacker.entityBlackboard.var.mLastTarget);
		if (entityWithEntityID != null && !entityWithEntityID.entityShape.mShape.IsEnable)
		{
			ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(attacker, CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID), RoleCampProcessor.GetInterestCamp(attacker.entityCamp.mRoleTypeCamp), out var _);
			if (nearestCollisionData != null)
			{
				entityWithEntityID = mSimContext.GetEntityWithEntityID(nearestCollisionData.OwnerID);
				attacker.entityBlackboard.var.mLastTarget = entityWithEntityID.creationIndex;
			}
		}
		if (!ConfigHelper.GetInstance().TryGetConfig<LockLimitParam>(attacker.ENTITY_CONFIG_ID, out var config2))
		{
			config2 = ConfigHelper.GetInstance().GetConfig<LockLimitParam>(0);
		}
		int lockFarestDistance = config2.LockFarestDistance;
		if (attacker.entityBlackboard.var.lockType == LockType.lockNearest)
		{
			attacker.entityBlackboard.var.hasManualLock = false;
			return LookatNearestTarget(attacker, lockFarestDistance);
		}
		if (attacker.entityBlackboard.var.lockType == LockType.manualType)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (simEntityByMultiColliders != null && simEntityByMultiColliders.entityBlackboard.var.mHP >= 0)
			{
				AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var _, out var _);
				if (baseValue == 0L)
				{
					attacker.entityBlackboard.var.mAimTarget = entityWithEntityID.creationIndex;
					attacker.entityBlackboard.var.hasManualLock = true;
					return entityWithEntityID.creationIndex;
				}
			}
		}
		int num = 0;
		int attackRange = lockFarestDistance;
		if (config != null && config.Range != 0)
		{
			attackRange = config.Range;
		}
		if (attacker.entityBlackboard.var.hasManualLock)
		{
			SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (simEntityByMultiColliders2 != null && simEntityByMultiColliders2.entityBlackboard.var.mHP >= 0)
			{
				AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders2.entityBlackboard.var.mAttributeID, 2171, out var baseValue2, out var _, out var _);
				if (baseValue2 == 0L)
				{
					num = entityWithEntityID.creationIndex;
					attacker.entityBlackboard.var.mAimTarget = num;
					return num;
				}
				attacker.entityBlackboard.var.hasManualLock = false;
			}
			else
			{
				attacker.entityBlackboard.var.hasManualLock = false;
			}
		}
		num = PlayerAutoChooseTargetRules(attacker, attackRange, lockFarestDistance);
		attacker.entityBlackboard.var.mAimTarget = num;
		return num;
	}

	public static void SetAimTargetAndNearestPart(SimEntity simEntity, int aimEntityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(aimEntityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		List<EntityShape> list = FrameListPool<EntityShape>.Claim();
		SimShapeProcessor.GetAllShape(entityWithEntityID, list);
		int num = -1;
		long num2 = long.MaxValue;
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape mShape = list[i].mShape;
			if (mShape.IsEnable)
			{
				long num3 = MovementProcessor.SqrDistance(mShape.WorldPos, simEntity);
				if (num2 > num3)
				{
					num = i;
					num2 = num3;
				}
			}
		}
		simEntity.entityBlackboard.var.mAimTarget = aimEntityID;
		if (num >= 0)
		{
			simEntity.entityBlackboard.var.mAimTarget = list[num].mShape.OwnerID;
		}
		FrameListPool<EntityShape>.Release(list);
	}

	public static Int3 GetTargetDirection(SimEntity attacker, int ID)
	{
		Int3 result = attacker.entityPositon.mForward;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(ID);
		if (entityWithEntityID != null)
		{
			result = Int3.ProjectionToY(entityWithEntityID.entityPositon.mPosition - attacker.entityPositon.mPosition).NormalizeTo(1000);
		}
		return result;
	}

	public static bool GetCDReturn(EntityActionAbility ability, out int percent)
	{
		percent = 0;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(ability.mAbilityID);
		int abilityStateIndex = config.AbilityStateInfoList.get_Item(ability.mCurrentStateIndex).AbilityStateIndex;
		AbilityStageClass abilityStageClass = (AbilityStageClass)(abilityStateIndex % 100);
		if (abilityStageClass == AbilityStageClass.CastBackswing || abilityStageClass == AbilityStageClass.CastMoveswing)
		{
			return false;
		}
		long num = ability.mLogicTime;
		for (int i = 0; i < config.CDCompensationList.Count; i++)
		{
			CDCompensationInfo cDCompensationInfo = config.CDCompensationList.get_Item(i);
			if (num >= cDCompensationInfo.Start && num <= cDCompensationInfo.Start + cDCompensationInfo.Duration)
			{
				percent = config.CDCompensationList.get_Item(i).CDCompensation;
				return true;
			}
		}
		return false;
	}

	public static void ProcessAvoidShadow(SimEntity simEntity)
	{
		Int3 @int = simEntity.entityPositon.mPosition - simEntity.entityActionAvoidShadow.EarliestPosition;
		if (simEntity.FindChildrenTag(SimEntity.Tag.AvoidShadow, out var children))
		{
			@int /= (float)children.Count;
			for (int i = 0; i < children.Count; i++)
			{
				SimEntity simEntity2 = children[i];
				simEntity2.entityPositon.mPosition = simEntity.entityActionAvoidShadow.EarliestPosition + @int * i;
				simEntity2.entityShape.mShape.UpdateWorldShape(simEntity2.entityPositon.mPosition, simEntity.entityPositon.mForward);
			}
		}
		if (!simEntity.hasEntityActionAvoidShadow)
		{
			return;
		}
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		int num = IntMath.Divide(logicConstTick * simEntity.entityBlackboard.var.mEntityTimeScale, 100);
		simEntity.entityActionAvoidShadow.leftTime -= num;
		SimContext simContext = CommonProcessor.mSimContext;
		if (simEntity.entityActionAvoidShadow.leftTime <= 0)
		{
			simEntity.RemoveEntityActionAvoidShadow();
			if (simContext.GetSimInterface().mUltimateAvoidFrameEvent != null)
			{
				simContext.GetSimInterface().mUltimateAvoidFrameEvent(simEntity.creationIndex, 0, 0, UltimateAvoidFrameEventType.Exit);
			}
		}
		else if (simContext.GetSimInterface().mUltimateAvoidFrameEvent != null)
		{
			simContext.GetSimInterface().mUltimateAvoidFrameEvent(simEntity.creationIndex, simEntity.entityActionAvoidShadow.leftTime, 0, UltimateAvoidFrameEventType.Tick);
		}
	}

	public static void JumpToFrame(SimEntity simEntity, int frameIndex)
	{
		if (simEntity.hasEntityActionAbility && frameIndex > 0)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityActionAbility.mAbilityID);
			int num = frameIndex * CommonProcessor.GetConfigInterval();
			simEntity.entityActionAbility.mLogicTime = num;
			simEntity.entityActionAbility.mHitIndex = 0;
			for (int i = 0; i < config.HitTimeList.Count && num >= config.HitTimeList.get_Item(i).Start; i++)
			{
				simEntity.entityActionAbility.mHitIndex = i;
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2022, out var baseValue, out var _, out var _);
			simEntity.entityActionAbility.mEnableAbilityMovement = baseValue <= 0;
			simEntity.entityActionAbility.mLogicTime = num;
			simEntity.entityActionAbility.mCurrentStateIndex = 0;
			for (int j = 0; j < config.AbilityStateInfoList.Count && num >= config.AbilityStateInfoList.get_Item(j).Start; j++)
			{
				simEntity.entityActionAbility.mCurrentStateIndex = j;
			}
		}
	}

	public static AbilityStatueInfo GetAbilityStatueInfo(SimEntity simEntity, ButtonType button)
	{
		AbilityStatueInfo result = default(AbilityStatueInfo);
		int abilityByInput = GetAbilityByInput(simEntity, (int)button);
		if (abilityByInput == 0)
		{
			return result;
		}
		result.ID = abilityByInput;
		result.ButtonType = button;
		AttributeProcessor.TryGetEnergyChangeValue(simEntity, abilityByInput, out var energyChangeValue, out var _);
		result.Consume = energyChangeValue;
		result.Enable = AttributeProcessor.IsEnableAbility(simEntity, abilityByInput);
		if (button == ButtonType.AVOID)
		{
			if (simEntity.hasEntityUltimateAvoidCD)
			{
				result.CD = simEntity.entityUltimateAvoidCD.mRuntime;
				result.MaxCD = simEntity.entityBlackboard.var.mCharacterParamUltimateAvoidCD;
				result.ChargingCount = simEntity.entityUltimateAvoidCD.mLeftUseCount;
			}
			else
			{
				result.CD = 0;
				result.MaxCD = 1;
				result.ChargingCount = simEntity.entityBlackboard.var.mUltimateAvoidMaxUseCount;
			}
		}
		else
		{
			bool cD = CDProcessor.GetCD(simEntity, abilityByInput, out var abilityCD);
			if (cD & CDProcessor.GetMaxCDAndMaxUseCount(simEntity, abilityByInput, out var _, out var maxUseCount))
			{
				result.CD = abilityCD.CD;
				result.MaxCD = abilityCD.MaxCD;
				result.ChargingCount = maxUseCount - abilityCD.UsedCount;
			}
			else
			{
				result.CD = 0;
				result.MaxCD = 1;
				result.ChargingCount = 1;
			}
		}
		return result;
	}
}
