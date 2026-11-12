using System.Collections;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] L_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] R_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2
	};

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180)
		{
			BeginAttack(1, L_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Back");
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 150);
		}
		else
		{
			BeginAttack(1, R_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Back");
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 150);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
