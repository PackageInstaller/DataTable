using System;

namespace AIScript.Monster.Soldier._31101;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "NormalAttack";

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
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		Action<string> action = onCustomEvent;
		BeginAttack("NormalAttack", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
	}
}
