using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue地图击杀数量", "Function", new string[] { "rogue", "map", "kill", "count" })]
public class FunctionRogueMapKillCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Model<RogueNewModel>.Interface.GetCurrentMapKillCount();
	}
}
