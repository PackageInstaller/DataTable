using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue击杀数量", "Function", new string[] { "rogue", "kill", "count" })]
public class FunctionRogueKillCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Model<RogueNewModel>.Interface.GetTotalKillCount();
	}
}
