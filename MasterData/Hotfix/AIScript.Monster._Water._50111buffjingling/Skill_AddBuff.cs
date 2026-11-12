using System.Collections;

namespace AIScript.Monster._Water._50111buffjingling;

public class Skill_AddBuff : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1];

	protected readonly string eventAddBuff = "AddBuff";

	protected readonly int buffId = 501110010;

	private readonly string AreaEffectAlias = "50111BuffJingLing_Area_Water";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		yield return WaitFrame(16);
		PlayAreaEffect(AreaEffectAlias, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
