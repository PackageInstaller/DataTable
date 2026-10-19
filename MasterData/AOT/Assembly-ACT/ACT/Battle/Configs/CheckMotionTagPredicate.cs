using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动作标签", "Predicate", new string[] { "check", "motion", "tag", "state", "status", "predicate", "condition" })]
public class CheckMotionTagPredicate : ConfigPredicate
{
	public List<MotionTag_backUp> tag;

	public override bool Check(ActionMemory memory)
	{
		bool result = true;
		if (memory.target.entity.IsValid)
		{
			for (int i = 0; i < tag.Count; i++)
			{
				if (!memory.target.entity.InTag(tag[i]))
				{
					result = false;
				}
			}
		}
		return result;
	}
}
