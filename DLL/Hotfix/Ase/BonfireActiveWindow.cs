using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class BonfireActiveWindow : UGuiWindow
{
	[SerializeField]
	private AnimationClip activeClip;

	[SerializeField]
	private TextMeshProUGUI bonfireName;

	private BonfireActiveViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BonfireActiveViewModel>();
		BindingSet<BonfireActiveWindow, BonfireActiveViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BonfireActiveWindow v) => v.OnDismissRequest).To((BonfireActiveViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(bonfireName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BonfireActiveViewModel vm) => vm.BonfireName);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
		Invoke("CloseWindow", activeClip.length);
	}

	private void CloseWindow()
	{
		_viewModel.Close();
	}
}
