namespace ACT.EventTrack;

public class TargetedWish : TrackBaseEvt<TargetedWish>
{
	public int id;

	public int type;

	public int challengeId;

	public int targetedId;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("targeted_wish", out var value))
		{
			value["wish_id"] = id;
			value["type"] = type;
			value["challenge_id"] = challengeId;
			value["targeted_id"] = targetedId;
			value["status"] = status;
			Send("targeted_wish", value);
		}
	}
}
