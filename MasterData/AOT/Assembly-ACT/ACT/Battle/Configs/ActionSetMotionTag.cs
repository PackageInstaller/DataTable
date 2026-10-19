using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置动作标签", "Action", new string[] { "set", "motion", "tag", "state", "status" })]
public class ActionSetMotionTag : ConfigAction
{
	public List<MotionTag_backUp> motionTag;

	public override void Do(ActionMemory memory)
	{
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		for (int i = 0; i < motionTag.Count; i++)
		{
			compMotion.motionTags |= (ulong)(1L << (int)motionTag[i]);
		}
	}
}
