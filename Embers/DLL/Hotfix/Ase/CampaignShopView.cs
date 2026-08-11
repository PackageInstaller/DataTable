using GameFramework.Runtime;

namespace Ase;

public class CampaignShopView : ShopViewBase
{
	private new CampaignShopViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignShopViewModel>(userData);
		this.CreateBindingSet(_viewModel).Build();
	}
}
