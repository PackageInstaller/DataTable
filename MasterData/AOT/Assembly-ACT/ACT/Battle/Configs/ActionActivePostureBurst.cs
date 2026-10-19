using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("激活架势爆发", "Action", new string[] { "active", "posture", "burst", "damage", "hit", "attack" })]
public class ActionActivePostureBurst : ConfigAction
{
	[Tooltip("开启关闭爆发态")]
	public bool active;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().SetPostureBurst(active);
		memory.target.entity.GetCompAI().ActBehaviorTree.SendEvent("enterPostureBurst");
	}
}
