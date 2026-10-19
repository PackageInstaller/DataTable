using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

[AbilityTypeMetadata("添加架势Segment", "Action", new string[] { "add", "posture", "segment", "damage", "hit", "attack" })]
public class ActionAddPostureSegment : ConfigAction
{
	public ConfigFunction<float> segment;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().SetPostureActive(value: true);
		memory.target.entity.GetCompAI().ActBehaviorTree.SendEvent("enterPosture");
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddPostureSegment(memory.target.entity, (int)segment.Return(memory));
	}
}
