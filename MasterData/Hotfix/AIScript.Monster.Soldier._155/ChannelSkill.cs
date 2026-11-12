using System;

namespace AIScript.Monster.Soldier._155;

public class ChannelSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill2";

	public const string activeTag = "InXiaChannel";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("InXiaChannel", value: true);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("InXiaChannel", value: false);
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void onFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		Action onComboFinish = onFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
