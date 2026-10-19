using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("恢复架势", "Action", new string[] { "revive", "posture", "damage", "hit", "attack" })]
public class ActionRevivePosture : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		CompAbility compAbility = memory.owner.GetCompAbility();
		if (compAbility.IsHavePosture)
		{
			compAbility.ServerSetRevivePostureProgress(1f);
		}
	}
}
