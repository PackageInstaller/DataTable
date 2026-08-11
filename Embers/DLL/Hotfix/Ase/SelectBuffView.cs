using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SelectBuffView : UGuiView
{
	public Button btnConfirm;

	public Button btnClose;

	public GameObject activeGo;

	public GameObject disactiveGo;

	public RectTransform buffRoot;

	public RecommendItemView buffItemTempl;

	private SelectBuffViewModel viewModel;

	private List<RecommendItemView> buffItemViews;

	public SelectBuffViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<SelectBuffViewModel>(userData);
		BindingSet<SelectBuffView, SelectBuffViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((SelectBuffViewModel vm) => vm.OptCommand)
			.CommandParameter("Confirm");
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((SelectBuffViewModel vm) => vm.OptCommand)
			.CommandParameter("Close");
		if (activeGo != null)
		{
			bindingSet.Bind(activeGo).For((GameObject v) => v.activeSelf).To((SelectBuffViewModel vm) => vm.IsConfirmEnable);
		}
		if (disactiveGo != null)
		{
			bindingSet.Bind(disactiveGo).For((GameObject v) => v.activeSelf).ToExpression((SelectBuffViewModel vm) => !vm.IsConfirmEnable);
		}
		bindingSet.Build();
		RebuildBuffItems();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<SelectBuffViewModel>(userData);
		this.SetDataContext(viewModel);
		RebuildBuffItems();
	}

	public void RefreshBuffList()
	{
		RefreshBuffItemsData();
	}

	private void RebuildBuffItems()
	{
		if (buffItemTempl == null || buffRoot == null || viewModel == null)
		{
			return;
		}
		if (buffItemViews == null)
		{
			buffItemViews = new List<RecommendItemView>();
		}
		buffItemTempl.gameObject.SetActive(value: false);
		for (int i = 0; i < viewModel.BuffItems.Count; i++)
		{
			RecommendItemView recommendItemView;
			if (buffItemViews.Count > i)
			{
				recommendItemView = buffItemViews[i];
			}
			else
			{
				recommendItemView = Object.Instantiate(buffItemTempl.gameObject, buffRoot).GetComponent<RecommendItemView>();
				buffItemViews.Add(recommendItemView);
			}
			recommendItemView.gameObject.SetActive(value: true);
			recommendItemView.Init(viewModel.BuffItems[i]);
		}
		for (int j = viewModel.BuffItems.Count; j < buffItemViews.Count; j++)
		{
			buffItemViews[j].gameObject.SetActive(value: false);
		}
	}

	private void RefreshBuffItemsData()
	{
		if (viewModel == null)
		{
			return;
		}
		if (buffItemViews == null)
		{
			RebuildBuffItems();
			return;
		}
		int count = viewModel.BuffItems.Count;
		for (int i = 0; i < count; i++)
		{
			if (buffItemViews.Count <= i)
			{
				RecommendItemView component = Object.Instantiate(buffItemTempl.gameObject, buffRoot).GetComponent<RecommendItemView>();
				buffItemViews.Add(component);
			}
			buffItemViews[i].gameObject.SetActive(value: true);
			buffItemViews[i].Init(viewModel.BuffItems[i]);
		}
		for (int j = count; j < buffItemViews.Count; j++)
		{
			buffItemViews[j].gameObject.SetActive(value: false);
		}
	}
}
