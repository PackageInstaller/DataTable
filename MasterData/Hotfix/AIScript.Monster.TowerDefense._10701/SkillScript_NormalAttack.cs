using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._10701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[4];

	private ComboInputBuffer.ActionKey[] actionKey_p1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private bool ip1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		ip1 = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_actor.CancelAttack();
		}
		if (ip1 && _actor.LogicTime - Parallel.norPlus_t > Parallel.time_1)
		{
			_actor.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		ComboInputBuffer.ActionKey[] array = actionKey;
		ip1 = false;
		if (GetPerk(1070101) && Parallel.norPlus_t > 0 && _actor.LogicTime - Parallel.norPlus_t < Parallel.time_1)
		{
			ip1 = true;
			array = actionKey_p1;
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
	}
}
