using ACT.Model;
using Fundamental;

namespace ACT.EventTrack;

public class ApcEvent : TrackBaseEvt<ApcEvent>
{
	public int apcId;

	public int status;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("apc_event", out var value))
		{
			value["apc_id"] = apcId;
			value["status"] = status;
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["raid_id"] = Model<RaidModel>.Interface.CurrentRaidId;
			Send("apc_event", value);
		}
	}
}
