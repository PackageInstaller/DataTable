using System.Collections;
using AIScript.Utils;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Death_3 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_One = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Two = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected override void OnSkillEnable()
	{
		_actor.SendDeclareDeadEvent();
		AdventureLevelStopTimingEvent aEvent = AdventureLevelStopTimingEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		CommonUtils_MonsterAPI.KillActors(CommonUtils_MonsterAPI.GetTargetsByFaction(_actor, isFriend: true));
		_actor.InterruptAttack(force: true);
		SetCloseBlockEnable();
	}

	protected override void OnSkillDisable()
	{
		_skill?.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.InterruptForceControl();
		BeginAttack(1, _actionKey_One, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_actor.Hide();
		_actor.DestroySelf();
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
