using System;
using System.Collections.Generic;

namespace RogueCard;

[Serializable]
public class RogueCardGameEffect
{
	public int effectID;

	public EntityType attachEntity;

	public TriggerMoment triggerMoment;

	public List<BaseCondition> conditions = new List<BaseCondition>();

	public BaseAction action;

	public int maxTriggers = -1;

	public int triggerCount;

	public TriggerMoment triggerResetMoment;

	public int maxLife = -1;

	public int lifeCount;

	public TriggerMoment lifeResetMoment;

	public RogueCardJokerData showOtherJoker;

	public RogueCardGameEffect(int effectID, EntityType entity, TriggerMoment trigger)
	{
		this.effectID = effectID;
		attachEntity = entity;
		triggerMoment = trigger;
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[effectID];
		maxTriggers = rogueCardEffectCfg.effective_time;
		triggerCount = 0;
		triggerResetMoment = (TriggerMoment)rogueCardEffectCfg.effective_reset_moment;
		maxLife = rogueCardEffectCfg.max_lifetime;
		lifeCount = 0;
		lifeResetMoment = (TriggerMoment)rogueCardEffectCfg.lifetime_grow_moment;
	}

	public RogueCardGameEffect(RogueCardGameEffect other, RogueCardJokerData jokerData)
	{
		effectID = other.effectID;
		attachEntity = other.attachEntity;
		triggerMoment = other.triggerMoment;
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[other.effectID];
		maxTriggers = other.maxTriggers;
		triggerCount = other.triggerCount;
		triggerResetMoment = other.triggerResetMoment;
		maxLife = other.maxLife;
		lifeCount = other.lifeCount;
		lifeResetMoment = other.lifeResetMoment;
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			BaseCondition baseCondition = RogueCardEffectManager.CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1);
			baseCondition.effectEntity = jokerData;
			conditions.Add(baseCondition);
		}
		BaseAction baseAction = RogueCardEffectManager.CreateAction(rogueCardEffectCfg);
		if (baseAction != null)
		{
			baseAction.effectID = effectID;
			baseAction.effectEntity = jokerData;
			action = baseAction;
			baseAction.otherJoker = jokerData;
			showOtherJoker = jokerData;
		}
	}

	public void RecoverTriggerNum()
	{
		if (maxTriggers != -1 && !RogueCardGameMain.GameContext.isRestoringSave)
		{
			triggerCount = 0;
		}
	}

	public void RecoverLifeNum()
	{
		if (maxLife != -1)
		{
			if (maxLife > 0)
			{
				lifeCount++;
			}
			if (maxLife > 0 && lifeCount >= maxLife)
			{
				RogueCardEffectManager.Instance.UnRegistEffect(effectID, attachEntity);
			}
		}
	}

	public bool CanTrigger()
	{
		if (maxTriggers != -1)
		{
			return triggerCount < maxTriggers;
		}
		return true;
	}

	public void OnTrigger()
	{
		if (maxTriggers > 0)
		{
			triggerCount++;
		}
	}

	public bool CheckConditions(TriggerMoment moment)
	{
		if (!CanTrigger())
		{
			return false;
		}
		if (triggerMoment != moment)
		{
			return false;
		}
		foreach (BaseCondition condition in conditions)
		{
			if (!condition.Check(moment))
			{
				return false;
			}
		}
		return true;
	}

	public void ExecuteActions(TriggerMoment moment)
	{
		if (action != null)
		{
			action.Execute(moment);
		}
		OnTrigger();
	}

	public void OnDisabled()
	{
		action.OnDisabled();
	}
}
