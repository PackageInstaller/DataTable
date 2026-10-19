using ACT.Game.Data;
using ACT.Model;

namespace ACT.Event;

public class SetBattleMainMissionState : BaseEventContent
{
	public MissionState mission;

	public BattleMainTaskTipModelV2.MissionState missionState;
}
