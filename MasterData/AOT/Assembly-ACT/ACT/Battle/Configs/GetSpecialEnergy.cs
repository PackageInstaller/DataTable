using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取特殊能量", "Function", new string[] { "get", "special", "energy" })]
public class GetSpecialEnergy : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return memory.target.entity.GetCompAbility().SpecialEnergyValue;
	}
}
