using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameActivityWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI timeText;

	[SerializeField]
	private LoopListView2 tabItemList;

	[SerializeField]
	private LoopListView2 taskItemList;

	[SerializeField]
	private ScrollRect taskListScroll;

	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private Image rewardIcon;

	[SerializeField]
	private TextMeshProUGUI pointText;

	[SerializeField]
	private Image activityFill;

	[SerializeField]
	private GameObject rewardItem;

	[SerializeField]
	private GameObject fillObj;

	[SerializeField]
	private GameObject rewardDetailView;

	[SerializeField]
	private Button closeRewardDetailView;

	[SerializeField]
	private Transform rewardDetailViewRect;

	[SerializeField]
	private GameObject rewardDetailItem;

	[SerializeField]
	private RectTransform expEffectFillRect;

	[SerializeField]
	private UIParticlePlayer expAddPlayer;

	[SerializeField]
	private UIParticlePlayer expFillHeadPlayer;

	[SerializeField]
	private UIParticlePlayer expFillPlayer;

	[SerializeField]
	private int fixDuration;

	private GameActivityViewModel viewModel;

	private int duration;

	private Timer addExpTimer;

	private float curExpWidth;

	private float perExpAdd;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameActivityViewModel>();
		BindingSet<GameActivityWindow, GameActivityViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameActivityViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(rewardIcon).For((Image v) => v.sprite).ToExpression((GameActivityViewModel vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(pointText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityViewModel vm) => vm.GameActivityPoint);
		bindingSet.Bind<TextMeshProUGUI>(timeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityViewModel vm) => vm.LeftRefreshTimeText);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.SwitchTab).To((GameActivityViewModel vm) => vm.SwitchTabRequest);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.RefreshTaskList).To((GameActivityViewModel vm) => vm.RefreshTaskRequest);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.PlayEffectList).To((GameActivityViewModel vm) => vm.PlayEffectRequest);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.OpenUguiWindow).To((GameActivityViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.CloseWindow).To((GameActivityViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GameActivityWindow v) => v.OpenRewardDetailView).To((GameActivityViewModel vm) => vm.OpenRewardDetailViewRequest);
		bindingSet.Build();
		if (fixDuration <= 0)
		{
			fixDuration = 1;
		}
		tabItemList.InitListView(viewModel.TabItemList.Count, OnGetTabItemByIndex);
		taskItemList.InitListView(viewModel.ShowTaskItemList.Count, OnGetTaskItemByIndex);
		SetRewardListItemPadding();
		rewardItemList.InitListView(viewModel.RewardItemList.Count, OnGetRewardItemByIndex);
		rewardItemList.ScrollRect.horizontal = false;
		rewardItemList.ScrollRect.vertical = false;
		SetFillStartPos();
		closeRewardDetailView.onClick.AddListener(delegate
		{
			rewardDetailView.gameObject.SetActive(value: false);
		});
	}

	private void SwitchTab(object sender, InteractionEventArgs e)
	{
		RefreshTaskList();
		activityFill.fillAmount = viewModel.GameActivityFill;
		SetFillStartPos();
		rewardItemList.SetListItemCount(viewModel.RewardItemList.Count);
		rewardItemList.RefreshAllShownItem();
		SetRewardListItemPadding();
	}

	private void SetFillStartPos()
	{
		float width = fillObj.GetComponent<RectTransform>().rect.width;
		expEffectFillRect.sizeDelta = new Vector2(width * viewModel.GameActivityFill, 30f);
		activityFill.fillAmount = viewModel.GameActivityFill;
	}

	private void RefreshTaskList(object sender = null, InteractionEventArgs e = null)
	{
		taskItemList.SetListItemCount(viewModel.ShowTaskItemList.Count);
		taskItemList.RefreshAllShownItem();
		taskListScroll.verticalNormalizedPosition = 1f;
	}

	private void PlayEffectList(object sender, InteractionEventArgs e)
	{
		float width = fillObj.GetComponent<RectTransform>().rect.width;
		expEffectFillRect.sizeDelta = new Vector2(width * viewModel.GameOldActivityFill, 30f);
		activityFill.fillAmount = viewModel.GameOldActivityFill;
		duration = fixDuration;
		if (expFillHeadPlayer != null)
		{
			expFillHeadPlayer.Play();
		}
		if (expAddPlayer != null)
		{
			expAddPlayer.Hide();
			expAddPlayer.Play();
		}
		curExpWidth = expEffectFillRect.rect.width;
		float num = width * viewModel.GameActivityFill;
		perExpAdd = (num - curExpWidth) / (float)duration;
		if (expFillPlayer != null)
		{
			expFillPlayer.Play();
			CloseAddExpTimer();
			addExpTimer = Timer.Register(0.01f, AddExp, null, isLooped: true, useRealTime: true);
		}
	}

	private void AddExp()
	{
		if (!(activityFill == null) && viewModel != null && !(expFillPlayer == null) && !(expEffectFillRect == null))
		{
			duration--;
			if (duration < 0)
			{
				activityFill.fillAmount = viewModel.GameActivityFill;
				expFillPlayer.Hide();
				CloseAddExpTimer();
			}
			else
			{
				curExpWidth += perExpAdd;
				expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 30f);
			}
		}
	}

	private void CloseAddExpTimer()
	{
		if (addExpTimer != null)
		{
			addExpTimer.Cancel();
			addExpTimer = null;
		}
	}

	private void OpenRewardDetailView(object sender, InteractionEventArgs e)
	{
		ClearObj();
		foreach (KnapsackItemViewModel showRewardItemData in viewModel.ShowRewardItemDataList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(rewardDetailItem, rewardDetailViewRect);
			obj.transform.GetComponent<KnapsackItemNew>().Init(showRewardItemData);
			obj.gameObject.SetActive(value: true);
		}
		float num = RectTransform.rect.width - 210f;
		float newValue = ((float)e.Context + num - 40f) * RectTransform.lossyScale.x;
		rewardDetailViewRect.GetComponent<RectTransform>().SetPositionX(newValue);
		rewardDetailView.gameObject.SetActive(value: true);
	}

	private void SetRewardListItemPadding()
	{
		float width = rewardItem.GetComponent<RectTransform>().rect.width;
		float width2 = fillObj.GetComponent<RectTransform>().rect.width;
		int count = viewModel.RewardItemList.Count;
		float itemPadding = (width2 - width * (float)count) / (float)count;
		rewardItemList.SetItemPadding(itemPadding);
		for (int i = 0; i < rewardItemList.ItemList.Count; i++)
		{
			rewardItemList.OnItemSizeChanged(i);
		}
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityTabItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TabItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TabItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ShowTaskItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityTaskItem");
		if (loopListViewItem != null)
		{
			GameActivityItem component = loopListViewItem.GetComponent<GameActivityItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ShowTaskItemList[index]);
			}
			else
			{
				component.RefreshGameActivityItem(viewModel.ShowTaskItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityRewardItem");
		if (loopListViewItem != null)
		{
			GameActivityRewardItem component = loopListViewItem.GetComponent<GameActivityRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemList[index]);
			}
			else
			{
				component.RefreshGameActivityRewardItem(viewModel.RewardItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private void ClearObj()
	{
		for (int i = 0; i < rewardDetailViewRect.childCount; i++)
		{
			UnityEngine.Object.Destroy(rewardDetailViewRect.GetChild(i).gameObject);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
