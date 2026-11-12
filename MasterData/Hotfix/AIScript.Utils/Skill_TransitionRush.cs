using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_TransitionRush
{
	private AdventureSkill _skill;

	private AdventureActor _actor;

	private ComboAttack _comboAttack;

	private FP _continueTime;

	private FP _duration;

	private bool _canceled;

	public void OnEnable(AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys_transitionRush, FP duration)
	{
		_actor = actor;
		_skill = skill;
		_duration = duration;
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor2 = _actor;
		AdventureSkill skill2 = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		comboAttack.BeginAttack(actor2, skill2, actionKeys_transitionRush, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		if (!_canceled)
		{
			_continueTime += _actor.LogicDeltaTime;
			if (_continueTime >= _duration)
			{
				_canceled = true;
				_comboAttack.InterruptAttack();
			}
			if (!_canceled && !SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
			{
				_canceled = true;
				_comboAttack.InterruptAttack();
			}
		}
	}

	public void OnDisable()
	{
		_continueTime = 0;
		_canceled = false;
		_comboAttack?.Clear();
		_actor = null;
		_skill = null;
	}
}
