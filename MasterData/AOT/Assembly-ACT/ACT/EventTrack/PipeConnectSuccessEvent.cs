namespace ACT.EventTrack;

public class PipeConnectSuccessEvent : TrackBaseEvt<PipeConnectSuccessEvent>
{
	public int areaId;

	public int subAreaId;

	public int playerLevel;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("pipe_connect_success", out var value))
		{
			value["area_id"] = areaId;
			value["sub_area_id"] = subAreaId;
			value["player_level"] = playerLevel;
			Send("pipe_connect_success", value);
		}
	}
}
