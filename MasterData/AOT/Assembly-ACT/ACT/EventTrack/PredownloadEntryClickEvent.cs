namespace ACT.EventTrack;

public class PredownloadEntryClickEvent : TrackBaseEvt<PredownloadEntryClickEvent>
{
	public bool isRednote;

	public float size;

	public string targetVersion;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("predownload_entry_click", out var value))
		{
			value["is_rednote"] = isRednote;
			value["size"] = size;
			value["target_version"] = targetVersion ?? "-";
			Send("predownload_entry_click", value);
		}
	}
}
