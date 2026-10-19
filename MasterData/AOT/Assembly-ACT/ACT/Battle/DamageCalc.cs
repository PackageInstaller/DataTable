using ACT.Battle.Configs;
using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public static class DamageCalc
{
	public static void Calculate(ref DamagePhaseContext ctx)
	{
		if (!ctx.attackData.isWeakElementOverridden)
		{
			ctx.attackData.isWeakElement = ctx.attackee.IsWeakElement(ctx.attackData.element);
		}
		if (!ctx.attackData.isStrongWeakElementOverridden)
		{
			ctx.attackData.isStrongWeakElement = ctx.attackee.IsStrongWeakElement(ctx.attackData.element);
		}
		CalcBaseDamage(ref ctx);
		CalcCritical(ref ctx);
		CalcElement(ref ctx);
		CalcDefense(ref ctx);
		CalcAttackType(ref ctx);
		CalcManner(ref ctx);
		CalcFinalMultiplier(ref ctx);
		CalcPostureDamage(ref ctx);
		CalcEnemyState(ref ctx);
		Finalize(ref ctx);
	}

	private static void CalcBaseDamage(ref DamagePhaseContext ctx)
	{
		ctx.config.damageFormula.Cal(ctx.ability, ctx.attacker, ctx.attackee, out var p, out var m, out var constValue, out var l, ctx.memory);
		ctx.damageP = p;
		ctx.damageM = m;
		ctx.damageL = l;
		ctx.constValue = constValue;
		float num = p * (m + l * (float)ctx.attackerAb.level + ctx.attackData.AddMultiPower) + constValue;
		ctx.damageP2 = 0f;
		ctx.damageM2 = 0f;
		ctx.damageL2 = 0f;
		ctx.constValue2 = 0f;
		if (ctx.config.enableDamageFormula2)
		{
			ctx.config.damageFormula2.Cal(ctx.ability, ctx.attacker, ctx.attackee, out var p2, out var m2, out var constValue2, out var l2, ctx.memory);
			ctx.damageP2 = p2;
			ctx.damageM2 = m2;
			ctx.damageL2 = l2;
			ctx.constValue2 = constValue2;
			num += p2 * (m2 + l2 * (float)ctx.attackerAb.level + ctx.attackData.AddMultiPower) + constValue2;
		}
		ctx.attackData.damage = num + ctx.attackData.basePhaseAdd;
	}

	private static void CalcCritical(ref DamagePhaseContext ctx)
	{
		bool flag = ctx.config.adjust2AttackTypeTag.HasFlag(Adjust2AttackTypeTag.ForceCritical);
		bool flag2 = ctx.config.adjust2AttackTypeTag.HasFlag(Adjust2AttackTypeTag.NoneCritical);
		float num = ctx.attackData.criticalChance + ctx.attackData.criticalPhaseAdd;
		ctx.attackData.critical = flag || (!flag2 && Random.value <= num);
		ctx.critMul = 1f;
		if (ctx.attackData.critical)
		{
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtCriticalDamage evt = abilitySystem.GetEvt<EvtCriticalDamage>(ctx.memory.owner, ctx.ability);
			evt.mainEntity = ctx.attacker;
			evt.attackData = ctx.attackData;
			abilitySystem.FireEvt(evt);
			abilitySystem.ReleaseEvt(evt);
			float num2 = ctx.attackData.criticalMul + ctx.attackData.criticalMulPhaseAdd;
			ctx.critMul += num2;
		}
		ctx.attackData.damage *= ctx.critMul;
	}

	private static void CalcElement(ref DamagePhaseContext ctx)
	{
		float[] hitTypeParams = RuntimeConfigs.data.game.HitTypeParams;
		Element element = ctx.attackData.element;
		ctx.attackData.elementPhaseAdd += (ctx.attackData.isWeakElement ? hitTypeParams[1] : (ctx.attackData.isStrongWeakElement ? hitTypeParams[0] : 0f));
		ctx.eleDamage = ctx.attackerAb.GetElementDamage(element) + ctx.attackData.elementPhaseAdd + ctx.attackData.partWeakPhaseAdd;
		ctx.eleResist = ctx.attackeeAb.GetElementResist(element);
		ctx.attackData.damage *= 1f + ctx.eleDamage;
		ctx.attackData.damage *= 1f - ctx.eleResist;
	}

	private static void CalcDefense(ref DamagePhaseContext ctx)
	{
		int num = ctx.attackerAb.level * 5;
		float num2 = ctx.attackData.defPenetration + ctx.attackData.defPenetrationPhaseAdd;
		ctx.defMul = (float)(500 + num) / ((float)(500 + num) + ctx.attackeeAb.Def * (1f - num2));
		ctx.attackData.damage *= ctx.defMul;
	}

	private static void CalcAttackType(ref DamagePhaseContext ctx)
	{
		ActionDamage.ApplyAdjust1AttackTypeIncrease(ctx.attackData);
		ActionDamage.ApplyAdjust2AttackTypeInCrease(ctx.attackData);
	}

	private static void CalcManner(ref DamagePhaseContext ctx)
	{
		ctx.attackData.mannerType = GetAttackMannerType(ctx.attackerAb.mannerType, ctx.config.adjust2AttackTypeTag);
		ctx.mannerDmgIncrease = ctx.attacker.GetCompAbility().GetMannerTypeDamageIncrease(ctx.attackData.mannerType) + ((ctx.attackData.mannerType != MannerType.None) ? ctx.attackData.MannerPhaseAdd : 0f);
		ctx.attackData.damage *= 1f + ctx.mannerDmgIncrease;
	}

	private static void CalcFinalMultiplier(ref DamagePhaseContext ctx)
	{
		ctx.attackData.damage *= ctx.attackData.finalPhaseMul * (1f + ctx.attackData.finalPhaseAdd + ctx.attackData.DamageMulAdd + ctx.attackeeAb.Vulnerable - ctx.attackeeAb.DamageReductionMulAdd);
	}

	private static void CalcPostureDamage(ref DamagePhaseContext ctx)
	{
		if (!ctx.attackeeAb.IsWeak && ctx.attackee.IsBattleBehaveNotCharacter() && ctx.attackeeAb.IsHavePosture)
		{
			ctx.attackData.isPostureDamage = true;
			ctx.config.postureDamageFormula.Cal(ctx.ability, ctx.attacker, ctx.attackee, out var p, out var m, out var constValue, out var l, ctx.memory);
			float num = m + l * (float)ctx.attackerAb.level + ctx.attackData.postureBaseAdd;
			ctx.posDamageP = p;
			ctx.posMul1 = num;
			ctx.posConstValue = constValue;
			float num2 = p * num + constValue;
			float critMul = ctx.critMul;
			float num3 = 1f + ctx.eleDamage - ctx.eleResist;
			float defMul = ctx.defMul;
			float finalPhaseMul = ctx.attackData.finalPhaseMul;
			float num4 = 1f + ctx.attackData.finalPhaseAdd + ctx.attackData.DamageMulAdd + ctx.attackeeAb.Vulnerable;
			float num5 = 1f + ctx.attackerAb.postureDmgChar + ctx.attackData.multiPosturePhase;
			ctx.attackData.postureDamage = num2 * critMul * num3 * defMul * finalPhaseMul * num4 * num5;
			ctx.attackData.postureDmgType = ctx.config.postureDmgType;
		}
	}

	private static void CalcEnemyState(ref DamagePhaseContext ctx)
	{
		ctx.enemyStateFix = 1f;
		if (!ctx.attackeeAb.IsWeak && ctx.attackee.IsBattleBehaveNotCharacter() && ctx.attackeeAb.IsHavePosture)
		{
			ctx.enemyStateFix -= ctx.attackeeAb.postureDmgResistance;
		}
		if (ctx.attackeeAb.IsWeak)
		{
			ctx.enemyStateFix += ctx.attackee.GetConfig().postureDmgIncrease + ctx.attackerAb.WeakMul + ctx.attackData.weakPhaseAdd;
		}
		if (ctx.attackee.IsBattleBehaveNotCharacter())
		{
			if (!ctx.attackeeAb.IsHavePosture || ctx.attackeeAb.IsWeak)
			{
				ctx.enemyStateFix += ctx.attacker.GetCompAbility().GetCharacterDamageTypeDamageIncrease(CharacterDamageType.Striker);
			}
			if (ctx.attackeeAb.IsHavePosture && !ctx.attackeeAb.IsWeak)
			{
				ctx.enemyStateFix += ctx.attacker.GetCompAbility().GetCharacterDamageTypeDamageIncrease(CharacterDamageType.Breaker);
			}
		}
		ctx.attackData.damage *= ctx.enemyStateFix;
	}

	private static void Finalize(ref DamagePhaseContext ctx)
	{
		if (ctx.attackData.damage < 0f)
		{
			ctx.attackData.damage = 0f;
		}
		if (ctx.attackData.postureDamage < 0f)
		{
			ctx.attackData.postureDamage = 0f;
		}
		ctx.attackData.rawDamage = ctx.attackData.damage;
		ctx.attackData.rawPostureDamage = ctx.attackData.postureDamage;
		ctx.attackData.damage = Mathf.Ceil(ctx.attackData.damage);
		ctx.attackData.postureDamage = Mathf.Ceil(ctx.attackData.postureDamage);
	}

	private static MannerType GetAttackMannerType(MannerType attackerMannerType, Adjust2AttackTypeTag tag)
	{
		if ((tag & (Adjust2AttackTypeTag.BreakerManner | Adjust2AttackTypeTag.StrategistManner | Adjust2AttackTypeTag.GeneralistManner)) != 0)
		{
			return attackerMannerType;
		}
		return MannerType.None;
	}
}
