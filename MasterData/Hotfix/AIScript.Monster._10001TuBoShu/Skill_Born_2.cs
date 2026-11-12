using System.Collections;

namespace AIScript.Monster._10001TuBoShu;

public class Skill_Born_2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		RemoveBuffFromTarget(_actor, 990010040);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
