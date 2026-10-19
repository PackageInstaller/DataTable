using ACT.Core;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue魔法点", "Function", new string[] { "rogue", "magic", "point" })]
public class FunctionRogueMagicPoint : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes) == null)
		{
			return 0f;
		}
		return Model<RogueNewModel>.Interface.MagicPoints;
	}
}
