using System.Collections;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_WanderAct : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] WanderAct_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.S,
		ComboInputBuffer.ActionKey.S
	};

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtMonsterTarget(0.5, 360);
		BeginAttack(1, WanderAct_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		PlayWwiseSound("mon_10005_hover");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
