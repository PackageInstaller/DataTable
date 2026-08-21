using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CountdownVerifyWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private Text sender;

	[SerializeField]
	private TextMeshProUGUI action;

	[SerializeField]
	private TextMeshProUGUI target;

	[SerializeField]
	private TextMeshProUGUI countdown;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private TextMeshProUGUI confirmText;

	[SerializeField]
	private TextMeshProUGUI confirmEngText;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private TextMeshProUGUI cancelText;

	[SerializeField]
	private TextMeshProUGUI cancelEngText;

	private CountdownVerifyViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<CountdownVerifyViewModel>();
		BindingSet<CountdownVerifyWindow, CountdownVerifyViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((CountdownVerifyWindow v) => v.OnDismissRequest).To((CountdownVerifyViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.Title);
		bindingSet.Bind(sender).For((Text v) => v.text).To((CountdownVerifyViewModel vm) => vm.Sender);
		bindingSet.Bind<TextMeshProUGUI>(action).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.Action);
		bindingSet.Bind<TextMeshProUGUI>(target).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.Target);
		bindingSet.Bind<TextMeshProUGUI>(countdown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.WaitTime);
		bindingSet.Bind<TextMeshProUGUI>(confirmText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.ConfirmText);
		bindingSet.Bind<TextMeshProUGUI>(confirmEngText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.ConfirmEngText);
		bindingSet.Bind<TextMeshProUGUI>(cancelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.CancelText);
		bindingSet.Bind<TextMeshProUGUI>(cancelEngText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CountdownVerifyViewModel vm) => vm.CancelEngText);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((CountdownVerifyViewModel vm) => vm.OnCancelClick);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((CountdownVerifyViewModel vm) => vm.OnConfirmClick);
		bindingSet.Build();
	}
}
