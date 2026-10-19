using System;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取 Rogue Boss 击杀数量", "Function", new string[] { "rogue", "boss", "kill", "count" })]
public class FunctionRogueBossKillCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		RogueGameInfo gameInfo = Model<RogueNewModel>.Interface.Info.GameInfo;
		RogueMode data = CoreUtils.GetData(gameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data == null)
		{
			return 0f;
		}
		int num = 0;
		int num2 = Math.Min(gameInfo.Index, data.mapNodeList.Length);
		for (int i = 0; i < num2; i++)
		{
			if (RuntimeConfigs.data.mapNodeConfigs.TryGetValue(data.mapNodeList[i], out var value) && value.nodeType == 4)
			{
				num++;
			}
		}
		return num;
	}
}
