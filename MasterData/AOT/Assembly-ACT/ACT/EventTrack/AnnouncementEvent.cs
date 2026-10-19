namespace ACT.EventTrack;

public class AnnouncementEvent : TrackBaseEvt<AnnouncementEvent>
{
	public int announcementId;

	public int announcementType;

	public int type;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("announcement_event", out var value) || EventConfigs.EventDictionary.TryGetValue("announce_event", out value))
		{
			value["announcement_id"] = announcementId;
			value["announcement_type"] = announcementType;
			value["type"] = type;
			value["status"] = status;
			Send("announcement_event", value);
		}
	}
}
