using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class InstanceDungeonEvent : TrackBaseEvt<InstanceDungeonEvent>
{
	public int areaId;

	public float eventDuration;

	public int status;

	public int star;

	public int worldId;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("instancedungeon_event", out var value))
		{
			SetTransNo(value);
			value["world_id"] = worldId;
			value["area_id"] = areaId;
			value["event_duration"] = eventDuration;
			value["status"] = status;
			value["star"] = star;
			value["player_level"] = SystemUnlockManager.playerLevel;
			JArray array = (JArray)(value["team_info"] = new JArray());
			TrackBaseEvt<InstanceDungeonEvent>.SetTeamInfo(array, out var _, value);
		}
	}
}
