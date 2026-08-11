using GameFramework.Runtime;

namespace Ase;

public class ShopView : ShopViewBase
{
	private new ShopViewData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ShopViewData>(userData);
		this.CreateBindingSet(_viewModel).Build();
	}
}
