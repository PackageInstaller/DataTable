using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyST4RewardView : UGuiView
{
	public Button btnBack;

	public Button btnBack2;

	public TextMeshProUGUI count;

	public GameObject st4;

	public GameObject st5;

	public LoopListView2 rewardList;

	private CopyST4RewardViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyST4RewardViewModel>(userData);
		BindingSet<CopyST4RewardView, CopyST4RewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopyST4RewardView v) => v.OnVisibleChanged).To((CopyST4RewardViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((CopyST4RewardView v) => v.RankItem).To((CopyST4RewardViewModel vm) => vm.RankRequest);
		bindingSet.Bind(st4).For((GameObject v) => v.activeSelf).ToExpression((CopyST4RewardViewModel vm) => vm.ItemType == 4);
		bindingSet.Bind(st5).For((GameObject v) => v.activeSelf).ToExpression((CopyST4RewardViewModel vm) => vm.ItemType == 5);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopyST4RewardViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((CopyST4RewardViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyST4RewardViewModel vm) => vm.Count);
		bindingSet.Build();
		rewardList.InitListView(viewModel.Reward4ItemVMs.Count, OnGetRewardItemByIndex);
	}

	private void RankItem(object sender, InteractionEventArgs e)
	{
		rewardList.SetListItemCount(viewModel.Reward4ItemVMs.Count);
		rewardList.RefreshAllShownItem();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			rewardList.SetListItemCount(viewModel.Reward4ItemVMs.Count);
			rewardList.RefreshAllShownItem();
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyST4RewardViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.Reward4ItemVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem($"Reward{viewModel.ItemType}ItemView");
		if (loopListViewItem != null)
		{
			CopyReward4ItemView component = loopListViewItem.GetComponent<CopyReward4ItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.Reward4ItemVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.Reward4ItemVMs[index]);
			}
		}
		return loopListViewItem;
	}
}
