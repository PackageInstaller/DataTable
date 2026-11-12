using System.Collections;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_01_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private readonly string TurnToS = "TurnS";

	private readonly string TurnToE = "TurnE";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C1");
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C2");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == TurnToS)
		{
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(logicEntity, 1, 200, 0);
		}
		else if (eventName == TurnToE)
		{
			StopWaitLookAt();
		}
	}
}
