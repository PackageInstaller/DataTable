using Bamboo.Collections;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断自身技能是否有特殊 Buff 类型", "Predicate", new string[] { "chec", "self", "ability", "have", "specail", "buff", "type", "state", "status", "tag" })]
public class ChecSelfAbilityHaveSpecailBuffType : ConfigPredicate
{
	public enum SpecailBuffType
	{
		normal,
		specialDebuff
	}

	public BuffType type;

	public SpecailBuffType haveSpecailBuffType;

	public override bool Check(ActionMemory memory)
	{
		BSet<Ability> abilities = memory.target.entity.GetCompAbility().abilities;
		bool result = false;
		if (type == BuffType.Debuff && haveSpecailBuffType == SpecailBuffType.specialDebuff)
		{
			foreach (Ability item in abilities)
			{
				if (item.config.buffType == BuffType.Debuff && item.config.debuffName != 0)
				{
					result = true;
					break;
				}
			}
		}
		else
		{
			foreach (Ability item2 in abilities)
			{
				if (item2.config.buffType == type)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}
}
