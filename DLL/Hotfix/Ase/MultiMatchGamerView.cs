using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiMatchGamerView : UGuiView
{
	[SerializeField]
	private Image gamerFrame;

	[SerializeField]
	private Image gamerImg;

	[SerializeField]
	private GameObject confirm;

	[SerializeField]
	private GameObject cancel;

	private MultiMatchGamerViewModel _viewModel;

	public void Init(MultiMatchGamerViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<MultiMatchGamerView, MultiMatchGamerViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(gamerImg).For((Image v) => v.sprite).ToExpression((MultiMatchGamerViewModel vm) => $"UserHead{vm.GamerImg}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(confirm).For((GameObject v) => v.activeSelf).To((MultiMatchGamerViewModel vm) => vm.GamerConfirm);
		bindingSet.Bind(cancel).For((GameObject v) => v.activeSelf).To((MultiMatchGamerViewModel vm) => vm.GamerCancel);
		bindingSet.Bind(gamerImg).For((Image v) => v.color).To((MultiMatchGamerViewModel vm) => vm.Color);
		bindingSet.Bind(gamerFrame).For((Image v) => v.color).To((MultiMatchGamerViewModel vm) => vm.Color);
		bindingSet.Build();
	}

	public void RefreshData(MultiMatchGamerViewModel viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
