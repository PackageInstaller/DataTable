using System;
using Config;
using Google.Protobuf.Collections;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("伤害公式(节点)", 0)]
[Category("Logic/Attribute")]
[Description("按formula公式的伤害计算")]
public class DamageFormula : FlowNode
{
	public static long GetFinalDamagePec(int abilityID, int hitIndex, int attributeID, int skillID)
	{
		int num = 0;
		long num2 = 0L;
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
		RepeatedField<int> hitDamagePec = config.HitDamagePec;
		RepeatedField<int> hitDamageGrp = config.HitDamageGrp;
		if (ConfigHelper.GetInstance().TryGetConfig<public_strengthen_skill>(abilityID, out var config2) && CommonProcessor.HasStrengthenModule(attributeID, config2.Condition))
		{
			hitDamagePec = config2.HitDamagePec;
			hitDamageGrp = config2.HitDamageGrp;
		}
		if (hitDamagePec.Count <= hitIndex)
		{
			Debug.LogError(abilityID + " 伤害倍率配置数量出错");
			return 0L;
		}
		long baseValue = 1L;
		num = config.SkillIndex - 1;
		if (config.SkillIndex != -1)
		{
			if (num == -1)
			{
				num = ConfigHelper.GetInstance().GetConfig<public_skill>(skillID).SkillIndex - 1;
			}
			if (num != -1)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeID, 2120 + num, out baseValue, out var _, out var _);
			}
		}
		num2 = hitDamagePec.get_Item(hitIndex) * 10;
		long num3 = 1000L;
		int cooperateUniqueSkillID = CommonProcessor.GetWorldState().m_CooperateUniqueSkillID;
		if (cooperateUniqueSkillID != 0 && ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(cooperateUniqueSkillID, out var config3))
		{
			int num4 = -1;
			for (int i = 0; i < config3.CooperateThrownIds.Count; i++)
			{
				if (config3.CooperateThrownIds.get_Item(i) == abilityID)
				{
					num4 = i;
					break;
				}
			}
			if (num4 != -1 && config3.HitDamagePercentGrp.Count > num4)
			{
				int cooperateUniqueSkillLevel = CommonProcessor.GetWorldState().m_CooperateUniqueSkillLevel;
				cooperateUniqueSkillLevel--;
				if (cooperateUniqueSkillLevel < 0)
				{
					cooperateUniqueSkillLevel = 0;
				}
				int num5 = config3.HitDamagePercentGrp.get_Item(num4) * cooperateUniqueSkillLevel * 10;
				int num6 = num5 / hitDamagePec.Count;
				if (num6 * hitDamagePec.Count < num5)
				{
					num6++;
				}
				num3 = (num6 + num2) * 1000 / num2;
			}
		}
		if (hitDamageGrp.Count != 0)
		{
			num2 = (baseValue - 1) * hitDamageGrp.get_Item(hitIndex) * 10 / 1000 + num2;
		}
		return num2 * num3 / 1000;
	}

	public static long GetFinalAttackValue(int attributeID)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 1, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 11, AttributeCalcType.Add);
		long finalAttributeByAttributeID3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 13, AttributeCalcType.Add);
		long finalAttributeByAttributeID4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 12, AttributeCalcType.Add);
		return finalAttributeByAttributeID * (1000 + finalAttributeByAttributeID2 + finalAttributeByAttributeID3) + finalAttributeByAttributeID4 * 1000;
	}

	public static long GetFinalCritRate(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 81, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 83, AttributeCalcType.Add);
		return finalAttributeByAttributeID - finalAttributeByAttributeID2;
	}

	public static long GetFinalCritDamagePercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long num = 1500L;
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 82, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 84, AttributeCalcType.Add);
		return num + finalAttributeByAttributeID - finalAttributeByAttributeID2;
	}

	public static long GetCharAttackRangeTypeDamagePercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2189, out var baseValue, out var _, out var _);
		if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>((int)baseValue, out var config))
		{
			return 0L;
		}
		int varName = 102;
		int varName2 = 112;
		if (config.RangeType == 0)
		{
			varName = 101;
			varName2 = 111;
		}
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, varName, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, varName2, AttributeCalcType.Add);
		return finalAttributeByAttributeID - finalAttributeByAttributeID2;
	}

	public static long GetElementDamagePercent(int abilityID, int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID).SkillDamageType;
		if (skillDamageType == SkillDamageType.Random)
		{
			AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2222, out var baseValue, out var _, out var _);
			skillDamageType = (SkillDamageType)baseValue;
		}
		int varName;
		int varName2;
		switch (skillDamageType)
		{
		case SkillDamageType.Physics:
			varName = 151;
			varName2 = 161;
			break;
		case SkillDamageType.Wind:
			varName = 152;
			varName2 = 162;
			break;
		case SkillDamageType.Fire:
			varName = 153;
			varName2 = 163;
			break;
		case SkillDamageType.Ice:
			varName = 154;
			varName2 = 164;
			break;
		case SkillDamageType.Water:
			varName = 155;
			varName2 = 165;
			break;
		case SkillDamageType.Dark:
			varName = 156;
			varName2 = 166;
			break;
		case SkillDamageType.Light:
			varName = 157;
			varName2 = 167;
			break;
		case SkillDamageType.Thunder:
			varName = 158;
			varName2 = 168;
			break;
		default:
			varName = 151;
			varName2 = 161;
			break;
		}
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, varName, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, varName2, AttributeCalcType.Add);
		long finalAttributeByAttributeID3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 159, AttributeCalcType.Add);
		long finalAttributeByAttributeID4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 169, AttributeCalcType.Add);
		return finalAttributeByAttributeID + finalAttributeByAttributeID3 - finalAttributeByAttributeID2 - finalAttributeByAttributeID4;
	}

	public static long GetExElementDamagePercent(int abilityID, int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID).SkillDamageType;
		if (skillDamageType == SkillDamageType.Random)
		{
			AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2222, out var baseValue, out var _, out var _);
			skillDamageType = (SkillDamageType)baseValue;
		}
		int varName;
		int varName2;
		switch (skillDamageType)
		{
		case SkillDamageType.Physics:
			varName = 171;
			varName2 = 181;
			break;
		case SkillDamageType.Wind:
			varName = 172;
			varName2 = 182;
			break;
		case SkillDamageType.Fire:
			varName = 173;
			varName2 = 183;
			break;
		case SkillDamageType.Ice:
			varName = 174;
			varName2 = 184;
			break;
		case SkillDamageType.Water:
			varName = 175;
			varName2 = 185;
			break;
		case SkillDamageType.Dark:
			varName = 176;
			varName2 = 186;
			break;
		case SkillDamageType.Light:
			varName = 177;
			varName2 = 187;
			break;
		case SkillDamageType.Thunder:
			varName = 178;
			varName2 = 188;
			break;
		default:
			varName = 171;
			varName2 = 181;
			break;
		}
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, varName, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, varName2, AttributeCalcType.Add);
		long finalAttributeByAttributeID3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 179, AttributeCalcType.Add);
		long finalAttributeByAttributeID4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 189, AttributeCalcType.Add);
		return finalAttributeByAttributeID + finalAttributeByAttributeID3 - finalAttributeByAttributeID2 - finalAttributeByAttributeID4;
	}

	public static long GetRaceDamagePercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2189, out var baseValue, out var plusValue, out var tempPlusValue);
		bool num = ConfigHelper.GetInstance().TryGetConfig<charactor_param>((int)baseValue, out var config);
		long num2 = 0L;
		if (num)
		{
			long num3 = 0L;
			long num4 = 0L;
			switch ((RaceType)config.RaceID)
			{
			case RaceType.RaceGreece:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 121, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 131, AttributeCalcType.Add);
				break;
			case RaceType.RaceEgypt:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 122, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 132, AttributeCalcType.Add);
				break;
			case RaceType.RaceJapan:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 123, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 133, AttributeCalcType.Add);
				break;
			case RaceType.RaceNorthernEurope:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 124, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 134, AttributeCalcType.Add);
				break;
			case RaceType.Other:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 125, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 135, AttributeCalcType.Add);
				break;
			case RaceType.RaceChina:
				num3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 126, AttributeCalcType.Add);
				num4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 136, AttributeCalcType.Add);
				break;
			}
			num2 = num3 - num4;
		}
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfTarget, 2189, out baseValue, out plusValue, out tempPlusValue);
		if (ConfigHelper.GetInstance().TryGetConfig<charactor_param>((int)baseValue, out config))
		{
			long num5 = 0L;
			long num6 = 0L;
			switch ((RaceType)config.RaceID)
			{
			case RaceType.RaceHuman:
				num5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 201, AttributeCalcType.Add);
				num6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 211, AttributeCalcType.Add);
				break;
			case RaceType.RaceMachine:
				num5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 202, AttributeCalcType.Add);
				num6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 212, AttributeCalcType.Add);
				break;
			case RaceType.RaceBug:
				num5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 203, AttributeCalcType.Add);
				num6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 213, AttributeCalcType.Add);
				break;
			case RaceType.RaceOtherEnemy:
				num5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 204, AttributeCalcType.Add);
				num6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 214, AttributeCalcType.Add);
				break;
			}
			num2 = num2 + num5 - num6;
		}
		return num2;
	}

	public static long GetAttackerRaceDamageReduction(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2189, out var baseValue, out var _, out var _);
		bool num = ConfigHelper.GetInstance().TryGetConfig<charactor_param>((int)baseValue, out var config);
		long result = 0L;
		if (num)
		{
			switch ((RaceType)config.RaceID)
			{
			case RaceType.RaceHuman:
				result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 511, AttributeCalcType.Add);
				break;
			case RaceType.RaceMachine:
				result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 512, AttributeCalcType.Add);
				break;
			case RaceType.RaceBug:
				result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 513, AttributeCalcType.Add);
				break;
			case RaceType.RaceOtherEnemy:
				result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 514, AttributeCalcType.Add);
				break;
			}
		}
		return result;
	}

	public static long GetMonsterTypeDamagePercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfTarget, 2009, out var baseValue, out var _, out var _);
		long num = 0L;
		long num2 = 0L;
		switch ((EnemyType)baseValue)
		{
		case EnemyType.MonsterElitel:
		case EnemyType.MonsterBoss:
			num = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 222, AttributeCalcType.Add);
			num2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 232, AttributeCalcType.Add);
			break;
		case EnemyType.MonsterNormal:
			num = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 221, AttributeCalcType.Add);
			num2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 231, AttributeCalcType.Add);
			break;
		}
		return num - num2;
	}

	public static long GetAttackerMonsterTypeDamageReduction(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2009, out var baseValue, out var _, out var _);
		long result = 0L;
		switch ((EnemyType)baseValue)
		{
		case EnemyType.MonsterElitel:
		case EnemyType.MonsterBoss:
			result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 522, AttributeCalcType.Add);
			break;
		case EnemyType.MonsterNormal:
			result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 521, AttributeCalcType.Add);
			break;
		}
		return result;
	}

	public static long GetCommonDamagePercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 401, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 402, AttributeCalcType.Add);
		long num = 0L;
		if (CommonProcessor.IsInSourceSpaceState())
		{
			num = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 421, AttributeCalcType.Add);
		}
		return finalAttributeByAttributeID + finalAttributeByAttributeID2 + num;
	}

	public static long GetSkillTypeDamagePercent(int ablityID, int skillID, int attributeIDOfAttacker)
	{
		long num = 0L;
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(ablityID);
		if (config.SkillType == 0)
		{
			config = ConfigHelper.GetInstance().GetConfig<public_skill>(skillID);
		}
		if ((config.SkillType & 4) != 0)
		{
			num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 303, AttributeCalcType.Add);
		}
		if ((config.SkillType & 2) != 0)
		{
			num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 302, AttributeCalcType.Add);
			AttributeProcessor.GetAttributeWithIntName(attributeIDOfAttacker, 2189, out var baseValue, out var _, out var _);
			if (ConfigHelper.GetInstance().TryGetConfig<charactor_param>((int)baseValue, out var config2))
			{
				switch ((EnergyType)config2.EnergyType)
				{
				case EnergyType.Rage:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 313, AttributeCalcType.Add);
					break;
				case EnergyType.Power:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 314, AttributeCalcType.Add);
					break;
				case EnergyType.Mark:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 311, AttributeCalcType.Add);
					break;
				case EnergyType.Unique:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 312, AttributeCalcType.Add);
					break;
				case EnergyType.Tune:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 321, AttributeCalcType.Add);
					break;
				}
			}
			if (ConfigHelper.GetInstance().TryGetConfig<public_skill>(skillID, out var config3))
			{
				switch ((SkillSubType)config3.SkillSubType)
				{
				case SkillSubType.Charge:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 315, AttributeCalcType.Add);
					break;
				case SkillSubType.Persist:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 317, AttributeCalcType.Add);
					break;
				case SkillSubType.Transfiguration:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 316, AttributeCalcType.Add);
					break;
				case SkillSubType.Strengthen:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 318, AttributeCalcType.Add);
					break;
				case SkillSubType.Switch:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 319, AttributeCalcType.Add);
					break;
				case SkillSubType.Prepare:
					num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 320, AttributeCalcType.Add);
					break;
				}
			}
		}
		if ((config.SkillType & 1) != 0)
		{
			num += AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 301, AttributeCalcType.Add);
		}
		return num;
	}

	public static long GetDefenseReductionPercent(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 2, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 21, AttributeCalcType.Add);
		long finalAttributeByAttributeID3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 25, AttributeCalcType.Add);
		finalAttributeByAttributeID3 = Math.Clamp(finalAttributeByAttributeID3, 0L, 1000L);
		long finalAttributeByAttributeID4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 22, AttributeCalcType.Add);
		long finalAttributeByAttributeID5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 24, AttributeCalcType.Add);
		finalAttributeByAttributeID5 = Math.Clamp(finalAttributeByAttributeID5, 0L, 1000L);
		long finalAttributeByAttributeID6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 23, AttributeCalcType.Add);
		long num = finalAttributeByAttributeID * (1000 + finalAttributeByAttributeID2) * (1000 - finalAttributeByAttributeID3) / 1000 * (1000 - finalAttributeByAttributeID5) / 1000 + (finalAttributeByAttributeID4 - finalAttributeByAttributeID6) * 1000;
		return 9 * num * 1000 / (10 * num + 40000000);
	}

	public static long GetCommonReductionPercent(int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 500, AttributeCalcType.SubMul);
		return 1000 - finalAttributeByAttributeID;
	}

	public static long GetSystemDamageBonus(int attributeIDOfAttacker)
	{
		return AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 600, AttributeCalcType.Add);
	}

	public static long GetSkillIBonus(int abilityID, int attributeID, int skillID)
	{
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
		int num = config.SkillIndex - 1;
		if (config.SkillIndex != -1 && num == -1)
		{
			num = ConfigHelper.GetInstance().GetConfig<public_skill>(skillID).SkillIndex - 1;
		}
		long result = 0L;
		if ((config.SkillType & 2) != 0 && num >= 1 && num <= 8)
		{
			result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 51 + num - 1, AttributeCalcType.Add);
		}
		return result;
	}

	public static long GetSkillIEXBonus(int abilityID, int attributeID, int skillID)
	{
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
		int skillIndex = config.SkillIndex;
		if (config.SkillIndex != -1 && skillIndex == 0)
		{
			skillIndex = ConfigHelper.GetInstance().GetConfig<public_skill>(skillID).SkillIndex;
		}
		long result = 0L;
		skillIndex--;
		if (skillIndex >= 0 && skillIndex <= 4)
		{
			result = AttributeProcessor.GetFinalAttributeByAttributeID(attributeID, 330 + skillIndex, AttributeCalcType.Add);
		}
		return result;
	}

	public static long CalAllDamageBonus(long damage, int attributeIDOfAttacker, int attributeIDOfTarget, int abilityID, int skillID)
	{
		long num = 1000L;
		if (DRandom.Random(1000u) < GetFinalCritRate(attributeIDOfAttacker, attributeIDOfTarget))
		{
			num = GetFinalCritDamagePercent(attributeIDOfAttacker, attributeIDOfTarget);
			AttributeProcessor.SetAttributeWithIntName(attributeIDOfAttacker, 2176, 2L, 0L, 0L);
		}
		long charAttackRangeTypeDamagePercent = GetCharAttackRangeTypeDamagePercent(attributeIDOfAttacker, attributeIDOfTarget);
		long elementDamagePercent = GetElementDamagePercent(abilityID, attributeIDOfAttacker, attributeIDOfTarget);
		long exElementDamagePercent = GetExElementDamagePercent(abilityID, attributeIDOfAttacker, attributeIDOfTarget);
		long raceDamagePercent = GetRaceDamagePercent(attributeIDOfAttacker, attributeIDOfTarget);
		long monsterTypeDamagePercent = GetMonsterTypeDamagePercent(attributeIDOfAttacker, attributeIDOfTarget);
		long commonDamagePercent = GetCommonDamagePercent(attributeIDOfAttacker, attributeIDOfTarget);
		long skillTypeDamagePercent = GetSkillTypeDamagePercent(abilityID, skillID, attributeIDOfAttacker);
		long defenseReductionPercent = GetDefenseReductionPercent(attributeIDOfAttacker, attributeIDOfTarget);
		long commonReductionPercent = GetCommonReductionPercent(attributeIDOfTarget);
		long systemDamageBonus = GetSystemDamageBonus(attributeIDOfAttacker);
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 4, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 5, AttributeCalcType.Add);
		long finalAttributeByAttributeID3 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 6, AttributeCalcType.Add);
		long finalAttributeByAttributeID4 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 7, AttributeCalcType.Add);
		long skillIBonus = GetSkillIBonus(abilityID, attributeIDOfAttacker, skillID);
		long skillIEXBonus = GetSkillIEXBonus(abilityID, attributeIDOfAttacker, skillID);
		long num2 = ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(damage) * num / 1000) * (1000 + skillIBonus) / 1000) * (1000 + charAttackRangeTypeDamagePercent) / 1000) * (1000 + elementDamagePercent) / 1000) * (1000 + exElementDamagePercent) / 1000) * (1000 + raceDamagePercent + monsterTypeDamagePercent + commonDamagePercent) / 1000) * (1000 + skillTypeDamagePercent) / 1000) * (1000 - defenseReductionPercent) / 1000) * (1000 - commonReductionPercent) / 1000) * (1000 + systemDamageBonus) / 1000) * (1000 + finalAttributeByAttributeID - finalAttributeByAttributeID2) / 1000);
		long finalAttributeByAttributeID5 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 450, AttributeCalcType.AddMul);
		long finalAttributeByAttributeID6 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 460, AttributeCalcType.AddMul);
		long finalAttributeByAttributeID7 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 701, AttributeCalcType.Add);
		long finalAttributeByAttributeID8 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 702, AttributeCalcType.Add);
		long finalAttributeByAttributeID9 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 703, AttributeCalcType.Add);
		long num3 = ClampPositive(ClampPositive(ClampPositive(ClampPositive(ClampPositive(num2 * finalAttributeByAttributeID5 / 1000) * finalAttributeByAttributeID6 / 1000) * (finalAttributeByAttributeID7 + 1000) / 1000) * (finalAttributeByAttributeID8 + 1000) / 1000) * (finalAttributeByAttributeID9 + 1000) / 1000);
		long attackerRaceDamageReduction = GetAttackerRaceDamageReduction(attributeIDOfAttacker, attributeIDOfTarget);
		long attackerMonsterTypeDamageReduction = GetAttackerMonsterTypeDamageReduction(attributeIDOfAttacker, attributeIDOfTarget);
		return GetResult(ClampPositive(ClampPositive(ClampPositive(ClampPositive(num3 * (1000 - attackerRaceDamageReduction) / 1000) * (1000 - attackerMonsterTypeDamageReduction) / 1000) + (finalAttributeByAttributeID3 - finalAttributeByAttributeID4) * 1000) * (1000 + skillIEXBonus) / 1000), 99L, 101L);
	}

	public static long CalcDamage(int abilityID, int skillID, int attributeIDOfAttacker, int attributeIDOfTarget, int hitIndex)
	{
		long finalAttackValue = GetFinalAttackValue(attributeIDOfAttacker);
		long finalDamagePec = GetFinalDamagePec(abilityID, hitIndex, attributeIDOfAttacker, skillID);
		long result = CalAllDamageBonus(ClampPositive(ClampPositive(finalAttackValue) * finalDamagePec / 1000), attributeIDOfAttacker, attributeIDOfTarget, abilityID, skillID);
		AttributeProcessor.ResetAttributeWithTemp(attributeIDOfAttacker);
		AttributeProcessor.ResetAttributeWithTemp(attributeIDOfTarget);
		return result;
	}

	public static long ClampPositive(long param)
	{
		if (param <= 0)
		{
			return 0L;
		}
		return param;
	}

	public static long GetResult(long baseAttackValue, long min = 99L, long max = 101L)
	{
		min *= baseAttackValue / 1000;
		max *= baseAttackValue / 1000;
		max += 100;
		if (max - min == 0L)
		{
			return 1L;
		}
		int num = (int)DRandom.Random((uint)(max - min));
		baseAttackValue = (min + num) / 100;
		baseAttackValue = IntMath.Max(1L, baseAttackValue);
		return baseAttackValue;
	}

	public static bool GetRootAbilityID(int abilityID, int thrownID, SimContext simContext, out int rootabilityID)
	{
		rootabilityID = abilityID;
		if (thrownID != 0)
		{
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(simContext, thrownID, out thrownState))
			{
				rootabilityID = thrownState.mCreatedRootTimelineID;
			}
		}
		bool flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(rootabilityID, out var config);
		if (flag)
		{
			if (config.OriginAbility != 0)
			{
				rootabilityID = config.OriginAbility;
			}
			else
			{
				flag = false;
			}
		}
		return flag;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> attackIDInput = AddValueInput<int>("攻击者ID");
		AddValueOutput("攻击者ID", () => attackIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		SkillDamageType skillDamageType = SkillDamageType.All;
		AddValueOutput("技能属性", () => skillDamageType);
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<int> hitIndexInput = AddValueInput<int>("HitIndex");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(attackIDInput.value);
			int attributeIDByEntityID2 = AttributeProcessor.GetAttributeIDByEntityID(targetIDInput.value);
			int value = abilityIDInput.value;
			int value2 = hitIndexInput.value;
			int value3 = thrownIDInput.value;
			GetRootAbilityID(value, value3, base.mSimContext, out var rootabilityID);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, 1L, 0L, 0L);
			int num = (int)CalcDamage(value, rootabilityID, attributeIDByEntityID, attributeIDByEntityID2, value2);
			int skillDamageType2 = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).SkillDamageType;
			skillDamageType = (SkillDamageType)skillDamageType2;
			if (skillDamageType == SkillDamageType.Random)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2222, out var baseValue, out var _, out var _);
				skillDamageType = (SkillDamageType)baseValue;
			}
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2175, num, 0L, 0L);
			f.Call(output);
		});
	}
}
