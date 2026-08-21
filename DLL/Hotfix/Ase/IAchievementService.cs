using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IAchievementService
{
	UniTask<bool> RequestAchievementData();

	List<AchievementMedal> GetBattleAchievementMedals(bool isPractice = false);

	List<AchievementMedal> GetAllAchievementMedalsList();

	UniTask<PropGetViewModel> SendAchievementReward(int medalId, int rank);

	UniTask<PropGetViewModel> SendAchievementGroupReward(int type);

	int[] GetFinishAchievementByType(int type);

	AchievementMedal GetAchievementMedalById(int medalId);

	bool CheckAchievementReward();

	bool CheckByAchiTypeRedPoint(int type);

	UniTask<bool> SendBattleAchievement(List<Achievement> achievementList);

	bool SendBoardHeroClick();

	void AddAchievementRedPoint(Action<bool> action);

	UniTask<bool> GetAchievementGroupInfo();

	Dictionary<int, int> GetAchievementGroupStateDic();

	List<int> GetAchiCacheList();

	void ClearAchiCache();
}
