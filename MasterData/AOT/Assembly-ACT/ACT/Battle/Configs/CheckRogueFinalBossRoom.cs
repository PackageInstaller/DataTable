using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Rogue最终Boss房间", "Predicate", new string[] { "check", "rogue", "final", "boss", "room", "predicate", "condition" })]
public class CheckRogueFinalBossRoom : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		RogueGameInfo gameInfo = Model<RogueNewModel>.Interface.Info.GameInfo;
		RogueMode data = CoreUtils.GetData(gameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data == null || gameInfo.RoomInfo.RoomType != RogueRoomType.Boss)
		{
			return false;
		}
		return gameInfo.Index == data.mapNodeList.Length - 1;
	}
}
