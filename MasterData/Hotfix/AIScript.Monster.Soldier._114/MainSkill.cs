using System;

namespace AIScript.Monster.Soldier._114;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "MainSkill";

	public const int buffId_State1 = 250105501;

	public const int buffId_State2 = 250105502;

	private int _potentialLv;

	private bool _buffGranted;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_buffGranted = false;
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
		GrantPotentialBuff();
	}

	private void GrantPotentialBuff()
	{
		if (_potentialLv >= 2 && !_buffGranted)
		{
			int num = ((_potentialLv >= 3) ? 250105502 : 250105501);
			if (num > 0)
			{
				_actor.buffComponent?.AddBuff(num, _actor);
				_buffGranted = true;
			}
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
		_buffGranted = false;
	}
}
