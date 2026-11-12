using System;
using TrueSync;

namespace AIScript.Monster.Soldier._143;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly FP loopDuration = 0.4;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_beginLoop = false;
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		_beginLoop = true;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
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
		_beginLoop = false;
		_loopDuration = 0;
	}
}
