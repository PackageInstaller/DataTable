using System.Collections;

namespace AIScript.Monster._Light._50111buffjingling;

public class Skill_AddBuff : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_AddBuff = "AddBuff";

	private static readonly int BuffID = 501110060;

	private static readonly int BuffID_02 = 501110070;

	private readonly string AreaEffectAlias = "50111BuffJingLing_Area_Light";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		yield return WaitFrame(16);
		PlayAreaEffect(AreaEffectAlias, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
