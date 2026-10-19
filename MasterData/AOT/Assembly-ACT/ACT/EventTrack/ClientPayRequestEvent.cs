namespace ACT.EventTrack;

public class ClientPayRequestEvent : TrackBaseEvt<ClientPayRequestEvent>
{
	public int goodsId;

	public string productId;

	public int goodsPrice;

	public string goodsTier;

	public int subShopId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("client_pay_request", out var value))
		{
			value["goods_id"] = goodsId;
			value["product_id"] = productId;
			value["goods_price"] = goodsPrice;
			value["goods_tier"] = goodsTier ?? "-";
			value["sub_shop_id"] = subShopId;
			Send("client_pay_request", value);
		}
	}
}
