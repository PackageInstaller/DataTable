using System.Collections;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Hide : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private ComboInputBuffer.ActionKey[] actionKeys;

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagFpValue(_actor, "Phase") == 1)
		{
			actionKeys = actionKeys_1;
		}
		else
		{
			actionKeys = actionKeys_2;
		}
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		ShowBlood(isShow: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptLockToughness();
	}
}
