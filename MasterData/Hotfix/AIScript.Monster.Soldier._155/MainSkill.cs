using System;

namespace AIScript.Monster.Soldier._155;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const int buffId = 250101901;

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
		_actor.buffComponent.AddBuff(250101901, _actor);
		_actor.logicVariable.ToggleLogicTag(Parallel.activeTag, value: true);
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
