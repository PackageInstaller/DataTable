using ACT.Battle;
using ACT.Game;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class WorldBossFightEvent : TrackBaseEvt<WorldBossFightEvent>
{
	public Entity entity;

	public double duration;

	public int result;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("world_boss_fight_event", out var value))
		{
			CompStateObject compStateObject = entity.GetCompStateObject();
			CompMonster compMonster = entity.GetCompMonster();
			value["world_level"] = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
			value["player_level"] = G.detailUserInfo.Attributes[90];
			value["event_duration"] = duration;
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["monster_id"] = compMonster.id;
			value["monster_swid"] = ((compStateObject.StateWorldAssetData != null) ? compStateObject.StateWorldAssetData.stateWorldAssetUid : (-1));
			value["monster_level"] = compMonster.level;
			value["monster_damage"] = compMonster.totalDamage;
			value["result"] = result;
			if (value["team_info"] is JArray array)
			{
				TrackBaseEvt<WorldBossFightEvent>.SetTeamInfo(array, out var _);
			}
			Send("world_boss_fight_event", value);
		}
	}
}
