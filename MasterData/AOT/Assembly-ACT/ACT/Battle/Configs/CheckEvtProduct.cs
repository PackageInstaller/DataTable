using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断事件产物", "Predicate", new string[] { "check", "evt", "product", "predicate", "condition" })]
public class CheckEvtProduct : ConfigPredicate
{
	public AbilityOwnerCheckType checkType;

	public override bool Check(ActionMemory memory)
	{
		if (memory.ability == null)
		{
			return false;
		}
		Entity owner = memory.ability.owner;
		Entity entity = owner;
		if (owner.TryGetCompProduct(out CompProduct component))
		{
			switch (checkType)
			{
			case AbilityOwnerCheckType.CasterRoot:
				entity = component.caster;
				break;
			case AbilityOwnerCheckType.Owner:
				entity = component.productOwner;
				break;
			case AbilityOwnerCheckType.ActionSource:
				entity = component.actionSource;
				break;
			case AbilityOwnerCheckType.AbilityOwner:
				entity = owner;
				break;
			default:
				return false;
			}
		}
		return entity == memory.evt.mainEntity;
	}
}
