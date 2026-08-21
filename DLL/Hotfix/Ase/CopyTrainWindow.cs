using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class CopyTrainWindow : UGuiWindow
{
	public MoneyView MoneyView;

	public Button btnBack;

	public Button btnType1;

	public Button btnType2;

	private CopyTrainViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopyTrainViewModel>();
		BindingSet<CopyTrainWindow, CopyTrainViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopyTrainWindow v) => v.OnDismissRequest).To((CopyTrainViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopyTrainWindow v) => v.OpenUguiWindow).To((CopyTrainViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopyTrainViewModel vm) => vm.Close);
		bindingSet.Bind(btnType1).For((Button v) => v.onClick).To((CopyTrainViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenTrain1");
		bindingSet.Bind(btnType2).For((Button v) => v.onClick).To((CopyTrainViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenTrain2");
		bindingSet.Build();
		MoneyView.Init(new MoneyViewModel(viewModel));
	}
}
