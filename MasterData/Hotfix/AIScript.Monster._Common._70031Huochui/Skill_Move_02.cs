using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_Move_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._2
	};

	private LogicEntity AttackTarget;

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
		BeginLookAt_NotWait(AttackTarget, 2, 360);
		BeginAttack(1, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 forward = GetForward();
		TSVector2 Direction = RotateTo(forward, GetRandomValue(-165, -195, isInt: true));
		FP fP = 6;
		FP speed = fP / 0.3;
		Dash Dash = BeginDash(1, Direction, speed, fP, 360, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		for (int i = 0; i < 5; i++)
		{
			Dash._direction = Direction;
			yield return WaitTime(0.01);
		}
		StopDash();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
