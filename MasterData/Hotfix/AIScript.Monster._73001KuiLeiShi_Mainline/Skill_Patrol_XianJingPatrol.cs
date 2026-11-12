using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Patrol_XianJingPatrol : SkillSimpleBase
{
	private FP patrolRadius = 2.5;

	private FP repathInterval = 0.25;

	private FP moveStopDistance = 0.2;

	private FP patrolAngleStep = 75;

	private FP trapMatchDistance = 0.5;

	private const string combo_Charge = "Charge";

	private const string chargeWarningAlias = "fx_warning_dash_2x30";

	private FP chargeSpeed = 45;

	private FP chargeDistance = 20;

	private const string combo_JumpAttack = "JumpAttack";

	private const string jumpWarningAlias = "fx_warning_circular_2";

	private FP jumpTargetRandomRadius = 2;

	private FP jumpWarningTime = 1.7f;

	private const string combo_Whirlwind = "Whirlwind";

	private FP whirlwindInterval = 2;

	private FP whirlwindDuration = 3;

	private FP whirlwindWanderRadius = 4;

	private FP whirlwindTraceTriggerDist = 5;

	private FP whirlwindTraceStopDist = 3;

	private FP whirlwindSummonerMinDist = 8;

	private AdventureActor _trapActor;

	private TSVector2 _assignedAnchor;

	private bool _hasAssignedAnchor;

	private int _trapMonsterId;

	private FP _patrolAngle;

	private FP _whirlwindTimer;

	private int _summonLevel;

	private int _slowBuffId;

	private int _bindBuffId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetInvincibleEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_slowBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.slowBuffIds);
		_bindBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.bindBuffIds);
		_patrolAngle = GetRandomValue(0, 360);
		_assignedAnchor = new TSVector2(GetLogicTagFpValue(_actor, "ShuFuPatrolAnchorPosX"), GetLogicTagFpValue(_actor, "ShuFuPatrolAnchorPosY"));
		_hasAssignedAnchor = _assignedAnchor != TSVector2.zero;
		_trapMonsterId = (int)(long)GetLogicTagFpValue(_actor, "ShuFuTrapMonsterId");
		_trapActor = ResolveAssignedTrap();
		_whirlwindTimer = FP.Zero;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopMove();
		StopTrace();
		CancelAttack();
		_trapActor = null;
		_hasAssignedAnchor = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			_trapActor = ResolveAssignedTrap();
			if (_trapActor == null)
			{
				break;
			}
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			if (logicEntity != null)
			{
				if (GetBuffNum(logicEntity, _bindBuffId) > 0)
				{
					_whirlwindTimer = FP.Zero;
					yield return StartCor(DoJumpAttack(logicEntity));
					continue;
				}
				if (GetBuffNum(logicEntity, _slowBuffId) > 0)
				{
					_whirlwindTimer = FP.Zero;
					yield return StartCor(DoChargeAttack(logicEntity));
					continue;
				}
			}
			TSVector2 tSVector = (_hasAssignedAnchor ? _assignedAnchor : GetEntityPosition(_trapActor));
			_patrolAngle += patrolAngleStep;
			TSVector2 position = tSVector + RotateTo(TSVector2.up, _patrolAngle) * patrolRadius;
			MoveToPosition(position, moveStopDistance, AdventureActor.MovementMode.Run, repathInterval);
			yield return WaitTime(repathInterval);
			_whirlwindTimer += repathInterval;
			if (_whirlwindTimer >= whirlwindInterval)
			{
				_whirlwindTimer = FP.Zero;
				if (!IsTooCloseToSummoner())
				{
					yield return StartCor(DoWhirlwind());
				}
			}
		}
		_actor.DestroySelf();
	}

	private IEnumerator DoChargeAttack(LogicEntity target)
	{
		StopMove();
		TSVector2 chargeDir = GetEntityPosition(target) - GetPosition();
		if (chargeDir.magnitude <= FP.Zero)
		{
			chargeDir = GetForward();
		}
		chargeDir = chargeDir.normalized;
		Skill_Patrol_XianJingPatrol skill_Patrol_XianJingPatrol = this;
		TSVector2 position = GetPosition();
		FP angle = chargeDir.GetAngle();
		long warningId = skill_Patrol_XianJingPatrol.PlayEarlyWarningEffect("fx_warning_dash_2x30", 10f, default, position, angle);
		CoroutineNode followCor = StartCoroutine(FollowWarning(warningId));
		yield return BeginLookAtByDir(chargeDir, default, 5000);
		BeginAttack(1, "Charge", flushInputedKeys: true);
		yield return WaitCustomEvent("DashStart");
		StopEffect(warningId);
		StopCoroutine(followCor);
		BeginDash(1, chargeDir, chargeSpeed, chargeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoJumpAttack(LogicEntity target)
	{
		StopMove();
		Skill_Patrol_XianJingPatrol skill_Patrol_XianJingPatrol = this;
		TSVector2 entityPosition = GetEntityPosition(target);
		FP radius = jumpTargetRandomRadius;
		DeterministicShape shapeData = skill_Patrol_XianJingPatrol.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius);
		TSVector2 landPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos(landPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(landPos, landPos - GetPosition(), new TSVector2(0, 2.3));
		Skill_Patrol_XianJingPatrol skill_Patrol_XianJingPatrol2 = this;
		float duration = (float)jumpWarningTime;
		TSVector2 position = tSVector;
		skill_Patrol_XianJingPatrol2.PlayEarlyWarningEffect("fx_warning_circular_2", duration, default, position, default, 1.7f);
		BeginAttack(1, "JumpAttack", flushInputedKeys: true);
		yield return WaitCustomEvent("JumpStart");
		FP fP = Distance(GetPosition(), landPos);
		yield return CrossJump(landPos, fP / 0.4, 0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool IsTooCloseToSummoner()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (monsterAdventureActor == null || monsterAdventureActor.monsterSummonInfo == null)
		{
			return false;
		}
		AdventureActor summonActor = monsterAdventureActor.monsterSummonInfo.SummonActor;
		if (summonActor == null || summonActor.isDead)
		{
			return false;
		}
		return Distance(GetPosition(), GetEntityPosition(summonActor)) < whirlwindSummonerMinDist;
	}

	private IEnumerator DoWhirlwind()
	{
		StopMove();
		BeginAttack(2, "Whirlwind", flushInputedKeys: true);
		yield return WaitCustomEvent("StartTrace");
		FP endTime = LockStepManager.time + whirlwindDuration;
		FP traceTriggerSq = whirlwindTraceTriggerDist * whirlwindTraceTriggerDist;
		while (LockStepManager.time < endTime)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			bool flag = false;
			if (currentPlayer != null)
			{
				flag = TSVector2.DistanceSquared(GetPosition(), GetEntityPosition(currentPlayer)) <= traceTriggerSq;
			}
			if (flag)
			{
				BeginTrace(currentPlayer, whirlwindTraceStopDist, -1, 1);
				yield return WaitTraceFinish();
			}
			else
			{
				Skill_Patrol_XianJingPatrol skill_Patrol_XianJingPatrol = this;
				TSVector2 position = GetPosition();
				FP radius = whirlwindWanderRadius;
				DeterministicShape shapeData = skill_Patrol_XianJingPatrol.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				MoveToPosition(shapeRandomPoint, moveStopDistance, AdventureActor.MovementMode.Walk);
				yield return WaitMoveStatus();
			}
			yield return null;
		}
		CancelAttack();
		StopMove();
		StopTrace();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator FollowWarning(long warningId)
	{
		while (true)
		{
			ModifyEffectPosition(warningId, GetPosition());
			yield return null;
		}
	}

	private AdventureActor ResolveAssignedTrap()
	{
		if (!_hasAssignedAnchor || _trapMonsterId <= 0)
		{
			return FindNearestTrap();
		}
		List<LogicEntity> targetByDataID = GetTargetByDataID(_trapMonsterId);
		for (int i = 0; i < targetByDataID.Count; i++)
		{
			AdventureActor adventureActor = targetByDataID.get_Item(i) as AdventureActor;
			if (!(adventureActor == null) && !adventureActor.isDead && !adventureActor.inDying && !adventureActor.isDeclareDead && Distance(GetEntityPosition(adventureActor), _assignedAnchor) <= trapMatchDistance)
			{
				return adventureActor;
			}
		}
		return null;
	}

	private AdventureActor FindNearestTrap()
	{
		if (_trapMonsterId <= 0)
		{
			return null;
		}
		List<LogicEntity> targetByDataID = GetTargetByDataID(_trapMonsterId);
		AdventureActor adventureActor = null;
		FP fP = FP.MaxValue;
		TSVector2 position = GetPosition();
		for (int i = 0; i < targetByDataID.Count; i++)
		{
			AdventureActor adventureActor2 = targetByDataID.get_Item(i) as AdventureActor;
			if (!(adventureActor2 == null) && !adventureActor2.isDead && !adventureActor2.inDying && !adventureActor2.isDeclareDead)
			{
				FP fP2 = Distance(position, GetEntityPosition(adventureActor2));
				if (adventureActor == null || fP2 < fP)
				{
					adventureActor = adventureActor2;
					fP = fP2;
				}
			}
		}
		return adventureActor;
	}
}
