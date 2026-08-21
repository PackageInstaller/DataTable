using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DisconnectWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI context;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnCancel;

	private DisconnectViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DisconnectViewModel>();
		BindingSet<DisconnectWindow, DisconnectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DisconnectWindow v) => v.OnDismissRequest).To((DisconnectViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(context).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DisconnectViewModel vm) => vm.Text);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((DisconnectViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm.gameObject).For((GameObject v) => v.activeSelf).To((DisconnectViewModel vm) => vm.IsConfirm);
		bindingSet.Bind(btnCancel.gameObject).For((GameObject v) => v.activeSelf).ToExpression((DisconnectViewModel vm) => !vm.IsConfirm);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((DisconnectViewModel vm) => vm.ConfirmCmd);
		bindingSet.Build();
	}
}
