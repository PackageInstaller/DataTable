using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Rogue普通房间类型", "Predicate", new string[] { "check", "rogue", "normal", "room", "type", "predicate", "condition" })]
public class CheckRogueNormalRoomType : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes) == null)
		{
			return false;
		}
		if (Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType != RogueRoomType.Ally && Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType != RogueRoomType.Item)
		{
			return Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Cion;
		}
		return true;
	}
}
