using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle.Configs;

public class FindTargetWithActions
{
	public BaseFindTargets findCondition;

	public ActionOrder actionOrder;

	public bool overrideResults;

	public ConfigAction[] onResult;

	public ConfigAction[] onFound;

	public ConfigAction[] onNotFound;

	public FindTargetWithActions nextFindTargetActions;

	public void FindTarget(ActionMemory memory, List<FindTargetResult> findTargetResults)
	{
		List<FindTargetResult> list = findTargetResults;
		if (!overrideResults)
		{
			list = ListPool<FindTargetResult>.Get();
			list.AddRange(findTargetResults);
		}
		findCondition.FindTargets(memory, list);
		if (list.Count > 0)
		{
			if (actionOrder == ActionOrder.FoundBeforeResult)
			{
				if (onFound != null)
				{
					SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, onFound);
				}
				if (onResult != null)
				{
					foreach (FindTargetResult item in list)
					{
						SystemAbility.DoActions(memory.caster, memory.owner, item, memory.evt, memory.ability, onResult);
					}
				}
			}
			else if (actionOrder == ActionOrder.ResultBeforeFound)
			{
				if (onResult != null)
				{
					foreach (FindTargetResult item2 in list)
					{
						SystemAbility.DoActions(memory.caster, memory.owner, item2, memory.evt, memory.ability, onResult);
					}
				}
				if (onFound != null)
				{
					SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, onFound);
				}
			}
		}
		else if (onNotFound != null)
		{
			SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, onNotFound);
		}
		nextFindTargetActions?.FindTarget(memory, findTargetResults);
		if (!overrideResults)
		{
			ListPool<FindTargetResult>.Release(list);
		}
	}

	public void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onResult, ab);
		ConfigAbility.CacheActionList(list, onFound, ab);
		ConfigAbility.CacheActionList(list, onNotFound, ab);
		nextFindTargetActions?.CacheActionList(list, ab);
	}
}
