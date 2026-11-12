using System.Collections;
using TrueSync;

namespace AIScript.Monster._Dark._50111buffjingling;

public class Skill_AddBuff : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_AddBuff = "AddBuff";

	private static readonly int BuffID = 501110030;

	private LogicEntity AttackTarget;

	private static readonly FP PlayerDistance = 12;

	private readonly string AreaEffectAlias = "50111BuffJingLing_Area_Dark";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		yield return WaitFrame(16);
		PlayAreaEffect(AreaEffectAlias, GetPosition());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
