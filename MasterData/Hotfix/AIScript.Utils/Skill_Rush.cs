using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_Rush
{
	private AdventureSkill _skill;

	private AdventureActor _actor;

	private FP _interruptTime;

	private bool _useSpecialRushEnd;

	private ComboInputBuffer.ActionKey[] _actionKeys_SpecialRushEnd;

	private string _endRushLogicTagEventName;

	private ComboAttack _comboAttack;

	private bool _beginStop;

	private FP _continueTime;

	private bool _isIndependent;

	public void OnEnable(AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys_Rush, ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent, FP interruptTime, bool useSpecialRushEnd, ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = null, string endRushLogicTagEventName = "")
	{
		_actor = actor;
		_skill = skill;
		_interruptTime = interruptTime;
		_useSpecialRushEnd = useSpecialRushEnd;
		_actionKeys_SpecialRushEnd = actionKeys_SpecialRushEnd;
		_endRushLogicTagEventName = endRushLogicTagEventName;
		_isIndependent = false;
		((PlayerAdventureActor)_actor).dodgeButtonHold = true;
		ComboInputBuffer.ActionKey[] array = actionKeys_Rush;
		if (!_actor.actorSkillManage.HaveDodgeSkill())
		{
			_isIndependent = true;
			array = actionKeys_Rush_Independent;
		}
		_actor.FastSpeedMode(isRunFast: true);
		_continueTime = 0;
		_beginStop = false;
		_actor.CancelAiming();
		_actor?.logicVariable.ToggleLogicTag("IsRush", value: true);
		_actor?.animatorController.SetBool(AdventureActor.AnimationParameterNames.rushCombo, value: true);
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor2 = _actor;
		AdventureSkill skill2 = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = array;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		bool isIndependent = _isIndependent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor2, skill2, actionKeys, isIndependent, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: true, null, keyPerfectMatch: true);
	}

	public void OnDisable()
	{
		_comboAttack?.Clear();
		_actor.FastSpeedMode(isRunFast: false);
		((PlayerAdventureActor)_actor).dodgeButtonHold = false;
		_actor?.logicVariable.ToggleLogicTag("IsRush", value: false);
		_actor?.animatorController.SetBool(AdventureActor.AnimationParameterNames.rushCombo, value: false);
		_actor = null;
		_skill = null;
		_actionKeys_SpecialRushEnd = null;
	}

	public void OnUpdate()
	{
		_continueTime += _actor.LogicDeltaTime;
		if (((PlayerAdventureActor)_actor).dodgeButtonHold || _beginStop)
		{
			return;
		}
		_beginStop = true;
		if (_continueTime < _interruptTime)
		{
			if (_useSpecialRushEnd && _actionKeys_SpecialRushEnd != null)
			{
				ComboAttack comboAttack = _comboAttack;
				AdventureActor actor = _actor;
				AdventureSkill skill = _skill;
				ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = _actionKeys_SpecialRushEnd;
				int skillId = ((_skill != null) ? _skill.skillId : 0);
				Action onComboFinish = OnFinish;
				Action onInterrupt = OnFinish;
				Action<string> onCustomEvent = OnCustomEvent;
				comboAttack.BeginAttack(actor, skill, actionKeys_SpecialRushEnd, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			}
			else
			{
				_comboAttack.InterruptAttack();
			}
		}
		else if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_comboAttack.InterruptAttack();
		}
		else if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAimRange(_actor))
			{
				_comboAttack.InterruptAttack();
			}
			else
			{
				_comboAttack.CancelAttack();
			}
		}
		else
		{
			_comboAttack.CancelAttack();
		}
		_actor?.FastSpeedMode(isRunFast: false);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(_endRushLogicTagEventName))
		{
			_actor?.logicVariable.ToggleLogicTag("IsRush", value: false);
		}
	}
}
