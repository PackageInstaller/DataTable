using System.Collections;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill1_RushStart : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private LogicEntity attackTarget;

	protected override IEnumerator DoMainLogic()
	{
		attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			yield return BeginLookAt(attackTarget, 0.3, 600);
			BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
			Skill1_RushStart skill1_RushStart = this;
			TSVector2 position = GetPosition();
			FP entityAngle = GetEntityAngle(_actor);
			skill1_RushStart.PlayEffect("fx_warning_dash_2x30", 0.5f, default, position, entityAngle);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			DoDash();
			yield return WaitDashFinish();
			comboAttack.CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 35, 22, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1);
	}
}
