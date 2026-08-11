using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardOptionalWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private LoopListView2 cardList;

	[SerializeField]
	private TextMeshProUGUI itemName;

	[SerializeField]
	private TextMeshProUGUI itemDesc;

	[SerializeField]
	private LoopListView2 tagList;

	private DrawCardOptionalViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardOptionalViewModel>();
		BindingSet<DrawCardOptionalWindow, DrawCardOptionalViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DrawCardOptionalWindow v) => v.CloseWindow).To((DrawCardOptionalViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((DrawCardOptionalWindow v) => v.OpenUguiWindow).To((DrawCardOptionalViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((DrawCardOptionalViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((DrawCardOptionalViewModel vm) => vm.BtnConfirmCmd);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardOptionalViewModel vm) => vm.ItemName);
		bindingSet.Bind<TextMeshProUGUI>(itemDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardOptionalViewModel vm) => vm.ItemDesc);
		bindingSet.Bind(this).For((DrawCardOptionalWindow v) => v.RefreshTagList).To((DrawCardOptionalViewModel vm) => vm.RefreshTagRequest);
		bindingSet.Build();
		cardList.InitListView(viewModel.ItemDataList.Count, OnGetOptionalIItemByIndex);
		tagList.InitListView(viewModel.TagList.Count, OnGetTagItemByIndex);
		cardList.MovePanelToItemIndex(viewModel.Index, 0f);
	}

	private void RefreshTagList(object sender, InteractionEventArgs e)
	{
		tagList.SetListItemCount(viewModel.TagList.Count);
		tagList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetOptionalIItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("OptionalItem");
		if (loopListViewItem != null)
		{
			DrawCardOptionalItem component = loopListViewItem.GetComponent<DrawCardOptionalItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemDataList[index]);
			}
			else
			{
				component.RefreshOptionalItemData(viewModel.ItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTagItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TagList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TagItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TagList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TagList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
