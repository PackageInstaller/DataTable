using System;
using TrueSync;

namespace AIScript.Monster.Soldier._17001;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private const int buffId_Self_2 = 250102101;

	private static readonly FP hpThreshold = 0.5;

	private int _potentialLv = 1;

	private LogicEntity _target;

	private bool _buffAdded;

	private bool _reReleased;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_target = null;
		_buffAdded = false;
		_reReleased = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_buffAdded)
		{
			_actor.buffComponent.RemoveBuffByBuffId(250102101);
			_buffAdded = false;
		}
		_target = null;
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.AimAtTarget(_target);
		}
		if (_potentialLv >= 2 && _target is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && adventureActor.actorHealthInfo.hpPercentage > hpThreshold)
		{
			_actor.buffComponent.AddBuff(250102101, _actor);
			_buffAdded = true;
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		if (_potentialLv >= 3 && !_reReleased && _target != null && !_target.IsDead())
		{
			_reReleased = true;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			_skill.Clear();
		}
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}
}
