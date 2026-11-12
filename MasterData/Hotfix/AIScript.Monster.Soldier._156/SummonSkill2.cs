using System;
using TrueSync;

namespace AIScript.Monster.Soldier._156;

public class SummonSkill2 : SkillAdvancedBase
{
	private readonly string comboTag1 = "Dance";

	private readonly string comboTag2 = "Boom";

	private readonly FP useComboInterval = 0.1;

	private bool _firstComboFinish;

	private bool _secondComboBegin;

	private FP _interval;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_firstComboFinish = false;
		_secondComboBegin = false;
		_interval = useComboInterval;
	}

	public void OnStart()
	{
		string actionTag = comboTag1;
		Action onComboFinish = OnFirstComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		if (_firstComboFinish)
		{
			if (_interval > 0)
			{
				_interval -= _actor.LogicDeltaTime;
			}
			else if (!_secondComboBegin)
			{
				string actionTag = comboTag2;
				Action onComboFinish = OnSecondFinish;
				Action onInterrupt = OnInterrupt;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
				_secondComboBegin = true;
			}
		}
	}

	private void OnFirstComboFinish()
	{
		_firstComboFinish = true;
	}

	private void OnSecondFinish()
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
		_firstComboFinish = false;
		_secondComboBegin = false;
		_interval = 0;
		_actor.DestroySelf();
	}
}
