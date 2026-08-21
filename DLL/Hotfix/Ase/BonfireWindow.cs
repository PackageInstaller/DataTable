using System;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BonfireWindow : UGuiWindow
{
	[SerializeField]
	private Button btnWeaponCasting;

	[SerializeField]
	private Button btnEquipmentCasting;

	[SerializeField]
	private Button btnCooking;

	[SerializeField]
	private Button btnAlchemy;

	[SerializeField]
	private Button btnBack;

	private BonfireViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		viewModel = new BonfireViewModel();
		BindingSet<BonfireWindow, BonfireViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BonfireWindow v) => v.CloseWindow).To((BonfireViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BonfireWindow v) => v.OpenWindow).To((BonfireViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BonfireViewModel vm) => vm.BackOnClick);
		bindingSet.Bind(btnWeaponCasting).For((Button v) => v.onClick).To((BonfireViewModel vm) => vm.WeaponCastingOnClick);
		bindingSet.Bind(btnEquipmentCasting).For((Button v) => v.onClick).To((BonfireViewModel vm) => vm.EquipmentCastingOnClick);
		bindingSet.Bind(btnCooking).For((Button v) => v.onClick).To((BonfireViewModel vm) => vm.CookingOnClick);
		bindingSet.Bind(btnAlchemy).For((Button v) => v.onClick).To((BonfireViewModel vm) => vm.AlchemyOnClick);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.HideBattleWindow();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		_ = args.Context;
		Window w = null;
		if (w != null && callback != null)
		{
			w.OnDismissed += Handler;
		}
		void Handler(object window, EventArgs e)
		{
			w.OnDismissed -= Handler;
			callback();
		}
	}
}
