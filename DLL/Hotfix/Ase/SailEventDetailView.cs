using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailEventDetailView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI eventName;

	[SerializeField]
	private TextMeshProUGUI eventDescription;

	[SerializeField]
	private LoopListView2 normalReward;

	[SerializeField]
	private LoopGridView greatReward;

	[SerializeField]
	private GameObject readyStateObj;

	[SerializeField]
	private TextMeshProUGUI costTime;

	[SerializeField]
	private TextMeshProUGUI leftTimes;

	[SerializeField]
	private Button btnAutoSelecte;

	[SerializeField]
	private Button btnStart;

	[SerializeField]
	private TextMeshProUGUI textStart;

	[SerializeField]
	private GameObject sailingStateObj;

	[SerializeField]
	private GameObject finiashStateObj;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private UIAudioPlayer uiAudioPlayer;

	private SailEventDetailViewModel viewModel;

	public void Init(SailEventDetailViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SailEventDetailView, SailEventDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((SailEventDetailViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(eventName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventDetailViewModel vm) => vm.EventName);
		bindingSet.Bind<TextMeshProUGUI>(eventDescription).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventDetailViewModel vm) => vm.Description);
		bindingSet.Bind(readyStateObj).For((GameObject v) => v.activeSelf).ToExpression((SailEventDetailViewModel vm) => vm.State == 2);
		bindingSet.Bind<TextMeshProUGUI>(costTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventDetailViewModel vm) => vm.CostTimeText);
		bindingSet.Bind<TextMeshProUGUI>(leftTimes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventDetailViewModel vm) => vm.LeftTimes);
		bindingSet.Bind(btnAutoSelecte).For((Button v) => v.onClick).To((SailEventDetailViewModel vm) => vm.AutoSelectCmd);
		bindingSet.Bind(btnStart).For((Button v) => v.onClick).To((SailEventDetailViewModel vm) => vm.StartCmd);
		bindingSet.Bind<TextMeshProUGUI>(textStart).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventDetailViewModel vm) => vm.StartText);
		bindingSet.Bind(sailingStateObj).For((GameObject v) => v.activeSelf).ToExpression((SailEventDetailViewModel vm) => vm.State == 3);
		bindingSet.Bind(finiashStateObj).For((GameObject v) => v.activeSelf).ToExpression((SailEventDetailViewModel vm) => vm.State == 1);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((SailEventDetailViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(this).For((SailEventDetailView v) => v.RefreshRewardList).To((SailEventDetailViewModel vm) => vm.RefreshRequest);
		bindingSet.Bind(this).For((SailEventDetailView v) => v.PlayerUIAudio).To((SailEventDetailViewModel vm) => vm.PlayAudioRequest);
		bindingSet.Build();
		normalReward.InitListView(viewModel.NormalRewardList.Count, OnGetNormalItemByIndex);
		greatReward.InitGridView(viewModel.GreatRewardList.Count, OnGetGreatItemByIndex);
	}

	private LoopListViewItem2 OnGetNormalItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.NormalRewardList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.NormalRewardList[index]);
			}
			else
			{
				component.RefreshData(viewModel.NormalRewardList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetGreatItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		KnapsackItemViewModel knapsackItemViewModel = viewModel.GreatRewardList[index];
		if (knapsackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = greatReward.NewListViewItem("PropItem");
		KnapsackItemNew component = loopGridViewItem.GetComponent<KnapsackItemNew>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(knapsackItemViewModel);
		}
		else
		{
			component.RefreshData(knapsackItemViewModel);
		}
		return loopGridViewItem;
	}

	private void RefreshRewardList(object sender, InteractionEventArgs e)
	{
		normalReward.SetListItemCount(viewModel.NormalRewardList.Count);
		normalReward.RefreshAllShownItem();
		greatReward.SetListItemCount(viewModel.GreatRewardList.Count);
		greatReward.RefreshAllShownItem();
	}

	private void PlayerUIAudio(object sender, InteractionEventArgs e)
	{
		uiAudioPlayer.AudioInvoke();
	}
}
