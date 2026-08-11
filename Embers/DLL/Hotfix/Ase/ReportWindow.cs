using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class ReportWindow : UGuiWindow
{
	public LoopGridView itemList;

	public new Text name;

	public TextMeshProUGUI typeName;

	public Button btnReport;

	public Button btnCancel;

	private ReportViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ReportViewModel>();
		BindingSet<ReportWindow, ReportViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ReportWindow v) => v.OnDismissRequest).To((ReportViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ReportWindow v) => v.OpenUguiWindow).To((ReportViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(typeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ReportViewModel vm) => $"举报{vm.ReportTypeName}：");
		bindingSet.Bind(name).For((Text v) => v.text).ToExpression((ReportViewModel vm) => vm.Name);
		bindingSet.Bind(btnReport).For((Button v) => v.onClick).To((ReportViewModel vm) => vm.OptCommand)
			.CommandParameter("OnSubmit");
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((ReportViewModel vm) => vm.OptCommand)
			.CommandParameter("OnCancel");
		bindingSet.Build();
		itemList.InitGridView(viewModel.ItemList.Count, OnGetReportItemByIndex);
	}

	private LoopGridViewItem OnGetReportItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.ItemList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("ReportItemView");
		if (loopGridViewItem != null)
		{
			ReportItemView component = loopGridViewItem.GetComponent<ReportItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.ItemList[index]);
			}
		}
		return loopGridViewItem;
	}
}
