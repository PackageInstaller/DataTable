using System;

namespace AIScript.Monster.Soldier._135;

public class NormalSkill : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[4];

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> action = onCustomEvent;
		BeginAttack(keys, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
	}
}
