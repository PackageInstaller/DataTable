using System;
using System.Collections.Generic;
using ACT.Game;
using ACT.Model;
using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class AbyssSettlement : TrackBaseEvt<AbyssSettlement>
{
	public class SubInfo
	{
		public int status;

		public int worldId;

		public int subStageId;

		public float duration;

		public string transNo;

		public int potionId;

		public IEnumerable<int> characters;

		public IEnumerable<int> capacity;

		private DateTime startTime;

		public void Init()
		{
			TrackBaseEvt<AbyssSettlement>.SetTeamInfo(new JArray(), out var ids);
			characters = ids;
			potionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			IEnumerable<int> enumerable;
			if (potionId != 0)
			{
				IEnumerable<int> keys = Model<BloodBottleModel>.Interface.bottleMaterials.Keys;
				enumerable = keys;
			}
			else
			{
				IEnumerable<int> keys = new List<int>();
				enumerable = keys;
			}
			capacity = enumerable;
			startTime = DateTime.Now;
			worldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			if (G.localPlayer.Profile.SceneInfos.TryGetValue(2, out var value))
			{
				transNo = value.TransNo;
			}
		}

		public void Set(JObject jObject)
		{
			jObject["world_id"] = worldId;
			jObject["event_duration"] = duration;
			jObject["status"] = status;
			jObject["sub_stage_id"] = subStageId;
			jObject["potion_id"] = potionId;
			jObject["capacity"] = new JArray(capacity);
			jObject["character_list"] = new JArray(characters);
			jObject["trans_no"] = transNo;
		}
	}

	public int stageId;

	public int abyssId;

	public int status;

	public int star;

	public static int restartNum;

	public static Dictionary<int, SubInfo> subInfo;

	public static void New()
	{
		subInfo = new Dictionary<int, SubInfo>();
		restartNum = 0;
	}

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (!EventConfigs.EventDictionary.TryGetValue("abyss_settlement", out var value))
		{
			return;
		}
		float num = 0f;
		value["stage_id"] = stageId;
		value["abyss_id"] = abyssId;
		value["player_level"] = SystemUnlockManager.playerLevel;
		value["status"] = status;
		value["star"] = star;
		value["star"] = star;
		value["restart_num"] = restartNum;
		JArray jArray = (JArray)(value["sub_info"] = new JArray());
		foreach (KeyValuePair<int, SubInfo> item in subInfo)
		{
			JObject jObject = new JObject();
			item.Value.Set(jObject);
			jArray.Add(jObject);
			num += item.Value.duration;
		}
		value["event_duration"] = num;
	}
}
