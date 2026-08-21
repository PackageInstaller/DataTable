using Cysharp.Threading.Tasks;

namespace Ase;

public class ActivityShopViewModel : ShopViewDataBase
{
	public ActivityShopViewModel()
	{
	}

	public ActivityShopViewModel(OptionBase parent, int subTabIndex = 0)
		: base(parent, subTabIndex)
	{
	}

	public override async UniTask RequestData()
	{
		await RefreshShopData(base.CurTabIndex, base.CurSubTabIndex, reRequest: true);
	}
}
