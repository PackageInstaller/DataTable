#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CampaignService : ICampaignService
{
	private IMessenger _messenger;

	private CampaignServiceData.MainInfo _mainInfo;

	private CampaignServiceData.DetailInfo _detailInfo;

	private List<int> _newBuildingMarks = new List<int>();

	private ISubscription<CampaignWorldBossRefreshNotify> _worldBossRefreshNotify;

	public CampaignService()
	{
		_messenger = Context.GetApplicationContext().GetService<IMessenger>();
		_worldBossRefreshNotify = Singleton<NetworkSystem>.Instance.Subscribe<CampaignWorldBossRefreshNotify>(OnWorldBossRefreshNotify);
	}

	private async void OnWorldBossRefreshNotify(CampaignWorldBossRefreshNotify notify)
	{
		if (notify != null)
		{
			if (notify.NotifyType == 4 && await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestCampaignMainInfo() != null)
			{
				_messenger.Publish(new CampaignMessage(this, CampaignMsgType.MainInfoRefresh));
			}
			if ((notify.NotifyType == 1 || notify.NotifyType == 2 || notify.NotifyType == 3 || notify.NotifyType == 4) && await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestCampaignDetailInfo() != null)
			{
				_messenger.Publish(new CampaignMessage(this, CampaignMsgType.DetailInfoRefresh));
			}
		}
	}

	public CampaignServiceData.MainInfo GetMainInfo()
	{
		return _mainInfo;
	}

	public CampaignServiceData.DetailInfo GetDetailInfo()
	{
		return _detailInfo;
	}

	public async UniTask<CampaignServiceData.MainInfo> RequestCampaignMainInfo()
	{
		GetCampaignInfoRequest rst = GetCampaignInfoRequest.Create();
		GetCampaignInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetCampaignInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取战役主页信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取战役主页信息失败"))
			{
				_mainInfo = new CampaignServiceData.MainInfo(response);
				return _mainInfo;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<CampaignServiceData.DetailInfo> RequestCampaignDetailInfo()
	{
		GetCampaignDetailInfoRequest rst = GetCampaignDetailInfoRequest.Create();
		GetCampaignDetailInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetCampaignDetailInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取战役详情信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取战役详情信息失败"))
			{
				List<CampaignServiceData.BuildingInfo> oldBuildingInfos = null;
				if (_detailInfo?.BuildingInfos != null)
				{
					oldBuildingInfos = _detailInfo.BuildingInfos;
				}
				_detailInfo = new CampaignServiceData.DetailInfo(response);
				if (oldBuildingInfos != null)
				{
					_detailInfo.BuildingInfos?.ForEach(delegate(CampaignServiceData.BuildingInfo a)
					{
						int num = oldBuildingInfos.Find((CampaignServiceData.BuildingInfo b) => b.BuildingId.Equals(a.BuildingId))?.BuildingLevel ?? (-1);
						a.Upgraded = _newBuildingMarks.Contains(a.BuildingId) || (num >= 0 && !a.BuildingLevel.Equals(num));
						if (a.Upgraded && !_newBuildingMarks.Contains(a.BuildingId))
						{
							_newBuildingMarks.Add(a.BuildingId);
						}
					});
				}
				return _detailInfo;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<CampaignServiceData.WorldBossInfo>> RequestSearchBoss()
	{
		CampaignSearchBossRequest rst = CampaignSearchBossRequest.Create();
		CampaignSearchBossResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CampaignSearchBossResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "搜索Boss") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "搜索Boss失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.CostItems);
				List<CampaignServiceData.WorldBossInfo> list = new List<CampaignServiceData.WorldBossInfo>();
				response.WorldBossInfos?.ForEach(delegate(PbCampaignWorldBossInfo p)
				{
					list.Add(new CampaignServiceData.WorldBossInfo(p));
				});
				_detailInfo?.AddWorldBossInfo(list);
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<CampaignServiceData.BuildingInfo>> RequestUpgradeBuilding(int pointId)
	{
		CampaignUpgradeBuildingRequest rst = CampaignUpgradeBuildingRequest.Create();
		rst.PointId = pointId;
		CampaignUpgradeBuildingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CampaignUpgradeBuildingResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "升级建筑") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "升级建筑失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.CostItems);
				List<CampaignServiceData.BuildingInfo> list = new List<CampaignServiceData.BuildingInfo>();
				response.BuildingInfos?.ForEach(delegate(PbCampaignBuildingInfo p)
				{
					list.Add(new CampaignServiceData.BuildingInfo(p));
				});
				List<CampaignServiceData.BuildingInfo> oldBuildingInfos = null;
				if (_detailInfo?.BuildingInfos != null)
				{
					oldBuildingInfos = _detailInfo.BuildingInfos;
				}
				_detailInfo?.RefreshBuildingInfo(list);
				if (oldBuildingInfos != null)
				{
					_detailInfo.BuildingInfos?.ForEach(delegate(CampaignServiceData.BuildingInfo a)
					{
						int num = oldBuildingInfos.Find((CampaignServiceData.BuildingInfo b) => b.BuildingId.Equals(a.BuildingId))?.BuildingLevel ?? (-1);
						a.Upgraded = _newBuildingMarks.Contains(a.BuildingId) || (num >= 0 && !a.BuildingLevel.Equals(num));
						if (a.Upgraded && !_newBuildingMarks.Contains(a.BuildingId))
						{
							_newBuildingMarks.Add(a.BuildingId);
						}
					});
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public void ResetBuildingUpgradeMark()
	{
		_newBuildingMarks.Clear();
	}

	public bool GetCampaignOpenState()
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.CampaignActId);
		if (dataRow == null)
		{
			return false;
		}
		ActivityViewModelBase activityViewModelBase = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel((int)dataRow.Value);
		if (activityViewModelBase != null)
		{
			if (activityViewModelBase.State == OpActivityState.On)
			{
				return activityViewModelBase.LockState == OpActivityLockState.Unlock;
			}
			return false;
		}
		return false;
	}

	public static string CalculateFactor(long factorValue, int symbolType, int argNum, bool showDecimal)
	{
		switch (symbolType)
		{
		case 1:
			return $"{factorValue + argNum}";
		case 2:
			return $"{factorValue - argNum}";
		case 3:
			return $"{factorValue * argNum}";
		case 4:
		{
			float num = (float)factorValue / (float)argNum;
			if (showDecimal)
			{
				return num.ToString("0.####");
			}
			return $"{(int)num}";
		}
		default:
			return $"{factorValue}";
		}
	}

	public static int GetMainShopId()
	{
		return GameEntry.DataTable.GetDataRow((DRMainShopList p) => p.ShopPosition == 6)?.Id ?? 0;
	}

	public void Dispose()
	{
		_worldBossRefreshNotify?.Dispose();
		_worldBossRefreshNotify = null;
	}

	public async UniTask<CampaignTeamRoomCheckResult> CheckCampaignTeamRoom(CampaignTeamRoomContext context, CampaignTeamRoomCheckScene scene)
	{
		if (context == null || context.CopyData == null)
		{
			return CampaignTeamRoomCheckResult.Fail("玩法已失效，创建房间失败，请稍后尝试");
		}
		if (context.AreaType == CampaignAreaType.WorldBoss)
		{
			long campaignWorldBossHp = GetCampaignWorldBossHp(context);
			bool flag = HasCampaignEnterCostTicket(context);
			if (campaignWorldBossHp <= 0)
			{
				return CampaignTeamRoomCheckResult.Fail("玩法已失效，创建房间失败，请稍后尝试");
			}
			if (!flag)
			{
				return CampaignTeamRoomCheckResult.Fail("挑战所需道具不足，无法创建房间");
			}
		}
		else if (context.AreaType == CampaignAreaType.EliteMonster)
		{
			if (!HasCampaignEnterCostTicket(context))
			{
				return CampaignTeamRoomCheckResult.Fail("挑战所需道具不足，无法创建房间");
			}
		}
		else if (context.AreaType == CampaignAreaType.LordMonster && !HasCampaignMonsterRemainTimes(context))
		{
			return CampaignTeamRoomCheckResult.Fail("挑战所需次数不足，无法创建房间");
		}
		return CampaignTeamRoomCheckResult.Ok();
	}

	private long GetCampaignWorldBossHp(CampaignTeamRoomContext context)
	{
		if (_detailInfo == null || _detailInfo.WorldBossInfos.Count < 0)
		{
			return 0L;
		}
		long result = 0L;
		for (int i = 0; i < _detailInfo.WorldBossInfos.Count; i++)
		{
			if (_detailInfo.WorldBossInfos[i].PlayId == context.PlayId)
			{
				result = _detailInfo.WorldBossInfos[i].BossHP;
				break;
			}
		}
		return result;
	}

	private bool HasCampaignMonsterRemainTimes(CampaignTeamRoomContext context)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(context.CopyId);
		if (dataRow == null)
		{
			return false;
		}
		int costNum = dataRow.CostNum;
		if (_detailInfo == null || _detailInfo.WorldBossInfos.Count < 0)
		{
			return false;
		}
		long num = 0L;
		for (int i = 0; i < _detailInfo.WorldBossInfos.Count; i++)
		{
			if (_detailInfo.WorldBossInfos[i].PlayId == context.PlayId)
			{
				num = _detailInfo.WorldBossInfos[i].Times;
				break;
			}
		}
		return num - costNum >= 0;
	}

	private bool HasCampaignEnterCostTicket(CampaignTeamRoomContext context)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(context.CopyId);
		if (dataRow == null)
		{
			return false;
		}
		int costId = dataRow.CostId;
		int costNum = dataRow.CostNum;
		if (costNum <= 0 || costId <= 0)
		{
			return true;
		}
		return ((Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetProp(costId))?.Amount ?? 0) >= costNum;
	}
}
