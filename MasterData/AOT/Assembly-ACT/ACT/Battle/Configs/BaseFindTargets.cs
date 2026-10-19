using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class BaseFindTargets
{
	public FunctionResultMode resultMode;

	public string blackboardKey;

	public BlackboardScope blackboardScope;

	public abstract void FindTargets(Entity referenceEntity, List<FindTargetResult> results);

	public void FindTargets(ActionMemory memory, List<FindTargetResult> results)
	{
		FindTargets(memory, memory.target.entity, results);
	}

	public void FindTargets(ActionMemory memory, Entity referenceEntity, List<FindTargetResult> results)
	{
		FindTargetsCore(memory, referenceEntity, results);
		WriteTargetsToBlackboard(memory, results);
	}

	public void FindTargets(ActionMemory memory, List<FindTargetResult> results, WhereTargets where)
	{
		FindTargetsCore(memory, memory.target.entity, results);
		where.FindTargets(results, memory.owner);
		WriteTargetsToBlackboard(memory, results);
	}

	public void FindTargets(ActionMemory memory, List<FindTargetResult> results, Predicate<FindTargetResult> predicate)
	{
		FindTargetsCore(memory, memory.target.entity, results);
		Where(results, predicate);
		WriteTargetsToBlackboard(memory, results);
	}

	protected virtual void FindTargetsCore(ActionMemory memory, Entity referenceEntity, List<FindTargetResult> results)
	{
		FindTargets(referenceEntity, results);
	}

	private void WriteTargetsToBlackboard(ActionMemory memory, List<FindTargetResult> targets)
	{
		if (resultMode != FunctionResultMode.GetAndSetBlackboard)
		{
			return;
		}
		BattleBlackboard orCreateBlackboard = memory.GetOrCreateBlackboard(blackboardScope);
		if (orCreateBlackboard == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"{GetType().Name} tried to write {blackboardScope} blackboard, but it is unavailable. Ability: {memory.ability}");
			}
			return;
		}
		EntityReference[] array = new EntityReference[targets.Count];
		for (int i = 0; i < targets.Count; i++)
		{
			array[i] = targets[i].entity;
		}
		orCreateBlackboard.Set(blackboardKey, array);
	}

	public static void Where(List<FindTargetResult> results, Predicate<FindTargetResult> predicate)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (!predicate(results[num]))
			{
				results.RemoveAt(num);
			}
		}
	}

	public static void Where(Entity referenceEntity, List<FindTargetResult> results, ConfigPredicate predicate)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (!predicate.Check(new ActionMemory(referenceEntity.GetCaster(), referenceEntity, results[num])))
			{
				results.RemoveAt(num);
			}
		}
	}

	public virtual void OnInit()
	{
	}
}
