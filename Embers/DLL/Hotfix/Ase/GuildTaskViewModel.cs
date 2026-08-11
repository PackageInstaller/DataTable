using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildTaskViewModel : OptionBase
{
	private int curPoint;

	private int totalPoint;

	private List<GuildTaskData> taskDatas;

	private List<GuildTaskRewardItemData> rewardItemDatas = new List<GuildTaskRewardItemData>();

	private SimpleCommand<GuildTaskItemData> finishTaskCmd;

	private SimpleCommand<GuildTaskRewardItemData> getRewardCmd;

	private InteractionRequest refreshTaskListRst = new InteractionRequest();

	private InteractionRequest<GuildTaskRewardItem> openRewardPanelRst = new InteractionRequest<GuildTaskRewardItem>();

	private InteractionRequest playProgressChangeEffect = new InteractionRequest();

	private ISubscription<GuildMessage> onGuildMessage;

	public InteractionRequest PlayProgressChangeEffect => playProgressChangeEffect;

	public int CurPoint
	{
		get
		{
			return curPoint;
		}
		set
		{
			Set(ref curPoint, value, "CurPoint");
		}
	}

	public int TotalPoint
	{
		get
		{
			return totalPoint;
		}
		set
		{
			Set(ref totalPoint, value, "TotalPoint");
		}
	}

	public List<GuildTaskData> TaskDatas => taskDatas;

	public InteractionRequest RefreshTaskListRst => refreshTaskListRst;

	public InteractionRequest<GuildTaskRewardItem> OpenRewardPanelRst => openRewardPanelRst;

	public GuildTaskViewModel()
	{
	}

	public GuildTaskViewModel(OptionBase parent)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		CurPoint = myGuildData.MyDailyActivePoint;
		TotalPoint = myGuildData.GetDailyMaxActivePoint();
		finishTaskCmd = new SimpleCommand<GuildTaskItemData>(TryFinishTask);
		getRewardCmd = new SimpleCommand<GuildTaskRewardItemData>(TryGetReward);
		RefreshTaskDatas();
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.TaskProcessChange || message.Type == GuildMessageEnum.GuildDataRefresh)
		{
			RefreshTaskDatas();
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			int num = CurPoint;
			CurPoint = myGuildData.MyDailyActivePoint;
			if (num != CurPoint)
			{
				playProgressChangeEffect.Raise();
			}
			TotalPoint = myGuildData.GetDailyMaxActivePoint();
		}
	}

	private void RefreshTaskDatas()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		int num = CurPoint;
		CurPoint = myGuildData.MyDailyActivePoint;
		if (num != CurPoint)
		{
			playProgressChangeEffect.Raise();
		}
		taskDatas = myGuildData.DailyTasks.Values.ToList();
		taskDatas.Sort((GuildTaskData a, GuildTaskData b) => a.State.CompareTo(b.State) * 10 + a.TaskId.CompareTo(b.TaskId));
		refreshTaskListRst.Raise();
	}

	public void AddRewardItemData(GuildTaskRewardItemData rewardItemData)
	{
		if (rewardItemData != null)
		{
			rewardItemDatas.Add(rewardItemData);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (!(optionArg.Obj is GuildTaskItemData guildTaskItemData))
			{
				return;
			}
			if (optionArg.OptionName == "FinishTask")
			{
				finishTaskCmd.Execute(guildTaskItemData);
			}
			else if (optionArg.OptionName == "OpenPropInfo")
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(guildTaskItemData.RequireId);
				if (dataRow != null)
				{
					PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, showOutsideMask: true, showOwnCount: false);
					propWindowViewModel.RefreshData(new PropData(dataRow));
					parent?.ItemOnClick(new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel));
				}
			}
		}
		else if (obj is GuildTaskRewardItem guildTaskRewardItem)
		{
			if (guildTaskRewardItem.ViewModel.State == 2)
			{
				getRewardCmd.Execute(guildTaskRewardItem.ViewModel);
			}
			else
			{
				openRewardPanelRst.Raise(guildTaskRewardItem);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg obj2 = knapsackItemViewModel.OpenPopupWindow(parent);
			parent?.ItemOnClick(obj2);
		}
	}

	private async void TryFinishTask(GuildTaskItemData taskItemData)
	{
		finishTaskCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestCompleteGuildTask(taskItemData.TaskId);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("完成任务成功");
			RefreshTaskDatas();
		}
		finishTaskCmd.Enabled = true;
	}

	private async void TryGetReward(GuildTaskRewardItemData rewardItemData)
	{
		getRewardCmd.Enabled = false;
		List<int> rewardLevelsCanGet = new List<int>();
		if (rewardItemDatas != null)
		{
			foreach (GuildTaskRewardItemData rewardItemData2 in rewardItemDatas)
			{
				if (rewardItemData2 != null && rewardItemData2.State == 2)
				{
					rewardLevelsCanGet.Add(rewardItemData2.DrConfigData.Id);
				}
			}
		}
		Loading loading = await Loading.Show();
		RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGetAllActivityReward(rewardLevelsCanGet);
		loading?.Dispose();
		if (rewardGetData != null)
		{
			PropGetViewModel userData = new PropGetViewModel(parent, rewardGetData.PropList);
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), userData));
			if (rewardItemDatas != null)
			{
				foreach (GuildTaskRewardItemData rewardItemData3 in rewardItemDatas)
				{
					if (rewardItemData3 != null && rewardItemData3.State == 2)
					{
						rewardItemData3.RefreshGetState(alreadyGet: true);
						rewardItemData3.ShowGetEffect = false;
						rewardItemData3.ShowGetEffect = true;
					}
				}
			}
		}
		getRewardCmd.Enabled = true;
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
