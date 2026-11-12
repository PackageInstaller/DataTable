using System.Collections;

namespace AIScript.Monster._50251ShanDianLieQuan;

public class Elite_Skill01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCustomEvent("T1");
		BeginLookAt_NotWait(Targetenemy, 0.3, 100);
		yield return WaitCustomEvent("T2");
		StopWaitLookAt();
		yield return WaitCustomEvent("C1");
		CancelAttack();
		yield return WaitCustomEvent("T3");
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90)
		{
			BeginRotateAngle(-30, 720);
		}
		else
		{
			BeginLookAt_NotWait(Targetenemy, 0.4, 720);
		}
		yield return WaitCustomEvent("T4");
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
