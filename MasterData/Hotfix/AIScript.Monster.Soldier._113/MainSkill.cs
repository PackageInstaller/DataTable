using System;

namespace AIScript.Monster.Soldier._113;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "ComboSkill";

	private readonly string comboTag_Potential1 = "ComboSkill1";

	private readonly int loopCount = 3;

	public const int buffId_Trigger = 250104201;

	private int _potentialLv;

	private int _loopCount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_loopCount = 0;
	}

	public void OnStart()
	{
		if (_potentialLv >= 3)
		{
			_actor.buffComponent?.AddBuff(250104201, _actor);
		}
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		string actionTag = ((_potentialLv >= 2) ? comboTag_Potential1 : comboTag);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnRecoveryBegin()
	{
		_loopCount++;
		if (_loopCount >= loopCount)
		{
			comboAttack?.CancelAttack();
			return;
		}
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		string actionTag = ((_potentialLv >= 2) ? comboTag_Potential1 : comboTag);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnFinish()
	{
		if (_loopCount >= loopCount)
		{
			_skill.Clear();
		}
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopCount = 0;
	}
}
