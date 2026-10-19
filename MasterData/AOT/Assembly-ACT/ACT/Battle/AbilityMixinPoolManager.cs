using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public sealed class AbilityMixinPoolManager
{
	internal sealed class PoolBucket
	{
		internal readonly Stack<BaseAbilityMixin> available = new Stack<BaseAbilityMixin>(4);
	}

	internal readonly struct FenceScope : IDisposable
	{
		private readonly AbilityMixinPoolManager _manager;

		internal FenceScope(AbilityMixinPoolManager manager)
		{
			_manager = manager;
		}

		public void Dispose()
		{
			_manager.EndFence();
		}
	}

	private const int MaxPoolSizePerType = 32;

	private readonly Dictionary<Type, PoolBucket> _buckets = new Dictionary<Type, PoolBucket>();

	private readonly List<BaseAbilityMixin> _pendingRecycle = new List<BaseAbilityMixin>(32);

	private int _fenceDepth;

	private bool _isFlushing;

	public BaseAbilityMixin Rent(ConfigMixin config, Ability ability, byte index)
	{
		Type type = config.GetType();
		if (!IsPoolable(type))
		{
			return config.CreateInst(ability, index);
		}
		if (!_buckets.TryGetValue(type, out var value))
		{
			value = new PoolBucket();
			_buckets.Add(type, value);
		}
		BaseAbilityMixin baseAbilityMixin = ((value.available.Count <= 0) ? config.CreateInst(ability, index) : value.available.Pop());
		baseAbilityMixin.poolBucket = value;
		baseAbilityMixin.poolState = BaseAbilityMixin.PoolState.InUse;
		baseAbilityMixin.RebindForPool(config, ability, index);
		return baseAbilityMixin;
	}

	public void RequestReturn(BaseAbilityMixin mixin)
	{
		if (mixin != null && mixin.poolBucket != null && mixin.poolState != BaseAbilityMixin.PoolState.PendingRecycle && mixin.poolState != BaseAbilityMixin.PoolState.Available && mixin.poolState == BaseAbilityMixin.PoolState.InUse)
		{
			mixin.isActive = false;
			mixin.poolState = BaseAbilityMixin.PoolState.PendingRecycle;
			_pendingRecycle.Add(mixin);
		}
	}

	private void BeginFence()
	{
		_fenceDepth++;
	}

	internal FenceScope EnterFence()
	{
		BeginFence();
		return new FenceScope(this);
	}

	private void EndFence()
	{
		if (_fenceDepth > 0)
		{
			_fenceDepth--;
			if (_fenceDepth == 0)
			{
				FlushPending();
			}
		}
	}

	private void FlushPending()
	{
		if (_fenceDepth != 0 || _isFlushing || _pendingRecycle.Count == 0)
		{
			return;
		}
		_isFlushing = true;
		try
		{
			for (int i = 0; i < _pendingRecycle.Count; i++)
			{
				BaseAbilityMixin baseAbilityMixin = _pendingRecycle[i];
				if (baseAbilityMixin == null || baseAbilityMixin.poolState != BaseAbilityMixin.PoolState.PendingRecycle)
				{
					continue;
				}
				try
				{
					RecycleNow(baseAbilityMixin);
				}
				catch (Exception exception)
				{
					baseAbilityMixin.isActive = false;
					baseAbilityMixin.poolBucket = null;
					baseAbilityMixin.poolState = BaseAbilityMixin.PoolState.None;
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(exception);
					}
				}
			}
			_pendingRecycle.Clear();
		}
		finally
		{
			_isFlushing = false;
		}
	}

	public void Clear()
	{
		for (int i = 0; i < _pendingRecycle.Count; i++)
		{
			BaseAbilityMixin baseAbilityMixin = _pendingRecycle[i];
			if (baseAbilityMixin.poolState == BaseAbilityMixin.PoolState.PendingRecycle)
			{
				baseAbilityMixin.ResetForPool();
				baseAbilityMixin.poolBucket = null;
				baseAbilityMixin.poolState = BaseAbilityMixin.PoolState.None;
			}
		}
		_pendingRecycle.Clear();
		foreach (PoolBucket value in _buckets.Values)
		{
			value.available.Clear();
		}
		_buckets.Clear();
		_fenceDepth = 0;
		_isFlushing = false;
	}

	private void RecycleNow(BaseAbilityMixin mixin)
	{
		PoolBucket poolBucket = mixin.poolBucket;
		if (poolBucket != null && mixin.poolState == BaseAbilityMixin.PoolState.PendingRecycle)
		{
			mixin.ResetForPool();
			if (poolBucket.available.Count >= 32)
			{
				mixin.poolBucket = null;
				mixin.poolState = BaseAbilityMixin.PoolState.None;
			}
			else
			{
				mixin.poolState = BaseAbilityMixin.PoolState.Available;
				poolBucket.available.Push(mixin);
			}
		}
	}

	private static bool IsPoolable(Type configType)
	{
		if (!(configType == typeof(ConfigMixinAim)) && !(configType == typeof(ConfigMixinCarry)) && !(configType == typeof(ConfigMixinChangeCDModifier)) && !(configType == typeof(ConfigMixinConditionDamage)) && !(configType == typeof(ConfigMixinDamageModifier)) && !(configType == typeof(ConfigMixinDamageReductionEvt)) && !(configType == typeof(ConfigMixinDamageRequireSystemUnlock)) && !(configType == typeof(ConfigMixinAbilityLifetime)) && !(configType == typeof(ConfigMixinListenMotionChange)) && !(configType == typeof(ConfigMixinListenMotionTagChange)) && !(configType == typeof(ConfigMixinAccumulateDamage)) && !(configType == typeof(ConfigMixinBattleEntityAddBuff)) && !(configType == typeof(ConfigMixinBloodThunder)) && !(configType == typeof(ConfigMixinCountWeaponInput)) && !(configType == typeof(ConfigMixinCreateRandomPositions)) && !(configType == typeof(ConfigMixinDanmaku)) && !(configType == typeof(ConfigMixinDeflect)) && !(configType == typeof(ConfigMixinDamageRequireBreakableByBloodThunderPlatform)) && !(configType == typeof(ConfigMixinGetCurrentAttacker)) && !(configType == typeof(ConfigMixinHPAction)) && !(configType == typeof(ConfigMixinIgnoreEnvironmentCollisionTag)) && !(configType == typeof(ConfigMixinListenCustomEvt)) && !(configType == typeof(ConfigMixinListenEvt)) && !(configType == typeof(ConfigMixinLockHP)) && !(configType == typeof(ConfigMixinParry)) && !(configType == typeof(ConfigMixinSkillCountModifier)) && !(configType == typeof(ConfigMixinHatred)) && !(configType == typeof(ConfigMixinRecordHatred)) && !(configType == typeof(ConfigMixinPush)) && !(configType == typeof(ConfigMixinDetectCollision)) && !(configType == typeof(ConfigMixinFindTargetTrigger)) && !(configType == typeof(ConfigMixinDelayTime)) && !(configType == typeof(ConfigMixinFollowTarget)) && !(configType == typeof(CMFollowTargetAppendVelocity)) && !(configType == typeof(ConfigMixinSequence)) && !(configType == typeof(ConfigMixinTargetDelayQueue)) && !(configType == typeof(ConfigMixinSwitchSkillFindTarget)) && !(configType == typeof(ConfigMixinChangeSpeed)) && !(configType == typeof(ConfigMixinChangeGlobalSpeed)) && !(configType == typeof(ConfigMixinChangeMotionSpeed)) && !(configType == typeof(ConfigMixinGravity)) && !(configType == typeof(ConfigMixinRestrict)) && !(configType == typeof(ConfigMixinMovementRestrict)) && !(configType == typeof(ConfigMixinBlackViscousSwamp)) && !(configType == typeof(ConfigMixinCompensation)) && !(configType == typeof(ConfigMixinShield)) && !(configType == typeof(ConfigMixinHoldingShield)) && !(configType == typeof(ConfigMixinDamageCD)) && !(configType == typeof(ConfigMixinFreeze)) && !(configType == typeof(ConfigMixinContinueEffect)) && !(configType == typeof(ConfigMixinIntervalDoAction)) && !(configType == typeof(ConfigMixinMaterial)) && !(configType == typeof(ConfigMixinAuraField)) && !(configType == typeof(ConfigMixinDodge)) && !(configType == typeof(ConfigMixinSafeAreaEffect)) && !(configType == typeof(ConfigMixinIntervalDamage)) && !(configType == typeof(ConfigMixinListenChangeCharacter)) && !(configType == typeof(ConfigMixinSetBreakPointPos)) && !(configType == typeof(ConfigMixinSetSwitchSkillPos)) && !(configType == typeof(ConfigMixinUnilateral)) && !(configType == typeof(ConfigMixinSpotlightTrigger)) && !(configType == typeof(ConfigMixinTeamateTrigger)) && !(configType == typeof(ConfigMixinMatOverride)))
		{
			return configType == typeof(ConfigMixinElevatorRecall);
		}
		return true;
	}
}
