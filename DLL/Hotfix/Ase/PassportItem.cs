using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private Button btnBuy;

	[SerializeField]
	private TextMeshProUGUI price;

	[SerializeField]
	private TextMeshProUGUI tip;

	[SerializeField]
	private LoopListView2 rewardItem1;

	[SerializeField]
	private LoopListView2 rewardItem2;

	private PassportItemData viewModel;

	public void Init(PassportItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportItem, PassportItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PassportItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((PassportItemData vm) => vm.Bg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportItemData vm) => vm.PassportName);
		bindingSet.Bind<TextMeshProUGUI>(price).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportItemData vm) => vm.PassportPrice);
		bindingSet.Bind(btnBuy).For((Button v) => v.onClick).To((PassportItemData vm) => vm.BuyPassportCmd);
		bindingSet.Bind<TextMeshProUGUI>(tip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportItemData vm) => vm.PassportTip);
		bindingSet.Build();
		rewardItem1.InitListView(this.viewModel.PassportRewardItemDataList1.Count, OnRewardItem1ByIndex);
		rewardItem2.InitListView(this.viewModel.PassportRewardItemDataList2.Count, OnRewardItem2ByIndex);
	}

	public void RefreshPassportItem(PassportItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnRewardItem1ByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PassportRewardItemDataList1.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = (viewModel.PassportRewardItemDataList1[index].IsEmpty ? listView2.NewListViewItem("PassportItem2") : listView2.NewListViewItem("PassportItem"));
		if (loopListViewItem != null)
		{
			PassportRewardItem component = loopListViewItem.GetComponent<PassportRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PassportRewardItemDataList1[index]);
			}
			else
			{
				component.RefreshPassRewardItemData(viewModel.PassportRewardItemDataList1[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnRewardItem2ByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PassportRewardItemDataList2.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PassportItem");
		if (loopListViewItem != null)
		{
			PassportRewardItem component = loopListViewItem.GetComponent<PassportRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PassportRewardItemDataList2[index]);
			}
			else
			{
				component.RefreshPassRewardItemData(viewModel.PassportRewardItemDataList2[index]);
			}
		}
		return loopListViewItem;
	}
}
