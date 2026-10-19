using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("消耗能量", "Action", new string[] { "consume", "energy" })]
public class ActionConsumeEnergy : ConfigAction
{
	public bool consumeAll;

	public DynamicFloat energy;

	public override void Do(ActionMemory memory)
	{
		if (consumeAll)
		{
			memory.target.entity.GetCompAbility().CurrentUltimateSkillValue = 0f;
		}
		else
		{
			memory.target.entity.GetCompAbility().CurrentUltimateSkillValue -= energy.GetFloat(memory.ability);
		}
	}
}
