namespace ACT.EventTrack;

public class PlayerActiveDurationEvent : TrackBaseEvt<PlayerActiveDurationEvent>
{
	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("player_active_duration", out var value))
		{
			Send("player_active_duration", value);
		}
	}
}
