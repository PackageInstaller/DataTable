namespace ACT.EventTrack;

public class LibraryContentEvent : TrackBaseEvt<LibraryContentEvent>
{
	public int contentId;

	public int type;

	public int mainId;

	public int libraryId;

	public int op;

	public bool isRednote;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("librarycontent_event", out var value))
		{
			value["content_id"] = contentId;
			value["type"] = type;
			value["main_id"] = mainId;
			value["library_id"] = libraryId;
			value["op"] = op;
			value["is_rednote"] = isRednote;
			Send("librarycontent_event", value);
		}
	}
}
