using System.Collections;

namespace AIScript.Monster._50561CanDao;

public class Skill_Knife_Catch : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string custom_OpenWeapon = "OpenWeapon";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		SetInvincibleEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_OpenWeapon)
		{
			ModelNodeShow("weapon", isShow: true);
			_actor.logicVariable.ToggleLogicTag("getBullet", value: false);
			SetInvincibleDisable();
		}
	}

	protected override void OnSkillDisable()
	{
		SetInvincibleDisable();
	}
}
