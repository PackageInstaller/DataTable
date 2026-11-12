using System.Collections;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_02_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)828141665,
		(ComboInputBuffer.ActionKey)825242416,
		(ComboInputBuffer.ActionKey)1500408152
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634222951,
		(ComboInputBuffer.ActionKey)1331654249,
		(ComboInputBuffer.ActionKey)1953775982
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack04 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1701668200,
		(ComboInputBuffer.ActionKey)1802659152,
		(ComboInputBuffer.ActionKey)1701336156
	};

	private readonly string Combo01 = "ComboTo01";

	private readonly string Combo02 = "ComboTo02";

	private readonly string Turn = "TurnTo";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 120);
		yield return WaitFrame(17);
		CancelAttack();
		yield return WaitFrame(25);
		BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		BeginAttack(4, FireAttack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(3);
		DoDash();
		yield return WaitCustomEvent(Turn);
		BeginLookAt_NotWait(Targetenemy, 0.4, 190);
		yield return WaitFrame(10);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	protected void DoDash()
	{
		BeginDash(4, GetForward(), 12, 8, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
