#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityViewModelBase : OptionBase
{
	protected bool _red;

	protected int _activityTypeId;

	protected int _curType = 1;

	protected bool _finished;

	protected string _activityName = "";

	protected string _activityTabIcon = "";

	protected string _uiViewName = "";

	protected int _priority;

	protected OpActivityState _state;

	protected OpActivityLockState _lockState;

	protected int _additionalParameter1;

	protected DRActivityType _drActivityType;

	protected List<ActivityTaskData> _pbTaskDataList;

	private OpActViewModel dataParent;

	protected List<ActivityTaskData> activityProgressList = new List<ActivityTaskData>();

	protected long _leftActivityTime = -1L;

	protected string _activityTimeText;

	private Timer _timer;

	public List<ActivityTaskData> ActivityProgressList => activityProgressList;

	public bool Red
	{
		get
		{
			return _red;
		}
		protected set
		{
			Set(ref _red, value, "Red");
		}
	}

	public int ActivityTypeId
	{
		get
		{
			return _activityTypeId;
		}
		private set
		{
			Set(ref _activityTypeId, value, "ActivityTypeId");
		}
	}

	public int CurType
	{
		get
		{
			return _curType;
		}
		private set
		{
			_curType = ((value <= 0) ? 1 : value);
		}
	}

	public bool Finished
	{
		get
		{
			return _finished;
		}
		private set
		{
			_finished = value;
		}
	}

	public string ActivityName
	{
		get
		{
			return _activityName;
		}
		private set
		{
			Set(ref _activityName, value, "ActivityName");
		}
	}

	public string ActivityTimeText
	{
		get
		{
			return _activityTimeText;
		}
		protected set
		{
			Set(ref _activityTimeText, value, "ActivityTimeText");
		}
	}

	public long LeftActivityTime => _leftActivityTime;

	public string ActivityTabIcon
	{
		get
		{
			return _activityTabIcon;
		}
		private set
		{
			Set(ref _activityTabIcon, value, "ActivityTabIcon");
		}
	}

	public string UiViewName => _uiViewName;

	public int Priority => _priority;

	public OpActivityState State
	{
		get
		{
			return _state;
		}
		private set
		{
			Set(ref _state, value, "State");
		}
	}

	public OpActivityLockState LockState
	{
		get
		{
			return _lockState;
		}
		private set
		{
			Set(ref _lockState, value, "LockState");
		}
	}

	public int AdditionalParameter1
	{
		get
		{
			return _additionalParameter1;
		}
		private set
		{
			Set(ref _additionalParameter1, value, "AdditionalParameter1");
		}
	}

	public DRActivityType DrActivityType
	{
		get
		{
			return _drActivityType;
		}
		private set
		{
			_drActivityType = value;
			ActivityTypeId = value.Id;
			ActivityTabIcon = value.Item;
			_uiViewName = value.ViewPath;
			_priority = value.Priority;
			ActivityName = value.Name;
			AdditionalParameter1 = value.AdditionalParam1;
		}
	}

	public List<ActivityTaskData> PbTaskDataList => _pbTaskDataList;

	public virtual void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		dataParent = opActViewModel;
		DrActivityType = drData;
	}

	public void RefreshState()
	{
		if (DrActivityType != null)
		{
			State = OpActivityDefinition.GetState(DrActivityType.StartCondition, DrActivityType.StartConditionValue, DrActivityType.EndCondition, DrActivityType.EndConditionValue);
			LockState = OpActivityDefinition.GetActivityLockState(DrActivityType.UnlockCondition, DrActivityType.UnlockConditionValue);
		}
		else
		{
			State = OpActivityState.Off;
			LockState = OpActivityLockState.Locked;
		}
	}

	public void RefreshTabType()
	{
		if (DrActivityType != null)
		{
			CurType = (OpActivityDefinition.CheckCondition2(DrActivityType.ChangeType, DrActivityType.ChangeEx) ? DrActivityType.EndType : DrActivityType.StartType);
		}
	}

	public void RefreshFinishState()
	{
		if (DrActivityType != null)
		{
			Finished = OpActivityDefinition.CheckCondition2(DrActivityType.FinishType, DrActivityType.FinishEx);
		}
	}

	public void SetViewParent(OptionBase parent)
	{
		base.parent = parent;
	}

	public virtual void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		_pbTaskDataList = taskDataList;
	}

	public virtual ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		if (rateNotify == null || rateNotify.ActivityType != ActivityTypeId)
		{
			return null;
		}
		ActivityTaskData activityTaskData = _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == rateNotify.Id);
		if (activityTaskData == null)
		{
			return null;
		}
		activityTaskData.CompleteValue = rateNotify.DoneValue;
		activityTaskData.CompleteState = (rateNotify.IsCompleted ? 1 : 0);
		return activityTaskData;
	}

	public virtual bool OnTaskRewardGot(int id)
	{
		ActivityTaskData activityTaskData = _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == id);
		if (activityTaskData == null)
		{
			return false;
		}
		if (activityTaskData.CompleteState == 1 && activityTaskData.RewardState == 0)
		{
			activityTaskData.RewardState = 1;
			return true;
		}
		return false;
	}

	public virtual bool CheckAllTaskFinished()
	{
		if (!CheckProgressTaskFinished())
		{
			return false;
		}
		if (PbTaskDataList == null)
		{
			return false;
		}
		return !PbTaskDataList.Exists((ActivityTaskData p) => p.CompleteState == 0 || p.RewardState == 0);
	}

	public virtual async Task RequestDataBeforeShow()
	{
	}

	public ActivityTaskData GetTaskData(int id)
	{
		return _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == id);
	}

	public virtual bool UpdateRed(bool notifyParent = true)
	{
		if (notifyParent)
		{
			dataParent?.OnActivityRedChanged(this);
		}
		return Red;
	}

	public void UpdateActivityProgress(int taskId, int point, int rewardState, int groupId)
	{
		ActivityTaskData activityTaskData = activityProgressList.Find((ActivityTaskData p) => p.Id == taskId);
		if (activityTaskData == null)
		{
			ActivityTaskData activityTaskData2 = new ActivityTaskData();
			activityTaskData2.Id = taskId;
			activityTaskData2.CompleteValue = point;
			activityTaskData2.RewardState = rewardState;
			activityTaskData2.GroupId = groupId;
			activityProgressList.Add(activityTaskData2);
		}
		else
		{
			activityTaskData.Id = taskId;
			activityTaskData.CompleteValue = point;
			activityTaskData.RewardState = rewardState;
			activityTaskData.GroupId = groupId;
		}
	}

	public void UpdateActivityTaskProgress(int progressId)
	{
		ActivityTaskData activityTaskData = activityProgressList.Find((ActivityTaskData p) => p.Id == progressId);
		if (activityTaskData != null)
		{
			activityTaskData.RewardState = 1;
		}
		Context.GetApplicationContext().GetService<IMessenger>().Publish(new OpActivityMessage(this, OpActivityMessageEnum.TaskStateChanged));
	}

	public void AddProgressTask(List<ActivityTaskData> progressList)
	{
		activityProgressList = progressList;
	}

	protected bool CheckProgressTaskFinished()
	{
		if (activityProgressList.Count == 0)
		{
			return true;
		}
		return !activityProgressList.Exists((ActivityTaskData p) => p.RewardState == 0);
	}

	public virtual void RefreshActivityTime(bool getLeftTime = true)
	{
		if (getLeftTime)
		{
			_leftActivityTime = OpActivityDefinition.GetActivityTime(DrActivityType);
		}
		string activityTimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime);
		ActivityTimeText = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : ("剩余时间：" + activityTimeText));
	}

	public bool StartTimer()
	{
		ClearTimer();
		if (_leftActivityTime < 0)
		{
			return true;
		}
		try
		{
			_timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error("Activity:" + ActivityName + " ：开启计时器失败");
			return false;
		}
		return true;
	}

	private void OnComplete()
	{
		_leftActivityTime--;
		if (_leftActivityTime == 0L)
		{
			RefreshActivityTime();
		}
		if (_leftActivityTime < 0)
		{
			_leftActivityTime = 0L;
			RefreshActivityTime();
			ClearTimer();
			dataParent?.RefreshTargetState(ActivityTypeId);
		}
		else
		{
			RefreshActivityTime(getLeftTime: false);
		}
	}

	public void ClearTimer()
	{
		if (_timer != null)
		{
			_timer.Cancel();
			_timer = null;
		}
	}

	public virtual void OnKnapsackChange(PropChangeMessage message)
	{
	}

	public virtual async UniTask SetLastPlayCopyData(CopyData lastPlay)
	{
	}

	public virtual void OnViewClose()
	{
	}

	public override void Dispose()
	{
		ClearTimer();
		base.Dispose();
	}
}
