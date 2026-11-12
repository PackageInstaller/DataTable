using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_Attack_LookAt
{
	private LookAtTarget _lookAtTarget;

	private ComboAttack _comboAttack;

	private AdventureSkill _skill;

	private AdventureActor _actor;

	private FP _rotateSpeed;

	private string _eventNameStartLookAt;

	private string _eventNameEndLookAt;

	public void OnEnable(AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys, FP rotateSpeed, string eventNameStartLookAt, string eventNameEndLookAt)
	{
		_actor = actor;
		_skill = skill;
		_rotateSpeed = rotateSpeed;
		_eventNameStartLookAt = eventNameStartLookAt;
		_eventNameEndLookAt = eventNameEndLookAt;
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		int skillId = ((skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnComboFinishOrInterrupt;
		Action onInterrupt = OnComboFinishOrInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnComboFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(_eventNameStartLookAt))
		{
			if (_lookAtTarget == null)
			{
				_lookAtTarget = new LookAtTarget();
			}
			_lookAtTarget.BeginLookAt(_actor, _actor.attackTarget, 999, _rotateSpeed, null);
		}
		else if (eventName.Equals(_eventNameEndLookAt))
		{
			_lookAtTarget?.StopLookAt();
		}
	}

	public void OnDisable()
	{
		_comboAttack?.Clear();
		_lookAtTarget?.Clear();
		_skill = null;
	}
}
