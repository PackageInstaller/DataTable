using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找仇恨目标", "FindTargets", new string[] { "find", "hatred", "target" })]
public class FindHatredTarget : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (referenceEntity.IsBattleBehaveNotCharacter())
		{
			CompHatred compHatred = referenceEntity.GetCompHatred();
			if (compHatred.GetHatred().IsValid)
			{
				FindTargetResult item = FindTargetResult.EntityOnly(compHatred.GetHatred());
				if (item.IsValid)
				{
					results.Add(item);
				}
			}
		}
		else
		{
			if (!referenceEntity.IsTrajectory())
			{
				return;
			}
			Entity hatred = referenceEntity.GetCaster().GetCompHatred().GetHatred();
			if (!hatred.IsValid)
			{
				Entity hatred2 = referenceEntity.GetCompHatred().GetHatred();
				if (hatred2.IsValid)
				{
					FindTargetResult item2 = FindTargetResult.EntityOnly(hatred2);
					if (item2.IsValid)
					{
						results.Add(item2);
					}
				}
			}
			else
			{
				FindTargetResult item3 = FindTargetResult.EntityOnly(hatred);
				if (item3.IsValid)
				{
					results.Add(item3);
				}
			}
		}
	}
}
