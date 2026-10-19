using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体Volume", "Predicate", new string[] { "check", "entity", "volume", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityVolume : ConfigPredicate
{
	public bool multiChoose;

	public CheckTarget target;

	public MonsterWeigtType checkVolumeType;

	public List<MonsterWeigtType> targetList;

	public override bool Check(ActionMemory memory)
	{
		MonsterWeigtType monsterWeigtType = MonsterWeigtType.Normal;
		ConfigCharacter config = ((target == CheckTarget.Target) ? memory.target.entity : memory.owner).GetConfig();
		if ((object)config == null)
		{
			return false;
		}
		monsterWeigtType = config.monsterWeigtType;
		if (multiChoose && targetList != null && targetList.Count > 0)
		{
			return targetList.Contains(monsterWeigtType);
		}
		return monsterWeigtType == checkVolumeType;
	}
}
