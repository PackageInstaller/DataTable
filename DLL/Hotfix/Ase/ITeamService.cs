using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface ITeamService
{
	int GetCurSelectTeamId();

	int GetHeroIdForHeroChallenge();

	void SetHeroIdForHeroChallenge(int heroId);

	int GetHeroIdForCopyType3FirePower();

	void SetHeroIdForCopyType3FirePower(int heroId);

	UniTask SetCurSelectTeamId(int id);

	BattleMode GetCopyMode(int copyId);

	void SetCopyMode(int copyId, BattleMode copyMode);

	UniTask<bool> InitTeamData();

	IMessenger GetTeamMessager();

	Dictionary<int, TeamModel> GetAllTeamData();

	TeamModel GetTeamDataById(int teamId);

	void AddTeam(int teamId, TeamModel teamModel);

	void RemoveTeam(int teamId);

	void SetTeamData(int teamId, List<int> roleIds);

	UniTask<bool> SetSingleTroopRequest(int teamId, List<int> roleIds);

	UniTask<bool> RenameSingleTroopRequest(int teamId, string newTeamName);

	void AddActivityHeroTryTeamModel(TeamModel teamModel);

	bool SetActivityHeroTryTroopRequest(int teamId, List<int> roleIds);

	TeamModel GetHeroTryTeamDataById(int teamId);
}
