using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LoginWindow : LoginWindowBase
{
	public TMP_InputField username;

	public TMP_InputField password;

	public Button loginButton;

	public Button closeButton;

	public Toggle toggle;

	public Toggle skiptoggle;

	public TabItem normalMode;

	public TabItem innerMode;

	public Toggle toggleAgree;

	public Button openAgreeButton;

	public Button closeAgreeButton;

	public GameObject agreeView;

	public Button openIpListButton;

	public GameObject iplistView;

	public GameObject ipInfoTemplate;

	private LoginViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<LoginViewModel>();
		BindingSet<LoginWindow, LoginViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((LoginWindow v) => v.OnDismissRequest).To((LoginViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TMP_InputField>(username).For((Expression<Func<TMP_InputField, string>>)((TMP_InputField v) => v.text), (Expression<Func<TMP_InputField, SubmitEvent>>)((TMP_InputField v) => v.onEndEdit)).To((LoginViewModel vm) => vm.Username)
			.TwoWay();
		bindingSet.Bind<TMP_InputField>(password).For((Expression<Func<TMP_InputField, string>>)((TMP_InputField v) => v.text), (Expression<Func<TMP_InputField, SubmitEvent>>)((TMP_InputField v) => v.onEndEdit)).To((LoginViewModel vm) => vm.Password)
			.TwoWay();
		bindingSet.Bind(loginButton).For((Button v) => v.onClick).To((LoginViewModel vm) => vm.LoginCommand);
		bindingSet.Bind(closeButton).For((Button v) => v.onClick).To((LoginViewModel vm) => vm.CloseCommand);
		bindingSet.Bind(toggle).For((Toggle v) => v.isOn, (Toggle v) => v.onValueChanged).To((LoginViewModel vm) => vm.RememberMe)
			.TwoWay();
		bindingSet.Bind(toggleAgree).For((Toggle v) => v.isOn, (Toggle v) => v.onValueChanged).To((LoginViewModel vm) => vm.Agree)
			.TwoWay();
		skiptoggle.gameObject.SetActive(value: false);
		bindingSet.Bind().For((LoginWindow v) => v.InnerModeChanged).To((LoginViewModel vm) => vm.InnerModeChangeRst);
		bindingSet.Build();
		openAgreeButton.onClick.AddListener(delegate
		{
			agreeView.SetActive(value: true);
		});
		closeAgreeButton.onClick.AddListener(delegate
		{
			agreeView.SetActive(value: false);
		});
		normalMode.Init(new TabItemData(viewModel, 1));
		innerMode.Init(new TabItemData(viewModel, 2));
		normalMode.ViewModel.IsSelected = !viewModel.KFInner;
		innerMode.ViewModel.IsSelected = viewModel.KFInner;
	}

	private void InnerModeChanged(object sender, InteractionEventArgs e)
	{
		normalMode.ViewModel.IsSelected = !viewModel.KFInner;
		innerMode.ViewModel.IsSelected = viewModel.KFInner;
	}
}
