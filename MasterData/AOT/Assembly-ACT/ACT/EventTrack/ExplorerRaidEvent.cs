using ACT.Core;
using ACT.Game;
using ACT.Model;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class ExplorerRaidEvent : TrackBaseEvt<ExplorerRaidEvent>
{
	public int status;

	public int worldId;

	public int raidId;

	public float eventDuration;

	public float collectorId;

	public float collectorNum;

	public float collectorTotal;

	public float dieCount;

	public float trapCount;

	public bool isRestart;

	public override void OnDispatch()
	{
		RuntimeConfigs.data.raidTypeDatas.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
		if (EventConfigs.EventDictionary.TryGetValue("exploreraid_event", out var value2))
		{
			JArray array = (JArray)(value2["team_info"] = new JArray());
			TrackBaseEvt<ExplorerRaidEvent>.SetTeamInfo(array, out var _, value2);
			value2["raid_id"] = Model<RaidModel>.Interface.CurrentRaidId;
			value2["raid_type"] = value?.raidType ?? 0;
			SetTransNo(value2);
			value2["world_id"] = worldId;
			value2["raid_id"] = raidId;
			value2["cycle_type"] = value?.cycleType ?? 0;
			value2["group_id"] = G.localPlayer.teamInfo.MainTeamIdx;
			value2["player_level"] = SystemUnlockManager.playerLevel;
			value2["status"] = status;
			value2["event_duration"] = eventDuration;
			value2["collector_id"] = collectorId;
			value2["collector_num"] = collectorNum;
			value2["collector_total"] = collectorTotal;
			value2["die_count"] = dieCount;
			value2["trap_count"] = trapCount;
			value2["is_restart"] = isRestart;
			Send("exploreraid_event", value2);
		}
	}
}
