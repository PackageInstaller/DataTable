using GameFramework.Runtime;

namespace Ase;

public class BattleStartEmoteItem : UGuiView
{
	private BattleStartEmoteItemModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleStartEmoteItemModel>(userData);
		this.CreateBindingSet(viewModel).Build();
	}

	public void RefreshData(BattleStartEmoteItemModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
