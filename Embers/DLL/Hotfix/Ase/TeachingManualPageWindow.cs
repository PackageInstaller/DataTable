using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachingManualPageWindow : UGuiWindow
{
	[SerializeField]
	private LoadUISprite pageIcon;

	[SerializeField]
	private TextMeshProUGUI pageTitle;

	[SerializeField]
	private TextMeshProUGUI pageContent;

	[SerializeField]
	private TextMeshProUGUI pageIndex;

	[SerializeField]
	private Button btnLast;

	[SerializeField]
	private Button btnNext;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private GameObject btnCloseMask;

	private TeachingManualPageViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachingManualPageViewModel>();
		BindingSet<TeachingManualPageWindow, TeachingManualPageViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((TeachingManualPageWindow v) => v.OnDismissRequest).To((TeachingManualPageViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TeachingManualPageWindow v) => v.OpenUguiWindow).To((TeachingManualPageViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(pageIcon).For((LoadUISprite v) => v.Path).ToExpression((TeachingManualPageViewModel vm) => $"Copy/CopyGuide/{vm.PageIcon}");
		bindingSet.Bind<TextMeshProUGUI>(pageTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachingManualPageViewModel vm) => vm.PageTitle);
		bindingSet.Bind<TextMeshProUGUI>(pageContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachingManualPageViewModel vm) => vm.PageContent);
		bindingSet.Bind<TextMeshProUGUI>(pageIndex).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TeachingManualPageViewModel vm) => $"<{vm.CurPage}/{vm.TotalPage}>");
		bindingSet.Bind(btnLast).For((Button v) => v.onClick).To((TeachingManualPageViewModel vm) => vm.OnLastBtnClick);
		bindingSet.Bind(btnNext).For((Button v) => v.onClick).To((TeachingManualPageViewModel vm) => vm.OnNextBtnClick);
		bindingSet.Bind(btnLast.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TeachingManualPageViewModel vm) => vm.CurPage > 1);
		bindingSet.Bind(btnNext.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TeachingManualPageViewModel vm) => vm.CurPage < vm.TotalPage);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((TeachingManualPageViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.enabled).To((TeachingManualPageViewModel vm) => vm.ReadComplete);
		bindingSet.Bind(btnClose.gameObject).For((GameObject v) => v.activeSelf).To((TeachingManualPageViewModel vm) => vm.ReadComplete);
		bindingSet.Build();
	}
}
