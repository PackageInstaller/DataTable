using System.Collections;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Summon : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_break = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_summon = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_blink = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_null = new ComboInputBuffer.ActionKey[0];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private static readonly string customEvent_Summon = "Summon";

	private static readonly TSVector2 blinkTargetPosition = new TSVector2(0, 13.2);

	private ComboInputBuffer.ActionKey[] actionKeys;

	protected override void OnSkillEnable()
	{
		SetLogicTagFpValue(_actor, "Phase", 2);
	}

	protected override void OnSkillDisable()
	{
		SetImmuneControlDisable();
		if (GetLogicTagToggleValue(_actor, "BattleInterrupted"))
		{
			Singleton<InteractiveManager>.Instance.triggerOpListener("BattleInterrupted");
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelDisable();
		BeginAttack(1, actionKeys_break, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ShowBlood(isShow: false);
		Blink_NotWait(actionKeys_blink, blinkTargetPosition, 0.3, "", 0, "", 0, null, actionKeys_null);
		yield return WaitTime(0.25);
		PlayFx("FlashIn", 1f, 1, GetPosition(), 0);
		BeginLookAtByPos_NotWait(new TSVector2(0, 0), 0, 999);
		ShowBlood(isShow: true);
		yield return WaitTime(0.5);
		BeginAttack(2, actionKeys_summon, flushInputedKeys: true);
		yield return WaitCustomEvent("Summon");
		SetLogicTagToggleValue(_actor, "BattleInterrupted", value: false);
		SetLogicTagToggleValue(_actor, "WakeTeammates", value: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.75);
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
