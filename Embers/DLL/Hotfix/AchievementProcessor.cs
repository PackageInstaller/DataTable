using System.Collections.Generic;
using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

public abstract class AchievementProcessor
{
	private List<Achievement> _achievementList = new List<Achievement>();

	protected Dictionary<int, int> ConditionParams;

	protected Dictionary<int, int> TargetParams;

	public Achievement RegisterAchievementMedal(AchievementMedal achievementMedal)
	{
		Achievement achievement = Achievement.Create(achievementMedal);
		if (achievement == null)
		{
			return null;
		}
		_achievementList.Add(achievement);
		return achievement;
	}

	public virtual void Processor(IObserverParams observerParams)
	{
		ConditionParams = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
		TargetParams = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
	}

	public void VerityAchievement()
	{
		for (int i = 0; i < _achievementList.Count; i++)
		{
			_achievementList[i].VerityAchievement(ConditionParams, TargetParams);
		}
		CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(ConditionParams);
		CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(TargetParams);
	}

	protected void CheckAndSetActionIsSelf(int actionEntity, BaseEntity baseEntity)
	{
		if (ConditionParams != null && baseEntity != null)
		{
			switch (actionEntity)
			{
			case 6003:
				ConditionParams.Add(6011, (baseEntity.Id == baseEntity.GetWorld().ActorId) ? 1 : 0);
				break;
			case 6001:
				ConditionParams.Add(6010, (baseEntity.Id == baseEntity.GetWorld().ActorId) ? 1 : 0);
				break;
			}
		}
	}

	public List<Achievement> GetAchievementAccomplishProgress()
	{
		return _achievementList;
	}

	public void Clear()
	{
		for (int i = 0; i < _achievementList.Count; i++)
		{
			ReferencePool.Release(_achievementList[i]);
		}
	}
}
