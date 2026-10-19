namespace ACT.EventTrack;

public class CharacterTrialActivityClickEvent : TrackBaseEvt<CharacterTrialActivityClickEvent>
{
	public int activityId;

	public int raidId;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("character_trial_activity_click", out var value))
		{
			value["activity_id"] = activityId;
			value["raid_id"] = raidId;
			value["status"] = status;
			Send("character_trial_activity_click", value);
		}
	}
}
