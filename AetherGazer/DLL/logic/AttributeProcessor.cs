using System.Collections.Generic;
using Config;
using Services;

public class AttributeProcessor
{
	public static SimContext mSimContext;

	public const int PRECISION = 1000;

	public static IRuntimeAttributeService mAttributeService;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
		mAttributeService = mSimContext.mService.mAttributeService;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
		mAttributeService = null;
	}

	public static bool SetAttributeWithIntName(int attributeID, int varName, long baseValue, long plusValue, long factor)
	{
		if (mAttributeService.TryGetAttribute(attributeID, out var attribute))
		{
			attribute.SetAttributeWithIntName(varName, baseValue, plusValue, factor);
			return true;
		}
		return false;
	}

	public static bool GetAttributeWithIntName(int attributeID, int varName, out long baseValue, out long plusValue, out long tempPlusValue)
	{
		baseValue = 0L;
		plusValue = 0L;
		tempPlusValue = 0L;
		if (mAttributeService.TryGetAttribute(attributeID, out var attribute))
		{
			return attribute.GetAttributeWithIntName(varName, out baseValue, out plusValue, out tempPlusValue);
		}
		return false;
	}

	public static void ResetAttributeWithTemp(int attributeID)
	{
		if (mAttributeService.TryGetAttribute(attributeID, out var attribute))
		{
			attribute.ResetTempAttributes();
		}
	}

	public static int GetAttributeIDByEntityID(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		int result = -1;
		if (entityWithEntityID == null)
		{
			result = (mAttributeService as RuntimeAttributeService).TryGetAttributeIDByEntityID(entityID);
		}
		else if (entityWithEntityID.hasEntityBlackboard)
		{
			result = entityWithEntityID.entityBlackboard.var.mAttributeID;
		}
		return result;
	}

	public static long GetFinalAttributeByAttributeID(int attributeID, int varName, AttributeCalcType calcType)
	{
		bool attributeWithIntName = GetAttributeWithIntName(attributeID, varName, out var baseValue, out var plusValue, out var tempPlusValue);
		long result = 0L;
		switch (calcType)
		{
		case AttributeCalcType.None:
			result = baseValue;
			break;
		case AttributeCalcType.Add:
			result = baseValue + plusValue + tempPlusValue;
			break;
		case AttributeCalcType.AddMul:
			result = (baseValue + 1000) * (1000 + plusValue + tempPlusValue) / 1000;
			break;
		case AttributeCalcType.SubMul:
			result = (1000 - baseValue) * (1000 - plusValue - tempPlusValue) / 1000;
			break;
		}
		return result;
	}

	public static bool UpdateMaxHp(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		int mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
		GetAttributeWithIntName(mAttributeID, 3, out var baseValue, out var _, out var _);
		long finalAttributeByAttributeID = GetFinalAttributeByAttributeID(mAttributeID, 31, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = GetFinalAttributeByAttributeID(mAttributeID, 32, AttributeCalcType.Add);
		long num = baseValue * (1000 + finalAttributeByAttributeID) + finalAttributeByAttributeID2 * 1000;
		long num2 = entityWithEntityID.entityBlackboard.var.mMaxHP;
		entityWithEntityID.entityBlackboard.var.mMaxHP = num / 1000;
		long mHP = entityWithEntityID.entityBlackboard.var.mHP;
		if (num2 == 0L)
		{
			num2 = baseValue;
		}
		if (num2 != 0L && mHP != 0L)
		{
			mHP = entityWithEntityID.entityBlackboard.var.mMaxHP * mHP / num2;
			mHP = IntMath.Clamp(mHP, 1L, entityWithEntityID.entityBlackboard.var.mMaxHP);
			entityWithEntityID.entityBlackboard.var.mHP = mHP;
		}
		else
		{
			entityWithEntityID.entityBlackboard.var.mHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
		}
		return true;
	}

	public static void CopyAttributeToOther(SimEntity entity, SimEntity other)
	{
		other.entityBlackboard.var.mAttributeID = entity.entityBlackboard.var.mAttributeID;
	}

	public static void DeepCopyAttributeToOther(SimEntity entity, SimEntity other)
	{
		bool flag = mAttributeService.TryGetAttribute(entity.entityBlackboard.var.mAttributeID, out var attribute);
		bool flag2 = mAttributeService.TryGetAttribute(other.entityBlackboard.var.mAttributeID, out var attribute2);
		if (flag & flag2)
		{
			Dictionary<int, EntityAttributeStruct> attr = attribute.GetAttr();
			Dictionary<int, EntityAttributeStruct> attr2 = attribute2.GetAttr();
			Dictionary<int, EntityAttributeStruct>.Enumerator enumerator = attr.GetEnumerator();
			while (enumerator.MoveNext())
			{
				attr2[enumerator.Current.Key] = enumerator.Current.Value;
			}
		}
	}

	public static int GetPowerValue(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return 0;
		}
		int mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
		GetAttributeWithIntName(mAttributeID, 2017, out var baseValue, out var _, out var _);
		return (int)baseValue;
	}

	public static bool AddPowerValue(int entityID, int maxValue, int delta, out int newValue, out int oldValue)
	{
		newValue = 0;
		oldValue = 0;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return false;
		}
		return TryAddPowerValue(entityWithEntityID, maxValue, delta, out newValue, out oldValue);
	}

	public static bool TryAddPowerValue(SimEntity simEntity, int maxValue, int delta, out int newValue, out int oldValue)
	{
		newValue = 0;
		oldValue = 0;
		if (!simEntity.hasEntityBlackboard)
		{
			return false;
		}
		int mAttributeID = simEntity.entityBlackboard.var.mAttributeID;
		SetAttributeWithIntName(mAttributeID, 2018, maxValue, 0L, 0L);
		TryAddPowerValue(simEntity, delta * 1000, out newValue, out oldValue);
		return true;
	}

	public static bool TryAddPowerValue(SimEntity simEntity, int delta, out int newValue, out int oldValue)
	{
		newValue = 0;
		oldValue = 0;
		if (!simEntity.hasEntityBlackboard || !simEntity.hasEntityConfig)
		{
			return false;
		}
		int mAttributeID = simEntity.entityBlackboard.var.mAttributeID;
		TryGetEnergyMaxValue(simEntity, out var maxValue);
		long plusValue = 0L;
		long tempPlusValue = 0L;
		GetAttributeWithIntName(mAttributeID, 2017, out var baseValue, out plusValue, out tempPlusValue);
		oldValue = (int)baseValue;
		long num = oldValue * 1000 + plusValue;
		newValue = (int)IntMath.Clamp(num + delta, 0L, maxValue * 1000);
		plusValue = newValue % 1000;
		newValue /= 1000;
		SetAttributeWithIntName(mAttributeID, 2017, newValue, plusValue, tempPlusValue);
		return true;
	}

	public static bool TryGetEnergyMaxValue(SimEntity simEntity, out int maxValue)
	{
		if (simEntity == null || !simEntity.hasEntityBlackboard || !simEntity.hasEntityConfig)
		{
			maxValue = 0;
			return false;
		}
		int mAttributeID = simEntity.entityBlackboard.var.mAttributeID;
		bool attributeWithIntName = GetAttributeWithIntName(mAttributeID, 2018, out var baseValue, out var _, out var _);
		maxValue = (int)baseValue;
		if (!attributeWithIntName)
		{
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(simEntity.entityConfig.mId);
			maxValue = config.EnergyMaxValue;
		}
		return true;
	}

	public static bool TryGetEnergyChangeValue(SimContext simContext, int entityID, int abilityID, out int energyChangeValue, out int fractionalPart)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			energyChangeValue = 0;
			fractionalPart = 0;
			return false;
		}
		return TryGetEnergyChangeValue(simEntity, abilityID, out energyChangeValue, out fractionalPart);
	}

	public static void CalcConsumeByAttribute(int currentValue, int attributeID, EnergyType energyType, out int energyChangeValue, out int fractionalPart)
	{
		if (energyType == EnergyType.None)
		{
			energyChangeValue = 0;
			fractionalPart = 0;
		}
		else if (currentValue < 0)
		{
			long num = 0L;
			long num2 = 0L;
			switch (energyType)
			{
			case EnergyType.Rage:
				num = 1000 - GetFinalAttributeByAttributeID(attributeID, 1109, AttributeCalcType.Add);
				num2 = GetFinalAttributeByAttributeID(attributeID, 1112, AttributeCalcType.Add);
				break;
			case EnergyType.Power:
				num = 1000 - GetFinalAttributeByAttributeID(attributeID, 1110, AttributeCalcType.Add);
				num2 = GetFinalAttributeByAttributeID(attributeID, 1113, AttributeCalcType.Add);
				break;
			case EnergyType.Unique:
				num = 1000 - GetFinalAttributeByAttributeID(attributeID, 1111, AttributeCalcType.Add);
				break;
			case EnergyType.Mark:
				num = 1000L;
				num2 = GetFinalAttributeByAttributeID(attributeID, 1114, AttributeCalcType.Add);
				break;
			case EnergyType.Tune:
				num = 1000 - GetFinalAttributeByAttributeID(attributeID, 1119, AttributeCalcType.Add);
				num2 = GetFinalAttributeByAttributeID(attributeID, 1121, AttributeCalcType.Add);
				break;
			}
			long num3 = currentValue;
			num3 = (num3 + num2) * num;
			if (num3 > 0)
			{
				num3 = 0L;
			}
			energyChangeValue = (int)num3 / 1000;
			fractionalPart = (int)num3 % 1000;
		}
		else if (currentValue > 0)
		{
			long num4 = 0L;
			long num5 = 0L;
			switch (energyType)
			{
			case EnergyType.Rage:
				num4 = GetFinalAttributeByAttributeID(attributeID, 1102, AttributeCalcType.Add) + 1000;
				num5 = GetFinalAttributeByAttributeID(attributeID, 1115, AttributeCalcType.Add);
				break;
			case EnergyType.Power:
				num4 = GetFinalAttributeByAttributeID(attributeID, 1103, AttributeCalcType.Add) + 1000;
				num5 = GetFinalAttributeByAttributeID(attributeID, 1116, AttributeCalcType.Add);
				break;
			case EnergyType.Unique:
				num4 = GetFinalAttributeByAttributeID(attributeID, 1104, AttributeCalcType.Add) + 1000;
				break;
			case EnergyType.Mark:
				num4 = 1000L;
				num5 = GetFinalAttributeByAttributeID(attributeID, 1117, AttributeCalcType.Add);
				break;
			case EnergyType.Tune:
				num4 = GetFinalAttributeByAttributeID(attributeID, 1118, AttributeCalcType.Add) + 1000;
				num5 = GetFinalAttributeByAttributeID(attributeID, 1120, AttributeCalcType.Add);
				break;
			}
			long num6 = currentValue;
			num6 = (num6 + num5) * num4;
			if (num6 < 0)
			{
				num6 = 0L;
			}
			energyChangeValue = (int)num6 / 1000;
			fractionalPart = (int)num6 % 1000;
		}
		else
		{
			energyChangeValue = 0;
			fractionalPart = 0;
		}
	}

	public static bool TryGetEnergyChangeValue(SimEntity simEntity, int abilityID, out int energyChangeValue, out int fractionalPart)
	{
		if (!simEntity.hasEntityBlackboard)
		{
			energyChangeValue = 0;
			fractionalPart = 0;
			return false;
		}
		Dictionary<int, AbilityConsume> mPublicSkillEntityChange = simEntity.entityBlackboard.var.mPublicSkillEntityChange;
		if (!mPublicSkillEntityChange.TryGetValue(abilityID, out var value))
		{
			ConfigProcessor.TryGetSkillConsumeConfig(simEntity, abilityID, out var energyChange);
			energyChangeValue = energyChange;
			value = (mPublicSkillEntityChange[abilityID] = new AbilityConsume
			{
				configValue = energyChangeValue,
				currentValue = energyChangeValue
			});
		}
		CalcConsumeByAttribute(value.currentValue, simEntity.entityBlackboard.var.mAttributeID, simEntity.entityBlackboard.var.mEnergyType, out energyChangeValue, out fractionalPart);
		return true;
	}

	public static bool TryModifyEnergyChangeValue(SimContext simContext, int entityID, int timelineID, int addValue, out int energyChangeValue)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			energyChangeValue = 0;
			return false;
		}
		Dictionary<int, AbilityConsume> mPublicSkillEntityChange = simEntity.entityBlackboard.var.mPublicSkillEntityChange;
		if (!mPublicSkillEntityChange.TryGetValue(timelineID, out var value))
		{
			ConfigProcessor.TryGetSkillConsumeConfig(simEntity, timelineID, out var energyChange);
			energyChangeValue = energyChange;
			value = new AbilityConsume
			{
				configValue = energyChangeValue,
				currentValue = energyChangeValue
			};
		}
		value.currentValue += addValue;
		mPublicSkillEntityChange[timelineID] = value;
		energyChangeValue = value.currentValue;
		return true;
	}

	public static bool TrySetEnergyChangeValue(SimContext simContext, int entityID, int timelineID, int newValue, out int energyChangeValue)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			energyChangeValue = 0;
			return false;
		}
		Dictionary<int, AbilityConsume> mPublicSkillEntityChange = simEntity.entityBlackboard.var.mPublicSkillEntityChange;
		if (!mPublicSkillEntityChange.TryGetValue(timelineID, out var value))
		{
			ConfigProcessor.TryGetSkillConsumeConfig(simEntity, timelineID, out var energyChange);
			energyChangeValue = energyChange;
			value = new AbilityConsume
			{
				configValue = energyChangeValue,
				currentValue = energyChangeValue
			};
		}
		value.currentValue = newValue;
		mPublicSkillEntityChange[timelineID] = value;
		energyChangeValue = value.currentValue;
		return true;
	}

	public static bool TryGetUltimateAvoidCD(SimContext simContext, int entityID, out int ultimateAvoidCD)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			ultimateAvoidCD = 0;
			return false;
		}
		ultimateAvoidCD = simEntity.entityBlackboard.var.mCharacterParamUltimateAvoidCD;
		return true;
	}

	public static bool TryModifyUltimateAvoidCD(SimContext simContext, int entityID, int addValue, out int ultimateAvoidCD)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			ultimateAvoidCD = 0;
			return false;
		}
		simEntity.entityBlackboard.var.mCharacterParamUltimateAvoidCD += addValue;
		ultimateAvoidCD = simEntity.entityBlackboard.var.mCharacterParamUltimateAvoidCD;
		return true;
	}

	public static bool TrySetUltimateAvoidCD(SimContext simContext, int entityID, int newValue, out int ultimateAvoidCD)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			ultimateAvoidCD = 0;
			return false;
		}
		ultimateAvoidCD = newValue;
		TrySetUltimateAvoidCD(simEntity, newValue);
		return true;
	}

	public static bool TrySetUltimateAvoidCD(SimEntity simEntity, int newValue)
	{
		if (!simEntity.hasEntityBlackboard)
		{
			return false;
		}
		simEntity.entityBlackboard.var.mCharacterParamUltimateAvoidCD = newValue;
		return true;
	}

	public static bool TryGetItemPickUpRadius(SimContext simContext, int entityID, out int itemPickUpRadius)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			itemPickUpRadius = -1;
			return false;
		}
		itemPickUpRadius = simEntity.entityBlackboard.var.mCharacterParamItemPickUpRadius;
		return true;
	}

	public static bool TryModifyItemPickUpRadius(SimContext simContext, int entityID, int addValue, out int itemPickUpRadius)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			itemPickUpRadius = -1;
			return false;
		}
		itemPickUpRadius = simEntity.entityBlackboard.var.mCharacterParamItemPickUpRadius + addValue;
		TrySetItemPickUpRadius(simEntity, itemPickUpRadius);
		return true;
	}

	public static bool TrySetItemPickUpRadius(SimContext simContext, int entityID, int newValue, out int itemPickUpRadius)
	{
		SimEntity simEntity = null;
		if (!CommonProcessor.TryGetEntityWithBlackboardByEntityID(simContext, entityID, out simEntity))
		{
			itemPickUpRadius = -1;
			return false;
		}
		itemPickUpRadius = newValue;
		TrySetItemPickUpRadius(simEntity, newValue);
		return true;
	}

	public static bool TrySetItemPickUpRadius(SimEntity simEntity, int newValue)
	{
		if (!simEntity.hasEntityBlackboard)
		{
			return false;
		}
		simEntity.entityBlackboard.var.mCharacterParamItemPickUpRadius = newValue;
		return true;
	}

	public static bool IsIgnoreHit(SimEntity simEntity)
	{
		if (simEntity == null || !simEntity.hasEntityBlackboard)
		{
			return false;
		}
		GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2020, out var baseValue, out var _, out var _);
		if (baseValue >= 1)
		{
			return true;
		}
		return false;
	}

	public static bool IsIgnoreHit(SimContext simContext, int entityID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
			return IsIgnoreHit(entityWithEntityID);
		}
		return false;
	}

	public static bool CanLockOfEntity(SimContext pSimContext, int pSimEntityID)
	{
		SimEntity entityWithEntityID = pSimContext.GetEntityWithEntityID(pSimEntityID);
		return CanLockOfEntity(entityWithEntityID);
	}

	public static bool CanLockOfEntity(SimEntity pSimEntity)
	{
		if (!CommonProcessor.IsAliveRole(pSimEntity))
		{
			return false;
		}
		GetAttributeWithIntName(pSimEntity.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var _, out var _);
		if (baseValue > 0)
		{
			return false;
		}
		return true;
	}

	public static bool IsEnableAbility(SimEntity entity, int ability)
	{
		if (entity == null || !entity.hasEntityBlackboard || ability == 0)
		{
			return false;
		}
		int powerValue = GetPowerValue(entity.creationIndex);
		TryGetEnergyChangeValue(entity, ability, out var energyChangeValue, out var _);
		if (powerValue + energyChangeValue < 0)
		{
			return false;
		}
		Dictionary<int, uint> mAbilityDisableFlag = entity.entityBlackboard.var.mAbilityDisableFlag;
		if (mAbilityDisableFlag.TryGetValue(ability, out var value) && value != 0)
		{
			return false;
		}
		Dictionary<int, int> mAbilityEnable = entity.entityBlackboard.var.mAbilityEnable;
		if (mAbilityEnable.TryGetValue(ability, out var value2))
		{
			return value2 <= 0;
		}
		if (entity.entityBlackboard.var.mIsBanMelee > 0 && entity.entityBlackboard.var.mMeleesSlots.Contains(ability))
		{
			return false;
		}
		return true;
	}
}
