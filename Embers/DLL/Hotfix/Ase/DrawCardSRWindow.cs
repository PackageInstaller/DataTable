using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardSRWindow : DrawCardSingleWindow
{
	[SerializeField]
	private GameObject sr;

	private DrawCardSingleViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardSingleViewModel>();
		BindingSet<DrawCardSRWindow, DrawCardSingleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(sr).For((GameObject v) => v.activeSelf).ToExpression((DrawCardSingleViewModel vm) => !vm.IsSsr);
		bindingSet.Build();
	}
}
