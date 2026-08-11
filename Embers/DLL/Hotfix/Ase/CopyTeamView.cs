using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyTeamView : UGuiView
{
	public LoopListView2 heroList;

	public GameObject selectRoot;

	public Button btnSel;

	public TextMeshProUGUI teamName;

	private CopyTeamViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyTeamViewModel>(userData);
		BindingSet<CopyTeamView, CopyTeamViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(teamName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyTeamViewModel vm) => vm.TeamName);
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTeamViewModel vm) => vm.IsSelect);
		bindingSet.Bind(btnSel).For((Button v) => v.onClick).To((CopyTeamViewModel vm) => vm.Select);
		bindingSet.Build();
		heroList.InitListView(viewModel.HeroItemViewModels.Count, OnGetHeroItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTeamViewModel>(userData);
		this.SetDataContext(viewModel);
		heroList.SetListItemCount(viewModel.HeroItemViewModels.Count);
		heroList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		if (viewModel.HeroItemViewModels[index].HeroModel == null || viewModel.HeroItemViewModels[index].HeroModel.Id == 0)
		{
			return listView2.NewListViewItem("Empty");
		}
		loopListViewItem = listView2.NewListViewItem("HeroItem");
		if (loopListViewItem != null)
		{
			CopyHeroItem component = loopListViewItem.GetComponent<CopyHeroItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}
}
