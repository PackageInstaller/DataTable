using System.Collections;

namespace AIScript.Monster._FengCao_Blow._16510FengCao;

public class Skill_FengCao_Blow_Attack : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		AddBuffToTarget(_actor, 160510131);
	}
}
