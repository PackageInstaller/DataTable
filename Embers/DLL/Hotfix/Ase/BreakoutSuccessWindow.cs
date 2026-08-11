using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BreakoutSuccessWindow : UGuiWindow
{
	[SerializeField]
	private Image heroIcon;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private UIStarGroup starGroup;

	[SerializeField]
	private TextMeshProUGUI tips;

	[SerializeField]
	private LoopListView2 propertyList;

	private BreakoutSuccessViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BreakoutSuccessViewModel>();
		BindingSet<BreakoutSuccessWindow, BreakoutSuccessViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BreakoutSuccessWindow v) => v.OnDismissRequest).To((BreakoutSuccessViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BreakoutSuccessViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(tips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BreakoutSuccessViewModel vm) => vm.Tips);
		bindingSet.Bind(starGroup).For((UIStarGroup v) => v.CurCount).To((BreakoutSuccessViewModel vm) => vm.StarLevel);
		bindingSet.Bind(heroIcon).For((Image v) => v.sprite).ToExpression((BreakoutSuccessViewModel vm) => vm.IconPath)
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
				component.SetDataContext(viewModel.PropertyDatas[index]);
			}
		}
		return loopListViewItem;
	}
}
