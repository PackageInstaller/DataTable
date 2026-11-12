using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_Crush : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Crush_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private LogicEntity Target;

	private FP DashDistance;

	private TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		Target = GetAttackTarget();
		TargetPosition = GetEntityPositionObsoleted(Target);
		SetLogicTagToggleValue(_actor, "StartAttack", value: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(Target, 999, 150);
		while (!GetLogicTagToggleValue(_actor, "StartAttack"))
		{
			yield return null;
		}
		StopWaitLookAt();
		yield return BeginLookAt(GetAttackTarget(isUpToDate: true), 0.1, 1800);
		if (CheckTargetIsValid(Target))
		{
			TargetPosition = GetEntityPositionObsoleted(Target);
		}
		BeginAttack(1, Crush_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("FlyupWarning", 0.8f, 0, TargetPosition, default, 0.5f);
		WaitLookAt(Target, 999, 1800);
		yield return WaitCustomEvent("Attack");
		StopWaitLookAt();
		DashDistance = Distance(GetPosition(), TargetPosition);
		BeginDash(1, TargetPosition - GetPosition(), DashDistance / 0.12, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCustomEvent("Die");
		_actor.DestroySelf();
	}
}
