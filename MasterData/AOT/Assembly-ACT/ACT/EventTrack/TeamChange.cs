using System.Collections.Generic;
using System.Linq;
using ACT.Game;
using ACT.Model;
using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class TeamChange : TrackBaseEvt<TeamChange>
{
	public int changeType;

	private List<int> beforeIds;

	private List<int> afterIds;

	private int beforePotionId;

	private int afterPotionId;

	private List<int> beforeCapacity;

	private List<int> afterCapacity;

	private int teamId;

	public void RecordBeforeChange()
	{
		if (EventConfigs.EventDictionary.TryGetValue("team_change", out var value))
		{
			JArray array = (JArray)(value["exit_team_info"] = new JArray());
			TrackBaseEvt<TeamChange>.SetTeamInfo(array, out beforeIds);
			value["exit_potion_id"] = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			value["exit_capacity"] = new JArray(Model<BloodBottleModel>.Interface.bottleMaterials.Keys);
			beforePotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			beforeCapacity = Model<BloodBottleModel>.Interface.bottleMaterials.Keys.ToList();
			teamId = G.localPlayer.teamInfo.MainTeamIdx;
		}
	}

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (!EventConfigs.EventDictionary.TryGetValue("team_change", out var value))
		{
			return;
		}
		JArray array = (JArray)(value["team_info"] = new JArray());
		TrackBaseEvt<TeamChange>.SetTeamInfo(array, out afterIds, value);
		afterPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
		afterCapacity = Model<BloodBottleModel>.Interface.bottleMaterials.Keys.ToList();
		if (G.localPlayer.teamInfo.MainTeamIdx != teamId)
		{
			changeType = 2;
		}
		else
		{
			if (beforeIds.SequenceEqual(afterIds) && beforeCapacity.SequenceEqual(afterCapacity) && beforePotionId == afterPotionId)
			{
				return;
			}
			changeType = 1;
		}
		value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		value["change_type"] = changeType;
		Send("team_change", value);
	}

	public override void ReleaseEvt()
	{
		beforeIds?.Clear();
		afterIds?.Clear();
		beforeCapacity?.Clear();
		afterCapacity?.Clear();
		base.ReleaseEvt();
	}
}
