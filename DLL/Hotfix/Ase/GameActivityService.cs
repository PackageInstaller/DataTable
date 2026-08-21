#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class GameActivityService : IGameActivityService
{
	private GameActivityData gameActivityData;

	private ISubscription<ActiveTaskProcessChangeNotify> subscription_GameActivityTask;

	private GameActivityViewModel gameActivityViewModel;

	public GameActivityService()
	{
		gameActivityData = new GameActivityData();
		gameActivityData.DailyPoint = 0;
		gameActivityData.WeekPoint = 0;
		gameActivityData.DailyReward = 0;
		gameActivityData.WeekReward = 0;
		gameActivityData.TaskList = new List<GameActivityTaskData>();
		subscription_GameActivityTask = Singleton<NetworkSystem>.Instance.Subscribe<ActiveTaskProcessChangeNotify>(ActivityTask);
		InitActivityTaskData();
	}

	public async Task<bool> SendGetGameActivityInfoRequest()
	{
		InitActivityTaskData();
		GetUserActiveInfoRequest request = new GetUserActiveInfoRequest();
		GetUserActiveInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUserActiveInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "活跃度", "获取活跃度数据失败"))
			{
				gameActivityData.DailyPoint = response.DailyPoint;
				gameActivityData.WeekPoint = response.WeekPoint;
				gameActivityData.DailyReward = response.DailyRewardState;
				gameActivityData.WeekReward = response.WeekRewardState;
				foreach (PbState item in response.TaskDoneValue)
				{
					foreach (GameActivityTaskData task in gameActivityData.TaskList)
					{
						if (item.Id == task.TaskId)
						{
							task.TaskDone = item.Value;
							task.TaskState = item.State;
						}
					}
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取活跃度数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public GameActivityViewModel GetGameActivityViewModel()
	{
		gameActivityViewModel = new GameActivityViewModel(null);
		return gameActivityViewModel;
	}

	public async Task<bool> SendCompleteTaskRequest(int taskId)
	{
		ActiveTaskCompleteRequest request = new ActiveTaskCompleteRequest
		{
			TaskId = taskId
		};
		ActiveTaskCompleteResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ActiveTaskCompleteResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "活跃度任务", "完成活跃度任务失败"))
			{
				gameActivityData.DailyPoint = response.DailyPoint;
				gameActivityData.WeekPoint = response.WeekPoint;
				foreach (GameActivityTaskData task in gameActivityData.TaskList)
				{
					if (task.TaskId == taskId)
					{
						task.TaskState = 1;
						return true;
					}
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("完成活跃度任务失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async Task<PropGetViewModel> SendGetRewardRequest(int rewardId)
	{
		GetActiveRewardRequest request = new GetActiveRewardRequest
		{
			RewardId = rewardId
		};
		GetActiveRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActiveRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "活跃度奖励", "获取活跃度奖励失败"))
			{
				gameActivityData.DailyReward = response.DailyRewardState;
				gameActivityData.WeekReward = response.WeekRewardState;
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateRoleLevelAndExp(response.Level, response.Exp);
				return new PropGetViewModel(null, (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).PropList);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error("获取活跃度奖励失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private void ActivityTask(ActiveTaskProcessChangeNotify notify)
	{
		foreach (GameActivityTaskData task in gameActivityData.TaskList)
		{
			if (task.TaskId == notify.TaskId)
			{
				task.TaskDone = notify.Value;
				gameActivityViewModel?.CheckRedPoint();
				break;
			}
		}
	}

	public GameActivityData GetGameActivityData()
	{
		return gameActivityData;
	}

	private void InitActivityTaskData()
	{
		gameActivityData.TaskList.Clear();
		DRActiveTask[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRActiveTask>();
		if (allDataRow != null)
		{
			DRActiveTask[] array = allDataRow;
			foreach (DRActiveTask dRActiveTask in array)
			{
				GameActivityTaskData gameActivityTaskData = new GameActivityTaskData();
				gameActivityTaskData.TaskId = dRActiveTask.Id;
				gameActivityData.TaskList.Add(gameActivityTaskData);
			}
		}
	}
}
