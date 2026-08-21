using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class TeamModel : ViewModelBase
{
	private int teamId;

	private string teamName;

	private int captainId = 1;

	private Dictionary<int, TeamMember> _allMembers = new Dictionary<int, TeamMember>();

	private List<int> _heroIds = new List<int>();

	public int TeamId
	{
		get
		{
			return teamId;
		}
		set
		{
			Set(ref teamId, value, "TeamId");
		}
	}

	public string TeamName
	{
		get
		{
			return teamName;
		}
		set
		{
			teamName = value;
		}
	}

	public bool IsNullOrEmpty
	{
		get
		{
			foreach (KeyValuePair<int, TeamMember> allMember in _allMembers)
			{
				if (!allMember.Value.HeroModel.IsNullOrEmpty())
				{
					return false;
				}
			}
			return true;
		}
	}

	public TeamModel()
	{
	}

	public TeamModel(int teamId, string name = null, List<int> heroIds = null)
	{
		TeamId = teamId;
		TeamName = (string.IsNullOrEmpty(name) ? $"队伍{teamId}" : name);
		for (int i = 0; i < 3; i++)
		{
			int num = ((heroIds != null && heroIds.Count > i) ? heroIds[i] : 0);
			HeroModel heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetHeroById(num) ?? new HeroModel();
			bool flag = i + 1 == captainId;
			_allMembers.Add(i + 1, new TeamMember(i + 1, flag, heroModel, flag, !flag));
			_heroIds.Add(num);
		}
	}

	public static TeamModel CreateHeroTry(int activityId, int teamSetId)
	{
		TeamModel teamModel = new TeamModel();
		DRTeamSet dataRow = GameEntry.DataTable.GetDataRow<DRTeamSet>(teamSetId);
		List<int> list = new List<int>();
		for (int i = 1; i <= 3; i++)
		{
			for (int j = 0; j < dataRow.Pos.Count; j++)
			{
				if (dataRow.Pos[j] == i && dataRow.TryHero.Count > j)
				{
					list.Add(dataRow.TryHero[j]);
				}
			}
		}
		teamModel.teamId = activityId;
		teamModel.TeamName = "队伍";
		teamModel._allMembers = new Dictionary<int, TeamMember>();
		teamModel._heroIds = new List<int>();
		for (int k = 0; k < 3; k++)
		{
			int num = ((list != null && list.Count > k) ? list[k] : 0);
			HeroModel heroModel = null;
			if (num == 0)
			{
				heroModel = new HeroModel();
			}
			else
			{
				DRPresetHeroData dataRow2 = GameEntry.DataTable.GetDataRow<DRPresetHeroData>(list[k]);
				if (dataRow2 != null)
				{
					WeaponData weaponData = WeaponData.CreateWeaponData(dataRow2.Weapon);
					weaponData.SetLevel(weaponData, dataRow2.WeaponLv, dataRow2.WeaponLv / 20, dataRow2.WeaponRefine);
					heroModel = HeroModel.CreateByPreset(dataRow2, weaponData);
				}
				else
				{
					heroModel = new HeroModel();
				}
			}
			bool flag = k + 1 == teamModel.captainId;
			teamModel._allMembers.Add(k + 1, new TeamMember(k + 1, flag, heroModel, flag, !flag));
			teamModel._heroIds.Add(num);
		}
		return teamModel;
	}

	public bool IsHeroTry(int index)
	{
		if (_heroIds.Count > index)
		{
			if (_heroIds[index] <= 0)
			{
				return false;
			}
			if (_heroIds[index] != _allMembers[index + 1].HeroModel.Id)
			{
				return true;
			}
		}
		return false;
	}

	public int GetHeroTryId(int index)
	{
		if (_heroIds.Count > index)
		{
			return _heroIds[index];
		}
		return 0;
	}

	public List<TeamMember> GetMemberList()
	{
		return _allMembers.Values.ToList();
	}

	public List<HeroModel> GetHeroModels()
	{
		return _allMembers.Values.Select((TeamMember p) => p.HeroModel).ToList();
	}

	public List<int> GetRoleIds()
	{
		return _heroIds;
	}

	public TeamMember GetMemberById(int id)
	{
		_allMembers.TryGetValue(id, out var value);
		return value;
	}

	public int GetSeatIdByHeroId(int heroId)
	{
		int result = -1;
		if (_allMembers.TryGetValue(heroId, out var value))
		{
			result = value.MemberId;
		}
		return result;
	}

	public void Cover(List<int> roleIds)
	{
		Clear();
		for (int i = 0; i < 3; i++)
		{
			HeroModel heroModel = ((roleIds.Count > i && roleIds[i] > 0) ? Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(roleIds[i]) : new HeroModel());
			bool flag = i + 1 == captainId;
			_allMembers.Add(i + 1, new TeamMember(i + 1, flag, heroModel, flag, !flag));
			_heroIds.Add(roleIds[i]);
		}
	}

	public void CoverHeroTry(List<int> roleIds)
	{
		Clear();
		for (int i = 0; i < 3; i++)
		{
			HeroModel heroModel = null;
			if (roleIds.Count > i && roleIds[i] > 0)
			{
				heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(roleIds[i]);
				if (heroModel == null || heroModel.Empty)
				{
					DRPresetHeroData dataRow = GameEntry.DataTable.GetDataRow<DRPresetHeroData>(roleIds[i]);
					if (dataRow != null)
					{
						WeaponData weaponData = WeaponData.CreateWeaponData(dataRow.Weapon);
						weaponData.SetLevel(weaponData, dataRow.WeaponLv, dataRow.WeaponLv / 20, dataRow.WeaponRefine);
						heroModel = HeroModel.CreateByPreset(dataRow, weaponData);
					}
				}
			}
			else
			{
				heroModel = new HeroModel();
			}
			bool flag = i + 1 == captainId;
			_allMembers.Add(i + 1, new TeamMember(i + 1, flag, heroModel, flag, !flag));
			_heroIds.Add(roleIds[i]);
		}
	}

	public bool CheckHeroInTeam(int heroId)
	{
		bool result = false;
		foreach (KeyValuePair<int, TeamMember> allMember in _allMembers)
		{
			if (allMember.Value.HeroModel != null && allMember.Value.HeroModel.Id == heroId)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	public bool CheckHeroIsCaptain(int heroId)
	{
		_allMembers.TryGetValue(captainId, out var value);
		if (value == null)
		{
			return false;
		}
		if (value.HeroModel != null && _allMembers[captainId].HeroModel.Id == heroId)
		{
			return true;
		}
		return false;
	}

	public void Clear()
	{
		_allMembers.Clear();
		_heroIds.Clear();
	}
}
