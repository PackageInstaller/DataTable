namespace ACT.EventTrack;

public class PredownloadWindowClickEvent : TrackBaseEvt<PredownloadWindowClickEvent>
{
	public float size;

	public float freeStorageSize;

	public string targetVersion;

	public int result;

	public int type;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("predownload_window_click", out var value))
		{
			value["size"] = size;
			value["free_storage_size"] = freeStorageSize;
			value["target_version"] = targetVersion ?? "-";
			value["result"] = result;
			value["type"] = type;
			Send("predownload_window_click", value);
		}
	}
}
