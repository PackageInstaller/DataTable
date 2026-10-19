namespace ACT.EventTrack;

public class ActivityCalendarJumpEvent : TrackBaseEvt<ActivityCalendarJumpEvent>
{
	public int systemId;

	public int jumpId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("activity_calender_jump", out var value))
		{
			value["system_id"] = systemId;
			value["jump_id"] = jumpId;
			Send("activity_calender_jump", value);
		}
	}
}
