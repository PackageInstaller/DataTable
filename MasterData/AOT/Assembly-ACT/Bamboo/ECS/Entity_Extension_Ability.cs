using ACT;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace Bamboo.ECS;

public static class Entity_Extension_Ability
{
	public static bool IsSuperArmor(this Entity entity)
	{
		if (entity.TryGetCompAbility(out CompAbility component))
		{
			Property property = component.GetProperty(101u);
			if (property == null || !(property.value > 0f))
			{
				return entity.InTag(MotionTag_backUp.SuperArmor);
			}
			return true;
		}
		return false;
	}

	public static bool CantBeAttack(this Entity entity)
	{
		if (!entity.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		Property property = component.GetProperty(100u);
		if ((property == null || !(property.value > 0f)) && !entity.InTag(EntityTag.IgnoreAttack) && !entity.InTag(MotionTag_backUp.Invincibility) && !entity.InTag(MotionTag_backUp.TrueInvincible) && !component.HasAbilityCustomTag("INVINCIBLE"))
		{
			return component.HasAbilityCustomTag("TRUEINVINCIBLE");
		}
		return true;
	}

	public static void Teleport(this Entity entity, Vector3 pos, bool testCollision = false)
	{
		CompTransform compTransform = entity.GetCompTransform();
		if (testCollision)
		{
			Vector3 physicsPosition = compTransform.physicsPosition;
			Vector3 direction = pos - physicsPosition;
			pos = (PhysicsUtility.CapsuleCast(compTransform.colliderPosition, compTransform.size, direction, direction.magnitude, out var hit) ? (physicsPosition + hit.distance * direction.normalized) : pos);
		}
		entity.GetRootTransform().position = pos;
		compTransform.SetPositionImmediately(pos);
	}

	public static void SetFaceDir(this Entity entity, FaceDir dir)
	{
		if (!entity.GetCompPhysics().ForbidDir)
		{
			CompTransform compTransform = entity.GetCompTransform();
			if (compTransform.FaceDir != dir)
			{
				entity.SetBool("FaceLeft", dir == FaceDir.Left);
				compTransform.FaceDir = dir;
			}
		}
	}

	private static void LightEffect(this Entity entity, CmdHit hit)
	{
		if (hit.adjust2AttackTypeTag.HasFlag(Adjust2AttackTypeTag.DotAttack))
		{
			return;
		}
		float duration = (entity.IsBattleBehaveNotCharacter() ? GameLoader.meta.getHitTime : GameLoader.meta.roleGetHitTime);
		MonoEntity mono = entity.GetMono();
		if (hit.bodyIndex > 0 && mono.bodyParts[hit.bodyIndex - 1].priority > 0)
		{
			byte priority = mono.bodyParts[hit.bodyIndex - 1].priority;
			if (priority <= 0)
			{
				return;
			}
			BodyPartPriorityHitEffect[] priorityHitEffect = mono.priorityHitEffect;
			for (int i = 0; i < priorityHitEffect.Length; i++)
			{
				BodyPartPriorityHitEffect bodyPartPriorityHitEffect = priorityHitEffect[i];
				if (priority == bodyPartPriorityHitEffect.priority)
				{
					mono.aniControl.ForwardPlay(bodyPartPriorityHitEffect.partType, duration, entity, null, reset: true);
					if (!string.IsNullOrEmpty(bodyPartPriorityHitEffect.trigger))
					{
						entity.SetTrigger(bodyPartPriorityHitEffect.trigger);
					}
				}
			}
		}
		else
		{
			mono.aniControl.ForwardPlay(hit.isPostureHit ? AniPartControl.PartType.LightHit : AniPartControl.PartType.GetHit, duration, entity, null, reset: true);
		}
	}

	public static void GetHit(this Entity entity, CmdHit hit)
	{
		UIEntityGetHitEvt evt = Singleton<EventManager>.instance.GetEvt<UIEntityGetHitEvt>();
		evt.cmdHit = hit;
		evt.uid = entity.Id;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_EntityGetHit, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		HitGlobalSpeedFx.Apply(entity, in hit);
		if (hit.hitReactionType == HitReactionType.Full)
		{
			entity.GetCompPhysics().GetHit(hit, hit.changeDir);
		}
		HitAnimatorParameters.Apply(entity, in hit);
		HitLightEffect.Play(entity, in hit);
		PostureHitEffectPlayer.Play(entity, in hit);
	}

	public static void GetCollisionHit(this Entity entity, CmdCollisionHit hit)
	{
		if (hit.bodyIndex <= 0)
		{
			return;
		}
		EffectPoint point = new EffectPoint
		{
			continueouslyFollow = false,
			rotateFollowLogicDir = false,
			useOwnerRot = false,
			oriRotX = 0f,
			oriRotY = ((!hit.attackerFaceLeft) ? 90 : 0),
			oriRotZ = 0f,
			aimTarget = false,
			useInitRotation = true,
			type = EffectPoint.EffectPointType.ConstPoint
		};
		Vector3 vector = new Vector3(0f, 0f, 0f);
		float y = vector.y;
		float x = (hit.attackerFaceLeft ? (0f - vector.x) : vector.x);
		bool flag = entity.IsFaceLeft();
		float enemyPostureEffectScale = entity.GetConfig().enemyPostureEffectScale;
		if (hit.attackerFaceLeft)
		{
			if (flag)
			{
				point.offset = new Vector3(x, y, 0f) + new Vector3(0.25f * enemyPostureEffectScale, 0f, 0f);
			}
			else
			{
				point.offset = new Vector3(x, y, 0f) + new Vector3(0.25f * enemyPostureEffectScale, 0f, 0f);
			}
		}
		else if (flag)
		{
			point.offset = new Vector3(x, y, 0f) + new Vector3(-0.25f * enemyPostureEffectScale, 0f, 0f);
		}
		else
		{
			point.offset = new Vector3(x, y, 0f) + new Vector3(-0.25f * enemyPostureEffectScale, 0f, 0f);
		}
		point.offset.z = vector.z;
		EffectPoint point2 = default;
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(entity),
			removeWhenMotionExit = false,
			timescale = TimeScale.NoScale,
			type = EffectDataType.Point,
			point1 = point,
			point2 = point2,
			removeWhenStop = false,
			changeScale = false,
			effectRangeEnum = EffectRangeEnum.none,
			transformScaleMulBase = Vector3.zero,
			isChangeWithEntity = false,
			initRotation = default,
			isAttach = false,
			xMirror = !hit.attackerFaceLeft,
			constPointPos = hit.touchPos
		};
		effectParams.patternAssetID = (hit.attackerFaceLeft ? GameLoader.meta.breakPostureActions.CollisionEffectR : GameLoader.meta.breakPostureActions.CollisionEffectL);
		GameManager.effectSystem.FireEffect(effectParams);
	}

	internal static void KillEntity(this Entity entity)
	{
		if (entity.GetCompAbility() == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"试图杀死没有CompAbility的Entitiy'{entity}'!!!!!!!!!!!!");
			}
		}
		else if (entity.GetCompAbility().zeroHpFeignedDie)
		{
			entity.HandleFeignedDie();
		}
		else
		{
			HandleDie(entity);
		}
	}

	private static void HandleFeignedDie(this Entity entity)
	{
		CompAbility compAbility = entity.GetCompAbility();
		if (!compAbility.feignedDie)
		{
			compAbility.feignedDie = true;
			CompAI compAI = entity.GetCompAI();
			CompInput compInput = entity.GetCompInput();
			CompMotion compMotion = entity.GetCompMotion();
			EntityType entityType = entity.GetEntityType();
			if (compAI.ActBehaviorTree != null)
			{
				compAI.ActBehaviorTree.Pause();
			}
			if (compInput != null)
			{
				compInput.dir = Vector2.zero;
			}
			switch (entityType)
			{
			case EntityType.Character:
			case EntityType.Monster:
			case EntityType.Boss:
			case EntityType.Elite:
			case EntityType.AssistNpc:
				compAbility.ServerSetTenacity(0);
				compAbility.ClearTimeAbility();
				compMotion.SetTrigger("FeignedDie");
				compMotion.SetBool("IsFeignedDie", b: true);
				entity.GetCompHatred().ClearHatred();
				Singleton<GroupAIManager>.instance.UnRegisterGroupAI(entity, compAI.groupUid);
				break;
			case EntityType.Robot:
			case EntityType.Trajectory:
			case EntityType.Npc:
			case EntityType.StateObject:
				break;
			}
		}
	}

	private static void HandleDie(Entity entity)
	{
		if (entity.IsAlive())
		{
			MonoECS instance = MonoECS.instance;
			CompAI compAI = entity.GetCompAI();
			(compAI?.ActBehaviorTree)?.Stop();
			CompInput compInput = entity.GetCompInput();
			if (compInput != null)
			{
				compInput.dir = Vector2.zero;
			}
			CompAbility compAbility = entity.GetCompAbility();
			compAbility.alive = false;
			compAbility.onDie.Invoke(entity);
			compAbility.onDie.Clear();
			compAbility.dieStartTime = GameManager.motionDieSystem.DeathLogicTime;
			EvtEntityDie evt = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<EvtEntityDie>(entity, null);
			evt.mainEntity = entity;
			evt.ownerEntity = entity;
			Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt);
			Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt);
			CompMotion compMotion = entity.GetCompMotion();
			CompHatred compHatred = entity.GetCompHatred();
			switch (entity.GetEntityType())
			{
			case EntityType.Character:
			{
				EntityDieEvt evt2 = Singleton<EventManager>.instance.GetEvt<EntityDieEvt>();
				evt2.entity = entity;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_EntityDie, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
				instance.SyncGameInfos();
				compAbility.ClearTimeAbility();
				compMotion.SetTrigger("Die");
				compMotion.SetBool("IsDead", b: true);
				break;
			}
			case EntityType.AssistNpc:
				compAbility.ClearTimeAbility();
				compMotion.SetTrigger("Die");
				compMotion.SetBool("IsDead", b: true);
				compHatred.ClearHatred();
				break;
			case EntityType.Boss:
			{
				CompTime? compTime = entity.GetCompTime();
				CompMonster compMonster = entity.GetCompMonster();
				int count = (int)Mathf.Round(compTime.lifeTime);
				Singleton<AchievementSyncBattleTypeManager>.instance.DispatchSyncFightType(compMonster.id, count, SyncBattleDataType.BossKillTime);
				goto case EntityType.Monster;
			}
			case EntityType.Monster:
			case EntityType.Elite:
			{
				compAbility.ServerSetTenacity(0);
				compAbility.ClearTimeAbility();
				compMotion.SetTrigger("Die");
				compMotion.SetBool("IsDead", b: true);
				compHatred.ClearHatred();
				EntityDieEvt evt3 = Singleton<EventManager>.instance.GetEvt<EntityDieEvt>();
				evt3.entity = entity;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MonsterDieCount, evt3);
				Singleton<EventManager>.instance.ReleaseEvt(evt3);
				Singleton<GroupAIManager>.instance.UnRegisterGroupAI(entity, compAI.groupUid);
				MonsterDieEvent evt4 = EventTrackSolver.Instance.GetEvt<MonsterDieEvent>();
				evt4.entity = entity;
				EventTrackSolver.Instance.Dispatch(evt4);
				break;
			}
			case EntityType.Trajectory:
				entity.GetCompTrajectory()?.trajectory?.HandleDie(entity);
				compAbility.ClearTimeAbility();
				break;
			case EntityType.StateObject:
				instance.TryRemoveBehave(entity);
				break;
			}
		}
	}
}
