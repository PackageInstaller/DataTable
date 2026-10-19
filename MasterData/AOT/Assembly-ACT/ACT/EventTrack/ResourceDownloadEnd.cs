namespace ACT.EventTrack;

public class ResourceDownloadEnd : TrackBaseEvt<ResourceDownloadEnd>
{
	public float size;

	public string url;

	public int result;

	public int type;

	public float eventDuration;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("resource_download_end", out var value))
		{
			value["size"] = size;
			value["url"] = url;
			value["result"] = result;
			value["type"] = type;
			value["event_duration"] = eventDuration;
			Send("resource_download_end", value);
		}
	}
}
