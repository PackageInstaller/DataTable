using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._114;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_Shoot = "shoot2";

	public const string dispatchEventName_Shoot = "shoot2";

	private int loopCount;

	private readonly List<LogicEntity> searchBuffer = new List<LogicEntity>();

	public void OnStart()
	{
		loopCount = 0;
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		loopCount++;
		if (loopCount > 0)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Shoot))
		{
			DispatchShootToParallel();
		}
	}

	private void DispatchShootToParallel()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventName = "shoot2";
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.target = _actor.attackTarget;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private void PickTwoTargets(out LogicEntity first, out LogicEntity second)
	{
		first = (IsTargetValid(_actor.attackTarget) ? _actor.attackTarget : null);
		second = null;
		searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, searchBuffer);
		for (int i = 0; i < searchBuffer.Count; i++)
		{
			LogicEntity logicEntity = searchBuffer.get_Item(i);
			if (IsTargetValid(logicEntity))
			{
				if (first == null)
				{
					first = logicEntity;
				}
				else if ((object)logicEntity != first)
				{
					second = logicEntity;
					break;
				}
			}
		}
		searchBuffer.Clear();
		if (second == null)
		{
			second = first;
		}
	}

	private bool IsTargetValid(LogicEntity entity)
	{
		if (entity is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity())
		{
			if (adventureActor is SoldierActor soldierActor)
			{
				return !soldierActor.isSupport;
			}
			return true;
		}
		return false;
	}

	private void ShootParabolaBullet(TSVector2 shootOffset, FP shootPositionY, LogicEntity target)
	{
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
