using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public static class HitReaction
{
	public static void Apply(ActionMemory memory, AttackData atkData, ActionHit config, int hitLevel, bool attackeeAtLeft, bool lastHavePosture, bool lastIsWeak)
	{
		FindTargetResult target = memory.target;
		Entity caster = memory.caster;
		HitReactionType reactionType = CalcHitReactionType(target, atkData, config, lastHavePosture, lastIsWeak, ref hitLevel);
		CmdHit hit = BuildCmdHit(memory, atkData, config, target, caster, reactionType, hitLevel, attackeeAtLeft, lastIsWeak, lastHavePosture);
		ApplyDeathHitOverride(target, config, ref hit, hitLevel);
		target.entity.GetHit(hit);
		ApplyBodyPartHit(target, caster, config);
	}

	private static HitReactionType CalcHitReactionType(FindTargetResult target, AttackData atkData, ActionHit config, bool lastHavePosture, bool lastIsWeak, ref int hitLevel)
	{
		CompAbility? compAbility = target.entity.GetCompAbility();
		bool isHavePosture = compAbility.IsHavePosture;
		bool isWeak = compAbility.IsWeak;
		int endureType = (int)atkData.endureType;
		int num = compAbility.endureLevel + ((!(!isHavePosture | isWeak)) ? 1 : 0);
		bool flag = endureType > num;
		bool flag2 = target.entity.IsSuperArmor();
		flag &= !flag2;
		if ((target.entity.GetConfig().postureType == PostureType.Multi) ? ((lastHavePosture && !lastIsWeak) & isWeak) : (lastHavePosture & isWeak))
		{
			flag = true;
			if (hitLevel < 1)
			{
				hitLevel = 1;
			}
		}
		if (config.InTag(HitTag.Roar))
		{
			flag = true;
		}
		if (!flag)
		{
			if (hitLevel <= 0)
			{
				return HitReactionType.None;
			}
			return HitReactionType.Light;
		}
		if (hitLevel <= 0)
		{
			return HitReactionType.Hit;
		}
		return HitReactionType.Full;
	}

	private static CmdHit BuildCmdHit(ActionMemory memory, AttackData atkData, ActionHit config, FindTargetResult target, Entity casterEb, HitReactionType reactionType, int hitLevel, bool attackeeAtLeft, bool lastIsWeak, bool lastHavePosture)
	{
		CmdHit hit = new CmdHit
		{
			hitReactionType = reactionType,
			isPostureHit = atkData.isPostureDamage,
			attackerIsMonster = casterEb.IsMonster(),
			hitType = (int)atkData.hitType,
			hitLevel = hitLevel,
			lastIsWeak = lastIsWeak,
			lastHavePosture = lastHavePosture,
			attackeeAtLeft = attackeeAtLeft
		};
		if (hit.attackeeAtLeft ^ !target.entity.IsFaceLeft())
		{
			hit.lockRotationNeedChangDir = true;
		}
		hit.attackerInAir = !target.entity.GetCompPhysics().isGrounded;
		hit.caster = memory.caster;
		hit.expressiveAngle = (int)config.hitExpressive;
		hit.dontChangeDir = config.dontChangeDir;
		hit.horizontalHitWallNum = (config.canHorizontalHitWall ? config.horizontalHitWallNum : 0);
		hit.verticalHitWallNum = (config.canVerticalHitWall ? config.verticalHitWallNum : 0);
		hit.hitEndureLevel = (int)atkData.endureType;
		hit.bodyIndex = target.bodyIndex;
		hit.groundprotection = target.entity.InTag(MotionTag_backUp.Groundprotection);
		hit.touchPos = target.TouchPos;
		hit.adjust1AttackTypeTag = config.adjust1AttackTypeTag;
		hit.adjust2AttackTypeTag = config.adjust2AttackTypeTag;
		hit.defaultFrameHalt = !config.noDefaultFrameHalt;
		if (config.lengthRandom)
		{
			hit.length = config.hitParameter.length * UnityEngine.Random.Range(GameLoader.meta.lengthRandomRange.x, GameLoader.meta.lengthRandomRange.y);
		}
		else
		{
			hit.length = config.hitParameter.length;
		}
		hit.angle = config.hitParameter.angle;
		hit.overrideSpeed = config.hitParameter.overrideSpeed;
		hit.hitBrakingDeceleration = config.hitParameter.hitBrakingDeceleration;
		hit.hitHorizontalFriction = config.hitParameter.hitHorizontalFriction;
		hit.upwardGravity = config.hitParameter.upwardGravity;
		hit.upwardFriction = config.hitParameter.upwardFriction;
		hit.downwardGravity = config.hitParameter.downwardGravity;
		hit.downwardMaxSpeed = config.hitParameter.downwardMaxSpeed;
		hit.downwardFriction = config.hitParameter.downwardFriction;
		ResolveDirectionAndSpeed(target.entity, ref hit);
		ResolveGlobalSpeedFx(target.entity, ref hit);
		return hit;
	}

	private static void ResolveDirectionAndSpeed(Entity attackee, ref CmdHit hit)
	{
		hit.globalSpeedConfigIndex = -1;
		if (hit.hitReactionType == HitReactionType.Full)
		{
			hit.hitBack = !(hit.changeDir = (attackee.IsBattleBehaveNotCharacter() ? ResolveMonsterChangeDir(attackee, ref hit) : ResolveCharacterChangeDir(attackee, in hit))) && hit.attackeeAtLeft == attackee.IsFaceLeft();
			float f = hit.angle * (MathF.PI / 180f);
			hit.hitSpeedX = hit.length * Mathf.Cos(f);
			hit.hitSpeedY = hit.length * Mathf.Sin(f);
		}
	}

	private static bool ResolveMonsterChangeDir(Entity attackee, ref CmdHit hit)
	{
		ConfigCharacter config = attackee.GetConfig();
		MonsterWeigtType monsterWeigtType = config.monsterWeigtType;
		bool flag = monsterWeigtType == MonsterWeigtType.Small || monsterWeigtType == MonsterWeigtType.Normal;
		if (hit.dontChangeDir)
		{
			flag = false;
		}
		if (((config.animationSchema == AnimationSchema.LockRotation) & flag) && hit.lockRotationNeedChangDir)
		{
			hit.needLockRotationChangeDirTrigger = true;
			flag = false;
		}
		if (config.animationSchema == AnimationSchema.LookAtCamera || config.animationSchema == AnimationSchema.CantTurn)
		{
			flag = false;
		}
		if (monsterWeigtType == MonsterWeigtType.Giant)
		{
			hit.length = 0f;
		}
		return flag;
	}

	private static bool ResolveCharacterChangeDir(Entity attackee, in CmdHit hit)
	{
		if (hit.dontChangeDir)
		{
			return false;
		}
		FaceDir faceDir = attackee.GetFaceDir();
		if (faceDir == FaceDir.Forward || faceDir == FaceDir.Back)
		{
			return true;
		}
		if (hit.hitLevel <= 1)
		{
			CmdHit cmdHit = hit;
			if (cmdHit.hitLevel == 1)
			{
				return cmdHit.attackerInAir;
			}
			return false;
		}
		return true;
	}

	private static void ResolveGlobalSpeedFx(Entity attackee, ref CmdHit hit)
	{
		if (!hit.attackerIsMonster || !hit.defaultFrameHalt || !attackee.IsCharacter() || GameLoader.meta.hitGlobalSpeed == null)
		{
			return;
		}
		switch (hit.hitReactionType)
		{
		case HitReactionType.Full:
		{
			List<HitGlobalSpeed> configs = GameLoader.meta.hitGlobalSpeed.configs;
			for (int i = 0; i < configs.Count; i++)
			{
				if (configs[i].type == (HitType)hit.hitType)
				{
					hit.globalSpeedConfigIndex = i;
					break;
				}
			}
			break;
		}
		case HitReactionType.Light:
			hit.globalSpeedUseSuperArmor = true;
			break;
		}
	}

	private static void ApplyDeathHitOverride(FindTargetResult target, ActionHit config, ref CmdHit hit, int hitLevel)
	{
		if (!target.entity.IsBattleBehaveNotCharacter())
		{
			return;
		}
		ConfigCharacter config2 = target.entity.GetConfig();
		MonsterWeigtType monsterWeigtType = config2.monsterWeigtType;
		if ((monsterWeigtType != MonsterWeigtType.Small && monsterWeigtType != MonsterWeigtType.Normal) || target.entity.GetCompAbility().hp > 0 || GameLoader.meta.configGroundLightDiePara == null)
		{
			return;
		}
		float length = config.hitParameter.length;
		List<GroundLightDieParaStruct> list = GameLoader.meta.configGroundLightDiePara.list;
		for (int i = 0; i < list.Count; i++)
		{
			if (length >= list[i].maxLength && !(list[i].hitParameter == null))
			{
				ConfigHitParameter hitParameter = list[i].hitParameter;
				hit.length = hitParameter.length * config2.dieForcceZoom;
				if (hitLevel < 2 || hit.angle < 0f)
				{
					hit.angle = 0f;
				}
				hit.overrideSpeed = hitParameter.overrideSpeed;
				hit.hitBrakingDeceleration = hitParameter.hitBrakingDeceleration;
				hit.hitHorizontalFriction = hitParameter.hitHorizontalFriction;
				hit.upwardGravity = hitParameter.upwardGravity;
				hit.upwardFriction = hitParameter.upwardFriction;
				hit.downwardGravity = hitParameter.downwardGravity;
				hit.downwardMaxSpeed = hitParameter.downwardMaxSpeed;
				hit.downwardFriction = hitParameter.downwardFriction;
				float f = hit.angle * (MathF.PI / 180f);
				hit.hitSpeedX = hit.length * Mathf.Cos(f);
				hit.hitSpeedY = hit.length * Mathf.Sin(f);
				break;
			}
		}
	}

	private static void ApplyBodyPartHit(FindTargetResult target, Entity casterEb, ActionHit config)
	{
		if (target.bodyIndex > 0)
		{
			CmdBodyPartHit hit = new CmdBodyPartHit
			{
				bodyIndex = target.bodyIndex,
				forceAngle = config.forceAngle,
				touchPos = target.TouchPos,
				attackerFaceLeft = casterEb.IsFaceLeft()
			};
			float[] ikStrength = GameLoader.meta.ikStrength;
			hit.hitStrength = (((int)config.hitType < ikStrength.Length) ? ikStrength[(int)config.hitType] : 1f);
			target.entity.BodyPartGetHit(hit);
		}
	}
}
