#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomeComeService : IHomeComeService
{
	private readonly IMessenger messenger;

	private readonly HomeComeData homeComeData = new HomeComeData();

	private ISubscription<HomeComeTaskUpdateNotify> subscription_HomeComeTaskUpdateNotify;

	private ISubscription<HomeComeNotify> subscription_HomeComeNotify;

	private bool homeComeOpenState;

	public HomeComeService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_HomeComeTaskUpdateNotify = Singleton<NetworkSystem>.Instance.Subscribe<HomeComeTaskUpdateNotify>(OnHomeComeTaskUpdateNotify);
		subscription_HomeComeNotify = Singleton<NetworkSystem>.Instance.Subscribe<HomeComeNotify>(OnHomeComeNotify);
	}

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public void PublishMessage(HomeComeMessageEnum messageEnum, object arg = null)
	{
		messenger?.Publish(new HomeComeMessage(this, messageEnum, arg));
	}

	private void OnHomeComeTaskUpdateNotify(HomeComeTaskUpdateNotify notify)
	{
		if (notify == null)
		{
			Log.Error("收到的HomeComeTaskUpdateNotify是null的");
			return;
		}
		homeComeData.UpdateTaskProgress(notify.TaskProgress);
		PublishMessage(HomeComeMessageEnum.TaskProgressChanged);
		PublishMessage(HomeComeMessageEnum.RedPointChanged);
	}

	private void OnHomeComeNotify(HomeComeNotify notify)
	{
		if (notify == null)
		{
			Log.Error("收到的HomeComeNotify是null的");
			return;
		}
		homeComeOpenState = notify.IsInReturn;
		homeComeData.SetOpenState(notify.IsInReturn);
		PublishMessage(HomeComeMessageEnum.OpenStateChanged, notify.IsInReturn);
		PublishMessage(HomeComeMessageEnum.RedPointChanged);
	}

	public bool GetHomeComeOpenState()
	{
		return homeComeOpenState;
	}

	public HomeComeData GetData()
	{
		return homeComeData;
	}

	public bool TryGetTaskProgress(int taskId, out HomeComeTaskProgressData data)
	{
		return homeComeData.TryGetTaskProgress(taskId, out data);
	}

	public async UniTask<bool> GetHomeComeInfoRst()
	{
		GetHomeComeInfoRequest request = GetHomeComeInfoRequest.Create();
		GetHomeComeInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeComeInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求回归系统数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求回归系统数据失败"))
			{
				homeComeData.ResetFromInfo(response);
				homeComeOpenState = response.IsInReturn;
				PublishMessage(HomeComeMessageEnum.InfoChanged);
				PublishMessage(HomeComeMessageEnum.OpenStateChanged, homeComeOpenState);
				PublishMessage(HomeComeMessageEnum.RedPointChanged);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<PbDropThing> GetHomeComeGiftRst()
	{
		GetHomeComeGiftRequest request = GetHomeComeGiftRequest.Create();
		GetHomeComeGiftResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeComeGiftResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取回归大礼") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取回归大礼失败"))
			{
				_ = response.Rewards;
				homeComeData.MarkGiftClaimed();
				PublishMessage(HomeComeMessageEnum.GiftClaimed);
				PublishMessage(HomeComeMessageEnum.RedPointChanged);
				return response.Rewards;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<PbDropThing> GetHomeComeSignRewardRst(int SignId)
	{
		GetHomeComeSignRewardRequest request = GetHomeComeSignRewardRequest.Create();
		request.SignId = SignId;
		GetHomeComeSignRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeComeSignRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取签到奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取签到奖励失败"))
			{
				_ = response.Rewards;
				homeComeData.MarkSignClaimed(SignId);
				PublishMessage(HomeComeMessageEnum.SignClaimed, SignId);
				PublishMessage(HomeComeMessageEnum.RedPointChanged);
				return response.Rewards;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<PbDropThing> GetHomeComeTaskRewardRst(int TaskId)
	{
		GetHomeComeTaskRewardRequest request = GetHomeComeTaskRewardRequest.Create();
		request.TaskId = TaskId;
		GetHomeComeTaskRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeComeTaskRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取任务奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取任务奖励失败"))
			{
				_ = response.Rewards;
				homeComeData.MarkTaskClaimed(TaskId);
				PublishMessage(HomeComeMessageEnum.TaskClaimed, TaskId);
				PublishMessage(HomeComeMessageEnum.RedPointChanged);
				return response.Rewards;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public bool HasAnyRedPoint()
	{
		return homeComeData.HasAnyRedPoint();
	}

	public bool HasGiftRedPoint()
	{
		return homeComeData.HasGiftRedPoint();
	}

	public bool HasSignRedPoint()
	{
		return homeComeData.HasSignRedPoint();
	}

	public bool HasTaskRedPoint()
	{
		return homeComeData.HasTaskRedPoint();
	}
}
