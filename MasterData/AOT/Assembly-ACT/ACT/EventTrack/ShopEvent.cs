namespace ACT.EventTrack;

public class ShopEvent : TrackBaseEvt<ShopEvent>
{
	public int subShopId;

	public int status;

	public int commodityId;

	public int commodityQty;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("shop_event", out var value))
		{
			value["sub_shop_id"] = subShopId;
			value["status"] = status;
			value["commodity_id"] = commodityId;
			value["commodity_qty"] = commodityQty;
			_ = LuminApplication.LogEnabled;
			Send("shop_event", value);
		}
	}
}
