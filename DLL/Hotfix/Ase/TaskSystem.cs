#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskSystem : BaseSystem
{
	public enum TaskChangeNotifyType
	{
		Received,
		Updated,
		Finished,
		Delete,
		UpdatePosition,
		LevelNodeCheck,
		TrackSet,
		IndexStateUpdate,
		CopyOpenUpdate,
		ShowChangeTrackUI,
		HideChangeTrackUI,
		ChangeTaskUIPosition,
		Disconnect
	}

	public enum TaskOptionType
	{
		Updated,
		Finished,
		Trigger
	}

	public class TaskCountDownData
	{
		public float endTime;

		public TaskDataViewModel taskDataViewModel;

		public bool CheckTime(float deltaTime)
		{
			endTime = Mathf.Max(0f, endTime - deltaTime);
			return endTime <= 0f;
		}

		public static TaskCountDownData CreateTaskCountDownData(TaskDataViewModel taskDataViewModel, float endTime)
		{
			return new TaskCountDownData
			{
				endTime = endTime,
				taskDataViewModel = taskDataViewModel
			};
		}
	}

	private ISubscription<TaskChangeNotifyMessager> subscription;

	private ISubscription<TaskChangeNotifyMessager> subscription_MonsterMessager;

	private ISubscription<TaskChangeNotifyMessager> subscription_BossMessager;

	private List<TaskCountDownData> taskCountDownDatas = new List<TaskCountDownData>();

	private ShowEventService showEventService;

	private ITaskServices _taskServicesCache;

	private SectionReceiveWindow sectionReceiveWindow;

	private SectionFinishWindow sectionFinishWindow;

	private KillRewardPropWindow _killRewardPropWindow;

	private KillRewardViewModel _killRewardViewModel;

	protected override bool IsLogicSystem => false;

	private ITaskServices TaskServices
	{
		get
		{
			if (_taskServicesCache == null)
			{
				_taskServicesCache = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
			}
			return _taskServicesCache;
		}
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		subscription = TaskServices.GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		showEventService = new ShowEventService();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		GetSystem<BattleSystem>().InitAddTaskTarget();
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		return true;
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		for (int num = taskCountDownDatas.Count - 1; num >= 0; num--)
		{
			if (!taskCountDownDatas[num].taskDataViewModel.IsFinished() && taskCountDownDatas[num].CheckTime(deltaTime))
			{
				FailedTask(taskCountDownDatas[num].taskDataViewModel);
				taskCountDownDatas[num].taskDataViewModel.SetCountDownData(null);
				GetSystem<BattleSystem>()?.ShowTaskTime(isShow: false);
				taskCountDownDatas.RemoveAt(num);
			}
			else if (taskCountDownDatas[num].taskDataViewModel.IsFinished())
			{
				taskCountDownDatas[num].taskDataViewModel.SetCountDownData(null);
				GetSystem<BattleSystem>()?.ShowTaskTime(isShow: false);
				taskCountDownDatas.RemoveAt(num);
			}
			else
			{
				GetSystem<BattleSystem>()?.SetTaskTime(taskCountDownDatas[num].taskDataViewModel.GetCountTime());
			}
		}
		showEventService.Update();
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager notifyMessager)
	{
		if (notifyMessager.changeNotifyType == TaskChangeNotifyType.Received)
		{
			showEventService.AddTaskShowEvent(notifyMessager.taskDataViewModel.TaskId, async delegate
			{
				await ShowRecevieUIOrStory(notifyMessager.taskDataViewModel);
			});
			GetSystem<SceneSystem>().GetLevelMapData().RefreshArea();
		}
		_ = notifyMessager.changeNotifyType;
		_ = 1;
		if (notifyMessager.changeNotifyType != TaskChangeNotifyType.Finished)
		{
			return;
		}
		if (notifyMessager.taskDataViewModel.IsOpenTask)
		{
			showEventService.AddTaskShowEvent(notifyMessager.taskDataViewModel.TaskId, async delegate
			{
				await ShowFinishUIOrStory(notifyMessager.taskDataViewModel);
			});
		}
		if ((notifyMessager.taskDataViewModel.NextTaskId == null || notifyMessager.taskDataViewModel.NextTaskId.Count == 0) && !string.IsNullOrEmpty(notifyMessager.taskDataViewModel.MapdataAssetPath))
		{
			GetSystem<SceneSystem>().GetLevelMapData().RefreshArea();
		}
	}

	private async UniTask ShowRecevieUIOrStory(TaskDataViewModel taskDataViewModel)
	{
		if (taskDataViewModel.Questaccept)
		{
			TaskReceiveWindow taskReceiveWindow = await GameEntry.UI.LoadWindow<TaskReceiveWindow>(AssetUtility.GetUIFormAsset("Level/TaskReceiveWindow"), "POPUP", taskDataViewModel);
			await taskReceiveWindow.DoShow();
			await UniTask.Delay(3000);
			await taskReceiveWindow.DoHide();
			taskReceiveWindow.Dismiss(ignoreAnimation: true);
		}
	}

	private async UniTask ShowFinishUIOrStory(TaskDataViewModel taskDataViewModel)
	{
		if (!taskDataViewModel.Chapterstart && !taskDataViewModel.SpaceChapter && taskDataViewModel.Timelineid > 0)
		{
			await Singleton<Story>.Instance.PlayStory(world.Id, taskDataViewModel.Timelineid);
		}
		if (world == null)
		{
			return;
		}
		if (taskDataViewModel.Questfinish)
		{
			TaskFinishWindow taskFinishWindow = await GameEntry.UI.LoadWindow<TaskFinishWindow>(AssetUtility.GetUIFormAsset("Level/TaskFinishWindow"), "POPUP", taskDataViewModel);
			await taskFinishWindow.DoShow();
			world.GamePause(transition: true);
			await UniTask.Delay(3000);
			await taskFinishWindow.DoHide();
			taskFinishWindow.Dismiss(ignoreAnimation: true);
			world.GameResume();
		}
		else if (taskDataViewModel.Chapterend)
		{
			sectionFinishWindow = await GameEntry.UI.LoadWindow<SectionFinishWindow>(AssetUtility.GetUIFormAsset("Level/SectionFinishWindow"), "POPUP", taskDataViewModel);
			await sectionFinishWindow.DoShow();
			world.GamePause();
			await new WaitUntil(() => sectionFinishWindow == null || sectionFinishWindow.IsClicked);
			if (!(sectionFinishWindow == null))
			{
				await sectionFinishWindow.DoHide();
				sectionFinishWindow.Dismiss(ignoreAnimation: true);
				sectionFinishWindow = null;
				world.GameResume();
				world.GameSettlement(GameSettlementType.PlayerQuit);
			}
		}
	}

	public async UniTask ChapterStartUI()
	{
		SceneSystem system = GetSystem<SceneSystem>();
		if (system == null || world == null)
		{
			return;
		}
		TaskDataViewModel taskDataViewModel = GetCurrentSectionTask();
		if (taskDataViewModel == null || taskDataViewModel.IsFinished() || !taskDataViewModel.Chapterstart || taskDataViewModel.MapdataLevel != system.GetLevelId())
		{
			return;
		}
		if (taskDataViewModel.Timelineid > 0)
		{
			await Singleton<Story>.Instance.PlayStory(world.Id, taskDataViewModel.Timelineid);
		}
		sectionReceiveWindow = await GameEntry.UI.LoadWindow<SectionReceiveWindow>(AssetUtility.GetUIFormAsset("Level/SectionReceiveWindow"), "POPUP", taskDataViewModel);
		if (!(sectionReceiveWindow == null))
		{
			await sectionReceiveWindow.DoShow();
			await UniTask.WaitUntil(() => sectionReceiveWindow == null || sectionReceiveWindow.IsClicked);
			sectionReceiveWindow = null;
			taskDataViewModel.Close();
		}
	}

	public void UpdateTaskProcess(int taskId, int process)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().UpdateTaskProcess(taskId, process, finshParentTask: false);
	}

	public void UpdateTaskProcess(int tasktargetType, int taskTargetId, int process)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().UpdateTaskProcess(GetSystem<SceneSystem>().GetLevelId(), tasktargetType, taskTargetId, process);
	}

	public void UpdateTaskState(int taskId, int stateIndex, string stateValue)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().UpdateTaskState(taskId, stateIndex, stateValue);
	}

	public async void FailedTask(TaskDataViewModel taskDataViewModel)
	{
		await GetSystem<BattleSystem>().ShowLevelFailWindow();
		await GetSystem<SceneSystem>().RevertLevel(rebornHero: true, teleport: true);
	}

	public async void FailedTask(int taskId)
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId) != null)
		{
			await GetSystem<BattleSystem>().ShowLevelFailWindow();
			await GetSystem<SceneSystem>().RevertLevel(rebornHero: true, teleport: true);
		}
	}

	public void StartTimeCountDown(int taskId, int time = 5)
	{
		TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId);
		if (task != null)
		{
			if (task.GetCountTime() > 0)
			{
				Log.Error($"任务{taskId}-已经开始了倒计时");
				return;
			}
			TaskCountDownData taskCountDownData = TaskCountDownData.CreateTaskCountDownData(task, time);
			task.SetCountDownData(taskCountDownData);
			taskCountDownDatas.Add(taskCountDownData);
			GetSystem<BattleSystem>()?.SetTaskTime(time);
			GetSystem<BattleSystem>()?.ShowTaskTime(isShow: true);
		}
	}

	public void StopTimeCountDown(int taskId)
	{
		TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId);
		if (task == null)
		{
			return;
		}
		task.StopCountDownData();
		GetSystem<BattleSystem>()?.ShowTaskTime(isShow: false);
		for (int num = taskCountDownDatas.Count - 1; num >= 0; num--)
		{
			if (taskCountDownDatas[num].taskDataViewModel == task)
			{
				taskCountDownDatas.RemoveAt(num);
				break;
			}
		}
	}

	public async UniTask<bool> FinishTask(int taskId)
	{
		return await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().FinishTask(taskId);
	}

	public async void ClientTriggerTask(int taskId)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().ClientTriggerTask(taskId))
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(GetSystem<SceneSystem>().GetLevelId());
		}
	}

	public TaskDataViewModel GetCurrentMainTask()
	{
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
	}

	public TaskDataViewModel GetCurrentSectionTask()
	{
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentSectionTask();
	}

	public int GetCurrentCopyOpen()
	{
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentCopyOpen();
	}

	public List<TaskDataViewModel> GetAllTask()
	{
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
	}

	public List<TaskDataViewModel> GetAllTrackTask()
	{
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		return service.FilterTrackingTask(service.GetDisplayLevelTask(GetSystem<SceneSystem>().GetLevelId()));
	}

	public bool CheckMapDataNodeActived(OpenCondition activeOpenCondition)
	{
		return TaskServices.CheckMapDataNodeActived(activeOpenCondition);
	}

	public bool CheckMapDataNodeActived(List<OpenCondition> activeTaskCondition)
	{
		return TaskServices.CheckMapDataNodeActived(activeTaskCondition);
	}

	public void UpdateTaskPosition(int taskId, int index, Vector2 position)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId)?.UpdateTaskPosition(index, position);
	}

	public void UpdateTaskPosition(int taskId, int index, bool active)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId)?.UpdateTaskPosition(index, active);
	}

	public void OnRevertLevel()
	{
		for (int num = taskCountDownDatas.Count - 1; num >= 0; num--)
		{
			taskCountDownDatas[num].taskDataViewModel.SetCountDownData(null);
			GetSystem<BattleSystem>()?.ShowTaskTime(isShow: false);
			taskCountDownDatas.RemoveAt(num);
		}
	}

	public void ShowKillRewardWindow(KillRewardType type, List<int> rewardId, List<int> rewardType, List<int> rewardCount, List<long> uids, string monsterIcon)
	{
		showEventService.AddKillRewardShowEvent(async delegate
		{
			await OpenKillRewardWindow(type, rewardId, rewardType, rewardCount, uids, monsterIcon);
		});
	}

	private async UniTask OpenKillRewardWindow(KillRewardType type, List<int> rewardId, List<int> rewardType, List<int> rewardCount, List<long> uids, string monsterIcon)
	{
		_killRewardViewModel = new KillRewardViewModel(type, rewardId, rewardType, rewardCount, uids, monsterIcon);
		_killRewardPropWindow = await GameEntry.UI.LoadWindow<KillRewardPropWindow>(AssetUtility.GetUIFormAsset("Level/KillRewardPropWindow"), "Tip", _killRewardViewModel);
		if (_killRewardPropWindow != null)
		{
			_killRewardPropWindow.Show();
		}
		await UniTask.WaitUntil(() => _killRewardViewModel == null || _killRewardViewModel.CloseKillReward);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (TaskCountDownData taskCountDownData in taskCountDownDatas)
		{
			taskCountDownData.taskDataViewModel.SetCountDownData(null);
		}
		if (sectionReceiveWindow != null)
		{
			GetCurrentSectionTask().Close();
			sectionReceiveWindow = null;
		}
		taskCountDownDatas = new List<TaskCountDownData>();
		showEventService = null;
		_taskServicesCache = null;
		if (subscription != null)
		{
			subscription.Dispose();
			subscription = null;
		}
		if (_killRewardPropWindow != null)
		{
			_killRewardViewModel.Close();
			_killRewardPropWindow = null;
			_killRewardViewModel = null;
		}
		if (sectionFinishWindow != null)
		{
			sectionFinishWindow.Dismiss(ignoreAnimation: true);
			sectionFinishWindow = null;
		}
	}
}
