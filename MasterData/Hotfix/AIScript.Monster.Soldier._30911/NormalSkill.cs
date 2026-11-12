using System;

namespace AIScript.Monster.Soldier._30911;

public class NormalSkill : SkillAdvancedBase
{
	private const string actionKey = "NormalAttack";

	private const string Event_EndLoop = "EndLoop";

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
		if (string.Equals(evt, "EndLoop"))
		{
			_actor.CancelAttack();
		}
	}
}
