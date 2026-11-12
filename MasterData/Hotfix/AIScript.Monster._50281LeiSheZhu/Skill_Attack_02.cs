using System.Collections;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_Attack_02 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity AttackTarget;

	private static readonly FP DashSpeed = 45;

	private FP TargetDis;

	private static readonly string Dash = "Dash";

	private static readonly string Turn = "Turn";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(AttackTarget, 0.2, 900);
		BeginAttack(1, _actionKey);
		Skill_Attack_02 skill_Attack_ = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(AttackTarget);
		skill_Attack_.PlayEffect("fx_common_base_Fire_YuJing_circular_4", 1f, default, entityPositionObsoleted);
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.5, GetPosition(), default, 3f);
		StopLookAt();
		yield return WaitCustomEvent(Dash);
		BeginDashActorForward(1, DashSpeed, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		Skill_Attack_02 skill_Attack_2 = this;
		entityPositionObsoleted = GetPosition();
		skill_Attack_2.PlayEffect("fx_common_base_Fire_YuJing_circular_4", 1f, default, entityPositionObsoleted);
		yield return WaitCustomEvent(Turn);
		CancelAttack();
		BeginLookAt_NotWait(AttackTarget, 2, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "warningFx")
		{
			PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.5, GetPosition(), default, 3f);
		}
	}
}
