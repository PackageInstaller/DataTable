using System;

namespace AIScript.Monster.Soldier._108;

public class NormalSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Atk";

	private readonly string comboTag_HasBuff = "Atk_Fire";

	private bool _consumeBuffOnFinish;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_consumeBuffOnFinish = false;
	}

	public void OnStart()
	{
		_consumeBuffOnFinish = MainSkill.buffId_Combo > 0 && _actor.buffComponent != null && _actor.buffComponent.CheckBuffByBuffID(MainSkill.buffId_Combo);
		string actionTag = (_consumeBuffOnFinish ? comboTag_HasBuff : comboTag);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		if (_consumeBuffOnFinish)
		{
			_consumeBuffOnFinish = false;
			_actor.buffComponent?.RemoveBuffByBuffId(MainSkill.buffId_Combo, 1);
		}
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_consumeBuffOnFinish = false;
	}
}
