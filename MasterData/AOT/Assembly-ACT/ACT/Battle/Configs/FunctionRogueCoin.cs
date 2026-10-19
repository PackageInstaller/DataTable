using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue金币", "Function", new string[] { "rogue", "coin" })]
public class FunctionRogueCoin : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Model<RogueNewModel>.Interface.GetRogueCoin();
	}
}
