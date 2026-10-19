using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue伤害", "Function", new string[] { "rogue", "damage" })]
public class FunctionRogueDamage : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return Model<RogueNewModel>.Interface.GetTotalDamage();
	}
}
