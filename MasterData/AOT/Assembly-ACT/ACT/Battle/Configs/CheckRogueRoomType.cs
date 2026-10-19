using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Runtime.Model;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Rogue房间类型", "Predicate", new string[] { "check", "rogue", "room", "type", "predicate", "condition" })]
public class CheckRogueRoomType : ConfigPredicate
{
	public RogueRoomType roomType;

	public override bool Check(ActionMemory memory)
	{
		if (CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes) == null)
		{
			return false;
		}
		return Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == roomType;
	}
}
