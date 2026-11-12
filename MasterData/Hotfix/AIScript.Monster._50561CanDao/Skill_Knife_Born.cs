#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._50561CanDao;

public class Skill_Knife_Born : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey_born = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_OpenWeapon = "OpenWeapon";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey_born, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_OpenWeapon)
		{
			ModelNodeShow("weapon", isShow: true);
			_actor.logicVariable.ToggleLogicTag("getBullet", value: false);
			NovaLogger.Debug("生成镖了");
		}
	}
}
