namespace ACT.EventTrack;

public class ActivityClick : TrackBaseEvt<ActivityClick>
{
	public int activityId;

	public int challengeId;

	public int challengeGroupId;

	public int status;

	public bool isPopup;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("activity_click", out var value))
		{
			value["activity_type"] = 0;
			value["activity_id"] = activityId;
			value["status"] = status;
			value["challenge_id"] = challengeId;
			value["challenge_group_id"] = challengeGroupId;
			value["is_popup"] = isPopup;
			Send("activity_click", value);
		}
	}
}
