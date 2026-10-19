using System.Collections.Generic;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class LiveareaSceneChangeEvent : TrackBaseEvt<LiveareaSceneChangeEvent>
{
	public int liveareaId;

	public int exitLiveareaId;

	public float eventDuration;

	public override void OnDispatch()
	{
		if (!EventConfigs.EventDictionary.TryGetValue("livearea_scene_change", out var value))
		{
			return;
		}
		value["livearea_id"] = liveareaId;
		value["exit_livearea_id"] = exitLiveareaId;
		value["event_duration"] = eventDuration;
		value["player_level"] = G.detailUserInfo.Attributes.GetValueOrDefault(90, 0L);
		JArray jArray = value["livearea_character_info"] as JArray;
		jArray?.Clear();
		if (RuntimeConfigs.data.areaLists.TryGetValue(liveareaId, out var value2))
		{
			int[] pointId = value2.pointId;
			foreach (int num in pointId)
			{
				if (!Model<LoungeModel>.Interface.TryGetPointCharacterInfo(num, out var info))
				{
					continue;
				}
				foreach (int item in info.character)
				{
					jArray?.Add(new JObject
					{
						["character_id"] = item,
						["location_id"] = num,
						["character_favorability_level"] = Model<LoungeModel>.Interface.GetCharacterFavorInfo(item).Item1,
						["character_level"] = ((CharacterDataHelper.TryGetCharacter(SceneStatus.Main, item, out var character) && character != null) ? character.Level : 0),
						["is_player_invite"] = info.useType == LoungeInteractPointUseType.LoungeInteractPointUseInvite
					});
				}
			}
		}
		Send("livearea_scene_change", value);
	}

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
	}
}
