using GameFramework.Runtime;

namespace Ase;

public class ActivityShopView : ShopViewBase
{
	private new ActivityShopViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ActivityShopViewModel>(userData);
		this.CreateBindingSet(_viewModel).Build();
	}
}
