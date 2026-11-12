using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._15001;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP searchRadius = 10;

	private int PotentialLv = 1;

	private int remainingAttacks;

	private readonly List<long> attackedIds = new List<long>();

	private readonly List<LogicEntity> searchBuffer = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		attackedIds.Clear();
		searchBuffer.Clear();
	}

	public void OnStart()
	{
		remainingAttacks = 1 + ((PotentialLv >= 2) ? 1 : 0) + ((PotentialLv >= 3) ? 1 : 0);
		attackedIds.Clear();
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
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			attackedIds.Add(_actor.attackTarget.Id);
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action onComboFinish = OnComboFinish;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
	}

	private void OnComboFinish()
	{
		remainingAttacks--;
		if (remainingAttacks <= 0)
		{
			OnFinish();
			return;
		}
		LogicEntity logicEntity = FindNextTarget();
		if (logicEntity == null)
		{
			OnFinish();
			return;
		}
		_actor.attackTarget = logicEntity;
		_actor.soldierAttackTarget = logicEntity;
		DoMainLogic();
	}

	private LogicEntity FindNextTarget()
	{
		searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, searchRadius, isConfront: true, includeSelf: false, searchBuffer);
		LogicEntity logicEntity = null;
		for (int i = 0; i < searchBuffer.Count; i++)
		{
			LogicEntity logicEntity2 = searchBuffer.get_Item(i);
			ActorHealthInfo actorHealthInfo = (logicEntity2 as SoldierActor)?.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && (!(logicEntity2 is AdventureActor entity) || !entity.IsSearchedImmunity()))
			{
				if ((object)logicEntity == null)
				{
					logicEntity = logicEntity2;
				}
				if (!attackedIds.Contains(logicEntity2.Id))
				{
					return logicEntity2;
				}
			}
		}
		return logicEntity;
	}
}
