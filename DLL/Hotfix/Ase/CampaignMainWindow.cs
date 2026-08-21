using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace Ase;

public class CampaignMainWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 msgListView;

	[SerializeField]
	private TextMeshProUGUI curMainTask;

	[SerializeField]
	private Image curMainTackIcon;

	[SerializeField]
	private GameObject haveNextTaskGo;

	[SerializeField]
	private GameObject lastTask1;

	[SerializeField]
	private Image lastTaskIcon1;

	[SerializeField]
	private TextMeshProUGUI lastTaskName1;

	[SerializeField]
	private GameObject lastTask2;

	[SerializeField]
	private Image lastTaskIcon2;

	[SerializeField]
	private TextMeshProUGUI lastTaskName2;

	[SerializeField]
	private TextMeshProUGUI curSideTaskInfo;

	[SerializeField]
	private TextMeshProUGUI pushTime;

	[SerializeField]
	private CampaignShopView shopView;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnRule;

	[SerializeField]
	private Button btnOpenShop;

	[SerializeField]
	private Button btnHideShop;

	[SerializeField]
	private Button btnTimeline;

	[SerializeField]
	private Button btnStart;

	private CampaignMainViewModel _viewModel;

	private long startSecond;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<CampaignMainViewModel>();
		BindingSet<CampaignMainWindow, CampaignMainViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((CampaignMainWindow v) => v.OnDismissRequest).To((CampaignMainViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((CampaignMainWindow v) => v.OpenUguiWindow).To((CampaignMainViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CampaignMainViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(curMainTask).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMainViewModel vm) => vm.CurMainTask);
		bindingSet.Bind(lastTask1).For((GameObject v) => v.activeSelf).To((CampaignMainViewModel vm) => vm.ShowLastTask1);
		bindingSet.Bind<TextMeshProUGUI>(lastTaskName1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMainViewModel vm) => vm.LastTask1);
		bindingSet.Bind(lastTask2).For((GameObject v) => v.activeSelf).To((CampaignMainViewModel vm) => vm.ShowLastTask2);
		bindingSet.Bind<TextMeshProUGUI>(lastTaskName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMainViewModel vm) => vm.LastTask2);
		bindingSet.Bind(curMainTackIcon).For((Image v) => v.sprite).To((CampaignMainViewModel vm) => vm.CurMainTaskIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(lastTaskIcon1).For((Image v) => v.sprite).To((CampaignMainViewModel vm) => vm.LastTaskIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(lastTaskIcon2).For((Image v) => v.sprite).To((CampaignMainViewModel vm) => vm.LastTaskIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(curSideTaskInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMainViewModel vm) => vm.CurBranchTaskInfo);
		bindingSet.Bind<TextMeshProUGUI>(pushTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMainViewModel vm) => vm.PushTimeText);
		bindingSet.Bind().For((CampaignMainWindow v) => v.RefreshMsgList).To((CampaignMainViewModel vm) => vm.RefreshMsgListRst);
		bindingSet.Bind(btnRule).For((Button v) => v.onClick).To((CampaignMainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("Rule");
		bindingSet.Bind(btnTimeline).For((Button v) => v.onClick).To((CampaignMainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("Timeline");
		bindingSet.Bind(btnStart).For((Button v) => v.onClick).To((CampaignMainViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("Start");
		bindingSet.Build();
		shopView.Init(_viewModel.ShopViewModel);
		btnOpenShop.onClick.AddListener(OpenShop);
		btnHideShop.onClick.AddListener(HideShop);
		msgListView.InitListView(_viewModel.MsgList.Count, OnGetMsgItemByIndex);
	}

	private LoopListViewItem2 OnGetMsgItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.MsgList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("MsgItem");
		if (loopListViewItem != null)
		{
			TextMeshProUGUI componentInChildren = loopListViewItem.GetComponentInChildren<TextMeshProUGUI>();
			if ((UnityEngine.Object)(object)componentInChildren != null)
			{
				((TMP_Text)componentInChildren).text = _viewModel.MsgList[index];
			}
		}
		return loopListViewItem;
	}

	private void RefreshMsgList(object sender, InteractionEventArgs e)
	{
		msgListView.SetListItemCount(_viewModel.MsgList.Count);
		msgListView.RefreshAllShownItem();
	}

	private async void OpenShop()
	{
		await _viewModel.ShopViewModel.OnOpen();
		shopView.Alpha = 1f;
		shopView.CanvasGroup.blocksRaycasts = true;
		btnHideShop.gameObject.SetActive(value: true);
		SendOpenShopTDA();
	}

	private void HideShop()
	{
		shopView.Alpha = 0f;
		shopView.CanvasGroup.blocksRaycasts = false;
		btnHideShop.gameObject.SetActive(value: false);
		SendHideShopTDA();
	}

	private void SendOpenShopTDA()
	{
		startSecond = (long)(DateTime.Now - new DateTime(1970, 1, 1)).TotalSeconds;
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("page_id", "0");
		dictionary.Add("page_type", "CampaignShopView");
		dictionary.Add("entrance", "CampaignMainWindow");
		TDAHandler.Instance.SendUserEvent("page_view_start", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	private void SendHideShopTDA()
	{
		long num = (long)(DateTime.Now - new DateTime(1970, 1, 1)).TotalSeconds - startSecond;
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("page_id", "0");
		dictionary.Add("page_type", "CampaignShopView");
		dictionary.Add("entrance", "CampaignMainWindow");
		dictionary.Add("duration", num);
		TDAHandler.Instance.SendUserEvent("page_view_end", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}
}
