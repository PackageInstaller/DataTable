using System.Collections;

namespace AIScript.Monster._99121MuZhuangGuai;

public class Skill_Recover : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 991210020);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
