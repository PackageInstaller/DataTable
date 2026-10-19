using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue房间数量", "Function", new string[] { "rogue", "room", "count" })]
public class FunctionRogueRoomCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		RogueGameInfo gameInfo = Model<RogueNewModel>.Interface.Info.GameInfo;
		if (CoreUtils.GetData(gameInfo.ModeId, RuntimeConfigs.data.rogueModes) == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Rogue Mode Id " + gameInfo.ModeId + " not found in Rogue Modes Config");
			}
			return -1f;
		}
		return Model<RogueNewModel>.Interface.Info.GameInfo.Index;
	}
}
