using System;
using ACT.Battle.Configs;
using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle;

public class AttackData
{
	public Entity attacker;

	public Entity directAttacker;

	public Entity attackee;

	public Element element;

	public bool isPostureDamage;

	public Adjust1AttackTypeTag adjust1AttackType;

	public Adjust2AttackTypeTag adjust2AttackType;

	public int bodyPart;

	public float damage;

	public float rawDamage;

	public float postureDamage;

	public float rawPostureDamage;

	public bool critical;

	public int hitEndureLevel;

	public int actualDamage;

	public int shieldMixinRemainingDamage;

	public int skillID;

	public int tenacity;

	public float attackerTenacityAtk;

	public float criticalPhaseAdd;

	public float basePhaseAdd;

	public float elementPhaseAdd;

	[Obsolete]
	public float anormalPhaseAdd;

	public float finalPhaseMul = 1f;

	public float DamageMulAdd;

	public float DamageMulVulnerableAdd;

	public float finalPhaseAdd;

	public float MannerPhaseAdd;

	public float criticalChance;

	public float criticalMul;

	public float criticalMulPhaseAdd;

	public float defPenetration;

	public float defPenetrationPhaseAdd;

	public float multiPosturePhase;

	public float weakPhaseAdd;

	public float postureBaseAdd;

	public float AddMultiPower;

	public float energyChargeAdd;

	public float energyChargeMul = 1f;

	public MannerType mannerType;

	public PostureDmgType postureDmgType;

	public HitTag hitTag;

	public HitType hitType;

	public EndureType endureType;

	public bool isWeakElement;

	public bool isWeakElementOverridden;

	public bool isStrongWeakElement;

	public bool isStrongWeakElementOverridden;

	public float partWeakPhaseAdd;

	public MotionPrimaryTypeTag motionPrimaryTypeTag;

	public MotionTypeTag motionTypeTag;

	public bool characterAttackDirFromLeft;

	public bool causedDeath;

	internal void Reset()
	{
		attacker = default;
		directAttacker = default;
		attackee = default;
		element = Element.Born;
		finalPhaseMul = 1f;
		AddMultiPower = 0f;
		elementPhaseAdd = 0f;
		basePhaseAdd = 0f;
		critical = false;
		hitEndureLevel = 0;
		attackerTenacityAtk = 0f;
		skillID = 0;
		bodyPart = 0;
		adjust1AttackType = Adjust1AttackTypeTag.Normally;
		adjust2AttackType = Adjust2AttackTypeTag.None;
		criticalPhaseAdd = 0f;
		postureDmgType = PostureDmgType.None;
		defPenetrationPhaseAdd = 0f;
		criticalMulPhaseAdd = 0f;
		multiPosturePhase = 0f;
		weakPhaseAdd = 0f;
		postureBaseAdd = 0f;
		hitTag = HitTag.None;
		hitType = HitType.None;
		energyChargeAdd = 0f;
		energyChargeMul = 1f;
		finalPhaseAdd = 0f;
		MannerPhaseAdd = 0f;
		postureDamage = 0f;
		rawDamage = 0f;
		rawPostureDamage = 0f;
		mannerType = MannerType.None;
		endureType = EndureType.None;
		isWeakElement = false;
		isWeakElementOverridden = false;
		isStrongWeakElement = false;
		isStrongWeakElementOverridden = false;
		partWeakPhaseAdd = 0f;
		motionPrimaryTypeTag = MotionPrimaryTypeTag.None;
		motionTypeTag = MotionTypeTag.None;
		characterAttackDirFromLeft = false;
		causedDeath = false;
		isPostureDamage = false;
	}
}
