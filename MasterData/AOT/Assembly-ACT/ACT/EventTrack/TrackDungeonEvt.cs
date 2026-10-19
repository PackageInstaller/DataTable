using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class TrackDungeonEvt : TrackBaseEvt<TrackDungeonEvt>
{
	public int dungeonId;

	public int status;

	public float eventDuration;

	public bool isRestart;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("dungeon_event", out var value) && !string.IsNullOrWhiteSpace(SetTransNo(value)))
		{
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["dungeon_id"] = dungeonId;
			value["player_level"] = SystemUnlockManager.playerLevel;
			value["status"] = status;
			value["event_duration"] = eventDuration;
			value["is_restart"] = isRestart;
			TrackBaseEvt<TrackDungeonEvt>.SetTeamInfo((JArray)value["team_info"], out var _, value);
			_ = LuminApplication.LogEnabled;
			Send("dungeon_event", value);
		}
	}
}
