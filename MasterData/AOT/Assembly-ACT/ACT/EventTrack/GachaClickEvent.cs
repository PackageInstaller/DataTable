namespace ACT.EventTrack;

public class GachaClickEvent : TrackBaseEvt<GachaClickEvent>
{
	public int gachaId;

	public int gachaType;

	public int type;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("gacha_click", out var value))
		{
			value["gacha_id"] = gachaId;
			value["gacha_type"] = gachaType;
			value["type"] = type;
			Send("gacha_click", value);
		}
	}
}
