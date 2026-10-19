using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中实体类型角色", "Predicate", new string[] { "check", "hit", "entity", "type", "is", "character", "target", "retarget", "aim", "predicate" })]
public class CheckHitEntityTypeIsCharacter : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetEntityType() switch
		{
			EntityType.Character => true, 
			EntityType.Null => false, 
			_ => false, 
		};
	}
}
