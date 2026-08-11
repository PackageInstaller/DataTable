using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IActivityAchievementService
{
	UniTask<bool> GetAllActivityAchievementDataRst();

	List<ActivityAchievementData> ByActivityTypeGetAchievementDataList(int activityTypeId);

	List<ActivityAchievementTaskData> ByActivityTypeGetTaskDataList(int activityTypeId);

	bool ByActivityTypeGetRedPoint(int activityTypeId);

	void SetActivityAchievementRedPointBlocked(int activityTypeId, bool blocked);

	bool IsActivityAchievementRedPointBlocked(int activityTypeId);

	ActivityAchievementState GetActivityAchievementStateRst(int activityTypeId, int achievementId);

	UniTask<ActivityReward> GetTaskRewardRst(int taskId);

	UniTask<bool> SendFightChooseBuffIds(List<int> seeBuffIds, List<int> chooseBuffIds);
}
