using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行攻击命中判定并结算伤害", "Action", new string[] { "hit", "damage", "attack" })]
public class ActionHit : ActionDamage
{
	public int damageId;

	public DynamicFloat energyRevert;

	[Tooltip("造成的受击程度类型（角色敌人交互物都要填）")]
	public HitType hitType;

	[Tooltip("攻击冲击力,用于和动作值比较")]
	public EndureType hitEndureType;

	public HitExpressive hitExpressive;

	public ConfigHitParameter hitParameter;

	[Space(20f)]
	[Tooltip("勾选后，水平的位移会随机的扩大或者缩小")]
	public bool lengthRandom;

	public bool ignoreDamage;

	public bool dontChangeDir;

	public ConfigFunction<Vector3> overrideHitOrigin;

	[Space(20f)]
	public bool canHorizontalHitWall;

	public int horizontalHitWallNum;

	public bool canVerticalHitWall;

	public int verticalHitWallNum;

	public ActionFireEffect hitEffect;

	public ActionCameraNoise cameraNoise;

	public ActionEnemyTraction carry;

	public ActionSound hitSound;

	public ActionFrameHalt attackeeFrameHalt;

	public ActionFrameHalt attackerFrameHalt;

	[Tooltip("仅怪打人生效")]
	public bool noDefaultFrameHalt;

	[Tooltip("使“Invincibility/TrueInvincibility”与“cantBeAttack”标签失效")]
	public bool forceHit;

	[HideInInspector]
	public float forceAngle;

	private void OnDamageIdChanged()
	{
		damageFormula.mulKey.source = ParamSource.CharacterSkillTable;
		damageFormula.mulKey.tableKey = "atk" + damageId;
		postureDamageFormula.mulKey.source = ParamSource.CharacterSkillTable;
		postureDamageFormula.mulKey.tableKey = "brk" + damageId;
		energyRevert.source = ParamSource.CharacterSkillTable;
		energyRevert.tableKey = "cha" + damageId;
		if (damageFormula.property == 0)
		{
			damageFormula.property = 2u;
		}
		if (damageFormula2.property == 0)
		{
			damageFormula2.property = 2u;
		}
		if (postureDamageFormula.property == 0)
		{
			postureDamageFormula.property = 2u;
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		base.CacheActionList(list, ab);
	}

	public override void Do(ActionMemory memory)
	{
		DoInternal(memory);
	}

	internal AttackResolveResult DoAndCollectResult(ActionMemory memory, MotionPrimaryTypeTag motionPrimaryTypeTag, MotionTypeTag motionTypeTag)
	{
		return DoInternal(memory, motionPrimaryTypeTag, motionTypeTag);
	}

	private AttackResolveResult DoInternal(ActionMemory memory, MotionPrimaryTypeTag motionPrimaryTypeTag = MotionPrimaryTypeTag.None, MotionTypeTag motionTypeTag = MotionTypeTag.None)
	{
		if (!memory.caster.IsValid)
		{
			return default;
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		if (memory.target.targetSourceType == FindTargetResult.TargetSourceType.Damageable)
		{
			AttackData attackData = abilitySystem.GetAttackData();
			attackData.motionPrimaryTypeTag = motionPrimaryTypeTag;
			attackData.motionTypeTag = motionTypeTag;
			DoDamage(memory, attackData);
			abilitySystem.ReleaseAttackData(attackData);
			return default;
		}
		Entity caster = memory.caster;
		FindTargetResult target = memory.target;
		HitResolveContext context = new HitResolveContext
		{
			memory = memory,
			hitResolveTag = hitResolveTag,
			forceHit = forceHit
		};
		if (!HitResolver.ResolvePreAttackEvent(context))
		{
			return default;
		}
		energyCharge = energyRevert.GetFloat(memory.ability);
		DamageEventHelper.FireAttackEvents(memory, caster, target, hitTag);
		if (!HitResolver.ResolvePostAttackEvent(context))
		{
			return default;
		}
		bool lastHavePosture = false;
		bool lastIsWeak = false;
		bool flag = false;
		CompAbility compAbility = target.entity.GetCompAbility();
		if (compAbility != null)
		{
			if (target.entity.IsBattleBehaveNotCharacter())
			{
				lastHavePosture = compAbility.posture > 0;
				lastIsWeak = compAbility.IsWeak;
			}
			flag = compAbility.HasAbilityTag(BuffTag.LockHp);
		}
		bool flag2 = CalcAttackeeAtLeft(memory, caster, target);
		AttackData attackData2 = abilitySystem.GetAttackData();
		attackData2.motionPrimaryTypeTag = motionPrimaryTypeTag;
		attackData2.motionTypeTag = motionTypeTag;
		attackData2.hitType = hitType;
		attackData2.endureType = hitEndureType;
		if (caster.IsCharacter())
		{
			attackData2.characterAttackDirFromLeft = flag2;
		}
		bool isParryOnlyBodyPart = target.IsParryOnlyBodyPart;
		bool flag3 = DoDamage(memory, attackData2);
		if (isParryOnlyBodyPart)
		{
			abilitySystem.ReleaseAttackData(attackData2);
			return new AttackResolveResult(isResolved: true, 0, causedDeath: false);
		}
		bool num = (flag3 || ignoreDamage) | flag;
		if (num)
		{
			TryFireDeflectEvent(abilitySystem, memory, attackData2);
		}
		int hitLevel = (target.entity.HasCompPhysics() ? ReduceHitByWeight(target.entity.GetConfig().monsterWeigtType, attackData2.hitType) : 0);
		if (num && target.entity.IsBehaveEntity())
		{
			HitReaction.Apply(memory, attackData2, this, hitLevel, flag2, lastHavePosture, lastIsWeak);
			HitFeedback.Play(memory, this, target);
		}
		ResourceRecovery.Process(memory, attackData2, this);
		AttackResolveResult result = new AttackResolveResult(isResolved: true, flag3 ? attackData2.actualDamage : 0, attackData2.causedDeath);
		abilitySystem.ReleaseAttackData(attackData2);
		return result;
	}

	private bool CalcAttackeeAtLeft(ActionMemory memory, Entity casterEb, FindTargetResult target)
	{
		float num;
		if (overrideHitOrigin != null)
		{
			num = overrideHitOrigin.Return(memory).x;
		}
		else
		{
			num = ((!memory.owner.IsValid) ? casterEb.GetCompTransform().physicsPosition.x : memory.owner.GetCompTransform().physicsPosition.x);
		}
		return num > target.entity.GetCompTransform().physicsPosition.x;
	}

	private static void TryFireDeflectEvent(SystemAbility systemAbility, ActionMemory memory, AttackData atkData)
	{
		if (atkData.attackee.GetAlliance() == Alliance.Enemy && atkData.attackee.InTag(MotionTag_backUp.CanBeDeflect) && atkData.adjust2AttackType.HasFlag(Adjust2AttackTypeTag.BreakImmunity))
		{
			EvtDeflectSuccess evt = systemAbility.GetEvt<EvtDeflectSuccess>(memory.caster, memory.ability);
			evt.mainEntity = memory.caster;
			evt.ownerEntity = memory.caster;
			evt.attackee = atkData.attackee;
			evt.attacker = memory.caster;
			systemAbility.FireEvt(evt);
			systemAbility.ReleaseEvt(evt);
		}
	}

	private int ReduceHitByWeight(MonsterWeigtType weigtType, HitType hitType)
	{
		switch (weigtType)
		{
		case MonsterWeigtType.Big:
		case MonsterWeigtType.Giant:
		case MonsterWeigtType.Middle:
			if (hitType > HitType.HitHeavy)
			{
				hitType = HitType.HitHeavy;
			}
			break;
		}
		return (int)hitType;
	}
}
