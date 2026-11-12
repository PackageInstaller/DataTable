using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_Dash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP DashSpeed = 20;

	private LogicEntity Target;

	protected override void OnSkillEnable()
	{
		Target = GetAttackTarget();
		SetLogicTagFpValue(_actor, "AttackTime", -1);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(Target, 999, 150);
		while (GetLogicTagFpValue(_actor, "AttackTime") == -1)
		{
			yield return null;
		}
		yield return WaitTime(GetLogicTagFpValue(_actor, "AttackTime"));
		StopWaitLookAt();
		yield return BeginLookAt(GetAttackTarget(isUpToDate: true), 0.1, 1800);
		BeginLookAt_NotWait(Target, 999, 150);
		BeginAttack(1, Dash_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.16);
		StopWaitLookAt();
		PlayEffect("WarningFX", 1f, 1, GetPosition(), default, 0.5f);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, DashSpeed, 999, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		while (Distance(GetPosition(), TSVector2.zero) <= 12)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	protected override void DashFinishByObstacle(int index)
	{
		_actor.DestroySelf();
	}
}
