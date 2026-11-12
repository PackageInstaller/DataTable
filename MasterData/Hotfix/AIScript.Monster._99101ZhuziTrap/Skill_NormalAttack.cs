using System.Collections;
using AIScript.Monster.Trap;
using TrueSync;

namespace AIScript.Monster._99101ZhuziTrap;

public class Skill_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly string FXAlias = "Actor/Monster/99051FlameTrap/FX/fx_99051FlameTrap_Attack_start_Prologue";

	private TSVector2 FXPosition;

	private FP FXRotation;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
