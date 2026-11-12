#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._50561CanDao;

public class Skill_Knife_Throw_miniboss : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey_throw = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private static readonly string custom_CloseWeapon = "CloseWeapon";

	protected override IEnumerator DoMainLogic()
	{
		AttackHint();
		BeginAttack(1, _actionKey_throw, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AttackHintEnd();
	}

	protected override void OnSkillDisable()
	{
		AttackHintCancel();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_CloseWeapon)
		{
			ModelNodeShow("weapon", isShow: false);
			_actor.logicVariable.ToggleLogicTag("haveBullet", value: false);
			NovaLogger.Debug("扔镖了");
		}
		if (eventName == custom_Turn)
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 0.5);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
	}
}
