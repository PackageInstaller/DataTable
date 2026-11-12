using System.Collections;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Transform_Phase1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!GetLogicTagToggleValue(_actor, "IsHardcore"))
		{
			ModelNodeShow("body_chushou", isShow: true);
			ReplaceAnimationGroup();
			BeginAttack(1, actionKeys, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(1);
		}
		else
		{
			yield return null;
		}
	}
}
