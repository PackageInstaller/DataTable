namespace ACT.EventTrack;

public class FreeTrainGround : TrackBaseEvt<FreeTrainGround>
{
	public int status;

	public float eventDuration;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("freetrain_ground", out var value))
		{
			SetTransNo(value);
			value["status"] = status;
			value["event_duration"] = eventDuration;
			Send("freetrain_ground", value);
		}
	}
}
