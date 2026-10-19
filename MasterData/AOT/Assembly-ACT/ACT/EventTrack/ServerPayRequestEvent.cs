namespace ACT.EventTrack;

public class ServerPayRequestEvent : TrackBaseEvt<ServerPayRequestEvent>
{
	public int goodsId;

	public int productId;

	public int price;

	public string tier;

	public int subShopId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("server_pay_request", out var value))
		{
			value["goods_id"] = goodsId;
			value["product_id"] = productId;
			value["price"] = price;
			value["tier"] = tier ?? "-";
			value["sub_shop_id"] = subShopId;
			Send("server_pay_request", value);
		}
	}
}
