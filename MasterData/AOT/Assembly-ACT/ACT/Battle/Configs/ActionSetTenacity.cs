using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置韧性", "Action", new string[] { "set", "tenacity", "damage", "hit", "attack" })]
public class ActionSetTenacity : ConfigAction
{
	public bool IsSetMax;

	public bool IsSetZero;

	public ConfigFunction<int> tenacity;

	public bool isOwner;

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		CompAbility compAbility = (isOwner ? memory.owner : memory.target.entity).GetCompAbility();
		if (IsSetMax)
		{
			compAbility.ServerSetTenacity(compAbility.maxTenacity);
		}
		else if (IsSetZero)
		{
			compAbility.ServerSetTenacity(0);
		}
		else
		{
			compAbility.ServerSetTenacity(tenacity.Return(memory));
		}
	}
}
