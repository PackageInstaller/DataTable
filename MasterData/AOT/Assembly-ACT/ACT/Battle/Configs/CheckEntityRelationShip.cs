using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体关系Ship", "Predicate", new string[] { "check", "entity", "relation", "ship", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityRelationShip : ConfigPredicate
{
	public enum RelationShipType
	{
		isMainEntity,
		isSwitchEntity,
		targetIsCaster,
		isTeamMate
	}

	public CheckTarget target;

	public RelationShipType relationShipType;

	public override bool Check(ActionMemory memory)
	{
		MPPlayer local = MPPlayer.local;
		EntityId entityId = EntityId.Invalid;
		switch (target)
		{
		case CheckTarget.Default:
		case CheckTarget.Target:
			entityId = memory.target.entity.Id;
			break;
		case CheckTarget.Owner:
			entityId = memory.owner.Id;
			break;
		}
		return relationShipType switch
		{
			RelationShipType.isMainEntity => entityId == local.battleEntity.Id, 
			RelationShipType.isSwitchEntity => local.IdIsSwitchCharacter(entityId), 
			RelationShipType.isTeamMate => local.IdIsTeamCharacter(entityId) && entityId != memory.owner.Id, 
			RelationShipType.targetIsCaster => entityId == memory.caster.Id, 
			_ => false, 
		};
	}
}
