using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Patrol_GuangXian : SkillSimpleBase
{
	private int attackCount = 2;

	private FP attackInterval = 1;

	private FP moveStopDistance = 0.2;

	private const string combo_Charge = "Charge";

	private const string chargeWarningAlias = "fx_warning_dash_2x30";

	private FP chargeSpeed = 45;

	private FP chargeDistance = 20;

	private const string combo_JumpAttack = "JumpAttack";

	private const string jumpWarningAlias = "fx_warning_circular_2";

	private FP jumpTargetRandomRadius = 2;

	private FP jumpWarningTime = 1.7f;

	private const string combo_Shoot = "Shoot";

	private FP aimDuration = 0.8;

	private FP aimEndDelay = 0.7;

	private const string combo_SilkPierce = "SilkPierce";

	private FP silkPierceTurnTime = 0.5;

	private const string combo_Whirlwind = "Whirlwind";

	private FP whirlwindDuration = 5;

	private FP whirlwindWanderRadius = 4;

	private FP whirlwindTraceTriggerDist = 15;

	private FP whirlwindTraceStopDist = 3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopMove();
		StopTrace();
		CancelAttack();
	}

	protected override IEnumerator DoMainLogic()
	{
		for (int i = 0; i < attackCount; i++)
		{
			int num = TSRandom.Range(0, 4);
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			switch (num)
			{
			case 0:
				yield return StartCor(DoChargeAttack(logicEntity));
				break;
			case 1:
				yield return StartCor(DoJumpAttack(logicEntity));
				break;
			case 2:
				yield return StartCor(DoEnergyRing(logicEntity));
				break;
			default:
				yield return StartCor(DoSilkPierce(logicEntity));
				break;
			}
			yield return WaitTime(attackInterval);
		}
		_actor.DestroySelf();
	}

	private IEnumerator DoChargeAttack(LogicEntity target)
	{
		StopMove();
		TSVector2 chargeDir = ((target != null) ? (GetEntityPosition(target) - GetPosition()).normalized : GetForward());
		if (chargeDir.magnitude <= FP.Zero)
		{
			chargeDir = GetForward();
		}
		Skill_Patrol_GuangXian skill_Patrol_GuangXian = this;
		TSVector2 position = GetPosition();
		FP angle = chargeDir.GetAngle();
		long warningId = skill_Patrol_GuangXian.PlayEarlyWarningEffect("fx_warning_dash_2x30", 10f, default, position, angle);
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
		TSVector2 position = ((target != null) ? GetEntityPosition(target) : GetPosition());
		Skill_Patrol_GuangXian skill_Patrol_GuangXian = this;
		FP radius = jumpTargetRandomRadius;
		DeterministicShape shapeData = skill_Patrol_GuangXian.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		TSVector2 landPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos(landPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(landPos, landPos - GetPosition(), new TSVector2(0, 2.3));
		Skill_Patrol_GuangXian skill_Patrol_GuangXian2 = this;
		float duration = (float)jumpWarningTime;
		TSVector2 position2 = tSVector;
		skill_Patrol_GuangXian2.PlayEarlyWarningEffect("fx_warning_circular_2", duration, default, position2, default, 1.7f);
		BeginAttack(1, "JumpAttack", flushInputedKeys: true);
		yield return WaitCustomEvent("JumpStart");
		FP fP = Distance(GetPosition(), landPos);
		yield return CrossJump(landPos, fP / 0.4, 0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoEnergyRing(LogicEntity target)
	{
		BeginAttack(1, "Shoot", flushInputedKeys: true);
		yield return WaitCustomEvent("StartAim");
		AimAtTarget(target, 80);
		yield return WaitTime(aimDuration);
		CancelAim();
		yield return WaitTime(aimEndDelay);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoSilkPierce(LogicEntity target)
	{
		BeginLookAt_NotWait(target, silkPierceTurnTime, GetRotSpdInSkill());
		yield return WaitTime(silkPierceTurnTime);
		BeginAttack(1, "SilkPierce", flushInputedKeys: true);
		yield return WaitCustomEvent("StartAim");
		AimAtTarget(target, 80);
		yield return WaitTime(aimDuration);
		CancelAim();
		yield return WaitTime(aimEndDelay);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
			if (currentPlayer != null && TSVector2.DistanceSquared(GetPosition(), GetEntityPosition(currentPlayer)) <= traceTriggerSq)
			{
				BeginTrace(currentPlayer, whirlwindTraceStopDist, -1, 1);
				yield return WaitTraceFinish();
			}
			else
			{
				Skill_Patrol_GuangXian skill_Patrol_GuangXian = this;
				TSVector2 position = GetPosition();
				FP radius = whirlwindWanderRadius;
				DeterministicShape shapeData = skill_Patrol_GuangXian.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
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
}
