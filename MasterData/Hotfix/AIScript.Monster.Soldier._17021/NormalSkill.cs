using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._17021;

public class NormalSkill : SkillAdvancedBase
{
	private const string comboTag = "Attack";

	private static readonly FP dashSpeed = 15;

	private static readonly FP ringRadius = 10;

	private const int dashTimes = 2;

	private Dash _dash;

	private TSVector2 _dashTargetPos;

	private int _dashIndex;

	private bool _aborted;

	private readonly List<AdventureActor> _enemyBuffer = new List<AdventureActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_dashIndex = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		ILRuntimeAPI.InterruptDash(_dash);
		ILRuntimeAPI.ClearDash(_dash);
		_dash = null;
		_actor.DisableCloseBlock();
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
		_aborted = true;
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_dashIndex = 0;
		Action onAnticipationEnd = OnLoopBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnLoopBegin()
	{
		if (!_aborted)
		{
			BeginDashTo(PickRandomEnemyPos());
		}
	}

	private void BeginDashTo(TSVector2 targetPos)
	{
		_dashTargetPos = targetPos;
		_actor.LookAt(_dashTargetPos, 0);
		FP distance = TSVector2.Distance(_actor.tsTransform.Position, _dashTargetPos);
		if (_dashIndex == 0)
		{
			distance += (FP)6;
		}
		_dashIndex++;
		_actor.EnableCloseBlock();
		ILRuntimeAPI.BeginDashActorForward(ref _dash, _actor, dashSpeed, distance, 0, OnDashFinish, OnDashFinish, OnDashFinish, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnDashFinish()
	{
		_actor.DisableCloseBlock();
		if (!_aborted)
		{
			if (_dashIndex < 2)
			{
				BeginDashTo(PickRingPos());
			}
			else
			{
				comboAttack?.CancelAttack();
			}
		}
	}

	private TSVector2 PickRandomEnemyPos()
	{
		_enemyBuffer.Clear();
		List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
		for (int i = 0; i < confrontFactionActors.Count; i++)
		{
			AdventureActor adventureActor = confrontFactionActors.get_Item(i);
			if (!(adventureActor == null))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					_enemyBuffer.Add(adventureActor);
				}
			}
		}
		if (_enemyBuffer.Count == 0)
		{
			return PickRingPos();
		}
		int index = TSRandom.Range(0, _enemyBuffer.Count);
		return _enemyBuffer.get_Item(index).tsTransform.Position;
	}

	private TSVector2 PickRingPos()
	{
		for (int i = 0; i < 30; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(TSVector2.zero, ringRadius, ringRadius);
			if (_actor.QueryPositionWalkable(tSVector))
			{
				return tSVector;
			}
		}
		return new TSVector2(0, ringRadius);
	}
}
