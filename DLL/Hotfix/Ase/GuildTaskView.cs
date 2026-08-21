using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildTaskView : UGuiView
{
	[SerializeField]
	private LoopListView2 taskList;

	[SerializeField]
	private TextMeshProUGUI curPointText;

	[SerializeField]
	private Image progress;

	[SerializeField]
	private RectTransform totalProgressBar;

	[SerializeField]
	private GuildTaskRewardItem rewardItemTpl;

	[SerializeField]
	private RectTransform rewardItemRoot;

	[SerializeField]
	private GameObject rewardDisplayPanel;

	[SerializeField]
	private Button btnCloseRewardPanel;

	[SerializeField]
	private RectTransform panelMain;

	[SerializeField]
	private KnapsackItemNew reward1;

	[SerializeField]
	private KnapsackItemNew reward2;

	[SerializeField]
	private GameObject progressChangeEffect;

	[SerializeField]
	private GameObject progressBarChangeEffect;

	private GuildTaskViewModel _viewModel;

	private List<GuildTaskRewardItem> _rewardItems = new List<GuildTaskRewardItem>();

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildTaskViewModel>(userData);
		BindingSet<GuildTaskView, GuildTaskViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(curPointText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildTaskViewModel vm) => vm.CurPoint);
		bindingSet.Bind(progress).For((Image v) => v.fillAmount).ToExpression((GuildTaskViewModel vm) => (vm.CurPoint >= vm.TotalPoint) ? 1f : ((float)vm.CurPoint / (float)vm.TotalPoint));
		bindingSet.Bind().For((GuildTaskView v) => v.OnTaskListChanged).To((GuildTaskViewModel vm) => vm.RefreshTaskListRst);
		bindingSet.Bind().For((GuildTaskView v) => v.OpenRewardDisplayPanel).To((GuildTaskViewModel vm) => vm.OpenRewardPanelRst);
		bindingSet.Bind().For((GuildTaskView v) => v.PlayProgressChangeEffect).To((GuildTaskViewModel vm) => vm.PlayProgressChangeEffect);
		bindingSet.Build();
		InitRewardItems();
		btnCloseRewardPanel.onClick.AddListener(delegate
		{
			rewardDisplayPanel.gameObject.SetActive(value: false);
		});
		reward1.Init(new KnapsackItemViewModel(_viewModel));
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(GuildDefinition.GetGuildFundPropId());
		if (dataRow != null)
		{
			reward2.Init(new KnapsackItemViewModel(_viewModel, new PropData(dataRow)));
		}
		taskList.InitListView(_viewModel.TaskDatas.Count, OnGetItemByIndex);
	}

	private void InitRewardItems()
	{
		DRGuildActiveReward[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRGuildActiveReward>();
		if (allDataRow == null || allDataRow.Length == 0)
		{
			return;
		}
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		int myDailyActivePoint = myGuildData.MyDailyActivePoint;
		int dailyMaxActivePoint = myGuildData.GetDailyMaxActivePoint();
		DRGuildActiveReward[] array = allDataRow;
		foreach (DRGuildActiveReward dRGuildActiveReward in array)
		{
			GuildTaskRewardItem guildTaskRewardItem = UnityEngine.Object.Instantiate(rewardItemTpl, rewardItemRoot);
			guildTaskRewardItem.gameObject.SetActive(value: true);
			bool alreadyGet = false;
			if (myGuildData.DailyActiveRewardState.Length >= dRGuildActiveReward.Id && int.TryParse(myGuildData.DailyActiveRewardState[dRGuildActiveReward.Id - 1].ToString(), out var result))
			{
				alreadyGet = result == 1;
			}
			GuildTaskRewardItemData guildTaskRewardItemData = new GuildTaskRewardItemData(_viewModel, dRGuildActiveReward, totalProgressBar.sizeDelta.x, myDailyActivePoint, dailyMaxActivePoint, alreadyGet);
			guildTaskRewardItem.Init(guildTaskRewardItemData);
			_viewModel.AddRewardItemData(guildTaskRewardItemData);
			_rewardItems.Add(guildTaskRewardItem);
		}
	}

	private void OnTaskListChanged(object sender, InteractionEventArgs e)
	{
		taskList.SetListItemCount(_viewModel.TaskDatas.Count);
		taskList.RefreshAllShownItem();
		int myDailyActivePoint = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().MyDailyActivePoint;
		foreach (GuildTaskRewardItem rewardItem in _rewardItems)
		{
			rewardItem.ViewModel.RefreshCurPoint(myDailyActivePoint);
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.TaskDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("GuildTaskItem");
		if (loopListViewItem != null)
		{
			GuildTaskItem component = loopListViewItem.GetComponent<GuildTaskItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(new GuildTaskItemData(_viewModel, _viewModel.TaskDatas[index]));
			}
			else
			{
				component.RefreshData(new GuildTaskItemData(_viewModel, _viewModel.TaskDatas[index]));
			}
		}
		return loopListViewItem;
	}

	private void OpenRewardDisplayPanel(object sender, InteractionEventArgs e)
	{
		if (e.Context is GuildTaskRewardItem guildTaskRewardItem)
		{
			DRGuildActiveReward drConfigData = guildTaskRewardItem.ViewModel.DrConfigData;
			if (drConfigData.RewardIds.Count > 0 && drConfigData.RewardNums.Count > 0)
			{
				reward1.ViewModel.Refresh(PropDataBase.CreateByType(PropTypeEnum.Coin, drConfigData.RewardIds[0], drConfigData.RewardNums[0]));
				reward1.gameObject.SetActive(value: true);
			}
			else
			{
				reward1.gameObject.SetActive(value: false);
			}
			if (reward2.ViewModel != null && reward2.ViewModel.PropDataBase != null)
			{
				reward2.ViewModel.PropDataBase.Amount = drConfigData.UnionFundReward;
				reward2.gameObject.SetActive(value: true);
			}
			else
			{
				reward2.gameObject.SetActive(value: false);
			}
			panelMain.SetParent(guildTaskRewardItem.transform);
			panelMain.anchorMin = new Vector2(0.5f, 1f);
			panelMain.anchorMax = new Vector2(0.5f, 1f);
			panelMain.pivot = new Vector2(0.5f, 0f);
			panelMain.anchoredPosition = Vector2.zero;
			panelMain.SetParent(rewardDisplayPanel.transform);
			rewardDisplayPanel.gameObject.SetActive(value: true);
		}
	}

	private void PlayProgressChangeEffect(object sender, InteractionEventArgs e)
	{
		progressChangeEffect.SetActive(value: false);
		progressChangeEffect.SetActive(value: true);
		progressBarChangeEffect.SetActive(value: false);
		RectTransform component = progressBarChangeEffect.GetComponent<RectTransform>();
		component.anchoredPosition = new Vector2(progress.rectTransform.sizeDelta.x * progress.fillAmount, component.anchoredPosition.y);
		progressBarChangeEffect.SetActive(value: true);
	}

	protected override void OnDestroy()
	{
		if (_rewardItems != null)
		{
			for (int i = 0; i < _rewardItems.Count; i++)
			{
				UnityEngine.Object.DestroyImmediate(_rewardItems[i]);
				_rewardItems[i] = null;
			}
		}
		base.OnDestroy();
	}
}
