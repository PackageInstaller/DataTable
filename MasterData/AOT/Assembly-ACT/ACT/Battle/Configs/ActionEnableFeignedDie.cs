using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行EnableFeignedDie", "Action", new string[] { "enable", "feigned", "die" })]
public class ActionEnableFeignedDie : ConfigAction
{
	public bool enable;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().zeroHpFeignedDie = enable;
	}
}
