using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取普通能量", "Function", new string[] { "get", "normal", "energy" })]
public class GetNormalEnergy : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return memory.target.entity.GetCompAbility().EnergyValue;
	}
}
