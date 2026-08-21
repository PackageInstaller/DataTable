using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AttributeBindingWindow : UGuiWindow
{
	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Button tipBtn;

	[SerializeField]
	private GameObject tipObj;

	[SerializeField]
	private Image attributeIcon;

	[SerializeField]
	private GameObject attributeIconObj;

	[SerializeField]
	private TextMeshProUGUI attributeText;

	[SerializeField]
	private LoopListView2 attributeBindList;

	private AttributeBindingViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AttributeBindingViewModel>();
		BindingSet<AttributeBindingWindow, AttributeBindingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((AttributeBindingViewModel vm) => vm.Close);
		bindingSet.Bind(tipBtn).For((Button v) => v.onClick).To((AttributeBindingViewModel vm) => vm.TipBtnOnClick);
		bindingSet.Bind(tipObj).For((GameObject v) => v.activeSelf).To((AttributeBindingViewModel vm) => vm.ShowTip);
		bindingSet.Bind(attributeIcon).For((Image v) => v.sprite).ToExpression((AttributeBindingViewModel vm) => vm.AttributeBindIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(attributeIconObj).For((GameObject v) => v.activeSelf).ToExpression((AttributeBindingViewModel vm) => !vm.AttributeBindIcon.Equals("empty"));
		bindingSet.Bind<TextMeshProUGUI>(attributeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeBindingViewModel vm) => vm.AttributeBindText);
		bindingSet.Bind(this).For((AttributeBindingWindow v) => v.OnDismissRequest).To((AttributeBindingViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		attributeBindList.InitListView(viewModel.AttributeBindItemList.Count, OnGetAttributeBindItemByIndex);
	}

	private LoopListViewItem2 OnGetAttributeBindItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AttributeBindItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttributeBindItem");
		if (loopListViewItem != null)
		{
			AttributeBindItem component = loopListViewItem.GetComponent<AttributeBindItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AttributeBindItemList[index]);
			}
			else
			{
				component.RefreshAttributeData(viewModel.AttributeBindItemList[index]);
			}
		}
		return loopListViewItem;
	}
}
