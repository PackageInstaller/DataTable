namespace ACT.EventTrack;

public class PredownloadBeginEvent : TrackBaseEvt<PredownloadBeginEvent>
{
	public float size;

	public float downloadedSize;

	public int step;

	public string targetVersion;

	public bool isNoticeAllowed;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("predownload__begin", out var value))
		{
			value["size"] = size;
			value["downloaded_size"] = downloadedSize;
			value["step"] = step;
			value["target_version"] = targetVersion ?? "-";
			value["is_notice_allowed"] = isNoticeAllowed;
			Send("predownload__begin", value);
		}
	}
}
