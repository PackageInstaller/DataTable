namespace ACT.EventTrack;

public class FileVerificationEnd : TrackBaseEvt<FileVerificationEnd>
{
	public int result;

	public float eventDuration;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("file_verification_end·", out var value))
		{
			value["result"] = result;
			value["event_duration"] = eventDuration;
			Send("file_verification_end·", value);
		}
	}
}
