using GameFramework.Runtime;

namespace Ase;

public class BattleEndWindow : UGuiWindow
{
	private BattleEndViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleEndViewModel>();
		BindingSet<BattleEndWindow, BattleEndViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleEndWindow v) => v.OpenUguiWindow).To((BattleEndViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BattleEndWindow v) => v.OnDismissRequest).To((BattleEndViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
	}

	protected override void OnDismiss()
	{
		viewModel.Clear();
		base.OnDismiss();
	}
}
