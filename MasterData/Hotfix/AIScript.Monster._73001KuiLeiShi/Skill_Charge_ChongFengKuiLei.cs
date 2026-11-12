using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Charge_ChongFengKuiLei : SkillSimpleBase
{
	private const string combo_Charge = "Charge";

	private const string warningAlias = "fx_warning_square_3side_2_5x30";

	private FP dashSpeed = 45;

	private FP dashDistance = 20;

	private FP wanderRadius = 10;

	private FP wanderRadiusInn = 8;

	private FP turnTime = 0.3;

	private FP damageImmuneDuration = 0.1;

	private TSVector2 _chargeDir;

	private FP wanderStopDistance = 0.2;

	private CoroutineNode AimCor;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: false);
		StopCor(AimCor);
		StopMove();
		CancelAim();
	}

	private IEnumerator KeepAiming()
	{
		LogicEntity Target = GetAttackTarget();
		AimAtTarget(Target, 120);
		while (true)
		{
			if (!CheckTargetIsValid(Target))
			{
				InterruptSkill();
			}
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				CancelAim();
				yield return BeginLookAt(Target, 0, 300);
				AimAtTarget(Target, 120);
			}
			yield return null;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		_chargeDir = GetEntityPosition(logicEntity) - GetPosition();
		if (_chargeDir.magnitude <= 0)
		{
			_chargeDir = GetForward();
		}
		_chargeDir = _chargeDir.normalized;
		float duration = 3f;
		Skill_Charge_ChongFengKuiLei skill_Charge_ChongFengKuiLei = this;
		TSVector2 position = GetPosition();
		FP angle = _chargeDir.GetAngle();
		long warningId = skill_Charge_ChongFengKuiLei.PlayEarlyWarningEffect("fx_warning_square_3side_2_5x30", duration, default, position, angle, 0.9f);
		CoroutineNode followCor = StartCoroutine(FollowWarning(warningId));
		Skill_Charge_ChongFengKuiLei skill_Charge_ChongFengKuiLei2 = this;
		TSVector2 position2 = GetPosition();
		angle = wanderRadius;
		FP innerRadius = wanderRadiusInn;
		DeterministicShape shapeData = skill_Charge_ChongFengKuiLei2.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, angle, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		StartCor(ref AimCor, KeepAiming());
		MoveToPosition(shapeRandomPoint, wanderStopDistance);
		while (_actor.movementState == ActorState.Move && !GetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag))
		{
			yield return null;
		}
		StopMove();
		StopCor(AimCor);
		while (!GetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag))
		{
			yield return null;
		}
		yield return BeginLookAtByDir(_chargeDir, default, 5000);
		BeginAttack(1, "Charge", flushInputedKeys: true);
		yield return WaitCustomEvent("DashStart");
		StopEffect(warningId);
		StopCoroutine(followCor);
		BeginDash(1, _chargeDir, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitTime(0.3);
		BeginLookAt_NotWait(GetAttackTarget(), 0.3, 600);
		yield return WaitTime(0.3);
		Skill_Charge_ChongFengKuiLei skill_Charge_ChongFengKuiLei3 = this;
		position = GetPosition();
		innerRadius = GetEntityAngle(_actor);
		warningId = skill_Charge_ChongFengKuiLei3.PlayEarlyWarningEffect("fx_warning_square_3side_2_5x30", 1.2f, default, position, innerRadius, 0.9f);
		BeginAttack(2, "Charge", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("DashStart");
		StopEffect(warningId);
		BeginDash(2, GetForward(), dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
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
