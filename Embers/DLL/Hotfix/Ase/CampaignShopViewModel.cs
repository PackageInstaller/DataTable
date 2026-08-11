using Cysharp.Threading.Tasks;

namespace Ase;

public class CampaignShopViewModel : ShopViewDataBase
{
	public CampaignShopViewModel()
	{
	}

	public CampaignShopViewModel(OptionBase parent, int subTabIndex = 0)
		: base(parent, subTabIndex)
	{
	}

	public override async UniTask RequestData()
	{
		await RefreshShopData(base.CurTabIndex, base.CurSubTabIndex, reRequest: true);
	}
}
