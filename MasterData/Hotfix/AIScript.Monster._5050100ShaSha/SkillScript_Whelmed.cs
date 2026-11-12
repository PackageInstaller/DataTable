using System.Collections;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Whelmed : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	protected override void OnSkillEnable()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		_actor.logicVariable.ToggleLogicTag("5050100EndWhelmed", value: true);
		SetSuperArmorEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(5);
		_actor.logicVariable.ToggleLogicTag("5050100EndWhelmed", value: false);
	}

	protected override void OnSkillDisable()
	{
		_skill?.Clear();
		_actor.logicVariable.ToggleLogicTag("5050100EndWhelmed", value: false);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		InterruptAttack();
		_skill?.Clear();
		_actor.logicVariable.ToggleLogicTag("5050100EndWhelmed", value: false);
	}
}
