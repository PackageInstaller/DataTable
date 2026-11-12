using System.Collections;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_JuJianYueJi_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.K,
		ComboInputBuffer.ActionKey._2
	};

	private LogicEntity AttackTarget;

	private static readonly FP DashSpeed = 35;

	private static readonly FP DashTime = 0.45;

	private FP TargetDis;

	private static readonly string Dash_Event = "Dash";

	private static readonly string StartTurn_Event = "StartTurn";

	private static readonly string AreaEffectAlias1 = "fx_common_base_Dark_YuJing_circular_2";

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
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 8, 300);
		yield return WaitCustomEvent(Dash_Event);
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 1;
		SetCloseBlockEnable();
		PlayEarlyWarningEffect(AreaEffectAlias1, 0.6f, default, GetEntityPosition(AttackTarget), default, 1.2f, actorScale: true);
		BeginDashActorForward(1, TargetDis / DashTime, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopLookAt();
		yield return WaitCustomEvent(StartTurn_Event);
		BeginLookAt_NotWait(AttackTarget, 2, 360);
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
	}
}
