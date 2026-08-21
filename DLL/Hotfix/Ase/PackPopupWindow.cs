using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PackPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI showName;

	[SerializeField]
	private TextMeshProUGUI showDesc;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarityColor;

	[SerializeField]
	private LoopGridView packItemList;

	private PackPopupViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PackPopupViewModel>();
		BindingSet<PackPopupWindow, PackPopupViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PackPopupViewModel vm) => vm.Close);
		bindingSet.Bind().For((PackPopupWindow v) => v.OnDismissRequest).To((PackPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((PackPopupWindow v) => v.OpenUguiWindow).To((PackPopupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(showName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PackPopupViewModel vm) => vm.PropData.Name);
		bindingSet.Bind<TextMeshProUGUI>(showDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PackPopupViewModel vm) => vm.PropDesc);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PackPopupViewModel vm) => vm.PropData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarityColor).For((Image v) => v.sprite).To((PackPopupViewModel vm) => vm.RarityColorBg)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		packItemList.InitGridView(_viewModel.PropPackItemViewModelList.Count, OnGetPackItemByIndex);
	}

	private LoopGridViewItem OnGetPackItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		PropPackItemViewModel propPackItemViewModel = _viewModel.PropPackItemViewModelList[index];
		if (propPackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = packItemList.NewListViewItem("PackItem");
		PropPackItem component = loopGridViewItem.GetComponent<PropPackItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(propPackItemViewModel);
		}
		else
		{
			component.RefreshData(propPackItemViewModel);
		}
		return loopGridViewItem;
	}
}
