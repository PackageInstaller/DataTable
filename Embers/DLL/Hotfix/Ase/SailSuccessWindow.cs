using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailSuccessWindow : UGuiWindow
{
	[SerializeField]
	private Button BtnClose;

	[SerializeField]
	private GameObject normalObj;

	[SerializeField]
	private GameObject greatObj;

	private SailSuccessViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<SailSuccessViewModel>();
		BindingSet<SailSuccessWindow, SailSuccessViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((SailSuccessWindow v) => v.CloseWindow).To((SailSuccessViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(BtnClose).For((Button v) => v.onClick).To((SailSuccessViewModel vm) => vm.BtnClose);
		bindingSet.Bind(normalObj).For((GameObject v) => v.activeSelf).ToExpression((SailSuccessViewModel vm) => !vm.IsGreat);
		bindingSet.Bind(greatObj).For((GameObject v) => v.activeSelf).To((SailSuccessViewModel vm) => vm.IsGreat);
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
