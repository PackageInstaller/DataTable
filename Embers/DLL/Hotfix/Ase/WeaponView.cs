using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponView : UGuiView
{
	[SerializeField]
	private WeaponDetailView _weaponDetailView;

	private WeaponViewModel viewModel;

	public void Init(WeaponViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<WeaponView, WeaponViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((WeaponView v) => v.Refresh).To((WeaponViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Build();
		_weaponDetailView.Init(viewModel.WeaponDetailViewModel);
	}

	private async void Refresh(object sender, InteractionEventArgs e)
	{
		RefreshWeaponView();
	}

	private void RefreshWeaponView()
	{
	}

	public void Show()
	{
		base.gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		base.gameObject.SetActive(value: false);
	}
}
