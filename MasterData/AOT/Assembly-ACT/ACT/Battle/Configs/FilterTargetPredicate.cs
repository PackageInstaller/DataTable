using ACT.Utility;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断过滤目标", "Predicate", new string[] { "filter", "target", "retarget", "aim", "predicate", "check", "condition" })]
public class FilterTargetPredicate : ConfigPredicate
{
	public AllianceCondition alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public bool canBeAttack;

	public bool cantFilterInactive;

	public override bool Check(ActionMemory memory)
	{
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = canBeAttack,
			FilterEntityType = filterEntityType,
			alliance = GameUtility.GetAlliance(alliance, memory.owner.GetCompAlliance().alliance),
			cantFilterInactive = cantFilterInactive
		};
		return whereTargets.Check(memory.owner, memory.target.entity);
	}
}
