using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeamInviteWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI friendName;

	[SerializeField]
	private TextMeshProUGUI copyName;

	[SerializeField]
	private TextMeshProUGUI time;

	[SerializeField]
	private Button cancelBtn;

	[SerializeField]
	private Button confirmBtn;

	private TeamInviteViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeamInviteViewModel>();
		BindingSet<TeamInviteWindow, TeamInviteViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((TeamInviteWindow v) => v.CloseWindow).To((TeamInviteViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(friendName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeamInviteViewModel vm) => vm.FriendName);
		bindingSet.Bind<TextMeshProUGUI>(copyName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeamInviteViewModel vm) => vm.CopyName);
		bindingSet.Bind<TextMeshProUGUI>(time).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeamInviteViewModel vm) => vm.WaitTime);
		bindingSet.Bind(cancelBtn).For((Button v) => v.onClick).To((TeamInviteViewModel vm) => vm.CancelCmd);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((TeamInviteViewModel vm) => vm.ConfirmCmd);
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
