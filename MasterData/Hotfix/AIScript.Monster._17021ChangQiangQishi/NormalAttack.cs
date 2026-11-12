using System.Collections;

namespace AIScript.Monster._17021ChangQiangQishi;

public class NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly string Startfx = "fx_17021ChangQiangQishi_loop_attack1_loop_01";

	private long fx_start;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget(isUpToDate: true);
		if (!(target == null))
		{
			if (CalcAngleBetweenSelfAndAttackTarget() >= 15)
			{
				BeginAttack(1, Attack_Combo2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(1f);
				AimAtTarget(target, 300);
				yield return WaitTime(0.6f);
				CancelAim();
				CancelAttack();
				yield return WaitTime(0.3f);
			}
			else
			{
				BeginLookAt_NotWait(target, 0.2f, 300);
				yield return WaitTime(0.2f);
			}
			BeginAttack(2, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.83f);
			fx_start = PlayEffect(Startfx);
			BeginDash(1, GetForward(), 24, 12, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			SetCloseBlockEnable();
			yield return WaitTime(0.5f);
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitTime(0.2f);
			StopEffect(fx_start);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
