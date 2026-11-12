using System;

namespace AIScript.Monster.Soldier._137;

public class NormalSkill : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[5];

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		LockDirection();
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
