namespace ACT.EventTrack;

public class NewGuide : TrackBaseEvt<NewGuide>
{
	public int id;

	public int status;

	public int step;

	public int stepType;

	public bool skip;

	public float eventDuration;

	public override void ReleaseEvt()
	{
		id = 0;
		status = 0;
		step = 0;
		stepType = 0;
		skip = false;
		eventDuration = 0f;
		base.ReleaseEvt();
	}

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("new_guide", out var value))
		{
			value["guide_id"] = id;
			value["status"] = status;
			value["skip"] = skip;
			value["step"] = step;
			value["step_type"] = stepType;
			value["event_duration"] = eventDuration;
			Send("new_guide", value);
		}
	}
}
