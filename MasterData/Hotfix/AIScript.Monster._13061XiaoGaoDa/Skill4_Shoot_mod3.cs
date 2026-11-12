using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot_mod3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private FP toangle1;

	private FP toangle2;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		if (CalcAngleBetweenSelfAndAttackTarget() > 80)
		{
			BeginLookAt(attackTarget, 0, 700);
			yield return WaitTime(0.2);
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(0.8);
		TSVector2 entityForward = GetEntityForward(_actor);
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP > 0)
		{
			toangle1 = fP + 60;
			toangle2 = -120;
		}
		else
		{
			toangle1 = fP - 60;
			toangle2 = 120;
		}
		BeginLookAtByDir(RotateTo(entityForward, toangle1), 0, 60);
		yield return WaitTime(FP.Abs(toangle1) / 60);
		entityForward = GetEntityForward(_actor);
		BeginLookAtByDir(RotateTo(entityForward, toangle2), 0, 60);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
