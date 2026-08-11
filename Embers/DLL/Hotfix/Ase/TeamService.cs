#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class TeamService : ITeamService
{
	private const string HeroChallengeKey = "Team_HeroChallenge";

	private const string CopyType3FirePowerKey = "Team_CopyType3FirePower";

	private Dictionary<int, TeamModel> allPrepareTeamModels;

	private Dictionary<int, TeamModel> allHeroTryActivityTeamModels;

	private readonly IMessenger teamMessenger;

	private int curSelectTeamId = 1;

	private Dictionary<int, BattleMode> _copyModes = new Dictionary<int, BattleMode>();

	public IMessenger GetTeamMessager()
	{
		return teamMessenger;
	}

	public TeamService()
	{
		allPrepareTeamModels = new Dictionary<int, TeamModel>();
		teamMessenger = Context.GetApplicationContext().GetService<IMessenger>();
		for (int i = 1; i < 7; i++)
		{
			allPrepareTeamModels.Add(i, new TeamModel(i));
		}
	}

	public int GetCurSelectTeamId()
	{
		return curSelectTeamId;
	}

	public async UniTask SetCurSelectTeamId(int id)
	{
		curSelectTeamId = id;
		C2H_SetTroopIdRequest rst = C2H_SetTroopIdRequest.Create();
		rst.TroopId = id;
		H2C_SetTroopIdResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<H2C_SetTroopIdResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "修改当前队伍的预设id", showToast: false))
			{
				Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "修改当前队伍的预设id", showToast: false);
			}
		}
		catch (TimeoutException)
		{
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			result?.Dispose();
		}
	}

	public BattleMode GetCopyMode(int copyId)
	{
		if (!_copyModes.ContainsKey(copyId))
		{
			_copyModes.Add(copyId, BattleMode.CopyNormal);
		}
		return _copyModes[copyId];
	}

	public void SetCopyMode(int copyId, BattleMode copyMode)
	{
		_copyModes[copyId] = copyMode;
	}

	public async UniTask<bool> InitTeamData()
	{
		C2H_GetSingleTroopRequest rst = C2H_GetSingleTroopRequest.Create();
		H2C_GetSingleTroopResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<H2C_GetSingleTroopResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "获取队伍预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "获取队伍预设失败"))
			{
				List<PbSingleTroopInfo> list = result.Troops?.ToList() ?? new List<PbSingleTroopInfo>();
				Dictionary<int, int> dictionary = new Dictionary<int, int>();
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i] != null)
					{
						dictionary.Add(list[i].TroopId, i);
					}
				}
				for (int j = 1; j < 7; j++)
				{
					if (dictionary.ContainsKey(j))
					{
						PbSingleTroopInfo pbSingleTroopInfo = list[dictionary[j]];
						allPrepareTeamModels[j] = new TeamModel(j, pbSingleTroopInfo.TroopName, pbSingleTroopInfo.RoleIds);
					}
					else
					{
						allPrepareTeamModels[j] = new TeamModel(j);
					}
				}
				curSelectTeamId = result.TroopId;
				return true;
			}
		}
		catch (TimeoutException)
		{
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			result?.Dispose();
		}
		return false;
	}

	public Dictionary<int, TeamModel> GetAllTeamData()
	{
		return allPrepareTeamModels;
	}

	public TeamModel GetTeamDataById(int id)
	{
		allPrepareTeamModels.TryGetValue(id, out var value);
		return value;
	}

	public void AddTeam(int teamId, TeamModel teamModel)
	{
		if (allPrepareTeamModels.ContainsKey(teamId))
		{
			allPrepareTeamModels[teamId] = teamModel;
		}
		else
		{
			allPrepareTeamModels.Add(teamId, teamModel);
		}
	}

	public void RemoveTeam(int teamId)
	{
		if (teamId > 0)
		{
			allPrepareTeamModels.Remove(teamId);
		}
	}

	public void SetTeamData(int teamId, List<int> roleIds)
	{
		allPrepareTeamModels.TryGetValue(teamId, out var value);
		if (value == null)
		{
			Toast.ShowError($"id为{teamId}的队伍数据不存在");
		}
		else
		{
			value.Cover(roleIds);
		}
	}

	public async UniTask<bool> SetSingleTroopRequest(int teamId, List<int> roleIds)
	{
		C2H_SetSingleTroopRequest rst = C2H_SetSingleTroopRequest.Create();
		rst.TroopId = teamId;
		rst.RoleIds = roleIds;
		H2C_SetSingleTroopResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<H2C_SetSingleTroopResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "保存队伍") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "保存队伍失败"))
			{
				SetTeamData(teamId, roleIds);
				return true;
			}
		}
		catch (TimeoutException)
		{
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			result?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RenameSingleTroopRequest(int teamId, string newTeamName)
	{
		C2H_RenameSingleTroopRequest rst = C2H_RenameSingleTroopRequest.Create();
		rst.TroopId = teamId;
		rst.NewName = newTeamName;
		H2C_RenameSingleTroopResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<H2C_RenameSingleTroopResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "修改队伍名") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "修改队伍名失败"))
			{
				GetTeamDataById(teamId).TeamName = newTeamName;
				return true;
			}
		}
		catch (TimeoutException)
		{
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			result?.Dispose();
		}
		return false;
	}

	public void SetHeroIdForHeroChallenge(int heroId)
	{
		Singleton<OuterSystem>.Instance.SavePlayerPrefs("Team_HeroChallenge", heroId.ToString());
	}

	public int GetHeroIdForHeroChallenge()
	{
		if (int.TryParse(Singleton<OuterSystem>.Instance.LoadPlayerPrefs("Team_HeroChallenge"), out var result))
		{
			return result;
		}
		return 0;
	}

	public void SetHeroIdForCopyType3FirePower(int heroId)
	{
		Singleton<OuterSystem>.Instance.SavePlayerPrefs("Team_CopyType3FirePower", heroId.ToString());
	}

	public int GetHeroIdForCopyType3FirePower()
	{
		if (int.TryParse(Singleton<OuterSystem>.Instance.LoadPlayerPrefs("Team_CopyType3FirePower"), out var result))
		{
			return result;
		}
		return 1104;
	}

	public void AddActivityHeroTryTeamModel(TeamModel teamModel)
	{
		if (allHeroTryActivityTeamModels == null)
		{
			allHeroTryActivityTeamModels = new Dictionary<int, TeamModel>();
		}
		if (allHeroTryActivityTeamModels.ContainsKey(teamModel.TeamId))
		{
			allHeroTryActivityTeamModels[teamModel.TeamId] = teamModel;
		}
		else
		{
			allHeroTryActivityTeamModels.Add(teamModel.TeamId, teamModel);
		}
	}

	public bool SetActivityHeroTryTroopRequest(int teamId, List<int> roleIds)
	{
		if (allHeroTryActivityTeamModels == null)
		{
			allHeroTryActivityTeamModels = new Dictionary<int, TeamModel>();
		}
		allHeroTryActivityTeamModels.TryGetValue(teamId, out var value);
		value.CoverHeroTry(roleIds);
		return true;
	}

	public TeamModel GetHeroTryTeamDataById(int teamId)
	{
		if (allHeroTryActivityTeamModels.ContainsKey(teamId))
		{
			return allHeroTryActivityTeamModels[teamId];
		}
		return null;
	}
}
