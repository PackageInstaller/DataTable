using System.Collections;

namespace AIScript.Monster._10002TuBoShuSheShou;

public class Skill_Born_Purple : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		SetLogicTagStringValue(_actor, "Type", "Purple");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
