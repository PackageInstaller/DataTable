#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItem5View : UGuiView
{
	public Button btn;

	public TextMeshProUGUI difficult;

	public TextMeshProUGUI scoreRate;

	public GameObject selRoot;

	public LoopListView2 attributeList;

	private CopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItem5View, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
				.CommandParameter("SelectCopy");
		}
		bindingSet.Bind<TextMeshProUGUI>(difficult).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Data.CopyRankName);
		bindingSet.Bind<TextMeshProUGUI>(scoreRate).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Rate);
		if (selRoot != null)
		{
			bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Build();
		attributeList.InitListView(viewModel.AdItemListType5.Count, OnGetAttributeItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
		attributeList.SetListItemCount(viewModel.AdItemListType5.Count);
		attributeList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		try
		{
			if (index < 0 || index >= viewModel.AdItemListType5.Count)
			{
				return null;
			}
			LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
			if (loopListViewItem != null)
			{
				CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
				component.Init();
				component.SetIcon(viewModel.AdItemListType5[index]);
			}
			return loopListViewItem;
		}
		catch (Exception ex)
		{
			Log.Error("buff图标报错 " + ex.Message);
			Log.Error("buff图标报错 " + ex.StackTrace);
		}
		return null;
	}
}
