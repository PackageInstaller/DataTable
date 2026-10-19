using ACT.Game.Data;
using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class AbyssChangeEvt : TrackBaseEvt<AbyssChangeEvt>
{
	public int stageId;

	public int abyssId;

	public int subAbyssId;

	public int status;

	public float duration;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("abyss_event", out var value))
		{
			TrackBaseEvt<AbyssChangeEvt>.SetTransNo(value, SceneStatus.Abyss);
			value["stage_id"] = stageId;
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["abyss_id"] = abyssId;
			value["sub_stage_id"] = subAbyssId;
			value["status"] = status;
			TrackBaseEvt<AbyssChangeEvt>.SetTeamInfo((JArray)value["team_info"], out var _, value);
			value["event_duration"] = duration;
			value["player_level"] = SystemUnlockManager.playerLevel;
			_ = LuminApplication.LogEnabled;
			Send("abyss_event", value);
		}
	}
}
