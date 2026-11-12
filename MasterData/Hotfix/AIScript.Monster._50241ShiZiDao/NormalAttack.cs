using System.Collections;
using TrueSync;

namespace AIScript.Monster._50241ShiZiDao;

public class NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private FP TurnAngle;

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		TurnAngle = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) % 90;
		yield return BeginRotateAngle(TurnAngle, 500);
		SetBlockPriorityToStatic();
		BeginAttack(1, Attack_Combo, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
