using System;

namespace AIScript.Character._11101;

public class SkillScript_Aim : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey _actionKey = ComboInputBuffer.ActionKey.S;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnStop()
	{
		Clear();
	}

	public void OnUpdate()
	{
		DoUpdateLogic();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	private void Clear()
	{
	}

	protected void onFinish()
	{
		_skill.Clear();
	}

	protected void onInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey actionKey = _actionKey;
		Action onComboFinish = onFinish;
		Action action = onInterrupt;
		BeginAttack(actionKey, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, action);
	}

	private void DoUpdateLogic()
	{
	}
}
