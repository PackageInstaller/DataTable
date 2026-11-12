using System;

namespace AIScript.Monster.Soldier._30932;

public class SummonSkill2 : SkillAdvancedBase
{
	private readonly string comboTag = "Skill_2";

	private const int totalLoopTime = 1;

	private int _loopTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTime = 0;
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_loopTime++;
		if (_loopTime >= 1)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopTime = 0;
	}
}
