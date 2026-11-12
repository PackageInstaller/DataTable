using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_Dash
{
	private LookAtTarget _lookAtTarget;

	private ComboAttack _comboAttack;

	private Dash _dash;

	private bool _anticipationEnd;

	private AdventureSkill _skill;

	private AdventureActor _actor;

	private FP _rotateSpeed;

	private string _eventNameStartLookAt;

	private string _eventNameEndLookAt;

	private FP _dashDistance;

	private FP _dashSpeed;

	private bool _stopWhenContactActor;

	public void OnEnable(AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys, FP rotateSpeed, string eventNameStartLookAt, string eventNameEndLookAt, FP dashDistance, bool absSpeed, FP dashSpeedOrMultiple, bool stopWhenContactActor)
	{
		_actor = actor;
		_skill = skill;
		_rotateSpeed = rotateSpeed;
		_eventNameStartLookAt = eventNameStartLookAt;
		_eventNameEndLookAt = eventNameEndLookAt;
		_dashDistance = dashDistance;
		_dashSpeed = dashSpeedOrMultiple;
		_stopWhenContactActor = stopWhenContactActor;
		if (!absSpeed)
		{
			_dashSpeed = actor.actorInfo.runSpeed * dashSpeedOrMultiple;
		}
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		int skillId = ((skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnComboFinishOrInterrupt;
		Action onInterrupt = OnComboFinishOrInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		_anticipationEnd = true;
		_lookAtTarget?.StopLookAt();
		if (_dash == null)
		{
			_dash = new Dash();
		}
		_dash.BeginDashActorForward(_actor, _dashSpeed, _dashDistance, 0, triggerEnemyStop: _stopWhenContactActor, finishCallback: DashFinish, finishByActorCallback: DashFinish, finishByObstacleCallback: DashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerFriendStop: false);
	}

	private void DashFinish()
	{
		_comboAttack?.CancelAttack();
	}

	private void OnComboFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(_eventNameStartLookAt))
		{
			if (!_anticipationEnd)
			{
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAt(_actor, SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, 999, _rotateSpeed, null);
			}
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
		_dash?.Clear();
		_anticipationEnd = false;
		_skill = null;
		_actor = null;
	}
}
