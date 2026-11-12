using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill7_Lazer_Light2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private FP toangle1;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(_target, 1, 200);
		yield return WaitTime(2);
		yield return WaitTime(2.4);
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP < 0)
		{
			toangle1 = -50 + fP;
		}
		else
		{
			toangle1 = 50 + fP;
		}
		BeginRotateAngle(toangle1, 40);
		yield return WaitTime(toangle1 / 40);
		yield return WaitTime(1);
		fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP < 0)
		{
			toangle1 = -50 + fP;
		}
		else
		{
			toangle1 = 50 + fP;
		}
		BeginRotateAngle(toangle1, 40);
		yield return WaitTime(toangle1 / 40);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
