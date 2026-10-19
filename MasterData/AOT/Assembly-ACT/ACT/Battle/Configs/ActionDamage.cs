using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行伤害", "Action", new string[] { "damage", "hit", "attack" })]
public class ActionDamage : ConfigAction
{
	[Tooltip("只用于 HitResolver 的命中决策，不参与受击后业务效果判定")]
	public HitResolveTag hitResolveTag;

	[Tooltip("需要攻击盒在攻击判定中有一些额外的瞬间功能就在这启用，比如角色的某次攻击需要强制击飞小体型的敌人就可以在这里勾选强制击飞的tag")]
	public HitTag hitTag;

	[Tooltip("owner表示默认使用角色元素属性类型，比如bebe是雷属性，伤害默认是雷属性伤害")]
	public Element element;

	public Adjust1AttackTypeTag adjust1AttackTypeTag = Adjust1AttackTypeTag.Normally;

	public Adjust2AttackTypeTag adjust2AttackTypeTag;

	[Tooltip("破势类型用那个特效")]
	[HideInInspector]
	public PostureDmgType postureDmgType;

	public DamageFormula damageFormula;

	public bool enableDamageFormula2;

	public DamageFormula damageFormula2;

	public DamageFormula postureDamageFormula;

	public AddAssistValue addAssistValue;

	public ActionChangeNormalEnergy actionChangeNormalEnergy;

	public ActionChangeSpecialEnergy actionChangeSpecialEnergy;

	public DynamicFloat bulletAtk = new DynamicFloat
	{
		source = ParamSource.Const,
		value = 1f
	};

	public ConfigAction[] damaged;

	public ConfigAction[] undamaged;

	protected internal float energyCharge;

	[HideInInspector]
	[Obsolete]
	public ConfigFunction<float> attackAssistValue;

	public override FindTargetResult.TargetSourceType VaildTagetSourceTypeMask => FindTargetResult.TargetSourceType.All;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, damaged, ab);
		ConfigAbility.CacheActionList(list, undamaged, ab);
		List<ConfigAction> list2 = new List<ConfigAction>();
		if (addAssistValue != null)
		{
			list2.Add(addAssistValue);
		}
		if (actionChangeNormalEnergy != null)
		{
			list2.Add(actionChangeNormalEnergy);
		}
		if (actionChangeSpecialEnergy != null)
		{
			list2.Add(actionChangeSpecialEnergy);
		}
		ConfigAbility.CacheActionList(list, list2.ToArray(), ab);
	}

	public bool InTag(HitTag tag)
	{
		return (hitTag & tag) > HitTag.None;
	}

	protected bool DoDamage(ActionMemory memory, AttackData attackData)
	{
		if (memory.target.targetSourceType == FindTargetResult.TargetSourceType.Damageable)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("可破坏物收到伤害");
			}
			memory.target.damageable.OnDamage(memory);
			return true;
		}
		Ability ability = memory.ability;
		_ = memory.owner;
		FindTargetResult target = memory.target;
		if (!target.entity.HasCompAbility())
		{
			return false;
		}
		if (!memory.caster.IsValid)
		{
			return false;
		}
		Entity caster = memory.caster;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		InitAttackData(memory, attackData, caster);
		if (TryHandleParryOnlyBodyPart(memory, attackData, ability))
		{
			return false;
		}
		if (IsFixedDamageTarget(target))
		{
			CalcFixedDamage(memory, attackData, target, ability);
		}
		else
		{
			ApplyDamageModifiers(memory, attackData, caster, target, ability);
			if (caster.IsCollection())
			{
				if (attackData.attackee.InTag(EntityTag.IgnoreTrap))
				{
					return false;
				}
				CalcTrapDamage(caster, attackData);
			}
			else
			{
				DamagePhaseContext ctx = DamagePhaseContext.Build(memory, attackData, this);
				DamageCalc.Calculate(ref ctx);
			}
		}
		abilitySystem.ServerResolveDamage(attackData, ability);
		DamageEventHelper.FirePostDamageEvents(memory, attackData, ability, this);
		return attackData.actualDamage != 0;
	}

	private void InitAttackData(ActionMemory memory, AttackData attackData, Entity attacker)
	{
		CompAbility compAbility = attacker.GetCompAbility();
		attackData.attacker = attacker;
		attackData.directAttacker = memory.owner;
		attackData.attackee = memory.target.entity;
		attackData.bodyPart = memory.target.bodyIndex;
		attackData.adjust1AttackType = adjust1AttackTypeTag;
		attackData.adjust2AttackType = adjust2AttackTypeTag;
		attackData.hitTag = hitTag;
		int skillID = ((memory.ability != null) ? memory.ability.skillLevelInfo.id : 0);
		attackData.skillID = skillID;
		Element element = ((this.element == Element.Owner) ? compAbility.element : this.element);
		attackData.element = element;
		attackData.defPenetration = compAbility.DefPenetration;
		attackData.criticalChance = compAbility.criticalChance;
		attackData.criticalMul = compAbility.criticalMul;
		attackData.DamageMulAdd = compAbility.DamageMulAdd;
	}

	private static bool TryHandleParryOnlyBodyPart(ActionMemory memory, AttackData attackData, Ability ability)
	{
		if (!memory.target.IsParryOnlyBodyPart)
		{
			return false;
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtAttackeeParryCheck evt = abilitySystem.GetEvt<EvtAttackeeParryCheck>(memory.owner, ability);
		evt.mainEntity = memory.target.entity;
		evt.attackData = attackData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		return true;
	}

	private static bool IsFixedDamageTarget(FindTargetResult target)
	{
		if (target.entity.IsCollection() && target.entity.GetCompNeutral().GeyDamageCalType(target.entity) == 1)
		{
			return true;
		}
		if (target.entity.IsTrajectory())
		{
			return true;
		}
		return false;
	}

	private void CalcFixedDamage(ActionMemory memory, AttackData attackData, FindTargetResult target, Ability ability)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		Entity owner = memory.owner;
		if (target.entity.IsCollection())
		{
			int defenceTowerType = target.entity.GetCompNeutral().defenceTowerType;
			attackData.damage = ((defenceTowerType != 4 && defenceTowerType != 6) ? 1 : 0);
		}
		else
		{
			attackData.damage = 1f;
		}
		attackData.critical = false;
		EvtAttackeeModifyDamage evt = abilitySystem.GetEvt<EvtAttackeeModifyDamage>(owner, ability);
		evt.mainEntity = target.entity;
		evt.attackData = attackData;
		abilitySystem.FireDamageableEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		target.entity.GetCompAbility().ApplyAttackeeDamageModifiers(attackData, ability);
		attackData.damage *= attackData.finalPhaseMul;
	}

	private static void CalcTrapDamage(Entity attacker, AttackData attackData)
	{
		int trapType = attacker.GetCompNeutral().trapType;
		if (trapType == 0)
		{
			attackData.damage = 1f;
			return;
		}
		int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		attackData.damage = CoreUtils.GetData(trapType * 100 + curWorldLevel, RuntimeConfigs.data.traps)?.damage ?? 1;
		TrapInteractDamage evt = EventTrackSolver.Instance.GetEvt<TrapInteractDamage>();
		evt.attacker = attackData.attacker;
		evt.attackee = attackData.attackee;
		evt.attackData = attackData;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private static void ApplyDamageModifiers(ActionMemory memory, AttackData attackData, Entity attacker, FindTargetResult target, Ability ability)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		Entity owner = memory.owner;
		EvtModifyDamage evt = abilitySystem.GetEvt<EvtModifyDamage>(owner, ability);
		evt.mainEntity = attacker;
		evt.attackData = attackData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		EvtAttackeeModifyDamage evt2 = abilitySystem.GetEvt<EvtAttackeeModifyDamage>(owner, ability);
		evt2.mainEntity = target.entity;
		evt2.attackData = attackData;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
		attacker.GetCompAbility().ApplyAttackerDamageModifiers(attackData, ability);
		target.entity.GetCompAbility().ApplyAttackeeDamageModifiers(attackData, ability);
	}

	public override void Do(ActionMemory memory)
	{
		if (HitResolver.ResolveDamageEvent(new HitResolveContext
		{
			memory = memory,
			hitResolveTag = hitResolveTag
		}))
		{
			SystemAbility abilitySystem = GameManager.abilitySystem;
			AttackData attackData = abilitySystem.GetAttackData();
			DoDamage(memory, attackData);
			abilitySystem.ReleaseAttackData(attackData);
		}
	}

	internal static void ApplyAdjust1AttackTypeIncrease(AttackData attackData)
	{
		CompAbility compAbility = attackData.attacker.GetCompAbility();
		AttackData attackData2;
		float finalPhaseAdd = (attackData2 = attackData).finalPhaseAdd;
		attackData2.finalPhaseAdd = finalPhaseAdd + attackData.adjust1AttackType switch
		{
			Adjust1AttackTypeTag.Normally => compAbility.GetProperty(61u).value, 
			Adjust1AttackTypeTag.SpecialAttack => compAbility.GetProperty(62u).value, 
			Adjust1AttackTypeTag.UltraAttack => compAbility.GetProperty(63u).value, 
			Adjust1AttackTypeTag.SwitchSkill => compAbility.GetProperty(64u).value, 
			Adjust1AttackTypeTag.Trap => 0f, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	public static void ApplyAdjust2AttackTypeInCrease(AttackData attackData)
	{
		CompAbility compAbility = attackData.attacker.GetCompAbility();
		if (attackData.adjust2AttackType.HasFlag(Adjust2AttackTypeTag.AirAttack))
		{
			attackData.finalPhaseAdd += compAbility.GetProperty(68u).value;
		}
	}
}
