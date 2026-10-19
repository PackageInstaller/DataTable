using ACT.Core;
using ACT.Model;

namespace ACT.EventTrack;

public class TeachingTrainGround : TrackBaseEvt<TeachingTrainGround>
{
	public int processId;

	public int status;

	public int result;

	public float eventDuration;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (!EventConfigs.EventDictionary.TryGetValue("teachingtrain_ground", out var value))
		{
			return;
		}
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		int key = 0;
		if (RuntimeConfigs.data.raids.TryGetValue(currentRaidId, out var value2))
		{
			key = value2.belongEntranceData;
		}
		SetTransNo(value);
		if (status != 4 && status != 5)
		{
			value["raid_id"] = currentRaidId;
		}
		value["process_id"] = processId;
		value["type"] = 0;
		if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(key, out var value3))
		{
			if (value3.raidType == 6)
			{
				value["type"] = 1;
			}
			else if (value3.raidType == 9)
			{
				value["type"] = 2;
			}
		}
		value["status"] = status;
		value["result"] = result;
		value["event_duration"] = eventDuration;
		Send("teachingtrain_ground", value);
	}
}
