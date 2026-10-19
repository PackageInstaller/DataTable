namespace ACT.EventTrack;

public class PredownloadEntryShowEvent : TrackBaseEvt<PredownloadEntryShowEvent>
{
	public bool isRednote;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("predownload_entry_show", out var value))
		{
			value["is_rednote"] = isRednote;
			Send("predownload_entry_show", value);
		}
	}
}
