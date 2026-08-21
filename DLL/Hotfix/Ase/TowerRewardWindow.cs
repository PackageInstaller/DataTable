using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerRewardWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn1;

	[SerializeField]
	private Button backBtn2;

	[SerializeField]
	private TowerRewardView towerRewardView;

	private TowerRewardViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TowerRewardViewModel>();
		BindingSet<TowerRewardWindow, TowerRewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerRewardWindow v) => v.OnDismissRequest).To((TowerRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TowerRewardWindow v) => v.OpenUguiWindow).To((TowerRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(backBtn1).For((Button v) => v.onClick).To((TowerRewardViewModel vm) => vm.Close);
		bindingSet.Bind(backBtn2).For((Button v) => v.onClick).To((TowerRewardViewModel vm) => vm.Close);
		bindingSet.Build();
		towerRewardView.Init(viewModel.RewardViewModel);
	}
}
