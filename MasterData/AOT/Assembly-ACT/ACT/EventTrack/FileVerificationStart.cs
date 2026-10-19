namespace ACT.EventTrack;

public class FileVerificationStart : TrackBaseEvt<FileVerificationStart>
{
	public int result;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("file_verification_start", out var value))
		{
			value["result"] = result;
			Send("file_verification_start", value);
		}
	}
}
