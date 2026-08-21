using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MapPointInfoViewModel : OptionBase
{
	private InteractivePointData _pointItemData;

	private InteractivePoint.PointInfo _pointInfo;

	private string _mainTitleText;

	private string _mainTitleIcon;

	private string _pointIcon;

	private string _childTitleText;

	private string _detailText;

	private bool _showFuncBtn;

	private string _funcBtnText;

	private List<TaskTargetData> _targetList = new List<TaskTargetData>();

	private List<KnapsackItemViewModel> _rewardDataList = new List<KnapsackItemViewModel>();

	private SimpleCommand<KnapsackItemViewModel> openPopupCmd;

	public string MainTitleText
	{
		get
		{
			return _mainTitleText;
		}
		set
		{
			Set(ref _mainTitleText, value, "MainTitleText");
		}
	}

	public string MainTitleIcon
	{
		get
		{
			return _mainTitleIcon;
		}
		set
		{
			_mainTitleIcon = value;
		}
	}

	public string PointIcon
	{
		get
		{
			return _pointIcon;
		}
		set
		{
			_pointIcon = value;
		}
	}

	public string ChildTitleText
	{
		get
		{
			return _childTitleText;
		}
		set
		{
			Set(ref _childTitleText, value, "ChildTitleText");
		}
	}

	public string DetailText
	{
		get
		{
			return _detailText;
		}
		set
		{
			Set(ref _detailText, value, "DetailText");
		}
	}

	public bool ShowFuncBtn
	{
		get
		{
			return _showFuncBtn;
		}
		set
		{
			Set(ref _showFuncBtn, value, "ShowFuncBtn");
		}
	}

	public string FuncBtnText
	{
		get
		{
			return _funcBtnText;
		}
		set
		{
			Set(ref _funcBtnText, value, "FuncBtnText");
		}
	}

	public InteractivePointData PointItemData
	{
		get
		{
			return _pointItemData;
		}
		private set
		{
			_pointItemData = value;
		}
	}

	public InteractivePoint.PointInfo PointInfo
	{
		get
		{
			return _pointInfo;
		}
		private set
		{
			_pointInfo = value;
		}
	}

	public List<TaskTargetData> TargetList
	{
		get
		{
			return _targetList;
		}
		set
		{
			_targetList = value;
		}
	}

	public List<KnapsackItemViewModel> RewardDataList
	{
		get
		{
			return _rewardDataList;
		}
		set
		{
			_rewardDataList = value;
		}
	}

	public MapPointInfoViewModel()
	{
	}

	public MapPointInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
		openPopupCmd = new SimpleCommand<KnapsackItemViewModel>(OpenPopupWindow);
	}

	public void Refresh(InteractivePointData pointItemData)
	{
		PointItemData = pointItemData;
		PointInfo = pointItemData.PointInfo;
		InteractivePoint.PointType pointType = PointInfo.PointType;
		if (pointType.Equals(InteractivePoint.PointType.NormalTp))
		{
			DRTransferPoint dataRow = GameEntry.DataTable.GetDataRow<DRTransferPoint>(PointInfo.Id);
			MainTitleText = dataRow.TransferPointName;
			MainTitleIcon = "MiniMap/map_mark_2_1.png";
			DetailText = dataRow.Desc;
			PointIcon = dataRow.Icon;
			ShowFuncBtn = true;
			FuncBtnText = "传送";
		}
		else if (pointType.Equals(InteractivePoint.PointType.SpecialTp))
		{
			DRTransferPoint dataRow2 = GameEntry.DataTable.GetDataRow<DRTransferPoint>(PointInfo.Id);
			MainTitleText = dataRow2.TransferPointName;
			MainTitleIcon = "MiniMap/map_mark_3_1.png";
			DetailText = dataRow2.Desc;
			PointIcon = dataRow2.Icon;
			ShowFuncBtn = false;
		}
		else if (pointType.Equals(InteractivePoint.PointType.MainTask) || pointType.Equals(InteractivePoint.PointType.SideTask) || pointType.Equals(InteractivePoint.PointType.DailyTask) || pointType.Equals(InteractivePoint.PointType.MonsterTask))
		{
			TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(PointInfo.Id);
			MainTitleText = task.TaskTitle;
			MainTitleIcon = $"MiniMap/task_mark_{task.TaskType}.png";
			ChildTitleText = task.TaskName;
			DetailText = task.TaskDesc;
			FuncBtnText = (task.TrackState ? "取消追踪" : "追踪");
			ShowFuncBtn = true;
			GetTaskTargetDataList(task);
			GetRewardDataList(task);
		}
		else
		{
			Hide();
		}
	}

	private void GetTaskTargetDataList(TaskDataViewModel taskData)
	{
		TargetList.Clear();
		if (taskData.ParentTaskId <= 0)
		{
			TargetList.Add(new TaskTargetData(taskData.TargetDesc, taskData.Progress, taskData.TargetValue));
		}
		else if (taskData.ParallelTaskType == 1)
		{
			TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskData.ParentTaskId);
			TargetList.Add(new TaskTargetData(task.TargetDesc, task.Progress, task.TargetValue));
		}
		else if (taskData.ParallelTaskType == 2)
		{
			TargetList.Add(new TaskTargetData(taskData.TargetDesc, taskData.Progress, taskData.TargetValue));
		}
	}

	private void GetRewardDataList(TaskDataViewModel taskData)
	{
		RewardDataList.Clear();
		RewardDataList = taskData.GetTaskRewardVM(this);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel parameter)
		{
			openPopupCmd.Execute(parameter);
		}
	}

	private void OpenPopupWindow(KnapsackItemViewModel knapsack)
	{
		openPopupCmd.Enabled = false;
		OpenViewArg openViewArg = ((!(parent is MapViewModel { MapMode: not MapMode.Outer })) ? knapsack.OpenPopupWindow(parent, delegate
		{
			openPopupCmd.Enabled = true;
		}) : knapsack.OpenPopupWindow(parent, delegate
		{
			openPopupCmd.Enabled = true;
		}, showOutsideMask: true, showOwnCount: true, allowSkipWindow: false));
		if (openViewArg != null)
		{
			parent?.ItemOnClick(openViewArg);
		}
		else
		{
			openPopupCmd.Enabled = true;
		}
	}

	public virtual void OnFuncBtnClick()
	{
		if (FuncBtnText.Equals("追踪中"))
		{
			return;
		}
		if (FuncBtnText.Equals("追踪"))
		{
			Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().SetTaskTrackState(PointInfo.Id, trackState: true);
			parent?.ItemOnClick(new OptionArg(this, "TaskTrackChanged"));
			Hide();
		}
		else if (FuncBtnText.Equals("取消追踪"))
		{
			Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().SetTaskTrackState(PointInfo.Id, trackState: false);
			parent?.ItemOnClick(new OptionArg(this, "TaskTrackChanged"));
			Hide();
		}
		else if (FuncBtnText.Equals("传送"))
		{
			if (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() == GameProcessType.Story)
			{
				LoadingToOtherLevelViewModel loadingToOtherLevelViewModel = new LoadingToOtherLevelViewModel();
				loadingToOtherLevelViewModel.SetBonfireKey(PointInfo.Id.ToString());
				parent.ItemOnClick(loadingToOtherLevelViewModel);
			}
			else
			{
				parent.ItemOnClick(GetReadyData(this));
			}
			Hide();
		}
	}

	private BattleReadyData GetReadyData(MapPointInfoViewModel viewModel)
	{
		InteractivePoint.PointInfo pointInfo = viewModel.PointInfo;
		int copyDropType = 0;
		return new BattleReadyData(BattleReadyTarget.Level, pointInfo.Id, copyDropType);
	}

	public void Hide()
	{
		visibleRequest.Raise(context: false);
		parent.ItemOnClick("ClosePointInfoView");
	}
}
