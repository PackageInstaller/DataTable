using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace Battle.Configs.Ability.Action;

[AbilityTypeMetadata("修改阵营", "Action", new string[] { "change", "alliance" })]
public class ActionChangeAlliance : ConfigAction
{
	public Alliance newAlliance;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.SetAlliance(newAlliance);
	}
}
