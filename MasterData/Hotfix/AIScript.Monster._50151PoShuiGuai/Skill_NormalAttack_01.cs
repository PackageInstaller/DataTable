using System.Collections;

namespace AIScript.Monster._50151PoShuiGuai;

public class Skill_NormalAttack_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
