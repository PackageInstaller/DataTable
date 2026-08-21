using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class GameActivityViewModel : OptionBase
{
	private List<GameActivityItemData> allTaskItemList;

	private List<GameActivityItemData> showTaskItemList;

	private List<TabItemNormalData> tabItemList;

	private List<GameActivityRewardItemData> rewardItemList;

	private GameActivityData gameActivityData;

	private int gameActivityPoint;

	private float gameOldActivityFill;

	private float gameActivityFill;

	private string iconPath;

	private TabItemNormalData curTab;

	private bool showRewardView;

	private List<KnapsackItemViewModel> showRewardItemDataList;

	private InteractionRequest switchTabRequest;

	private InteractionRequest refreshTaskRequest;

	private InteractionRequest playEffectRequest;

	private InteractionRequest<float> openRewardDetailViewRequest;

	private long leftRefreshTime;

	private string leftRefreshTimeText;

	private Timer timer;

	private string timeFormat;

	private bool isOpenWindow;

	private bool redPoint;

	private Action<bool> action;

	public List<GameActivityItemData> ShowTaskItemList
	{
		get
		{
			return showTaskItemList;
		}
		set
		{
			Set(ref showTaskItemList, value, "ShowTaskItemList");
		}
	}

	public List<GameActivityRewardItemData> RewardItemList
	{
		get
		{
			return rewardItemList;
		}
		set
		{
			Set(ref rewardItemList, value, "RewardItemList");
		}
	}

	public List<TabItemNormalData> TabItemList
	{
		get
		{
			return tabItemList;
		}
		set
		{
			Set(ref tabItemList, value, "TabItemList");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public string LeftRefreshTimeText
	{
		get
		{
			return leftRefreshTimeText;
		}
		set
		{
			Set(ref leftRefreshTimeText, value, "LeftRefreshTimeText");
		}
	}

	public float GameActivityFill
	{
		get
		{
			return gameActivityFill;
		}
		set
		{
			Set(ref gameActivityFill, value, "GameActivityFill");
		}
	}

	public int GameActivityPoint
	{
		get
		{
			return gameActivityPoint;
		}
		set
		{
			Set(ref gameActivityPoint, value, "GameActivityPoint");
		}
	}

	public float GameOldActivityFill => gameOldActivityFill;

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public List<KnapsackItemViewModel> ShowRewardItemDataList => showRewardItemDataList;

	public InteractionRequest SwitchTabRequest => switchTabRequest;

	public InteractionRequest<float> OpenRewardDetailViewRequest => openRewardDetailViewRequest;

	public InteractionRequest RefreshTaskRequest => refreshTaskRequest;

	public InteractionRequest PlayEffectRequest => playEffectRequest;

	public GameActivityViewModel(OptionBase parent)
	{
		base.parent = parent;
		Init();
		InitTabList();
		InitGameActivityTask();
		SwitchTab(tabItemList[0]);
		CheckRedPoint();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private void Init()
	{
		tabItemList = new List<TabItemNormalData>();
		allTaskItemList = new List<GameActivityItemData>();
		showTaskItemList = new List<GameActivityItemData>();
		rewardItemList = new List<GameActivityRewardItemData>();
		showRewardItemDataList = new List<KnapsackItemViewModel>();
		switchTabRequest = new InteractionRequest();
		openRewardDetailViewRequest = new InteractionRequest<float>();
		refreshTaskRequest = new InteractionRequest();
		playEffectRequest = new InteractionRequest();
	}

	private async void OnDailyUpdated()
	{
		Loading loading = await Loading.Show();
		if (await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendGetGameActivityInfoRequest())
		{
			gameActivityData = Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().GetGameActivityData();
			InitGameActivityTask();
			SwitchTab(tabItemList[0]);
			CheckRedPoint();
			switchTabRequest.Raise();
		}
		loading.Dispose();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tab)
		{
			SwitchTab(tab);
			switchTabRequest.Raise();
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GameActivityRewardItemData rewardItemData)
			{
				if (optionArg.OptionName.Equals("Receive"))
				{
					ReceivedReward(rewardItemData);
				}
				else if (optionArg.OptionName.Equals("Open"))
				{
					ShowRewardView(rewardItemData);
				}
			}
			else if (optionArg.Obj is GameActivityItemData gameActivityItemData)
			{
				if (optionArg.OptionName.Equals("Receive"))
				{
					SendCompleteTask(gameActivityItemData);
				}
				else if (optionArg.OptionName.Equals("Jump"))
				{
					OpenJumpWindow(gameActivityItemData);
				}
			}
		}
		else if (obj is OpenViewArg openViewArg)
		{
			if (openViewArg.ViewName.Equals("Ase.GameActivityWindow"))
			{
				OnDailyUpdated();
			}
			else
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	private void InitTabList()
	{
		TabItemNormalData item = new TabItemNormalData(this, "empty", 1, isSelected: false, "每日");
		tabItemList.Add(item);
		TabItemNormalData item2 = new TabItemNormalData(this, "empty", 2, isSelected: false, "每周");
		tabItemList.Add(item2);
	}

	public void InitGameActivityTask()
	{
		gameActivityData = Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().GetGameActivityData();
		allTaskItemList.Clear();
		showTaskItemList.Clear();
		rewardItemList.Clear();
		showRewardItemDataList.Clear();
		DRActiveTask[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRActiveTask>();
		if (allDataRow == null)
		{
			return;
		}
		DRActiveTask[] array = allDataRow;
		foreach (DRActiveTask dRActiveTask in array)
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(dRActiveTask.OpenId))
			{
				continue;
			}
			GameActivityItemData gameActivityItemData = new GameActivityItemData(this, dRActiveTask.Id, dRActiveTask.ActiveItem, dRActiveTask.EXP, dRActiveTask.TargetDesc, dRActiveTask.TargetValue, dRActiveTask.ActiveType, dRActiveTask.TargetWindow, dRActiveTask.WindowParams);
			foreach (GameActivityTaskData task in gameActivityData.TaskList)
			{
				if (task.TaskId == dRActiveTask.Id)
				{
					gameActivityItemData.SetRealData(task.TaskDone, task.TaskState == 1);
				}
			}
			allTaskItemList.Add(gameActivityItemData);
		}
	}

	public void AddAction(Action<bool> action)
	{
		this.action = action;
	}

	private void SwitchTab(TabItemNormalData tab)
	{
		curTab?.SetSelected(value: false);
		curTab = tab;
		curTab.SetSelected(value: true);
		ShowTaskItemList.Clear();
		ShowTaskItemList = allTaskItemList.FindAll((GameActivityItemData p) => p.TaskType == tab.ID);
		ShowTaskItemList.Sort(new GameActivitySort());
		if (ShowTaskItemList.Count > 0)
		{
			IconPath = ShowTaskItemList[0].IconPath;
		}
		DRActiveReward[] drActiveRewards = GameEntry.DataTable.GetDataRows((DRActiveReward p) => p.ActiveType == tab.ID);
		if (drActiveRewards != null)
		{
			RewardItemList.Clear();
			int i;
			for (i = 0; i < drActiveRewards.Length; i++)
			{
				DRDropGroups dataRow = GameEntry.DataTable.GetDataRow((DRDropGroups p) => p.GroupId == drActiveRewards[i].ActiveReward);
				if (dataRow == null)
				{
					continue;
				}
				foreach (int item in dataRow.ChildrenSetId)
				{
					AddRewardItem(item, drActiveRewards[i].Id, drActiveRewards[i].ActiveLev, drActiveRewards[i].Id);
				}
			}
			RewardItemList.Reverse();
		}
		CheckReward();
		gameOldActivityFill = GameActivityFill;
		SetTime();
	}

	private void AddRewardItem(int groupId, int rewardId, int rewardLevel, int index)
	{
		GameActivityRewardItemData gameActivityRewardItemData = new GameActivityRewardItemData(this, rewardId, rewardLevel, index);
		DRGoodsGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRGoodsGroup p) => p.ChildSetId == groupId);
		if (dataRows != null)
		{
			List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
			DRGoodsGroup[] array = dataRows;
			foreach (DRGoodsGroup dRGoodsGroup in array)
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(dRGoodsGroup.GoodsId);
				if (dataRow != null)
				{
					PropDataBase data = PropDataBase.CreateByType(dataRow.Type, dRGoodsGroup.GoodsId, dRGoodsGroup.GoodsMin);
					KnapsackItemViewModel item = new KnapsackItemViewModel(null, data);
					list.Add(item);
				}
			}
			gameActivityRewardItemData.SetRewardList(list);
			int num2 = ((curTab.ID == 1) ? gameActivityData.DailyReward : gameActivityData.WeekReward);
			gameActivityRewardItemData.SetState(UiConvert.BitwiseConvert.Bitwise(num2, index - 1));
		}
		RewardItemList.Add(gameActivityRewardItemData);
	}

	private async void ReceivedReward(GameActivityRewardItemData rewardItemData)
	{
		Loading loading = await Loading.Show();
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendGetRewardRequest(rewardItemData.RewardId);
		loading.Dispose();
		if (propGetViewModel != null)
		{
			int num = ((curTab.ID == 1) ? gameActivityData.DailyReward : gameActivityData.WeekReward);
			for (int i = 0; i < rewardItemList.Count; i++)
			{
				RewardItemList[i].SetState(UiConvert.BitwiseConvert.Bitwise(num, rewardItemList[i].IndexId - 1));
			}
			curTab.RedPoint = CheckRedPoint(curTab.ID);
			CheckViewRedPoint();
			propGetViewModel.MergeProp();
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel), delegate
			{
				rewardItemData.ReSetBtn();
			});
		}
	}

	private void ShowRewardView(GameActivityRewardItemData rewardItemData)
	{
		showRewardItemDataList.Clear();
		foreach (KnapsackItemViewModel rewardItemData2 in rewardItemData.RewardItemDataList)
		{
			showRewardItemDataList.Add(rewardItemData2);
		}
		openRewardDetailViewRequest.Raise(rewardItemData.Position);
		rewardItemData.ReSetBtn();
	}

	private async void OpenJumpWindow(GameActivityItemData gameActivityItemData)
	{
		if (isOpenWindow)
		{
			return;
		}
		isOpenWindow = true;
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(gameActivityItemData.JumpWindow, gameActivityItemData.JumpFlagValueList), this, "GameActivity");
		if (openViewArg != null)
		{
			openWindowRequest.Raise(openViewArg, delegate
			{
				RefreshTask();
			});
			object userData = openViewArg.UserData;
			if (userData is DrawCardViewModel drawCardViewModel)
			{
				await Task.Delay(100);
				drawCardViewModel.OnShow();
			}
		}
		isOpenWindow = false;
		gameActivityItemData.SetBtnOnclick(value: true);
	}

	private void RefreshTask()
	{
		RefreshTaskData();
		ShowTaskItemList.Sort(new GameActivitySort());
		refreshTaskRequest.Raise();
	}

	private void RefreshTaskData()
	{
		gameActivityData = Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().GetGameActivityData();
		foreach (GameActivityTaskData task in gameActivityData.TaskList)
		{
			foreach (GameActivityItemData allTaskItem in allTaskItemList)
			{
				if (task.TaskId == allTaskItem.TaskId)
				{
					allTaskItem.SetRealData(task.TaskDone, task.TaskState == 1);
				}
			}
		}
	}

	private async void SendCompleteTask(GameActivityItemData gameActivityItemData)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IGameActivityService>().SendCompleteTaskRequest(gameActivityItemData.TaskId))
		{
			bool num = gameActivityFill < 1f;
			gameOldActivityFill = gameActivityFill;
			gameActivityItemData.SetFinishState();
			CheckReward();
			curTab.RedPoint = CheckRedPoint(curTab.ID);
			if (num)
			{
				playEffectRequest.Raise();
			}
			CheckViewRedPoint();
			ShowTaskItemList.Sort(new GameActivitySort());
			refreshTaskRequest.Raise();
		}
		else
		{
			gameActivityItemData.SetBtnOnclick(value: true);
			Toast.ShowInfo("完成活跃度任务失败");
		}
	}

	private void CheckReward()
	{
		int num = ((curTab.ID == 1) ? gameActivityData.DailyPoint : gameActivityData.WeekPoint);
		int num2 = ((RewardItemList.Count <= 0) ? 1 : RewardItemList[0].ActiveLevel);
		GameActivityFill = (((float)num / (float)num2 > 1f) ? 1f : ((float)num / (float)num2));
		GameActivityPoint = num;
		foreach (GameActivityRewardItemData rewardItem in RewardItemList)
		{
			rewardItem.SetState(num);
		}
	}

	public void CheckRedPoint()
	{
		RedPoint = false;
		RefreshTaskData();
		foreach (TabItemNormalData tabItem in tabItemList)
		{
			tabItem.RedPoint = CheckRedPoint(tabItem.ID);
			if (tabItem.RedPoint)
			{
				RedPoint = true;
			}
		}
		action?.Invoke(RedPoint);
	}

	public void RefreshData()
	{
		InitGameActivityTask();
		CheckRedPoint();
		SwitchTab(tabItemList[0]);
		isOpenWindow = false;
	}

	private void CheckViewRedPoint()
	{
		RedPoint = false;
		foreach (TabItemNormalData tabItem in tabItemList)
		{
			if (tabItem.RedPoint)
			{
				RedPoint = true;
				action?.Invoke(RedPoint);
				return;
			}
		}
		action?.Invoke(RedPoint);
	}

	private void SetTime()
	{
		long num = DateTime.Now.Hour * 3600 + DateTime.Now.Minute * 60 + DateTime.Now.Second;
		long num2 = 86400L;
		long num3 = 14400L;
		if (curTab.ID == 1)
		{
			leftRefreshTime = ((num <= num3) ? (num3 - num) : (num2 - num + num3));
			timeFormat = "hh\\时mm\\分";
		}
		else
		{
			int dayOfWeek = (int)DateTime.Now.DayOfWeek;
			int num4 = ((dayOfWeek != 0) ? (7 - dayOfWeek) : 0);
			long num5 = num4 * 24 * 3600;
			leftRefreshTime = ((num <= num3) ? (num3 - num + num5) : (num2 - num + num3 + num5));
			timeFormat = "dd\\天hh\\时mm\\分";
		}
		LeftRefreshTimeText = Utility.DateTime.GetLeftDateTime(leftRefreshTime, timeFormat) + "后刷新";
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	private void RefreshTime()
	{
		leftRefreshTime--;
		if (leftRefreshTime >= 0)
		{
			LeftRefreshTimeText = Utility.DateTime.GetLeftDateTime(leftRefreshTime, timeFormat) + "后刷新";
		}
	}

	private bool CheckRedPoint(int id)
	{
		DRActiveReward[] dataRows = GameEntry.DataTable.GetDataRows((DRActiveReward p) => p.ActiveType == id);
		if (id == 1)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				if (!UiConvert.BitwiseConvert.Bitwise(gameActivityData.DailyReward, dataRows[num].Id - 1) && gameActivityData.DailyPoint >= dataRows[num].ActiveLev)
				{
					return true;
				}
			}
			if (gameActivityData.DailyPoint >= dataRows[dataRows.Length - 1].ActiveLev)
			{
				return false;
			}
		}
		else
		{
			for (int num2 = 0; num2 < dataRows.Length; num2++)
			{
				if (!UiConvert.BitwiseConvert.Bitwise(gameActivityData.WeekReward, dataRows[num2].Id - 1) && gameActivityData.WeekPoint >= dataRows[num2].ActiveLev)
				{
					return true;
				}
			}
			if (gameActivityData.WeekPoint >= dataRows[dataRows.Length - 1].ActiveLev)
			{
				return false;
			}
		}
		foreach (GameActivityItemData item in allTaskItemList.FindAll((GameActivityItemData p) => p.TaskType == id))
		{
			if (item.TaskState == 3)
			{
				return true;
			}
		}
		return false;
	}

	public override void Close()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
		base.Close();
	}
}
