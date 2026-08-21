namespace Ase;

public class ShopViewData : ShopViewDataBase
{
	public ShopViewData()
	{
	}

	public ShopViewData(OptionBase parent, int subTabIndex = 0)
		: base(parent, subTabIndex)
	{
	}

	public void RefreshData()
	{
		RefreshShopData(base.CurTabIndex, base.CurSubTabIndex, reRequest: true);
	}
}
