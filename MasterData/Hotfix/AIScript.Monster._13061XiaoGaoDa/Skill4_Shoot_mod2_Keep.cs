using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill4_Shoot_mod2_Keep : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity _target = GetAttackTarget();
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(_target, 0.8, 160);
		yield return WaitTime(0.8);
		AimAtTarget(_target, 45);
		while (GetLogicTagFpValue(_actor, "Stage") == 1)
		{
			yield return null;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
