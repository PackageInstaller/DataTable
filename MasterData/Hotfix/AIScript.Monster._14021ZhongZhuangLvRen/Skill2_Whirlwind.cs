using System.Collections;

namespace AIScript.Monster._14021ZhongZhuangLvRen;

public class Skill2_Whirlwind : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 0.6, 240);
		yield return WaitTime(0.55);
		AimAtTarget(_target, 240);
		yield return WaitTime(1.5);
		yield return WaitTime(1.1);
		CancelAim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
