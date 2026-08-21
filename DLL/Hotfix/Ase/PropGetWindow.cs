using GameFramework.Runtime;

namespace Ase;

public class PropGetWindow : UGuiWindow
{
	private PropGetViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PropGetViewModel>();
		BindingSet<PropGetWindow, PropGetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropGetWindow v) => v.OpenUguiWindow).To((PropGetViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PropGetWindow v) => v.OnDismissRequest).To((PropGetViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((PropGetWindow v) => v.OnOpt).To((PropGetViewModel vm) => vm.OptRequest);
		bindingSet.Build();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			viewModel.StartOpen();
		}
	}
}
