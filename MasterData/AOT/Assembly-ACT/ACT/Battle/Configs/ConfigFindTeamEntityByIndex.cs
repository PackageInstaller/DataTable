using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找队伍实体按索引", "FindTargets", new string[] { "find", "team", "entity", "by", "index" })]
public class ConfigFindTeamEntityByIndex : BaseFindTargets
{
	public ConfigFunction<float> index;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		float num = index.Return(new ActionMemory(referenceEntity, referenceEntity, referenceEntity));
		Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter((int)num);
		if (teamCharacter != null)
		{
			results.Add(FindTargetResult.EntityOnly(teamCharacter));
		}
	}
}
