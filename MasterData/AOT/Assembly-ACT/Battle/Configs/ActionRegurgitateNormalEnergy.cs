using ACT.Battle.Configs;
using Bamboo.ECS;

namespace Battle.Configs;

[AbilityTypeMetadata("执行返还普通能量", "Action", new string[] { "regurgitate", "normal", "energy" })]
public class ActionRegurgitateNormalEnergy : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility()?.ActionRegurgitateNormalEnergy(value.Return(memory), memory.ability);
	}
}
