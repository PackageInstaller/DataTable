namespace ACT.EventTrack;

public class SystemOpen : TrackBaseEvt<SystemOpen>
{
	public int id;

	public int type;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("system_open", out var value))
		{
			value["system_id"] = id;
			value["type"] = type;
			Send("system_open", value);
		}
	}
}
