using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置生命值", "Action", new string[] { "set", "hp", "heal", "recover" })]
public class ActionSetHP : ConfigAction
{
	public ConfigFunction<int> HP;

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().ServerSetHP(HP.Return(memory));
	}
}
