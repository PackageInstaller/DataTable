using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找其他队友实体", "FindTargets", new string[] { "find", "other", "teamer", "entity" })]
public class ConfigFindOtherTeamerEntity : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter != null && teamCharacter != referenceEntity)
			{
				results.Add(FindTargetResult.EntityOnly(teamCharacter));
			}
		}
	}
}
