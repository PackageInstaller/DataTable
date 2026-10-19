namespace ACT.EventTrack;

public class HyperlinkClick : TrackBaseEvt<HyperlinkClick>
{
	public string title;

	public string link;

	public int systemId;

	public int mailId;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("hyperlink_click", out var value))
		{
			value["title"] = title;
			value["link"] = link;
			value["system_id"] = systemId;
			value["mail_id"] = mailId;
			Send("hyperlink_click", value);
		}
	}
}
