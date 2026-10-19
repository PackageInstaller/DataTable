namespace ACT.EventTrack;

public class TrackDramaEvt : TrackBaseEvt<TrackDramaEvt>
{
	public int conversationId;

	public long subId;

	public int type;

	public int status;

	public double conversationDuration;

	public bool isSkip;

	public override bool SkipIfWorldNotStart => false;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("drama_event", out var value))
		{
			value["drama_id"] = conversationId;
			value["sub_drama_id"] = subId;
			value["type"] = type;
			value["event_duration"] = conversationDuration;
			value["status"] = status;
			value["skip"] = isSkip;
			_ = LuminApplication.LogEnabled;
			Send("drama_event", value);
		}
	}
}
