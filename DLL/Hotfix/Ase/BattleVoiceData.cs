#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class BattleVoiceData
{
	private BaseEntity entity;

	private DRBattleVoice config;

	private List<List<string>> conditionLists;

	private List<ObserverConditionBase> observerConditionList;

	private float coolingTime;

	private float lastPlayTime;

	private float delayTime;

	protected int conditionFlags;

	public DRBattleVoice Config => config;

	public BattleVoiceData(BaseEntity entity, DRBattleVoice config)
	{
		this.entity = entity;
		this.config = config;
		conditionLists = new List<List<string>>();
		observerConditionList = new List<ObserverConditionBase>();
		OnInitConditions();
		OnInitCoolingTime();
		OnInitDelayTime();
	}

	private void OnInitCoolingTime()
	{
		coolingTime = config.CoolingTime;
		lastPlayTime = 0f;
	}

	private void OnInitDelayTime()
	{
		delayTime = 0f;
	}

	private void OnInitConditions()
	{
		conditionFlags = 0;
		List<string> list = new List<string>();
		foreach (string condition in config.Conditions)
		{
			if (condition.Contains("&"))
			{
				SetConditionFlags(1);
				string[] array = condition.Split('&');
				list.Add(array[0]);
				conditionLists.Add(list.ToList());
				list.Clear();
				list.Add(array[1]);
			}
			else if (condition.Contains("|"))
			{
				SetConditionFlags(2);
				string[] array2 = condition.Split('|');
				list.Add(array2[0]);
				conditionLists.Add(list.ToList());
				list.Clear();
				list.Add(array2[1]);
			}
			else
			{
				list.Add(condition);
			}
		}
		conditionLists.Add(list.ToList());
		for (int i = 0; i < conditionLists.Count; i++)
		{
			ObserverConditionBase observerCondition = ObserverUtility.GetObserverCondition(config.BattleObserverEventEnum);
			if (observerCondition != null)
			{
				observerCondition.Init(entity, config.BattleObserverEventEnum, conditionLists[i]);
				observerConditionList.Add(observerCondition);
			}
		}
	}

	private void SetConditionFlags(int flags)
	{
		if (conditionFlags != 0 && conditionFlags != flags)
		{
			Log.Error("语音表填写错误，当前不支持不同的判断条件");
		}
		else
		{
			conditionFlags = flags;
		}
	}

	public bool CheckCondition(BaseEntity entity, IObserverParams param)
	{
		if (param == null)
		{
			return true;
		}
		if (observerConditionList.Count == 0)
		{
			return true;
		}
		if (conditionFlags == 0)
		{
			return observerConditionList[0].CheckCondition(param);
		}
		if (conditionFlags == 1)
		{
			foreach (ObserverConditionBase observerCondition in observerConditionList)
			{
				if (!observerCondition.CheckCondition(param))
				{
					return false;
				}
			}
			return true;
		}
		if (conditionFlags == 2)
		{
			foreach (ObserverConditionBase observerCondition2 in observerConditionList)
			{
				if (observerCondition2.CheckCondition(param))
				{
					return true;
				}
			}
			return false;
		}
		return false;
	}

	public bool CheckCoolingTime()
	{
		float num = entity.GetSystem<BattleSystem>()?.GlobalBattleTime ?? 0f;
		if (num == 0f)
		{
			return false;
		}
		if (lastPlayTime != 0f && num - lastPlayTime < coolingTime)
		{
			return false;
		}
		lastPlayTime = num;
		return true;
	}

	public bool CheckDelayTime()
	{
		if (config == null)
		{
			return false;
		}
		return delayTime >= config.DelayTime;
	}

	public void Update(float deltaTime)
	{
		delayTime += deltaTime;
	}

	public void Reset()
	{
		delayTime = 0f;
	}
}
