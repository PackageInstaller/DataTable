using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标瞄准实体", "Predicate", new string[] { "check", "target", "is", "aim", "entity", "retarget", "predicate", "condition" })]
public class CheckTargetIsAimEntity : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		Entity? entity = memory.caster.GetCompAim()?.aimEntity;
		if (entity.HasValue)
		{
			Entity valueOrDefault = entity.GetValueOrDefault();
			if (valueOrDefault.IsValid)
			{
				return memory.target.entity.Id == valueOrDefault.Id;
			}
		}
		return false;
	}
}
