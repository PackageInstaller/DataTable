using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Rogue标记魔法点", "Action", new string[] { "rogue", "mark", "magic", "point" })]
public class ActionRogueMarkMagicPoint : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		float num = value.Return(memory);
		Model<RogueNewModel>.Interface.MagicPoints += (int)num;
	}
}
