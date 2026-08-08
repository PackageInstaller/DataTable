using Config;
using Google.Protobuf.Collections;
using UnityEngine;

public class ConfigProcessor
{
	public static SimContext mSimContext;

	private static int ABILITY_STATUS_TIME_INDEX = 100;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	public static AbilityState GetAbilityState(SimEntity entity)
	{
		AbilityState result = default(AbilityState);
		result.detailClass = AbilityDetailClass.None;
		result.spaceClass = AbilitySpaceClass.None;
		result.stageClass = AbilityStageClass.None;
		if (entity != null)
		{
			int num = 0;
			int index = 0;
			if (entity.hasEntityActionAbility)
			{
				num = entity.entityActionAbility.mAbilityID;
				index = entity.entityActionAbility.mCurrentStateIndex;
			}
			else if (entity.hasEntityHitRecover)
			{
				num = entity.entityHitRecover.mHitRecoverActionID;
				index = entity.entityHitRecover.mCurrentStateIndex;
			}
			if (num == 0)
			{
				return result;
			}
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(num);
			int abilityStateIndex = config.AbilityStateInfoList.get_Item(index).AbilityStateIndex;
			result.stageClass = (AbilityStageClass)(abilityStateIndex % 100);
			abilityStateIndex /= 100;
			result.spaceClass = (AbilitySpaceClass)(abilityStateIndex % 100);
			abilityStateIndex /= 100;
			result.detailClass = (AbilityDetailClass)(abilityStateIndex % 100);
		}
		return result;
	}

	public static bool CanInterrupt(int interrupter, int beInterrupter, bool isSelf, out bool error)
	{
		error = false;
		interrupter = (isSelf ? (interrupter / ABILITY_STATUS_TIME_INDEX * ABILITY_STATUS_TIME_INDEX) : interrupter);
		interrupter = ConfigHelper.GetInstance().GetConfig<Auto_Generate_Ability_State_Index>(interrupter).GroupIndex;
		beInterrupter = ConfigHelper.GetInstance().GetConfig<Auto_Generate_Ability_State_Index>(beInterrupter).GroupIndex;
		int id = (interrupter << 16) | beInterrupter;
		if (!isSelf)
		{
			Auto_Generate_Interrupt_Other config = ConfigHelper.GetInstance().GetConfig<Auto_Generate_Interrupt_Other>(id);
			if (config == null)
			{
				Debug.LogError((object)$"to other Can't Find Interrupt Data By GroupID {interrupter} -> {beInterrupter}");
				error = true;
			}
			return config?.CanInterrupt ?? false;
		}
		Auto_Generate_Interrupt_Self config2 = ConfigHelper.GetInstance().GetConfig<Auto_Generate_Interrupt_Self>(id);
		if (config2 == null)
		{
			Debug.LogError((object)$"to self Can't Find Interrupt Data By GroupID {interrupter} -> {beInterrupter}");
			error = true;
		}
		return config2?.CanInterrupt ?? false;
	}

	public static bool IsMoveRecover(SimEntity entity)
	{
		return AbilityStageClass.CastMoveswing == GetAbilityState(entity).stageClass;
	}

	public static bool IsRecover(SimEntity entity)
	{
		return AbilityStageClass.CastBackswing == GetAbilityState(entity).stageClass;
	}

	public static bool IsTurnState(SimEntity entity)
	{
		return AbilityStageClass.CastTurn == GetAbilityState(entity).stageClass;
	}

	public static bool IsMoveTurnState(SimEntity entity)
	{
		return AbilityStageClass.CastMoveTurn == GetAbilityState(entity).stageClass;
	}

	public static bool IsMoveLockState(SimEntity entity)
	{
		return AbilityStageClass.CastMoveLock == GetAbilityState(entity).stageClass;
	}

	public static bool IsMoveLockStateBackwing(SimEntity entity)
	{
		return AbilityStageClass.CastMoveLockBackswing == GetAbilityState(entity).stageClass;
	}

	public static bool IsMoveUpdateLockState(SimEntity simEntity)
	{
		return AbilityStageClass.CastMoveUpdateLock == GetAbilityState(simEntity).stageClass;
	}

	public static bool IsAvoid(int abilityID)
	{
		int num = abilityID % 1000;
		if (305 != num)
		{
			return 306 == num;
		}
		return true;
	}

	public static int GetAvaoidCommonID(int abilityID)
	{
		return abilityID / 1000 * 1000 + 305;
	}

	public static bool AbilityHasLockTrack(int abilityID)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
		return config.LockAcionList.Count > 0;
	}

	public static bool TryGetSkillIndex(SimEntity simEntity, int abilityID, out int index)
	{
		index = -1;
		if (!simEntity.hasEntityBlackboard || !simEntity.hasEntityConfig)
		{
			return false;
		}
		for (int i = 0; i < simEntity.entityBlackboard.var.mAbilitySlots.Length; i++)
		{
			if (abilityID == simEntity.entityBlackboard.var.mAbilitySlots[i])
			{
				index = i;
				return true;
			}
		}
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(simEntity.ENTITY_CONFIG_ID);
		if (config == null)
		{
			return false;
		}
		for (int j = 0; j < config.Ability.Count; j++)
		{
			if (abilityID == config.Ability.get_Item(j))
			{
				index = j;
				return true;
			}
		}
		return false;
	}

	public static bool TryGetSkillIndex(SimEntity simEntity, int abilityID, out ButtonType index)
	{
		index = ButtonType.MELEE;
		int index2 = -1;
		if (TryGetSkillIndex(simEntity, abilityID, out index2))
		{
			index = (ButtonType)index2;
			return true;
		}
		return false;
	}

	public static bool TryGetParryingInfo(int abilityID, int logicTime, out ParryActionInfo pParryActionInfo, out Timeline timelineConfig)
	{
		pParryActionInfo = null;
		if (!ConfigHelper.GetInstance().TryGetConfig<Timeline>(abilityID, out timelineConfig))
		{
			return false;
		}
		if (timelineConfig.ParryActionInfoList == null || timelineConfig.ParryActionInfoList.Count <= 0)
		{
			return false;
		}
		RepeatedField<ParryActionInfo> parryActionInfoList = timelineConfig.ParryActionInfoList;
		int count = parryActionInfoList.Count;
		for (int i = 0; i < count; i++)
		{
			ParryActionInfo parryActionInfo = parryActionInfoList.get_Item(i);
			if (i == 0 && parryActionInfo.Start == 0 && logicTime == 0)
			{
				pParryActionInfo = parryActionInfo;
				return true;
			}
			if (logicTime > parryActionInfo.Start && logicTime <= parryActionInfo.Start + parryActionInfo.Duration)
			{
				pParryActionInfo = parryActionInfo;
				return true;
			}
			if (logicTime < parryActionInfo.Start)
			{
				return false;
			}
		}
		return false;
	}

	public static bool TryGetCDConfig(SimEntity simEntity, int skillID, out int cd, out int maxUseCount)
	{
		cd = 0;
		maxUseCount = 1;
		if (simEntity == null || !simEntity.hasEntityCD)
		{
			return false;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<public_strengthen_skill>(skillID, out var config) && CommonProcessor.HasStrengthenModule(simEntity.entityBlackboard.var.mAttributeID, config.Condition))
		{
			cd = config.Cd;
			maxUseCount = config.MaxUseCount;
			return true;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<public_skill>(skillID, out var config2))
		{
			cd = config2.Cd;
			maxUseCount = config2.MaxUseCount;
			return true;
		}
		return false;
	}

	public static bool TryGetSkillConsumeConfig(SimEntity simEntity, int skillID, out int energyChange)
	{
		energyChange = 0;
		if (simEntity == null)
		{
			return false;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<public_strengthen_skill>(skillID, out var config) && CommonProcessor.HasStrengthenModule(simEntity.entityBlackboard.var.mAttributeID, config.Condition))
		{
			energyChange = config.EnergyChange;
			return true;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<public_skill>(skillID, out var config2))
		{
			energyChange = config2.EnergyChange;
			return true;
		}
		return false;
	}

	public static HitHeight GetCurHitHeight(SimEntity entity)
	{
		if (entity == null)
		{
			return HitHeight.None;
		}
		int num = 0;
		int num2 = 0;
		if (entity.hasEntityActionAbility)
		{
			num = entity.entityActionAbility.mAbilityID;
			num2 = entity.entityActionAbility.mLogicTime;
		}
		else if (entity.hasEntityHitRecover)
		{
			num = entity.entityHitRecover.mHitRecoverActionID;
			num2 = entity.entityHitRecover.mHitRecoverTime;
		}
		else if (entity.hasEntityActionMoveDirection)
		{
			num = entity.entityActionMoveDirection.mMoveID;
			num2 = entity.entityActionMoveDirection.mLogicTime;
		}
		else if (entity.hasEntityBlackboard)
		{
			num = entity.entityBlackboard.var.mRunSlot;
		}
		if (num == 0)
		{
			return HitHeight.None;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(num);
		if (config == null || config.HitHeightInfoList == null)
		{
			return HitHeight.None;
		}
		HitHeight result = HitHeight.None;
		num2 %= config.Duration;
		for (int i = 0; i < config.HitHeightInfoList.Count; i++)
		{
			HitHeightInfo hitHeightInfo = config.HitHeightInfoList.get_Item(i);
			if (num2 >= hitHeightInfo.Start && num2 < hitHeightInfo.Start + hitHeightInfo.Duration)
			{
				result = (HitHeight)hitHeightInfo.State;
			}
		}
		return result;
	}
}
