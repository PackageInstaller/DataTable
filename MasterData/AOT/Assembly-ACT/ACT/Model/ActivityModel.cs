using ACT.Battle;
using ACT.Core;
using ACT.Game;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class ActivityModel : Model<ActivityModel>
{
	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public bool CheckGotReward(int activityId, int activityChallengeId)
	{
		for (int i = 0; i < G.localPlayer.playerLevelActivity[activityId].Count; i++)
		{
			G.localPlayer.playerLevelActivity[activityId][i].ActivityChallengeIds.Contains(activityChallengeId);
		}
		return false;
	}

	public bool CheckPlayerLevel(int activityChallengeId)
	{
		int challengeCondition = CoreUtils.GetData(activityChallengeId, RuntimeConfigs.data.activityChallengeDatas).challengeCondition;
		int[] challengeConditionParm = CoreUtils.GetData(activityChallengeId, RuntimeConfigs.data.activityChallengeDatas).challengeConditionParm;
		if (challengeCondition == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("活动挑战条件为空");
			}
			return false;
		}
		return Singleton<PreconditionInfoManager>.instance.IsComplete(challengeCondition, challengeConditionParm);
	}
}
