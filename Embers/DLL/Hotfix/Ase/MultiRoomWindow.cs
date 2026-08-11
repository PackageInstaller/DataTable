using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomWindow : UGuiWindowBase
{
	[SerializeField]
	private ChatBarView chatBarView;

	[SerializeField]
	private Button friendBtn;

	[SerializeField]
	private TextMeshProUGUI roomInfo;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private List<TabItem> _tabToggles;

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private GameObject captainObj;

	[SerializeField]
	private Button btnMatch;

	[SerializeField]
	private GameObject captainInMatch;

	[SerializeField]
	private TextMeshProUGUI captainTime;

	[SerializeField]
	private Button btnCancelMatch;

	[SerializeField]
	private Button btnStartFight;

	[SerializeField]
	private GameObject teammate;

	[SerializeField]
	private Button btnReady;

	[SerializeField]
	private GameObject readyObj;

	[SerializeField]
	private GameObject cancelObj;

	[SerializeField]
	private TextMeshProUGUI readyText;

	[SerializeField]
	private GameObject firstGameObj;

	[SerializeField]
	private GameObject teammateInMatch;

	[SerializeField]
	private TextMeshProUGUI teammatetime;

	[SerializeField]
	private TextMeshProUGUI teamLevelTipText;

	[SerializeField]
	private List<MultiRoomPlayerView> gamers;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private LoopListView2 copyCostItemList;

	[SerializeField]
	private GameObject copyCostItemListObj;

	[SerializeField]
	private Button btnOpenCopyList;

	[SerializeField]
	private Button btnCloseCopyList;

	[SerializeField]
	private GameObject arrowUP;

	[SerializeField]
	private GameObject arrowDown;

	[SerializeField]
	private TextMeshProUGUI curCostDesc;

	[SerializeField]
	private GameObject costProp;

	[SerializeField]
	private Image costIcon;

	[SerializeField]
	private TextMeshProUGUI costText;

	[SerializeField]
	private TextMeshProUGUI costTextNotEnough;

	[SerializeField]
	private GameObject startBattleBtnBg;

	[SerializeField]
	private MultiRoomFunctionView multiRoomFunctionView;

	[SerializeField]
	private Button btnRecruit;

	[SerializeField]
	private TeamAttributeView teamAttributeView;

	[SerializeField]
	private GameObject buffRoot;

	[SerializeField]
	private LoopListView2 attributeList;

	private MultiRoomViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<MultiRoomViewModel>();
		BindingSet<MultiRoomWindow, MultiRoomViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(roomInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomViewModel vm) => $"{vm.CopyData.Name}");
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.BackCommand);
		bindingSet.Bind(captainObj).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.IsCaptain);
		bindingSet.Bind(btnMatch).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.MatchCommand);
		bindingSet.Bind(btnMatch.gameObject).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.ShowMatch);
		bindingSet.Bind(btnStartFight).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.StartCommand);
		bindingSet.Bind(captainInMatch).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.IsMatch);
		bindingSet.Bind<TextMeshProUGUI>(captainTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomViewModel vm) => $"匹配中 {vm.WaitTimeText}");
		bindingSet.Bind(btnCancelMatch).For((Button v) => v.onClick).ToExpression((MultiRoomViewModel vm) => vm.MatchCommand);
		bindingSet.Bind(teammate).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomViewModel vm) => !vm.IsCaptain);
		bindingSet.Bind(teammateInMatch).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.IsMatch);
		bindingSet.Bind<TextMeshProUGUI>(teammatetime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomViewModel vm) => $"{vm.WaitTimeText}");
		bindingSet.Bind(btnReady).For((Button v) => v.onClick).ToExpression((MultiRoomViewModel vm) => vm.ReadyCmd);
		bindingSet.Bind(readyObj).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomViewModel vm) => !vm.IsReady);
		bindingSet.Bind(cancelObj).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.IsReady);
		bindingSet.Bind<TextMeshProUGUI>(readyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomViewModel vm) => vm.BtnReadyText);
		bindingSet.Bind(firstGameObj).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.IsFirstGame);
		bindingSet.Bind<TextMeshProUGUI>(teamLevelTipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomViewModel vm) => vm.TeamLevelTipText);
		bindingSet.Bind(friendBtn).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.OpenFriendWindowCmd);
		bindingSet.Bind(this).For((MultiRoomWindow v) => v.CloseWindow).To((MultiRoomViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((MultiRoomWindow v) => v.OpenUguiWindow).To((MultiRoomViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((MultiRoomWindow v) => v.RefreshMatchBp).To((MultiRoomViewModel vm) => vm.RefreshMatchBpRequest);
		bindingSet.Bind(costRoot).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.ShowCost);
		bindingSet.Bind(btnOpenCopyList).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.OpenCopyCostList);
		bindingSet.Bind(btnCloseCopyList).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.CloseCopyCostList);
		bindingSet.Bind(copyCostItemListObj).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.ShowCostItemList);
		bindingSet.Bind(arrowUP).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomViewModel vm) => vm.ShowCostItemList && !vm.IsFirstGame);
		bindingSet.Bind(arrowDown).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomViewModel vm) => !vm.ShowCostItemList && !vm.IsFirstGame);
		bindingSet.Bind<TextMeshProUGUI>(curCostDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomViewModel vm) => vm.CurCostDesc);
		bindingSet.Bind(costProp.gameObject).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.ShowCostProp);
		bindingSet.Bind(startBattleBtnBg.gameObject).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.ShowCostProp);
		bindingSet.Bind(costIcon).For((Image v) => v.sprite).To((MultiRoomViewModel vm) => vm.CostPropIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(costText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomViewModel vm) => (float)vm.CostPropCount * vm.CostPropRate);
		bindingSet.Bind(((Component)(object)costText).gameObject).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.CostEnough);
		bindingSet.Bind<TextMeshProUGUI>(costTextNotEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomViewModel vm) => (float)vm.CostPropCount * vm.CostPropRate);
		bindingSet.Bind(((Component)(object)costTextNotEnough).gameObject).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomViewModel vm) => !vm.CostEnough);
		bindingSet.Bind(btnRecruit).For((Button v) => v.onClick).To((MultiRoomViewModel vm) => vm.SendRecruitCmd);
		bindingSet.Bind(buffRoot).For((GameObject v) => v.activeSelf).To((MultiRoomViewModel vm) => vm.HasCopyBuff);
		bindingSet.Build();
		moneyView.Init(new MoneyViewModel(_viewModel));
		for (int num = 0; num < gamers.Count; num++)
		{
			gamers[num].Init(_viewModel.GamerInfoList[num]);
		}
		InitChatBarView();
		InitCostItemList();
		multiRoomFunctionView.Init(_viewModel.MultiRoomFunctionViewModel);
		teamAttributeView.Init(_viewModel.TeamAttributeViewModel);
		if (_viewModel.HasCopyBuff)
		{
			attributeList.InitListView(_viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		}
	}

	private void InitCostItemList()
	{
		int count = _viewModel.MultiRoomCostItemDataList.Count;
		if (count < 3)
		{
			RectTransform component = copyCostItemList.GetComponent<RectTransform>();
			float num = ((copyCostItemList.ItemPrefabDataList.Count > 0) ? copyCostItemList.ItemPrefabDataList[0].mPadding : 0f);
			float num2 = ((copyCostItemList.ItemPrefabDataList.Count > 0 && copyCostItemList.ItemPrefabDataList[0].mItemPrefab != null) ? copyCostItemList.ItemPrefabDataList[0].mItemPrefab.GetComponent<RectTransform>().sizeDelta.y : 0f);
			component.sizeDelta = new Vector2(component.sizeDelta.x, copyCostItemList.PaddingTop + copyCostItemList.PaddingBottom + num2 * (float)count + num * (float)(count - 1));
		}
		copyCostItemList.InitListView(_viewModel.MultiRoomCostItemDataList.Count, OnGetCopyCostItemByIndex);
	}

	private void RefreshMatchBp(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < gamers.Count; i++)
		{
			gamers[i].RefreshBattlePropConfig();
		}
	}

	private void InitChatBarView()
	{
		if (chatBarView != null)
		{
			chatBarView.Init(_viewModel.ChatBar);
		}
	}

	private LoopListViewItem2 OnGetCopyCostItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.MultiRoomCostItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyCostItem");
		if (loopListViewItem != null)
		{
			MultiRoomCostItem component = loopListViewItem.GetComponent<MultiRoomCostItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.MultiRoomCostItemDataList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.MultiRoomCostItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			component.Init();
			component.SetIcon(_viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (_viewModel != null && _viewModel.ConsumeCampaignRoomDismissToast() && _viewModel.IsCaptain)
		{
			Toast.ShowInfo("已解散房间");
		}
		Dismiss();
	}
}
