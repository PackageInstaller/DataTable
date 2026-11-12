using System;
using TrueSync;

namespace AIScript.Monster.Soldier._115;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1];

	private readonly ComboInputBuffer.ActionKey[] actionKeys_Potential = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly FP loopDuration_Potential3 = 2.73;

	private readonly FP useActionKeysNeedTime_Potential = 10;

	private int _potentialLv;

	private long _targetId;

	private FP _duration_Potential;

	private bool _usePotentialActionKeys;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		if (_potentialLv >= 3)
		{
			if (_actor.logicVariable.GetLogicTagToggle("TriggerPotential"))
			{
				_usePotentialActionKeys = true;
				return;
			}
			_targetId = _actor.logicVariable.GetLogicTagValue("TargetId_Potential").AsLong();
			_duration_Potential = _actor.logicVariable.GetLogicTagValue("Duration_Potential");
			_usePotentialActionKeys = false;
		}
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] array = actionKeys;
		if (_potentialLv >= 3 && _usePotentialActionKeys)
		{
			array = actionKeys_Potential;
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		if (_potentialLv >= 3 && _usePotentialActionKeys)
		{
			_loopDuration = loopDuration_Potential3;
			_beginLoop = true;
		}
	}

	public void OnUpdate()
	{
		if (_potentialLv < 3)
		{
			return;
		}
		if (_usePotentialActionKeys)
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
		else if (_actor.attackTarget != null)
		{
			if (_actor.attackTarget.Id == _targetId)
			{
				_duration_Potential += _actor.LogicDeltaTime;
				if (_duration_Potential > useActionKeysNeedTime_Potential)
				{
					_actor.logicVariable.ToggleLogicTag("TriggerPotential", value: true);
				}
			}
			else
			{
				_targetId = _actor.attackTarget.Id;
				_duration_Potential = 0;
			}
		}
		else
		{
			_targetId = 0L;
			_duration_Potential = 0;
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
		if (_potentialLv >= 3)
		{
			if (_usePotentialActionKeys)
			{
				_actor.logicVariable.ToggleLogicTag("TriggerPotential", value: false);
				_actor.logicVariable.SetLogicTagValue("TargetId_Potential", 0);
				_actor.logicVariable.SetLogicTagValue("Duration_Potential", 0);
			}
			else
			{
				_actor.logicVariable.SetLogicTagValue("TargetId_Potential", _targetId);
				_actor.logicVariable.SetLogicTagValue("Duration_Potential", _duration_Potential);
			}
		}
		_targetId = 0L;
		_duration_Potential = 0;
		_usePotentialActionKeys = false;
		_beginLoop = false;
		_loopDuration = 0;
	}
}
