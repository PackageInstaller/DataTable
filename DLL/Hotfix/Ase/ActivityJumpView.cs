using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityJumpView : ActivityViewBase
{
	[SerializeField]
	private Button jumpBtn;

	private ActivityJumpViewModel viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (ActivityJumpViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityJumpView, ActivityJumpViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(jumpBtn).For((Button v) => v.onClick).To((ActivityJumpViewModel vm) => vm.JumpWindowCmd);
		bindingSet.Build();
	}
}
