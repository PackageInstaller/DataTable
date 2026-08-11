using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LoadingMultiWindow : UGuiWindow
{
	public LoopListView2 playerList;

	public TextMeshProUGUI progressBarText;

	public Image progressBar;

	public TextMeshProUGUI tipText;

	public float interval = 20f;

	private LoadingMultiBattleViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<LoadingMultiBattleViewModel>();
		BindingSet<LoadingMultiWindow, LoadingMultiBattleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((LoadingMultiWindow v) => v.OnDismissRequest).To((LoadingMultiBattleViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(progressBar).For((Image v) => v.fillAmount).To((LoadingMultiBattleViewModel vm) => vm.ProgressBar.Progress);
		bindingSet.Bind<TextMeshProUGUI>(progressBarText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((LoadingMultiBattleViewModel vm) => $"{Mathf.FloorToInt(vm.ProgressBar.Progress * 100f)}%")
			.OneWay();
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((LoadingMultiBattleViewModel vm) => $"{vm.ProgressBar.Title}：{vm.ProgressBar.Tip}")
			.OneWay();
		bindingSet.Build();
		playerList.InitListView(viewModel.PlayerLoadingVMs.Count, OnGetPlayerItemByIndex);
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.StartLoading();
	}

	private LoopListViewItem2 OnGetPlayerItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PlayerLoadingVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PlayerItem");
		if (loopListViewItem != null)
		{
			PlayerLoadingView component = loopListViewItem.GetComponent<PlayerLoadingView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PlayerLoadingVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.PlayerLoadingVMs[index]);
			}
		}
		return loopListViewItem;
	}

	private new void OnDismissRequest(object sender, InteractionEventArgs args)
	{
		Dismiss();
	}

	private void TryGetBgm()
	{
	}
}
