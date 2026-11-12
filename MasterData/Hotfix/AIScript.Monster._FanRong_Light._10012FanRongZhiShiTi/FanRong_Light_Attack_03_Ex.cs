using System.Collections;

namespace AIScript.Monster._FanRong_Light._10012FanRongZhiShiTi;

public class FanRong_Light_Attack_03_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1952805747,
		(ComboInputBuffer.ActionKey)1918065779,
		(ComboInputBuffer.ActionKey)1867013987
	};

	private readonly string Combo1 = "C1";

	private readonly string Turn1 = "T1";

	private readonly string Turn2 = "T2";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo1);
		CancelAttack();
		GetEnemy();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 380);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == Turn1)
		{
			Targetenemy = GetAttackTarget();
			if (Targetenemy == null)
			{
				Targetenemy = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(Targetenemy, 1, 200, 0);
		}
		else if (eventName == Turn2)
		{
			StopWaitLookAt();
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
