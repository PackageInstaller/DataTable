using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityChallengeCopyItemView : UGuiView
{
	public new TextMeshProUGUI name;

	public LoadUISprite icon;

	public Button btn;

	public GameObject completeGo;

	private CopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<ActivityChallengeCopyItemView, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenDetail");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.BossName);
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
		if (completeGo != null)
		{
			completeGo.SetActive(value: false);
			bindingSet.Bind(completeGo).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsAccessed);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
