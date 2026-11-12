using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._10005;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "Skill_1";

	private const string comboTag_Ex = "Skill_2";

	private static readonly FP dashSpeed = 40;

	private static readonly FP dashDistanceExtra = 3;

	private const int buffOnHitId = 250103301;

	private int _potentialLv = 1;

	private Dash _dash;

	private bool _dashing;

	private AdventureActor _target;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_dashing = false;
		_target = null;
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dashing = false;
		_target = null;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		_actor.CancelAiming();
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
	}

	private void DoMainLogic()
	{
		_target = FindFarthestConfrontTarget();
		if (_target != null)
		{
			_actor.attackTarget = _target;
			_actor.soldierAttackTarget = _target;
			_actor.AimAtTarget(_target);
		}
		string actionTag = ((_potentialLv >= 2) ? "Skill_2" : "Skill_1");
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		if (_target == null || _target.IsDead())
		{
			comboAttack?.CancelAttack();
			return;
		}
		_actor.LookAt(_target.tsTransform.Position, 0);
		FP distance = TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) + dashDistanceExtra;
		_dashing = true;
		ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnDashFinish()
	{
		_dashing = false;
		comboAttack?.CancelAttack();
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (_dashing && _potentialLv < 3 && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.to is AdventureActor)
		{
			_actor.buffComponent?.AddBuff(250103301, _actor);
		}
	}

	private AdventureActor FindFarthestConfrontTarget()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		for (int num = _searchBuffer.Count - 1; num >= 0; num--)
		{
			if (_searchBuffer.get_Item(num) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return adventureActor;
			}
		}
		return null;
	}
}
