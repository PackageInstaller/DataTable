using System.Collections;
using TrueSync;

namespace AIScript.Monster._90001SaoDiJiQiRen;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[2];

	private static readonly int LoopCount = 1;

	private static readonly FP DashSpeed = 8;

	private static readonly FP DashAngleLimit = 1;

	private static readonly FP DashOffset = 2;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		LogicEntity target = GetAttackTarget();
		for (int i = 0; i < LoopCount; i++)
		{
			FP distance = _actor.DistanceWithRadius(target) + DashOffset;
			BeginDashActorForward(i + 1, DashSpeed, distance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
