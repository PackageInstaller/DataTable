#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Reflection;

public class AdventureEffectFactory
{
	private static AdventureEffectFactory _instance;

	private static Dictionary<HotfixEnum.effectType, Type> _effectDict = new Dictionary<HotfixEnum.effectType, Type>
	{
		[HotfixEnum.effectType.STATE_CAHNGE] = typeof(StateChanged),
		[HotfixEnum.effectType.CURRENTCD] = typeof(CurrentSkillCDAmend),
		[HotfixEnum.effectType.CD] = typeof(SkillCDMaxAmend),
		[HotfixEnum.effectType.ADDBUFF] = typeof(AddBuffById),
		[HotfixEnum.effectType.ADD_SKILL_LV] = typeof(SkillLevelupAmend),
		[HotfixEnum.effectType.SET_SKILL_LV] = typeof(SkillLevelupTo),
		[HotfixEnum.effectType.IMM_BUFF] = typeof(ImmunityBuff),
		[HotfixEnum.effectType.ADDSKILLAMOUNT] = typeof(AddCurrentSkillAmount),
		[HotfixEnum.effectType.RESUMSKILLAMOUNT] = typeof(ResumSkillAmount),
		[HotfixEnum.effectType.ATTR_FIX] = typeof(BaseAttriFix),
		[HotfixEnum.effectType.REMOVE_BUFF] = typeof(RemoveBuff),
		[HotfixEnum.effectType.EFFECT_CD_FIX] = typeof(EffectCdFix),
		[HotfixEnum.effectType.EFFECT_MAX_CD_FIX] = typeof(EffectMaxCdFix),
		[HotfixEnum.effectType.AMEND_NO_COST] = typeof(AmendNoCostEffect),
		[HotfixEnum.effectType.DAMAGE_IMM_ACC] = typeof(DamageImmunityAcc),
		[HotfixEnum.effectType.EFFECT_MUL] = typeof(EffectMul),
		[HotfixEnum.effectType.EFFECT_HP_RECOVRY] = typeof(EffectHpRecovery),
		[HotfixEnum.effectType.KILL_IMMEDIATELY] = typeof(KillImmediately),
		[HotfixEnum.effectType.ADD_BUFF_DURATION_EXISTING] = typeof(AddBuffDuration),
		[HotfixEnum.effectType.HIT_ELEMENT_TYPE_EXTEND] = typeof(HitElementTypeExtend),
		[HotfixEnum.effectType.CHANGE_EFFECT_RATE] = typeof(ChangeEffectRate),
		[HotfixEnum.effectType.ADD_TAG] = typeof(AddTag),
		[HotfixEnum.effectType.EFFECT_HP_REVERTTO] = typeof(EffectHpRevertTo),
		[HotfixEnum.effectType.EFFECT_HP_ABSORB] = typeof(EffectHpAbsorb),
		[HotfixEnum.effectType.CHANGE_BUFF_LAMINATEDNUM] = typeof(ChangeBuffLaminatedNum),
		[HotfixEnum.effectType.CHANGE_BUFF_TIME] = typeof(ChangeBuffTime),
		[HotfixEnum.effectType.SPECIAL_ATTR_FIX] = typeof(SpecialAttrFix),
		[HotfixEnum.effectType.AMMO_FIX] = typeof(AmmoFix),
		[HotfixEnum.effectType.MONSTER_ATTR_FIX] = typeof(MonsterAttrFix),
		[HotfixEnum.effectType.PLAYER_ATTR_FIX] = typeof(PlayerAttrFix),
		[HotfixEnum.effectType.IMMUNE_DEAD] = typeof(ImmuneDead),
		[HotfixEnum.effectType.ENTER_TRANSPARENT] = typeof(EnterTransparent),
		[HotfixEnum.effectType.UNABLE_RECOVER_ENERGY] = typeof(UnableRecoverEnergy),
		[HotfixEnum.effectType.CLEAR_MONSTER_AI_BRANCH_CD] = typeof(ClearMonsterAiBranchCD),
		[HotfixEnum.effectType.ADD_SHIELD] = typeof(AddShield),
		[HotfixEnum.effectType.REDUCE_HP_BY_CURRENTHP] = typeof(EffectHpRecduceByCurrentHp),
		[HotfixEnum.effectType.REDUCE_HP_BY_MAXHP] = typeof(EffectHpRecduceByMaxHp),
		[HotfixEnum.effectType.HITTED_ADDITIONAL_ATTR_FIX] = typeof(HittedAdditionalAttriFix),
		[HotfixEnum.effectType.ATTR_ASSIGNMENT] = typeof(BaseAttriAssignment),
		[HotfixEnum.effectType.CAST_AREAEFFECT] = typeof(CastAreaEffect),
		[HotfixEnum.effectType.PASSIVE_SKILL] = typeof(CastPassiveSkill),
		[HotfixEnum.effectType.IMM_CERTAIN_HITDAMAGEID] = typeof(ImmuneCertainIdDamage),
		[HotfixEnum.effectType.STATE_AMOUNT] = typeof(EffectStateAmount),
		[HotfixEnum.effectType.DROP_ITEM_PICKUP_RANGE_FIX] = typeof(DropItemPickupRangeFix),
		[HotfixEnum.effectType.ELEMENTTYPE_ATTR_FIX] = typeof(ElementAttriFix),
		[HotfixEnum.effectType.DAMAGETYPE_ATTR_FIX] = typeof(DamageTypeAttriFix),
		[HotfixEnum.effectType.HITTED_ADDITIONAL_ELEMENTTYPE_ATTR_FIX] = typeof(HittedAdditionalElementTypeAttriFix),
		[HotfixEnum.effectType.HITTED_ADDITIONAL_DAMAGETYPE_ATTR_FIX] = typeof(HittedAdditionalDamageTypeAttriFix),
		[HotfixEnum.effectType.ELEMENTTYPE_ATTR_PERCENT_FIX] = typeof(ElementAttriPercentFix),
		[HotfixEnum.effectType.DAMAGETYPE_ATTR_PERCENT_FIX] = typeof(DamageTypeAttriPercentFix),
		[HotfixEnum.effectType.HITTED_ADDITIONAL_ELEMENTTYPE_ATTR_PERCENT_FIX] = typeof(HittedAdditionalElementTypeAttriPercentFix),
		[HotfixEnum.effectType.HITTED_ADDITIONAL_DAMAGETYPE_ATTR_PERCENT_FIX] = typeof(HittedAdditionalDamageTypeAttriPercentFix),
		[HotfixEnum.effectType.ELEMENTTYPE_ATTR_ASSIGNMENT] = typeof(ElementAttriAssignment),
		[HotfixEnum.effectType.DAMAGETYPE_ATTR_ASSIGNMENT] = typeof(DamageTypeAttriAssignment),
		[HotfixEnum.effectType.ELEMENTTYPE_ATTR_PERCENT_ASSIGNMENT] = typeof(ElementAttriPercentAssignment),
		[HotfixEnum.effectType.DAMAGETYPE_ATTR_PERCENT_ASSIGNMENT] = typeof(DamageTypeAttriPercentAssignment)
	};

	public static AdventureEffectFactory Instance
	{
		get
		{
			if (_instance != null)
			{
				return _instance;
			}
			_instance = new AdventureEffectFactory();
			return _instance;
		}
	}

	public AdventureEffectBase CreateAdventureEffect(HotfixEnum.effectType effectType)
	{
		if (_effectDict.TryGetValue(effectType, out var value))
		{
			return (AdventureEffectBase)Activator.CreateInstance(value);
		}
		NovaLogger.Error($"效果枚举 {effectType} 对应的效果实现没找到，需要先在效果枚举和效果实现之间建立映射，设置_effectDict。");
		return null;
	}

	private static void initEffectDict()
	{
		_effectDict = new Dictionary<HotfixEnum.effectType, Type>();
		Type[] types = Assembly.GetExecutingAssembly().GetTypes();
		Type typeFromHandle = typeof(AdventureEffectBase);
		foreach (Type type in types)
		{
			Type baseType = type.BaseType;
			if (baseType != null && baseType == typeFromHandle)
			{
				AdventureEffectAttribute attribute = getAttribute(type);
				if (attribute != null)
				{
					_effectDict.Add(attribute.EffectType, type);
				}
			}
		}
	}

	private static AdventureEffectAttribute getAttribute(Type type)
	{
		object[] customAttributes = type.GetCustomAttributes(typeof(AdventureEffectAttribute), inherit: true);
		if (customAttributes.Length == 0)
		{
			return null;
		}
		return customAttributes[0] as AdventureEffectAttribute;
	}
}
