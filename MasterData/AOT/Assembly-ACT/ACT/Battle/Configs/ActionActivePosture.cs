using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("激活架势", "Action", new string[] { "active", "posture", "damage", "hit", "attack" })]
public class ActionActivePosture : ConfigAction
{
	public bool active;

	public bool recovery;

	public override void Do(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		compAbility.SetPostureActive(active);
		memory.target.entity.GetCompAI().ActBehaviorTree.SendEvent("enterPosture");
		if (recovery)
		{
			compAbility.ServerSetPosture(compAbility.maxPosture);
		}
	}
}
