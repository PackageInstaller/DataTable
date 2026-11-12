using System.Collections;

namespace AIScript.Monster._50091GuanZi;

internal class Skill_Explode_Earth : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] ActionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string Hide_Event = "Hide";

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ActionKey);
		yield return WaitCustomEvent(Hide_Event);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
