using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ActivitySweepTaskProgress : MonoBehaviour
{
	public LocalizeStringEvent title;

	public CommonNumberComponent number;

	private int _poolID;

	private int _activityChallengeGroupID;

	private ActivityChallengeGroup _activityChallengeGroupData;

	public int ActivityChallengeGroupID
	{
		get
		{
			return _activityChallengeGroupID;
		}
		set
		{
			_activityChallengeGroupID = value;
			_activityChallengeGroupData = CoreUtils.GetData(value, RuntimeConfigs.data.activityChallengeGroups);
			int id = _activityChallengeGroupData.challengeId.FirstOrDefault();
			_poolID = CoreUtils.GetData(id, RuntimeConfigs.data.activityChallengeDatas).lotteryRewards.FirstOrDefault()?.id ?? 0;
			UpdateStyle();
		}
	}

	private ActivityDailyLotteryInfo _lotteryInfo => Model<ActivityCenterModel>.Interface.GetLotteryInfo();

	public void Refresh()
	{
		if (_activityChallengeGroupData != null)
		{
			UpdateStyle();
		}
	}

	private void UpdateStyle()
	{
		title.SetTable("shortcommon");
		title.StringReference.TableEntryReference = _activityChallengeGroupData.stageName;
		_lotteryInfo.LotteryInfos.TryGetValue(_poolID, out var value);
		int num = 0;
		int[] challengeId = _activityChallengeGroupData.challengeId;
		for (int i = 0; i < challengeId.Length; i++)
		{
			ActivityChallengeData data = CoreUtils.GetData(challengeId[i], RuntimeConfigs.data.activityChallengeDatas);
			num += data.lotteryRewards.Count * data.times * (data.lotteryRewards.FirstOrDefault()?.count ?? 1);
		}
		number.UpdateNumber(value?.TodayGachaConut ?? 0, num);
	}
}
