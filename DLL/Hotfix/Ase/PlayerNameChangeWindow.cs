using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerNameChangeWindow : UGuiWindowBase
{
	public string colorEnough;

	public string colorLack;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnRandom;

	[SerializeField]
	private TMP_InputField input;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnClose2;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI cardCount;

	private PlayerNameChangeViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PlayerNameChangeViewModel>();
		BindingSet<PlayerNameChangeWindow, PlayerNameChangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((PlayerNameChangeWindow v) => v.OpenUguiWindow).To((PlayerNameChangeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((PlayerNameChangeWindow v) => v.OnDismissRequest).To((PlayerNameChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TMP_InputField>(input).For((Expression<Func<TMP_InputField, string>>)((TMP_InputField v) => v.text), (Expression<Func<TMP_InputField, SubmitEvent>>)((TMP_InputField v) => v.onEndEdit)).To((PlayerNameChangeViewModel vm) => vm.NameInput);
		bindingSet.Bind(btnRandom).For((Button v) => v.onClick).To((PlayerNameChangeViewModel vm) => vm.RandomName);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PlayerNameChangeViewModel vm) => vm.ChangeNameCard.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PlayerNameChangeViewModel vm) => vm.ConfirmCommand);
		bindingSet.Bind().For((PlayerNameChangeWindow v) => v.OnOpt).To((PlayerNameChangeViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PlayerNameChangeViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((PlayerNameChangeViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(cardCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerNameChangeViewModel vm) => $"<color=#{((vm.ChangeNameCard.Amount >= 1) ? colorEnough : colorLack)}>{vm.ChangeNameCard.Amount}</color>");
		bindingSet.Build();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("Refresh".Equals(optName))
		{
			this.SetDataContext(viewModel);
		}
	}
}
