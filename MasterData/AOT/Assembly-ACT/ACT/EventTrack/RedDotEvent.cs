namespace ACT.EventTrack;

public class RedDotEvent : TrackBaseEvt<RedDotEvent>
{
	public string redDotPath;

	public int type;

	public int systemId;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("reddot_event", out var value))
		{
			value["reddot_path"] = redDotPath;
			value["type"] = type;
			value["system_id"] = systemId;
			value["status"] = status;
			Send("reddot_event", value);
		}
	}
}
