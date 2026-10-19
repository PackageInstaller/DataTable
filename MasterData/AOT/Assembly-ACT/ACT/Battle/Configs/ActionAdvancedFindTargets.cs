using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行高级目标", "Action", new string[] { "advanced", "find", "targets", "target", "search", "retarget", "aim" })]
public class ActionAdvancedFindTargets : ConfigAction
{
	public BaseFindTargets findCondition = new ComplexFoundTargets();

	public ActionOrder actionOrder;

	public ConfigAction[] onResult;

	public ConfigAction[] onFound;

	public ConfigAction[] onNotFound;

	public FindTargetWithActions nextFindTargetActions;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onResult, ab);
		ConfigAbility.CacheActionList(list, onFound, ab);
		ConfigAbility.CacheActionList(list, onNotFound, ab);
		nextFindTargetActions?.CacheActionList(list, ab);
	}

	public override void Do(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
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
		nextFindTargetActions?.FindTarget(memory, list);
		ListPool<FindTargetResult>.Release(list);
	}
}
