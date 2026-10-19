using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue地图伤害", "Function", new string[] { "rogue", "map", "damage" })]
public class FunctionRogueMapDamage : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Model<RogueNewModel>.Interface.GetCurrentMapDamage();
	}
}
