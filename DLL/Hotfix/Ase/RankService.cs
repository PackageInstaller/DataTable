#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Network;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class RankService : IRankService
{
	private const string HeroChallengeIdForRank = "Rank_HeroChallenge_HeroId";

	public const int defaultHeroChallengeId = 1104;

	private INetworkChannel _channel;

	private readonly IMessenger messenger;

	private List<RankDefinition.HeroChallengeData> _heroChallengeDatas = new List<RankDefinition.HeroChallengeData>();

	public RankService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
	}

	public async UniTask<bool> RequestDatas()
	{
		return true;
	}

	public async UniTask<List<RankDefinition.HeroChallengeData>> RequestHeroChallengeData()
	{
		GetSelfHeroRankInfoRequest rst = GetSelfHeroRankInfoRequest.Create();
		GetSelfHeroRankInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSelfHeroRankInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取角色极限挑战数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取角色极限挑战数据 失败"))
			{
				_heroChallengeDatas.Clear();
				foreach (DRHeroInfo drHeroInfo in HeroDefinition.GetOuterHeroConfigs())
				{
					RankDefinition.HeroChallengeData item = new RankDefinition.HeroChallengeData
					{
						HeroId = drHeroInfo.Id,
						Rank = 0,
						Score = 0
					};
					if (response.SelfRanks != null)
					{
						PbSelfHeroRankInfo pbSelfHeroRankInfo = response.SelfRanks.Find((PbSelfHeroRankInfo p) => p.RoleId == drHeroInfo.Id);
						if (pbSelfHeroRankInfo != null)
						{
							item.Rank = pbSelfHeroRankInfo.Rank;
							item.Score = pbSelfHeroRankInfo.Score;
						}
					}
					_heroChallengeDatas.Add(item);
				}
				return _heroChallengeDatas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return _heroChallengeDatas;
	}

	public List<RankDefinition.HeroChallengeData> GetHeroChallengeData()
	{
		return _heroChallengeDatas;
	}

	public async UniTask<HeroChallengeRankResultData> RequestSuitboxHeroRankInfo(int type, int roleId)
	{
		HeroChallengeRankResultData result = new HeroChallengeRankResultData();
		C2S_GetSuitboxHeroRankInfo request = C2S_GetSuitboxHeroRankInfo.Create();
		request.Type = type;
		request.RoleId = roleId;
		S2C_GetSuitboxHeroRankInfo response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetSuitboxHeroRankInfo>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取角色排行榜数据 type={type} roleId={roleId}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取角色排行榜数据失败 type={type} roleId={roleId}"))
			{
				if (response.HeroRankInfos != null)
				{
					result.HeroRankInfos.AddRange(response.HeroRankInfos);
				}
				if (response.SelfRanks != null)
				{
					result.SelfScore = response.SelfRanks.Score;
					result.SelfRank = response.SelfRanks.Rank;
				}
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求角色排行榜数据异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<List<PbSuitboxCopyRankInfo>> RequestSuitBoxCopyRankData(int type, int subType, int seasonId = 0)
	{
		GetRankListRequest rst = GetRankListRequest.Create();
		rst.Type = type;
		rst.SubType = subType;
		rst.SeasonId = seasonId;
		rst.PageIndex = 0;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取护石本{subType}的排行榜数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取护石本{subType}的排行榜数据 失败"))
			{
				List<PbSuitboxCopyRankInfo> datas = new List<PbSuitboxCopyRankInfo>();
				datas.AddRange(response.SuitboxCopyRankInfos);
				if (response.TotalPage > 1)
				{
					for (int i = 1; i < response.TotalPage; i++)
					{
						GetRankListRequest getRankListRequest = GetRankListRequest.Create();
						getRankListRequest.Type = type;
						getRankListRequest.SubType = subType;
						getRankListRequest.SeasonId = seasonId;
						getRankListRequest.PageIndex = i;
						GetRankListResponse getRankListResponse = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(getRankListRequest);
						if (getRankListResponse != null)
						{
							datas.AddRange(getRankListResponse.SuitboxCopyRankInfos);
						}
					}
				}
				return datas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PbRaceCopyRankInfo>> RequestRaceCopyRankData(int type, int subType, int seasonId = 0)
	{
		GetRankListRequest rst = GetRankListRequest.Create();
		rst.Type = type;
		rst.SubType = subType;
		rst.SeasonId = seasonId;
		rst.PageIndex = 0;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取竞速本{subType}的排行榜数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取竞速本{subType}的排行榜数据 失败"))
			{
				List<PbRaceCopyRankInfo> datas = new List<PbRaceCopyRankInfo>();
				datas.AddRange(response.RaceCopyRankInfos);
				if (response.TotalPage > 1)
				{
					for (int i = 1; i < response.TotalPage; i++)
					{
						GetRankListRequest getRankListRequest = GetRankListRequest.Create();
						getRankListRequest.Type = type;
						getRankListRequest.SubType = subType;
						getRankListRequest.SeasonId = seasonId;
						getRankListRequest.PageIndex = i;
						GetRankListResponse getRankListResponse = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(getRankListRequest);
						if (getRankListResponse != null)
						{
							datas.AddRange(getRankListResponse.RaceCopyRankInfos);
						}
					}
				}
				return datas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PbHeroRankInfo>> RequestHeroChallengeRankData(int type, int subType, int seasonId = 0)
	{
		GetRankListRequest rst = GetRankListRequest.Create();
		rst.Type = type;
		rst.SubType = subType;
		rst.SeasonId = seasonId;
		rst.PageIndex = 0;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取极限挑战{subType}的排行榜数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取极限挑战{subType}的排行榜数据 失败"))
			{
				List<PbHeroRankInfo> datas = new List<PbHeroRankInfo>();
				datas.AddRange(response.HeroRankInfos);
				if (response.TotalPage > 1)
				{
					for (int i = 1; i < response.TotalPage; i++)
					{
						GetRankListRequest getRankListRequest = GetRankListRequest.Create();
						getRankListRequest.Type = type;
						getRankListRequest.SubType = subType;
						getRankListRequest.SeasonId = seasonId;
						getRankListRequest.PageIndex = i;
						GetRankListResponse getRankListResponse = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(getRankListRequest);
						if (getRankListResponse != null)
						{
							datas.AddRange(getRankListResponse.HeroRankInfos);
						}
					}
				}
				return datas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PbUnionRankInfo>> RequestGuildActiveRankData()
	{
		GetUnionRankListRequest rst = GetUnionRankListRequest.Create();
		rst.Type = 0;
		GetUnionRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求公会活跃度排行数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求公会活跃度排行数据失败"))
			{
				return response.UnionRankInfos;
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

	public async UniTask<List<PbUnionCopyRankInfo>> RequestGuildCopyRankData()
	{
		GetUnionRankListRequest rst = GetUnionRankListRequest.Create();
		rst.Type = 1;
		GetUnionRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求公会副本 公会间总伤害榜") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求公会副本 公会间总伤害榜 失败"))
			{
				return response.CopyRankInfos;
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

	public async UniTask<List<PbUnionMemberRankInfo>> RequestGuildMemberRankData()
	{
		GetUnionRankListRequest rst = GetUnionRankListRequest.Create();
		rst.Type = 2;
		GetUnionRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求公会副本 公会内成员伤害榜") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求公会副本 公会内成员伤害榜 失败"))
			{
				return response.MemberRankInfos;
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

	public async UniTask<List<PbChallengeCopyRankInfo>> RequestChallengeCopyRankData(int type, int subType, int seasonId = 0)
	{
		GetRankListRequest rst = GetRankListRequest.Create();
		rst.Type = type;
		rst.SubType = subType;
		rst.SeasonId = seasonId;
		rst.PageIndex = 0;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取挑战副本{subType}的排行榜数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取挑战副本{subType}的排行榜数据 失败"))
			{
				List<PbChallengeCopyRankInfo> datas = new List<PbChallengeCopyRankInfo>();
				datas.AddRange(response.ChallengeCopyRankInfos);
				if (response.TotalPage > 1)
				{
					for (int i = 1; i < response.TotalPage; i++)
					{
						GetRankListRequest getRankListRequest = GetRankListRequest.Create();
						getRankListRequest.Type = type;
						getRankListRequest.SubType = subType;
						getRankListRequest.SeasonId = seasonId;
						getRankListRequest.PageIndex = i;
						GetRankListResponse getRankListResponse = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(getRankListRequest);
						if (getRankListResponse != null)
						{
							datas.AddRange(getRankListResponse.ChallengeCopyRankInfos);
						}
					}
				}
				return datas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PbChallengeCopyRankInfo>> RequestTowerCopyRankData(int type, int subType, int seasonId = 0)
	{
		GetRankListRequest rst = GetRankListRequest.Create();
		rst.Type = type;
		rst.SubType = subType;
		rst.SeasonId = seasonId;
		rst.PageIndex = 0;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取爬塔副本{subType}的排行榜数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取爬塔副本{subType}的排行榜数据 失败"))
			{
				List<PbChallengeCopyRankInfo> datas = new List<PbChallengeCopyRankInfo>();
				datas.AddRange(response.ChallengeCopyRankInfos);
				if (response.TotalPage > 1)
				{
					for (int i = 1; i < response.TotalPage; i++)
					{
						GetRankListRequest getRankListRequest = GetRankListRequest.Create();
						getRankListRequest.Type = type;
						getRankListRequest.SubType = subType;
						getRankListRequest.SeasonId = seasonId;
						getRankListRequest.PageIndex = i;
						GetRankListResponse getRankListResponse = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(getRankListRequest);
						if (getRankListResponse != null)
						{
							datas.AddRange(getRankListResponse.ChallengeCopyRankInfos);
						}
					}
				}
				return datas;
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
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public void SetHeroChallengeIdForRank(int heroId)
	{
		PlayerPrefs.SetString("Rank_HeroChallenge_HeroId", heroId.ToString());
	}

	public int GetHeroChallengeIdForRank()
	{
		if (int.TryParse(PlayerPrefs.GetString("Rank_HeroChallenge_HeroId", 1104.ToString()), out var result))
		{
			return result;
		}
		return 0;
	}

	public List<DRRankType> GetOpenRankTypes()
	{
		List<DRRankType> list = new List<DRRankType>();
		DRRankType[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRRankType>();
		if (allDataRow != null)
		{
			DRRankType[] array = allDataRow;
			foreach (DRRankType dRRankType in array)
			{
				RankDefinition.RankState rankState = RankDefinition.GetRankState(dRRankType.StartTime, dRRankType.EndTime, dRRankType.OffTime);
				if (rankState == RankDefinition.RankState.InProgress || rankState == RankDefinition.RankState.AlreadySettled)
				{
					list.Add(dRRankType);
				}
			}
		}
		return list;
	}

	public DRRankType GetLatestRaceCopyConfig()
	{
		DRRankType latestConfig = null;
		GetOpenRankTypes().FindAll((DRRankType p) => RankDefinition.CheckRaceCopyRank(p.Type)).ForEach(delegate(DRRankType p)
		{
			if (latestConfig == null || p.Id > latestConfig.Id)
			{
				latestConfig = p;
			}
		});
		return latestConfig;
	}

	public DRRankType GetLatestHeroChallengeRank()
	{
		DRRankType latestConfig = null;
		GetOpenRankTypes().FindAll((DRRankType p) => RankDefinition.CheckHeroChallengeRank(p.Type)).ForEach(delegate(DRRankType p)
		{
			if (latestConfig == null || p.Id > latestConfig.Id)
			{
				latestConfig = p;
			}
		});
		return latestConfig;
	}
}
