using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class HomeComePhasedActivityViewModel : OptionBase
{
	private readonly List<DRHomeComeTask> taskRows = new List<DRHomeComeTask>();

	private readonly List<ActivityTabItemData2> tabList = new List<ActivityTabItemData2>();

	private readonly List<ActivityTaskItemData> allTaskList = new List<ActivityTaskItemData>();

	private readonly Dictionary<int, ActivityTaskItemData> taskItemMap = new Dictionary<int, ActivityTaskItemData>();

	private readonly InteractionRequest refreshRequest = new InteractionRequest();

	private List<ActivityTaskItemData> showTaskList = new List<ActivityTaskItemData>();

	private IHomeComeService service;

	private ISubscription<HomeComeMessage> subscription;

	private ActivityTabItemData2 curTab;

	private bool isClaimingTask;

	public List<ActivityTabItemData2> TabList => tabList;

	public List<ActivityTaskItemData> ShowTaskList => showTaskList;

	public IInteractionRequest RefreshRequest => refreshRequest;

	public HomeComePhasedActivityViewModel()
	{
	}

	public HomeComePhasedActivityViewModel(OptionBase parent)
	{
		base.parent = parent;
		service = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
		BuildFromTable();
		subscription = service?.GetMessager()?.Subscribe<HomeComeMessage>(OnHomeComeMessage);
		RefreshFromData();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is ActivityTabItemData2 activityTabItemData)
			{
				if (activityTabItemData.StateEnum == ActivityTabStateEnum.Lock)
				{
					Toast.ShowInfo(string.IsNullOrEmpty(activityTabItemData.LockDes) ? "未解锁" : activityTabItemData.LockDes);
				}
				else
				{
					SelectTab(activityTabItemData, raiseRefresh: true);
				}
			}
			else if (optionArg.Obj is ActivityTaskItemData taskItemData)
			{
				if ("Accept".Equals(optionArg.OptionName))
				{
					ClaimTask(taskItemData);
				}
				else if ("Jump".Equals(optionArg.OptionName))
				{
					JumpTask(taskItemData);
				}
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg obj2 = knapsackItemViewModel.OpenPopupWindow(this);
			parent?.ItemOnClick(obj2);
		}
		else if (obj is OpenViewArg obj3)
		{
			parent?.ItemOnClick(obj3);
		}
	}

	private void BuildFromTable()
	{
		taskRows.Clear();
		tabList.Clear();
		allTaskList.Clear();
		taskItemMap.Clear();
		taskRows.AddRange(HomeComeTableHelper.GetTaskRowsSorted());
		List<int> list = (from p in taskRows.Select(HomeComeTableHelper.GetTaskStage).Distinct()
			orderby p
			select p).ToList();
		for (int num = 0; num < list.Count; num++)
		{
			int num2 = list[num];
			tabList.Add(new ActivityTabItemData2(this, 0, num2, $"第{num2}天"));
		}
		for (int num3 = 0; num3 < taskRows.Count; num3++)
		{
			DRHomeComeTask dRHomeComeTask = taskRows[num3];
			int taskStage = HomeComeTableHelper.GetTaskStage(dRHomeComeTask);
			ActivityTaskItemData activityTaskItemData = new ActivityTaskItemData(this, dRHomeComeTask.Id, dRHomeComeTask.Id);
			activityTaskItemData.InitTaskInfo(dRHomeComeTask.TaskDesc, HomeComeTableHelper.GetTaskTargetValue(dRHomeComeTask));
			activityTaskItemData.SetActivityInfo(0, taskStage);
			List<KnapsackItemViewModel> list2 = HomeComeTableHelper.BuildKnapsackItemViewModels(dRHomeComeTask.Reward, this);
			if (list2 != null && list2.Count > 0)
			{
				activityTaskItemData.RewardPropList.AddRange(list2);
			}
			if (HomeComeTableHelper.TryGetTaskJump(dRHomeComeTask.Id, out var config) && !string.IsNullOrEmpty(config.WindowName))
			{
				activityTaskItemData.AddJumpWindow(config.WindowName, config.Args);
			}
			activityTaskItemData.IsPhasedActivityTask = false;
			allTaskList.Add(activityTaskItemData);
			taskItemMap[dRHomeComeTask.Id] = activityTaskItemData;
		}
		if (tabList.Count > 0)
		{
			SelectTab(tabList[0], raiseRefresh: false);
		}
	}

	private void OnHomeComeMessage(HomeComeMessage msg)
	{
		if (msg != null)
		{
			HomeComeMessageEnum type = msg.Type;
			if ((uint)type <= 2u || (uint)(type - 4) <= 2u)
			{
				RefreshFromData();
			}
		}
	}

	private void RefreshFromData()
	{
		HomeComeData homeComeData = service?.GetData();
		for (int i = 0; i < taskRows.Count; i++)
		{
			DRHomeComeTask dRHomeComeTask = taskRows[i];
			if (!taskItemMap.TryGetValue(dRHomeComeTask.Id, out var value))
			{
				continue;
			}
			int taskMaxFinishCount = HomeComeTableHelper.GetTaskTargetValue(dRHomeComeTask);
			int value2 = 0;
			bool flag = homeComeData?.IsTaskClaimed(dRHomeComeTask.Id) ?? false;
			bool canAccept = false;
			if (service != null && service.TryGetTaskProgress(dRHomeComeTask.Id, out var data) && data != null)
			{
				value2 = data.Progress;
				if (data.TargetValue > 0)
				{
					taskMaxFinishCount = data.TargetValue;
				}
				canAccept = data.State == 1 && !flag;
			}
			value.InitTaskInfo(dRHomeComeTask.TaskDesc, taskMaxFinishCount);
			value.RefreshFinishCount(value2, canAccept, flag);
			value.SetItemState(value.TaskState);
			value.ResetCmd();
		}
		RefreshTabState(homeComeData);
		if (curTab == null || curTab.StateEnum == ActivityTabStateEnum.Lock)
		{
			ActivityTabItemData2 activityTabItemData = tabList.Find((ActivityTabItemData2 p) => p.StateEnum != ActivityTabStateEnum.Lock);
			SelectTab(activityTabItemData ?? ((tabList.Count > 0) ? tabList[0] : null), raiseRefresh: false);
		}
		else
		{
			SelectTab(curTab, raiseRefresh: false);
		}
		refreshRequest.Raise();
	}

	private void RefreshTabState(HomeComeData data)
	{
		for (int i = 0; i < tabList.Count; i++)
		{
			ActivityTabItemData2 tab = tabList[i];
			List<ActivityTaskItemData> list = allTaskList.FindAll((ActivityTaskItemData p) => p.TaskRankId == tab.TagId);
			int num = list.Count((ActivityTaskItemData p) => p.TaskState == ActivityTaskStateEnum.Finished);
			bool flag = list.Count > 0 && num >= list.Count;
			bool flag2 = list.Exists((ActivityTaskItemData p) => p.TaskState == ActivityTaskStateEnum.Accept);
			tab.ActivityfinishDes = $"<color=#ffc962>{num}</color>/{list.Count}";
			tab.TimeLock = false;
			tab.AreaRedPoint = false;
			if (data == null || !data.IsInReturn || data.SignDays < tab.TagId)
			{
				tab.StateEnum = ActivityTabStateEnum.Lock;
				tab.LockDes = $"第{tab.TagId}天解锁";
				tab.PassAllLevel = false;
				continue;
			}
			tab.LockDes = string.Empty;
			tab.PassAllLevel = flag;
			if (flag)
			{
				tab.StateEnum = ActivityTabStateEnum.Finish;
			}
			else if (flag2)
			{
				tab.StateEnum = ActivityTabStateEnum.RedPoint;
			}
			else
			{
				tab.StateEnum = ActivityTabStateEnum.Normal;
			}
		}
	}

	private void SelectTab(ActivityTabItemData2 tab, bool raiseRefresh)
	{
		if (tab == null)
		{
			showTaskList = new List<ActivityTaskItemData>();
			if (raiseRefresh)
			{
				refreshRequest.Raise();
			}
			return;
		}
		curTab?.SetSelect(value: false);
		curTab = tab;
		curTab.SetSelect(value: true);
		showTaskList = allTaskList.FindAll((ActivityTaskItemData p) => p.TaskRankId == curTab.TagId);
		showTaskList.Sort(HomeComeTaskSortComparer.Instance);
		if (raiseRefresh)
		{
			refreshRequest.Raise();
		}
	}

	private async void ClaimTask(ActivityTaskItemData taskItemData)
	{
		if (service == null || taskItemData == null || isClaimingTask)
		{
			return;
		}
		isClaimingTask = true;
		taskItemData.StateOnclickCmd.Enabled = false;
		PbDropThing pbDropThing = await service.GetHomeComeTaskRewardRst(taskItemData.TaskId);
		taskItemData.ResetCmd();
		isClaimingTask = false;
		if (pbDropThing != null)
		{
			RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(pbDropThing);
			if (rewardGetData?.PropList != null && rewardGetData.PropList.Count > 0)
			{
				parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(parent, rewardGetData.PropList)));
			}
		}
		RefreshFromData();
	}

	private async void JumpTask(ActivityTaskItemData taskItemData)
	{
		if (taskItemData == null)
		{
			return;
		}
		taskItemData.StateOnclickCmd.Enabled = false;
		if (!HomeComeTableHelper.TryGetTaskJump(taskItemData.TaskId, out var config) || string.IsNullOrEmpty(config.WindowName))
		{
			Toast.ShowInfo("暂未配置跳转");
			taskItemData.ResetCmd();
			return;
		}
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(config.WindowName, config.Args), this, "HomeComePhasedActivity", taskItemData.ResetCmd);
		taskItemData.ResetCmd();
		if (openViewArg != null)
		{
			parent?.ItemOnClick(openViewArg);
		}
	}

	public override void Dispose()
	{
		subscription?.Dispose();
		subscription = null;
		service = null;
		base.Dispose();
	}
}
