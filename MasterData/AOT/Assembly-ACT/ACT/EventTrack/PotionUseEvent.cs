namespace ACT.EventTrack;

public class PotionUseEvent : TrackBaseEvt<PotionUseEvent>
{
	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("potion_use", out var value))
		{
			Send("potion_use", value);
		}
	}
}
