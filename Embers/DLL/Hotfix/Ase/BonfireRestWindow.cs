using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BonfireRestWindow : UGuiWindow
{
	[SerializeField]
	private float minDisplayTime = 1f;

	private BonfireRestViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BonfireRestViewModel>();
		BindingSet<BonfireRestWindow, BonfireRestViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BonfireRestWindow v) => v.OnDismissRequest).To((BonfireRestViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BonfireRestWindow v) => v.OpenUguiWindow).To((BonfireRestViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
	}

	private void Update()
	{
		if (_viewModel.ReadyClose)
		{
			if (minDisplayTime <= 0f)
			{
				_viewModel.ReadyClose = false;
				_viewModel.Close();
			}
			minDisplayTime -= Time.deltaTime;
		}
	}
}
