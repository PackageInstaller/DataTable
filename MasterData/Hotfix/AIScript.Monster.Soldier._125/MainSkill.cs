using System;
using TrueSync;

namespace AIScript.Monster.Soldier._125;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill_1";

	private readonly FP loopDuration = 1.26;

	private readonly string comboTag_Potential = "Skill_2";

	private readonly FP loopDuration_Potential = 3.3800000000000003;

	private bool _beginLoop;

	private FP _loopDuration;

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_beginLoop = false;
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string text = comboTag;
		if (_potentialLv >= 3)
		{
			text = comboTag_Potential;
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		if (_potentialLv >= 3)
		{
			_loopDuration = loopDuration_Potential;
		}
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
