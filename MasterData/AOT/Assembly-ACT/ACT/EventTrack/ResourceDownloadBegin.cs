namespace ACT.EventTrack;

public class ResourceDownloadBegin : TrackBaseEvt<ResourceDownloadBegin>
{
	public float size;

	public string url;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("resource_download_begin", out var value))
		{
			value["size"] = size;
			value["url"] = url;
			Send("resource_download_begin", value);
		}
	}
}
