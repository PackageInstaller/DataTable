using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UpgradeSuccessWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI levelOld;

	[SerializeField]
	private TextMeshProUGUI levelNew;

	[SerializeField]
	private Image heroIcon;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopListView2 propertyList;

	private UpgradeSuccessViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<UpgradeSuccessViewModel>();
		BindingSet<UpgradeSuccessWindow, UpgradeSuccessViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((UpgradeSuccessWindow v) => v.OnDismissRequest).To((UpgradeSuccessViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((UpgradeSuccessViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(levelOld).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UpgradeSuccessViewModel vm) => vm.LevelOld);
		bindingSet.Bind<TextMeshProUGUI>(levelNew).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UpgradeSuccessViewModel vm) => vm.LevelNew);
		bindingSet.Bind(heroIcon).For((Image v) => v.sprite).ToExpression((UpgradeSuccessViewModel vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		propertyList.InitListView(viewModel.PropertyDatas.Count, OnGetPropertyItemByIndex);
		heroIcon.SetNativeSize();
	}

	private LoopListViewItem2 OnGetPropertyItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PropertyDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropertyItem");
		if (loopListViewItem != null)
		{
			PropertyItem component = loopListViewItem.GetComponent<PropertyItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PropertyDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.PropertyDatas[index]);
			}
		}
		return loopListViewItem;
	}
}
