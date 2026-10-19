using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Taunt", "Action", new string[] { "taunt" })]
public class ActionTaunt : ConfigAction
{
	public bool taunt;

	public bool aplyProduct;

	public int tauntLevel;

	public override void Do(ActionMemory memory)
	{
		if (!memory.target.entity.IsBattleBehaveNotCharacter())
		{
			return;
		}
		if (taunt)
		{
			if (aplyProduct)
			{
				List<Entity> list = ListPool<Entity>.Get();
				SystemProduct.GetCasterProductEntity(memory.ability.caster, ref list);
				foreach (Entity item in list)
				{
					if (item.IsTrajectory() && item.GetCompProduct().AbilityEntityType == AbilityEntityType.Taunt)
					{
						memory.target.entity.SetHatred(item, tauntLevel);
						break;
					}
				}
				ListPool<Entity>.Release(list);
			}
			else
			{
				memory.target.entity.SetHatred(memory.ability.caster, tauntLevel);
			}
		}
		else
		{
			CompHatred? compHatred = memory.target.entity.GetCompHatred();
			compHatred.ClearHatred();
			compHatred.hatredLevel = 0;
		}
	}
}
