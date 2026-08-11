using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardSSRWindow : DrawCardSingleWindow
{
	[SerializeField]
	private GameObject ssr;

	private DrawCardSingleViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardSingleViewModel>();
		BindingSet<DrawCardSSRWindow, DrawCardSingleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(ssr).For((GameObject v) => v.activeSelf).To((DrawCardSingleViewModel vm) => vm.IsSsr);
		bindingSet.Build();
	}
}
