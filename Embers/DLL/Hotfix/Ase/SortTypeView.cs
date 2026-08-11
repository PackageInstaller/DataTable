using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class SortTypeView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI sortTypeNmae;

	[SerializeField]
	private LoopGridView sortItemList;

	private SortTypeViewModel viewModel;

	public void Init(SortTypeViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SortTypeView, SortTypeViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(sortTypeNmae).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SortTypeViewModel vm) => vm.SortTypeName);
		bindingSet.Build();
		sortItemList.InitGridView(viewModel.SortItemList.Count, OnGetSortItemItemByIndex);
	}

	public void RefreshData(SortTypeViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private LoopGridViewItem OnGetSortItemItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.SortItemList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("SortItemView");
		if (loopGridViewItem != null)
		{
			SortItemView component = loopGridViewItem.GetComponent<SortItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SortItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SortItemList[index]);
			}
		}
		return loopGridViewItem;
	}
}
