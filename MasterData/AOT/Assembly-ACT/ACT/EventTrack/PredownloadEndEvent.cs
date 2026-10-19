namespace ACT.EventTrack;

public class PredownloadEndEvent : TrackBaseEvt<PredownloadEndEvent>
{
	public float size;

	public int step;

	public int result;

	public int type;

	public int eventDuration;

	public string targetVersion;

	public bool isNoticeAllowed;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("predownload__end", out var value))
		{
			value["size"] = size;
			value["step"] = step;
			value["result"] = result;
			value["type"] = type;
			value["event_duration"] = eventDuration;
			value["target_version"] = targetVersion ?? "-";
			value["is_notice_allowed"] = isNoticeAllowed;
			Send("predownload__end", value);
		}
	}
}
