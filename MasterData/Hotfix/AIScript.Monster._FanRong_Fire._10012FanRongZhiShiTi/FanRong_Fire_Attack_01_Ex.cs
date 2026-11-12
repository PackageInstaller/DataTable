using System.Collections;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_01_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._3
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private readonly string Combo01 = "ComboTo1";

	private readonly string Combo02 = "ComboTo2";

	private readonly string TurnToTarget = "TurnTo";

	private long AreaEffectID;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToTarget);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.66, 150);
		yield return WaitFrame(22);
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
}
