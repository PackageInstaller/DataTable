using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断援护角色索引", "Predicate", new string[] { "check", "assist", "character", "index", "predicate", "condition" })]
public class CheckAssistCharacterIndex : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAssistSKill { ownerEntity: var ownerEntity } evtAssistSKill)
		{
			if (ownerEntity.GetEntityType() != EntityType.Character)
			{
				return false;
			}
			int num = MonoECS.instance.localPlayer.IndexOfTeamCharacter(ownerEntity);
			return evtAssistSKill.index == num;
		}
		return false;
	}
}
