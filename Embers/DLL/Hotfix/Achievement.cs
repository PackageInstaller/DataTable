using System.Collections.Generic;
using Ase;
using GameFramework;
using UnityEngine.Pool;

public abstract class Achievement : IReference
{
	public string AchievementName;

	public int MedalId;

	public Dictionary<int, List<int>> ConditionParam;

	public int TargetParamType;

	protected int targetSuccessValue;

	public int TargetSuccessValue => targetSuccessValue;

	public static Achievement Create(AchievementMedal medal)
	{
		Achievement achievement = null;
		List<int> settlementcheckPamIndex = medal.SettlementcheckPamIndex;
		achievement = ((settlementcheckPamIndex != null && settlementcheckPamIndex.Count == 0) ? ((Achievement)ReferencePool.Acquire<NormalAchievement>()) : ((Achievement)ReferencePool.Acquire<SettlementAchievement>()));
		achievement.MedalId = medal.MedalId;
		achievement.AchievementName = medal.MedalName;
		achievement.targetSuccessValue = 0;
		achievement.InitPrivateData(medal);
		achievement.InitCondition(medal.ConditionList, medal.BattleTarget);
		return achievement;
	}

	protected abstract void InitPrivateData(AchievementMedal medal);

	protected virtual bool InitCondition(List<int> conditionList, List<List<int>> targetList)
	{
		ConditionParam = new Dictionary<int, List<int>>();
		if (conditionList == null || targetList == null)
		{
			return false;
		}
		if (conditionList.Count == 0 || targetList.Count == 0)
		{
			return false;
		}
		if (conditionList.Count != targetList.Count)
		{
			return false;
		}
		return true;
	}

	public abstract void VerityAchievement(Dictionary<int, int> conditionParams, Dictionary<int, int> targetParams);

	public virtual void DoubleVerityAchievement(Dictionary<int, int> conditionParams)
	{
		if (conditionParams != null)
		{
			conditionParams.Clear();
			CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(conditionParams);
		}
	}

	public void Clear()
	{
		MedalId = 0;
		TargetParamType = 0;
		targetSuccessValue = 0;
		ConditionParam.Clear();
		ConditionParam = null;
	}
}
