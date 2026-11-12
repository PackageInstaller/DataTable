using System;

namespace AIScript.Monster.Soldier._118;

public class NormalSkill : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[4];

	public void OnUpdate()
	{
		LockDirection();
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
