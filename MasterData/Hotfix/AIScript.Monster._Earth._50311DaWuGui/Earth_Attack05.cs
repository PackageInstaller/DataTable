using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private readonly ComboInputBuffer.ActionKey[] L_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] R_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._2
	};

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180)
		{
			BeginAttack(1, L_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Turn01");
			FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
			FP rotateSpeed = fP / 0.25;
			if (fP < 75 && fP > 0)
			{
				BeginRotateAngle_NotWait(fP, rotateSpeed);
			}
			else if (fP >= 75 && fP <= 180)
			{
				BeginRotateAngle_NotWait(75, 300);
			}
			else
			{
				BeginRotateAngle_NotWait(10, 45);
			}
		}
		else
		{
			BeginAttack(1, R_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Turn01");
			FP fP2 = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
			FP fP3 = fP2 / 0.25;
			if (fP2 < 0 && fP2 > -75)
			{
				BeginRotateAngle_NotWait(fP2, -fP3);
			}
			else
			{
				BeginRotateAngle_NotWait(-75, 300);
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
