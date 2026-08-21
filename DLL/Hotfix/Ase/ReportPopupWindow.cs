using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ReportPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button btnOpenReport;

	[SerializeField]
	private RectTransform btnRect;

	[SerializeField]
	private Button btnOutside;

	private ReportPopupViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ReportPopupViewModel>();
		BindingSet<ReportPopupWindow, ReportPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ReportPopupWindow v) => v.OnDismissRequest).To((ReportPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ReportPopupWindow v) => v.OpenUguiWindow).To((ReportPopupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((ReportPopupViewModel vm) => vm.Close);
		bindingSet.Bind(btnOpenReport).For((Button v) => v.onClick).To((ReportPopupViewModel vm) => vm.OpenReportCmd);
		bindingSet.Bind(btnRect).For((RectTransform v) => v.anchoredPosition).To((ReportPopupViewModel vm) => vm.BtnPosition);
		bindingSet.Build();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			viewModel.RefreshPosition(RectTransform);
		}
	}
}
