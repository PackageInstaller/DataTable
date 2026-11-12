using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill7_Lazer_Light : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 1, 400);
		yield return WaitTime(0.5);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		AimAtTarget(_target, 200);
		yield return WaitTime(2.5);
		CancelAttack();
		yield return WaitCustomEvent("Hit1Start");
		CancelAim();
		yield return WaitCustomEvent("Hit1End");
		AimAtTarget(_target, 200);
		yield return WaitCustomEvent("Hit2Start");
		CancelAim();
		yield return WaitCustomEvent("Hit2End");
		AimAtTarget(_target, 200);
		yield return WaitCustomEvent("Hit3Start");
		CancelAim();
		yield return WaitCustomEvent("Hit3End");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
