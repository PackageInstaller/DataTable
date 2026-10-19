using ACT.EventTrack;

namespace ACT.UI;

public static class ShopEventTrackHelper
{
	public const int StatusOpenTab = 1;

	public const int StatusCloseTab = 2;

	public const int StatusClickBuy = 3;

	public const int StatusConfirmBuy = 4;

	public const int StatusCancelBuy = 5;

	public const int StatusBuySuccess = 6;

	public static void Dispatch(int subShopId, int status, int commodityId = 0, int commodityQty = 0)
	{
		ShopEvent evt = EventTrackSolver.Instance.GetEvt<ShopEvent>();
		evt.status = status;
		evt.subShopId = subShopId;
		evt.commodityId = commodityId;
		evt.commodityQty = commodityQty;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
