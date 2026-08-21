using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityVersion1View : ActivityViewBase
{
	public TextMeshProUGUI activityDesc;

	public List<VersionMoneyView> propViews;

	public TextMeshProUGUI curCount;

	public TextMeshProUGUI maxCount;

	public TextMeshProUGUI acumCount;

	public Button btnShop;

	public GameObject gotoRed;

	public GameObject storeRed;

	public Button btnOpenMain;

	public TextMeshProUGUI timeLockText;

	public LoopListView2 rewardList;

	private ActivityVersion1ViewModel viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (ActivityVersion1ViewModel)viewModel;
		base.Init(viewModel);
		this.viewModel?.LightResetOnViewInit();
		BindingSet<ActivityVersion1View, ActivityVersion1ViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityVersion1View v) => v.OnVisibleChanged).To((ActivityVersion1ViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(activityDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersion1ViewModel vm) => vm.ActivityDesc);
		bindingSet.Bind(btnShop).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenShop");
		bindingSet.Bind(btnShop.gameObject).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.ShowLimitedContent);
		bindingSet.Bind(btnOpenMain).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenVersionMain");
		bindingSet.Bind<TextMeshProUGUI>(curCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.CurCount}");
		bindingSet.Bind<TextMeshProUGUI>(maxCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.MaxCount}");
		bindingSet.Bind<TextMeshProUGUI>(acumCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.AcumCount}");
		bindingSet.Bind(gotoRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.Red);
		bindingSet.Bind(storeRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.StoreRed);
		bindingSet.Bind().For((ActivityVersion1View v) => v.OnOpt).To((ActivityVersion1ViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		LoadProp();
		this.viewModel.CreateRankLock();
		rewardList.InitListView(this.viewModel.RewardItemViewModels.Count, OnGetRewardItemByIndex);
	}

	private void LoadProp()
	{
		if (propViews == null || propViews.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < propViews.Count; i++)
		{
			if (!(propViews[i] == null))
			{
				VersionMoneyViewModel versionMoneyViewModel = viewModel.AddProp(propViews[i].id);
				if (versionMoneyViewModel != null)
				{
					propViews[i].Init(versionMoneyViewModel);
				}
			}
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.RewardItemViewModels[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.RewardItemViewModels[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}
}
