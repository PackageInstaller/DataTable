using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleEmoteTabView : UGuiView
{
	[SerializeField]
	private GameObject timeLimitIcon;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private LoadUISprite tabIcon;

	[SerializeField]
	private TextMeshProUGUI emoteName;

	[SerializeField]
	private TextMeshProUGUI selectName;

	private BattleEmoteTabViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleEmoteTabViewModel>(userData);
		BindingSet<BattleEmoteTabView, BattleEmoteTabViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(tabIcon).For((LoadUISprite v) => v.Path).ToExpression((BattleEmoteTabViewModel vm) => vm.IconPath);
		bindingSet.Bind(timeLimitIcon).For((GameObject v) => v.activeSelf).ToExpression((BattleEmoteTabViewModel vm) => vm.IsTimeLimit);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((BattleEmoteTabViewModel vm) => vm.IsSelected);
		bindingSet.Bind<TextMeshProUGUI>(emoteName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleEmoteTabViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(selectName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleEmoteTabViewModel vm) => vm.Name);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((BattleEmoteTabViewModel vm) => vm.OnClike);
		bindingSet.Build();
	}

	public void RefreshData(BattleEmoteTabViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
