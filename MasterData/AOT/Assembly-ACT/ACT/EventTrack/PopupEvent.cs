namespace ACT.EventTrack;

public class PopupEvent : TrackBaseEvt<PopupEvent>
{
	public int adId;

	public int popupId;

	public float eventDuration;

	public int type;

	public int status;

	public bool skip;

	public int subShopId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("popup_event", out var value))
		{
			value["popup_id"] = ((popupId != 0) ? popupId : adId);
			value["event_duration"] = eventDuration;
			value["type"] = type;
			value["status"] = status;
			value["skip"] = skip;
			value["sub_shop_id"] = subShopId;
			Send("popup_event", value);
		}
	}
}
