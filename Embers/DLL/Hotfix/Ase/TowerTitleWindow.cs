using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class TowerTitleWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI titleText;

	[SerializeField]
	private TextMeshProUGUI contentText;

	[SerializeField]
	private float showTime = 3f;

	private TowerTitleViewModel viewModel;

	public float ShowTime => showTime;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TowerTitleViewModel>();
		BindingSet<TowerTitleWindow, TowerTitleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerTitleWindow v) => v.OnDismissRequest).To((TowerTitleViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(titleText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTitleViewModel vm) => vm.TitleName);
		bindingSet.Bind<TextMeshProUGUI>(contentText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTitleViewModel vm) => vm.ContentDesc);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
	}
}
