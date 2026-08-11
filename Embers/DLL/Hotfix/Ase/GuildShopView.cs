using GameFramework.Runtime;

namespace Ase;

public class GuildShopView : ShopViewBase
{
	private new GuildShopViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildShopViewModel>(userData);
		this.CreateBindingSet(_viewModel).Build();
	}
}
