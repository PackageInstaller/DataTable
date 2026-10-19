using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("根据条件查找目标实体并执行后续动作", "Action", new string[] { "find", "target", "search" })]
public class ActionFindTargets : ConfigAction
{
	public AllianceCondition alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public bool canBeAttack;

	public bool cantFilterInactive;

	public BaseFindTargets findCondition;

	public ActionOrder actionOrder;

	public ConfigAction[] onResultBefore;

	public ConfigAction[] onResult;

	public ConfigAction[] onFound;

	public ConfigAction[] onNotFound;

	public bool extend;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onResult, ab);
		ConfigAbility.CacheActionList(list, onFound, ab);
		ConfigAbility.CacheActionList(list, onNotFound, ab);
		ConfigAbility.CacheActionList(list, onResultBefore, ab);
	}

	public override void Do(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = canBeAttack,
			FilterEntityType = filterEntityType,
			alliance = GameUtility.GetAlliance(alliance, memory.owner.GetCompAlliance().alliance),
			cantFilterInactive = cantFilterInactive
		};
		findCondition.FindTargets(memory, list, whereTargets);
		if (list.Count > 0)
		{
			if (extend && onResultBefore != null)
			{
				foreach (FindTargetResult item in list)
				{
					SystemAbility.DoActions(memory.caster, memory.owner, item, memory.evt, memory.ability, onResultBefore);
				}
			}
			if (actionOrder == ActionOrder.FoundBeforeResult)
			{
				if (onFound != null)
				{
					SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, onFound);
				}
				if (onResult != null)
				{
					foreach (FindTargetResult item2 in list)
					{
						SystemAbility.DoActions(memory.caster, memory.owner, item2, memory.evt, memory.ability, onResult);
					}
				}
			}
			else if (actionOrder == ActionOrder.ResultBeforeFound)
			{
				if (onResult != null)
				{
					foreach (FindTargetResult item3 in list)
					{
						SystemAbility.DoActions(memory.caster, memory.owner, item3, memory.evt, memory.ability, onResult);
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
		ListPool<FindTargetResult>.Release(list);
	}
}
