using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PassportTaskViewModel : OptionBase
{
	private List<TabItemNormalData> taskTagList;

	private TabItemNormalData curTaskTab;

	private List<PassportTaskItemData> passportTaskItemDataList;

	private List<PassportTaskItemData> showTaskList;

	private InteractionRequest refreshTaskRequest;

	private bool redPoint;

	private SimpleCommand getAllCmd;

	public List<TabItemNormalData> TaskTagList => taskTagList;

	public InteractionRequest RefreshTaskRequest => refreshTaskRequest;

	public List<PassportTaskItemData> ShowTaskList
	{
		get
		{
			return showTaskList;
		}
		set
		{
			Set(ref showTaskList, value, "ShowTaskList");
		}
	}

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

	public SimpleCommand GetAllCmd => getAllCmd;

	public PassportTaskViewModel(OptionBase parent)
	{
		base.parent = parent;
		ShowTaskList = new List<PassportTaskItemData>();
		refreshTaskRequest = new InteractionRequest();
		getAllCmd = new SimpleCommand(GetAll);
		InitTab();
		InitTask();
		SwitchTaskType(taskTagList[0]);
		CheckRedPoint();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			if (!tabItemNormalData.IsSelected)
			{
				SwitchTaskType(tabItemNormalData);
				refreshTaskRequest.Raise();
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is PassportTaskItemData passportTaskItemData && optionArg.OptionName.Equals("Received"))
			{
				SendTask(passportTaskItemData);
			}
		}
		else if (obj is PassportTaskItemData obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	private async void SendTask(PassportTaskItemData passportTaskItemData)
	{
		parent?.ItemOnClick(new OptionArg(this, "RecordInfo"));
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendTaskCompleteRequest(passportTaskItemData.TaskId, passportTaskItemData.Type);
		loading.Dispose();
		if (num)
		{
			passportTaskItemData.PlayCompleteEffect();
			await Task.Delay(700);
			parent?.ItemOnClick(new OptionArg(this, "RefreshLevel"));
			CheckRedPoint();
			ShowTaskList.Sort(new PassportTaskSort());
			refreshTaskRequest.Raise();
		}
	}

	private void SwitchTaskType(TabItemNormalData tab)
	{
		curTaskTab?.SetSelected(value: false);
		curTaskTab = tab;
		curTaskTab.SetSelected(value: true);
		ShowTaskList.Clear();
		foreach (PassportTaskItemData passportTaskItemData in passportTaskItemDataList)
		{
			if (passportTaskItemData.Type == curTaskTab.ID)
			{
				ShowTaskList.Add(passportTaskItemData);
			}
		}
		ShowTaskList.Sort(new PassportTaskSort());
	}

	private void InitTab()
	{
		taskTagList = new List<TabItemNormalData>();
		for (int i = 0; i < 3; i++)
		{
			int id = i + 1;
			TabItemNormalData item = new TabItemNormalData(this, "empty", id);
			taskTagList.Add(item);
		}
	}

	private void InitTask()
	{
		passportTaskItemDataList = new List<PassportTaskItemData>();
		DRPassportTask[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRPassportTask>();
		Dictionary<int, int> taskIdValueDic = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetTaskIdValueDic();
		List<int> completeTask = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetCompleteTask();
		DRPassportTask[] array = allDataRow;
		foreach (DRPassportTask drPassportTask in array)
		{
			taskIdValueDic.TryGetValue(drPassportTask.Id, out var value);
			bool isComplete = completeTask.FindAll((int p) => p.Equals(drPassportTask.Id)).Count > 0;
			PassportTaskItemData item = new PassportTaskItemData(this, drPassportTask, value, isComplete);
			passportTaskItemDataList.Add(item);
		}
	}

	private async void GetAll()
	{
		parent?.ItemOnClick(new OptionArg(this, "RecordInfo"));
		getAllCmd.Enabled = false;
		if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendTaskCompleteRequest(-1, curTaskTab.ID))
		{
			foreach (PassportTaskItemData passportTaskItemData in passportTaskItemDataList)
			{
				if (passportTaskItemData.PassportTaskState == PassportTaskState.Reward)
				{
					passportTaskItemData.PlayCompleteEffect();
				}
			}
			await Task.Delay(700);
			parent?.ItemOnClick(new OptionArg(this, "RefreshLevel"));
			CheckRedPoint();
			ShowTaskList.Sort(new PassportTaskSort());
			refreshTaskRequest.Raise();
		}
		getAllCmd.Enabled = true;
	}

	public void RefreshTask()
	{
		Dictionary<int, int> taskIdValueDic = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetTaskIdValueDic();
		List<int> completeTask = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetCompleteTask();
		if (passportTaskItemDataList == null)
		{
			return;
		}
		foreach (PassportTaskItemData taskItemData in passportTaskItemDataList)
		{
			taskIdValueDic.TryGetValue(taskItemData.TaskId, out var value);
			bool finish = completeTask != null && completeTask.FindAll((int p) => p.Equals(taskItemData.TaskId)).Count > 0;
			taskItemData.SetFinishCount(value, finish);
		}
		CheckRedPoint();
	}

	private void CheckRedPoint()
	{
		PassportInfo passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		if (passportInfo != null && (passportInfo.WeeklyPoint == passportInfo.WeeklyPointMax || passportInfo.Level == passportInfo.LevelMax))
		{
			taskTagList[0].RedPoint = false;
			taskTagList[1].RedPoint = false;
			taskTagList[2].RedPoint = false;
			RedPoint = false;
			parent?.ItemOnClick("RedPoint");
			return;
		}
		List<PassportTaskItemData> list = passportTaskItemDataList.FindAll((PassportTaskItemData p) => p.Type == 1);
		List<PassportTaskItemData> list2 = passportTaskItemDataList.FindAll((PassportTaskItemData p) => p.Type == 2);
		List<PassportTaskItemData> list3 = passportTaskItemDataList.FindAll((PassportTaskItemData p) => p.Type == 3);
		taskTagList[0].RedPoint = false;
		foreach (PassportTaskItemData item in list)
		{
			if (item.PassportTaskState == PassportTaskState.Reward)
			{
				taskTagList[0].RedPoint = true;
				break;
			}
		}
		taskTagList[1].RedPoint = false;
		foreach (PassportTaskItemData item2 in list2)
		{
			if (item2.PassportTaskState == PassportTaskState.Reward)
			{
				taskTagList[1].RedPoint = true;
				break;
			}
		}
		taskTagList[2].RedPoint = false;
		foreach (PassportTaskItemData item3 in list3)
		{
			if (item3.PassportTaskState == PassportTaskState.Reward)
			{
				taskTagList[2].RedPoint = true;
				break;
			}
		}
		RedPoint = taskTagList[0].RedPoint || taskTagList[1].RedPoint || taskTagList[2].RedPoint;
		parent?.ItemOnClick("RedPoint");
	}
}
