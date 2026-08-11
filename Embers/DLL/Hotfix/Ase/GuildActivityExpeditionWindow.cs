using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildActivityExpeditionWindow : UGuiWindowBase
{
	public Button btnBack;

	public ShowInfoItem showInfoItem;

	public TextMeshProUGUI beatCount;

	public TextMeshProUGUI bossName;

	public GameObject goNomal;

	public GameObject goFinal;

	public GameObject goReward;

	public GameObject goRewardRed;

	public GameObject goUnReward;

	public Button btnRank;

	public Button btnOpenMulti;

	public Button btnRankScore;

	public Button btnReward;

	public GuildActivityItemView ItemView;

	public CopyItemDetail1View detailView;

	public LoopListView2 itemList;

	[SerializeField]
	private GameObject rewardDetailView;

	[SerializeField]
	private Button closeRewardDetailView;

	[SerializeField]
	private Transform rewardDetailViewRect;

	[SerializeField]
	private GameObject rewardDetailItem;

	private GuildActivityExpeditionViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GuildActivityExpeditionViewModel>();
		BindingSet<GuildActivityExpeditionWindow, GuildActivityExpeditionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((GuildActivityExpeditionWindow v) => v.OnDismissRequest).To((GuildActivityExpeditionViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildActivityExpeditionWindow v) => v.OpenUguiWindow).To((GuildActivityExpeditionViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((GuildActivityExpeditionWindow v) => v.SetChildViewVisibility).To((GuildActivityExpeditionViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GuildActivityExpeditionViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(beatCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildActivityExpeditionViewModel vm) => $"{vm.SelectItemViewModel.Data.CurBeatCount}/{vm.SelectItemViewModel.Data.MaxBeatCount}");
		bindingSet.Bind<TextMeshProUGUI>(bossName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildActivityExpeditionViewModel vm) => vm.BossName);
		bindingSet.Bind(goReward).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => !vm.SelectItemViewModel.Data.IsReward);
		bindingSet.Bind(goUnReward).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => vm.SelectItemViewModel.Data.IsReward);
		bindingSet.Bind(goRewardRed).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => !vm.SelectItemViewModel.Data.IsReward && vm.SelectItemViewModel.Data.IsPass);
		bindingSet.Bind(ItemView).For((GuildActivityItemView v) => v.ViewModel).To((GuildActivityExpeditionViewModel vm) => vm.ItemViewModel);
		bindingSet.Bind(detailView).For((CopyItemDetail1View v) => v.ViewModel).To((GuildActivityExpeditionViewModel vm) => vm.DetailViewModel);
		bindingSet.Bind(this).For((GuildActivityExpeditionWindow v) => v.OnOpt).To((GuildActivityExpeditionViewModel vm) => vm.OptRequest);
		bindingSet.Bind(goNomal).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => (int)vm.SelectItemViewModel.Data.CopyShowTypeEnum == 0);
		bindingSet.Bind(goFinal).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => (int)vm.SelectItemViewModel.Data.CopyShowTypeEnum == 1);
		bindingSet.Bind(btnReward).For((Button v) => v.onClick).To((GuildActivityExpeditionViewModel vm) => vm.OptCommand)
			.CommandParameter("OnReward");
		bindingSet.Bind(btnReward.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityExpeditionViewModel vm) => (int)vm.SelectItemViewModel.Data.CopyShowTypeEnum == 0);
		bindingSet.Bind(btnRank).For((Button v) => v.onClick).To((GuildActivityExpeditionViewModel vm) => vm.OptCommand)
			.CommandParameter("OnRankAll");
		bindingSet.Bind(btnRankScore).For((Button v) => v.onClick).To((GuildActivityExpeditionViewModel vm) => vm.OptCommand)
			.CommandParameter("OnRankScore");
		bindingSet.Bind(btnOpenMulti).For((Button v) => v.onClick).To((GuildActivityExpeditionViewModel vm) => vm.OptCommand)
			.CommandParameter("OnMulti");
		bindingSet.Build();
		showInfoItem.Init();
		itemList.InitListView(viewModel.ListItems.Count, OnGetItemByIndex);
		closeRewardDetailView.onClick.AddListener(delegate
		{
			rewardDetailView.gameObject.SetActive(value: false);
		});
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("ShowRewardPop".Equals(optName))
		{
			OpenRewardDetailView();
		}
	}

	private void OpenRewardDetailView()
	{
		for (int i = 0; i < rewardDetailViewRect.childCount; i++)
		{
			UnityEngine.Object.Destroy(rewardDetailViewRect.GetChild(i).gameObject);
		}
		foreach (KnapsackItemViewModel showRewardItemData in viewModel.ShowRewardItemDataList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(rewardDetailItem, rewardDetailViewRect);
			obj.transform.GetComponent<KnapsackItemNew>().Init(showRewardItemData);
			obj.gameObject.SetActive(value: true);
		}
		rewardDetailView.gameObject.SetActive(value: true);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ListItems.Count)
		{
			return null;
		}
		if (viewModel.ListItems[index].Data.Id == -1)
		{
			return listView2.NewListViewItem("FinalTitleItem");
		}
		if (viewModel.ListItems[index].Data.Id == -2)
		{
			return listView2.NewListViewItem("NormalTitleItem");
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("GuildCopyItemView");
		if (loopListViewItem != null)
		{
			GuildActivityCopyItemView component = loopListViewItem.GetComponent<GuildActivityCopyItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ListItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.ListItems[index]);
			}
		}
		return loopListViewItem;
	}
}
