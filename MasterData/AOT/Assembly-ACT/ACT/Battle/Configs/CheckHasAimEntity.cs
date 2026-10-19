using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断瞄准实体", "Predicate", new string[] { "check", "has", "aim", "entity", "target", "retarget", "predicate", "condition" })]
public class CheckHasAimEntity : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.caster.GetCompAim().aimEntity.IsValid;
	}
}
