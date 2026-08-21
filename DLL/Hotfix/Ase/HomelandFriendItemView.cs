using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomelandFriendItemView : UGuiView
{
	public TextMeshProUGUI level;

	public new Text name;

	public GameObject isCur;

	public Button btnEntry;

	private HomelandFriendItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (userData != null)
		{
			viewModel = GetUserData<HomelandFriendItemViewModel>(userData);
			BindingSet<HomelandFriendItemView, HomelandFriendItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandFriendItemViewModel vm) => $"{vm.Data.HomelandLevel}");
			bindingSet.Bind(name).For((Text v) => v.text).To((HomelandFriendItemViewModel vm) => vm.Data.Name);
			bindingSet.Bind(isCur).For((GameObject v) => v.activeSelf).To((HomelandFriendItemViewModel vm) => vm.IsSelect);
			bindingSet.Bind(btnEntry).For((Button v) => v.onClick).To((HomelandFriendItemViewModel vm) => vm.OptCommand)
				.CommandParameter(HomelandMainArg.VisitFriend);
			bindingSet.Bind(btnEntry.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HomelandFriendItemViewModel vm) => !vm.IsSelect);
			bindingSet.Build();
		}
	}

	public override void RefreshData(object userData)
	{
		if (userData != null)
		{
			base.RefreshData(userData);
			viewModel = GetUserData<HomelandFriendItemViewModel>(userData);
			this.SetDataContext(viewModel);
		}
	}
}
