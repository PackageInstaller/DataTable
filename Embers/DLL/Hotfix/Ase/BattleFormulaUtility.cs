using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class BattleFormulaUtility
{
	public static DamageProgressBase GetDamageProgress(EntityType entityType, BuffDataDamage dataDamage)
	{
		if (dataDamage != null)
		{
			switch (entityType)
			{
			case EntityType.HERO:
				return ReferencePool.Acquire<HeroDamageProgress>();
			case EntityType.MONSTER:
				return ReferencePool.Acquire<MonsterDamageProgress>();
			case EntityType.INTERACTIVE:
				return ReferencePool.Acquire<InteractiveDamageProgress>();
			case EntityType.SummonedEntity:
				return ReferencePool.Acquire<SummonedDamageProgress>();
			}
		}
		return null;
	}

	public static CureProgressBase GetCureProgress()
	{
		return new CureProgressBase();
	}

	public static CureProgressBase GetCureProgressNonAlloc()
	{
		return ReferencePool.Acquire<CureProgressBase>();
	}

	public static void ReleaseCureProgress(CureProgressBase cureProgressBase)
	{
		ReferencePool.Release(cureProgressBase);
	}

	public static float GetProperty(BaseEntity entity, string propertyKey, PropertyType propertyType = PropertyType.Cur)
	{
		if (CheckSpecialProperty(propertyKey))
		{
			return GetSpecialPropertyAddition(entity, propertyKey, propertyType);
		}
		return GetNormalProperty(entity, propertyKey, propertyType);
	}

	public static float GetNormalProperty(BaseEntity entity, string propertyKey, PropertyType propertyType = PropertyType.Cur)
	{
		return propertyType switch
		{
			PropertyType.Cur => entity.GetProperty(propertyKey), 
			PropertyType.Max => entity.GetPropertyMax(propertyKey), 
			PropertyType.Init => entity.GetPropertyInit(propertyKey), 
			PropertyType.Min => entity.GetPropertyMin(propertyKey), 
			_ => 0f, 
		};
	}

	public static float GetPropertyAdditionDelta(BaseEntity entity, PropertyAdditionData data)
	{
		if (entity == null || data == null)
		{
			return 0f;
		}
		float result = 0f;
		float normalProperty = GetNormalProperty(entity, data.propertyKey, data.propertyType);
		if (data.operation == ChangeType.Set)
		{
			result = data.value - normalProperty;
		}
		else if (data.operation == ChangeType.Add || data.operation == ChangeType.Dec)
		{
			result = ((data.operation == ChangeType.Add) ? data.value : (0f - data.value));
		}
		else if (data.operation == ChangeType.Mul)
		{
			result = normalProperty * data.value - normalProperty;
		}
		return result;
	}

	public static bool CheckSpecialProperty(string propertyKey)
	{
		if (!(propertyKey == "Attack"))
		{
			return propertyKey == "Defence";
		}
		return true;
	}

	public static bool CheckSpecialPropertyRelevant(string propertyKey)
	{
		return propertyKey switch
		{
			"Attack" => true, 
			"AttackRadio" => true, 
			"FixAttack" => true, 
			"Defence" => true, 
			"DefenceRadio" => true, 
			"FixDefence" => true, 
			_ => false, 
		};
	}

	public static List<string> GetSpecialPropertyRelevantOther(string propertyKey)
	{
		return propertyKey switch
		{
			"Attack" => new List<string> { "AttackRadio", "FixAttack" }, 
			"AttackRadio" => new List<string> { "Attack", "FixAttack" }, 
			"FixAttack" => new List<string> { "Attack", "AttackRadio" }, 
			"Defence" => new List<string> { "DefenceRadio", "FixDefence" }, 
			"DefenceRadio" => new List<string> { "Defence", "FixDefence" }, 
			"FixDefence" => new List<string> { "Defence", "DefenceRadio" }, 
			_ => null, 
		};
	}

	public static float GetSpecialPropertyAddition(BaseEntity entity, string propertyKey, PropertyType propertyType = PropertyType.Cur)
	{
		string propertyKey2 = propertyKey + "Radio";
		string propertyKey3 = "Fix" + propertyKey;
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		switch (propertyType)
		{
		case PropertyType.Cur:
			num = entity.GetPropertyInit(propertyKey);
			num2 = entity.GetProperty(propertyKey2);
			num3 = entity.GetProperty(propertyKey3);
			break;
		case PropertyType.Init:
			return entity.GetPropertyInit(propertyKey);
		case PropertyType.Max:
			return entity.GetPropertyMax(propertyKey);
		case PropertyType.Min:
			return entity.GetPropertyMin(propertyKey);
		}
		return (num * num2 + num3).CeilToInt();
	}

	public static float GetSpecialPropertyAddition(ObservableDictionary<string, Ase.ECS.PropertyData> propertyDic, string propertyKey, PropertyType propertyType = PropertyType.Cur)
	{
		if (propertyDic == null || propertyDic.Count == 0)
		{
			return 0f;
		}
		string key = propertyKey + "Radio";
		string key2 = "Fix" + propertyKey;
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		switch (propertyType)
		{
		case PropertyType.Cur:
		{
			if (propertyDic.TryGetValue(propertyKey, out var value4))
			{
				num = value4.InitValue;
			}
			if (propertyDic.TryGetValue(key, out var value5))
			{
				num2 = value5.CurValue;
			}
			if (propertyDic.TryGetValue(key2, out var value6))
			{
				num3 = value6.CurValue;
			}
			break;
		}
		case PropertyType.Init:
		{
			if (propertyDic.TryGetValue(propertyKey, out var value2))
			{
				return value2.InitValue;
			}
			break;
		}
		case PropertyType.Max:
		{
			if (propertyDic.TryGetValue(propertyKey, out var value3))
			{
				return value3.MaxValue;
			}
			break;
		}
		case PropertyType.Min:
		{
			if (propertyDic.TryGetValue(propertyKey, out var value))
			{
				return value.MinValue;
			}
			break;
		}
		}
		return num * num2 + num3;
	}

	public static string GetElementAdditionPropertyKey(HeroAttributeEnum attributeEnum)
	{
		return attributeEnum switch
		{
			HeroAttributeEnum.Wind => "WindDamageRadio", 
			HeroAttributeEnum.Water => "WaterDamageRadio", 
			HeroAttributeEnum.Fire => "FireDamageRadio", 
			HeroAttributeEnum.Light => "LightDamageRadio", 
			HeroAttributeEnum.Dark => "DarkDamageRadio", 
			HeroAttributeEnum.Ice => "IceDamageRadio", 
			HeroAttributeEnum.Thunder => "ThunderDamageRadio", 
			HeroAttributeEnum.Rock => "RockDamageRadio", 
			HeroAttributeEnum.Dragon => "DragonDamageRadio", 
			_ => string.Empty, 
		};
	}

	public static string GetElementByRelation(HeroAttributeEnum damageTypeEnum)
	{
		return damageTypeEnum switch
		{
			HeroAttributeEnum.Light => "AmendByLight", 
			HeroAttributeEnum.Dark => "AmendByDark", 
			HeroAttributeEnum.Wind => "AmendByWind", 
			HeroAttributeEnum.Water => "AmendByWater", 
			HeroAttributeEnum.Fire => "AmendByFire", 
			HeroAttributeEnum.Ice => "AmendByIce", 
			HeroAttributeEnum.Thunder => "AmendByThunder", 
			HeroAttributeEnum.Rock => "AmendByRock", 
			HeroAttributeEnum.Dragon => "AmendByDragon", 
			_ => string.Empty, 
		};
	}

	public static string GetElementToRelation(HeroAttributeEnum damageTypeEnum)
	{
		return damageTypeEnum switch
		{
			HeroAttributeEnum.Light => "AmendToLight", 
			HeroAttributeEnum.Dark => "AmendToDark", 
			HeroAttributeEnum.Wind => "AmendToWind", 
			HeroAttributeEnum.Water => "AmendToWater", 
			HeroAttributeEnum.Fire => "AmendToFire", 
			HeroAttributeEnum.Ice => "AmendToIce", 
			HeroAttributeEnum.Thunder => "AmendToThunder", 
			HeroAttributeEnum.Rock => "AmendToRock", 
			HeroAttributeEnum.Dragon => "AmendToDragon", 
			_ => string.Empty, 
		};
	}

	public static float GetDamageBouns(DamageBonusTypeEnum damageBonusTypeEnum, string property, BuffDataDamage dataDamage, BaseEntity defender)
	{
		return damageBonusTypeEnum switch
		{
			DamageBonusTypeEnum.AttackCur => dataDamage.GetAttackerProperty(property), 
			DamageBonusTypeEnum.AttackMax => dataDamage.GetAttackerProperty(property, PropertyType.Max), 
			DamageBonusTypeEnum.AttackInit => dataDamage.GetAttackerProperty(property, PropertyType.Init), 
			DamageBonusTypeEnum.DefenderCur => GetProperty(defender, property), 
			DamageBonusTypeEnum.DefenderInit => GetProperty(defender, property, PropertyType.Init), 
			DamageBonusTypeEnum.DefenderMax => GetProperty(defender, property, PropertyType.Max), 
			_ => 0f, 
		};
	}

	public static string GetWeaponMechanismPropertyKey(WeaponEnum weaponEnum)
	{
		return weaponEnum switch
		{
			WeaponEnum.Sword => "SwordFrameAdditon", 
			WeaponEnum.Hammer => "HammerFrameAddition", 
			WeaponEnum.Bow => "BowFrameAddition", 
			WeaponEnum.Gloves => "GlovesFrameAddition", 
			WeaponEnum.Gun => "GunFrameAddition", 
			_ => string.Empty, 
		};
	}

	public static string GetWeaponDamageAdditionPropertyKey(WeaponEnum weaponEnum)
	{
		return weaponEnum switch
		{
			WeaponEnum.Sword => "SwordDamageAdditon", 
			WeaponEnum.Hammer => "HammerDamageAddition", 
			WeaponEnum.Bow => "BowDamageAddition", 
			WeaponEnum.Gloves => "GlovesDamageAddition", 
			WeaponEnum.Gun => "GunDamageAddition", 
			WeaponEnum.Lance => "LanceDamageAddition", 
			_ => string.Empty, 
		};
	}

	public static float HeroEnergyRecoverySpeed(BaseEntity heroEntity)
	{
		float property = heroEntity.GetProperty("EnergyRecoverySpeed");
		float property2 = heroEntity.GetProperty("EnergyRecoveryRatio");
		float propertyMax = heroEntity.GetPropertyMax("Energy");
		float property3 = heroEntity.GetProperty("BUFFEnergyRecoverySpeed");
		float property4 = heroEntity.GetProperty("ExtraEnergyRecover");
		bool entityBattleState = heroEntity.GetSystem<BattleStateSystem>().GetEntityBattleState(heroEntity);
		float num = 0f;
		float num2 = 0f;
		if (!entityBattleState)
		{
			num = heroEntity.GetProperty("OutCombatExtraEnergyRecover");
			num2 = heroEntity.GetProperty("OutCombatEnergyRecoveryRatio");
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"HeroEnergyRecoverySpeed : energyRecoverySpeed : {property}" + $"maxEnergy : {propertyMax} buffEnergyRecoverySpeed : {property3} " + $"extraEnergy : {property4} nonBattleRecover : {num}" + $"ocEnergyRecover : {num} ocEnergyRecoverRatio : {num2}", heroEntity);
		}
		return property * property2 * propertyMax * (1f + property3) + property4 + num * num2;
	}

	public static bool GetConstantConfigValue(int cfgId, out float value)
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(cfgId);
		if (dataRow == null)
		{
			value = 0f;
			return false;
		}
		value = dataRow.Value;
		return true;
	}

	public static PropertyAdditionData[] PropertyStringListToAddition(IList<string> list)
	{
		if (list == null || list.Count == 0)
		{
			return null;
		}
		if (list.Count % 2 == 0)
		{
			PropertyAdditionData[] array = new PropertyAdditionData[list.Count / 2];
			for (int i = 0; i < array.Length; i++)
			{
				string propertyKey = list[i * 2];
				float value = float.Parse(list[i * 2 + 1]);
				PropertyAdditionData propertyAdditionData = PropertyAdditionData.Create(propertyKey, value);
				array[i] = propertyAdditionData;
			}
			return array;
		}
		return null;
	}

	public static float DealMonsterAttackIncreaseAnger(float damage, BaseEntity monsterEntity, BaseEntity attackerEntity)
	{
		float num = 1f + attackerEntity.GetProperty("MonsterAngerExtraIncreaseScale");
		return monsterEntity.GetComponent<MonsterPhaseComponent>().GetMonsterStateAttackToAngerScale() * num * damage;
	}

	public static float DealMonsterAttackSubAnger(float damage, BaseEntity monsterEntity, BaseEntity attackerEntity)
	{
		float num = 1f + attackerEntity.GetProperty("MonsterAngerExtraSubScale");
		return monsterEntity.GetComponent<MonsterPhaseComponent>().GetMonsterStateAttackToAngerScale() * num * damage;
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void FormulaLog(BaseEntity trigger, ICollection<FormulaZoneDataBase> values, int result)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("公式结算最终结果:");
		foreach (FormulaZoneDataBase value in values)
		{
			if (value.isExcuteFormula)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance.WriteAuthorityEntityId(value.ToString(), trigger);
				}
				stringBuilder.Append($" * {value.FormulaDataName}:{value.result}");
			}
		}
		stringBuilder.Append($" = {result}");
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId(stringBuilder.ToString(), trigger);
		}
	}
}
