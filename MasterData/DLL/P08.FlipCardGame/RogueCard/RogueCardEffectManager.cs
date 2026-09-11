using System;
using System.Collections.Generic;

namespace RogueCard;

public class RogueCardEffectManager
{
	private static RogueCardEffectManager instance;

	private Dictionary<TriggerMoment, List<RogueCardGameEffect>> playerEffectRegistry = new Dictionary<TriggerMoment, List<RogueCardGameEffect>>();

	private Dictionary<TriggerMoment, List<RogueCardGameEffect>> deckEffectRegistry = new Dictionary<TriggerMoment, List<RogueCardGameEffect>>();

	private Queue<RogueCardGameEffect> multiQueue = new Queue<RogueCardGameEffect>();

	public static RogueCardEffectManager Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new RogueCardEffectManager();
				instance.Init();
			}
			return instance;
		}
	}

	private void Init()
	{
		foreach (TriggerMoment value in Enum.GetValues(typeof(TriggerMoment)))
		{
			playerEffectRegistry[value] = new List<RogueCardGameEffect>();
			deckEffectRegistry[value] = new List<RogueCardGameEffect>();
		}
	}

	public void ResetForNewGame()
	{
		playerEffectRegistry.Clear();
		deckEffectRegistry.Clear();
		multiQueue.Clear();
		Init();
	}

	public RogueCardGameEffect RegistEffect(int effectID, EntityType entityType, bool executeOnAcquire = true)
	{
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[effectID];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(effectID, entityType, rogueCardEffectCfg.moment);
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction == null)
		{
			return null;
		}
		rogueCardGameEffect.action = baseAction;
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			rogueCardGameEffect.conditions.Add(CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1));
		}
		switch (entityType)
		{
		case EntityType.Player:
			playerEffectRegistry[rogueCardEffectCfg.moment].Add(rogueCardGameEffect);
			break;
		case EntityType.Deck:
			deckEffectRegistry[rogueCardEffectCfg.moment].Add(rogueCardGameEffect);
			break;
		}
		if (executeOnAcquire && rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
		{
			rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
		}
		return rogueCardGameEffect;
	}

	public RogueCardGameEffect RegistEffect(int effectID, RogueCardJokerData jokerData, bool isVersion = false, bool isCopy = false)
	{
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[effectID];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(effectID, EntityType.Joker, rogueCardEffectCfg.moment);
		if (isVersion)
		{
			jokerData.versionEffect = rogueCardGameEffect;
		}
		else if (isCopy)
		{
			jokerData.copyEffect = rogueCardGameEffect;
		}
		else
		{
			jokerData.effect.Add(rogueCardGameEffect);
		}
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			BaseCondition baseCondition = CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1);
			baseCondition.effectEntity = jokerData;
			rogueCardGameEffect.conditions.Add(baseCondition);
		}
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction == null)
		{
			return rogueCardGameEffect;
		}
		baseAction.effectID = effectID;
		baseAction.effectEntity = jokerData;
		rogueCardGameEffect.action = baseAction;
		if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
		{
			rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
		}
		return rogueCardGameEffect;
	}

	public void RegistEffect(int enhanceID, RogueCardJokerData jokerData, int cfgID)
	{
		int num = RogueCardDataManager.enhanceDatabase[enhanceID].effect_list[0];
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[num];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(num, EntityType.Joker, rogueCardEffectCfg.moment);
		jokerData.effect.Add(rogueCardGameEffect);
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			BaseCondition baseCondition = CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1);
			baseCondition.effectEntity = jokerData;
			rogueCardGameEffect.conditions.Add(baseCondition);
		}
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction != null)
		{
			baseAction.effectID = num;
			baseAction.effectEntity = jokerData;
			rogueCardGameEffect.action = baseAction;
			jokerData.versionID = cfgID;
			jokerData.versionEffect = rogueCardGameEffect;
			if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
			{
				rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
			}
		}
	}

	public void RegistEffect(int effectID, RogueCardData cardData)
	{
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[effectID];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(effectID, EntityType.Card, rogueCardEffectCfg.moment);
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			BaseCondition baseCondition = CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1);
			baseCondition.effectEntity = cardData;
			rogueCardGameEffect.conditions.Add(baseCondition);
		}
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction != null)
		{
			baseAction.effectID = effectID;
			baseAction.effectEntity = cardData;
			rogueCardGameEffect.action = baseAction;
			cardData.otherEffect.Add(rogueCardGameEffect);
			if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
			{
				rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
			}
		}
	}

	public void RegistEffect(int effectID)
	{
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[effectID];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(effectID, EntityType.Player, rogueCardEffectCfg.moment);
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			rogueCardGameEffect.conditions.Add(CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1));
		}
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction != null)
		{
			baseAction.effectID = effectID;
			rogueCardGameEffect.action = baseAction;
			if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
			{
				rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
			}
		}
	}

	public void RegistEffect(int enhanceID, RogueCardData cardData, int cfgID)
	{
		RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[enhanceID];
		int num = rogueCardEnhanceCfg.effect_list[0];
		RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[num];
		RogueCardGameEffect rogueCardGameEffect = new RogueCardGameEffect(num, EntityType.Card, rogueCardEffectCfg.moment);
		if (rogueCardEffectCfg.condition != ConditionType.Always)
		{
			BaseCondition baseCondition = CreateCondition(rogueCardEffectCfg.condition, rogueCardEffectCfg.param1);
			baseCondition.effectEntity = cardData;
			rogueCardGameEffect.conditions.Add(baseCondition);
		}
		BaseAction baseAction = CreateAction(rogueCardEffectCfg);
		if (baseAction == null)
		{
			return;
		}
		baseAction.effectID = num;
		baseAction.effectEntity = cardData;
		rogueCardGameEffect.action = baseAction;
		if (rogueCardEnhanceCfg.type == EnhanceType.Enhance)
		{
			cardData.enhanceEffect = rogueCardGameEffect;
			cardData.enhanceID = cfgID;
			if (RogueCardGameMain.Instance != null)
			{
				RogueCardGameMain.Instance.RecordItem(2, cfgID);
			}
		}
		else if (rogueCardEnhanceCfg.type == EnhanceType.Tag)
		{
			cardData.tagEffect = rogueCardGameEffect;
			cardData.tagID = cfgID;
			if (RogueCardGameMain.Instance != null)
			{
				RogueCardGameMain.Instance.RecordItem(2, cfgID);
			}
		}
		if (rogueCardGameEffect.triggerMoment == TriggerMoment.OnAcquire)
		{
			rogueCardGameEffect.ExecuteActions(rogueCardGameEffect.triggerMoment);
		}
	}

	public void UnRegistEffect(int effectID, EntityType entityType)
	{
		RogueCardGameEffect rogueCardGameEffect = null;
		switch (entityType)
		{
		case EntityType.Player:
		{
			foreach (KeyValuePair<TriggerMoment, List<RogueCardGameEffect>> item in playerEffectRegistry)
			{
				rogueCardGameEffect = item.Value.Find((RogueCardGameEffect e) => e.effectID == effectID);
				if (rogueCardGameEffect != null)
				{
					rogueCardGameEffect.OnDisabled();
					item.Value.Remove(rogueCardGameEffect);
				}
			}
			break;
		}
		case EntityType.Deck:
		{
			foreach (KeyValuePair<TriggerMoment, List<RogueCardGameEffect>> item2 in deckEffectRegistry)
			{
				rogueCardGameEffect = item2.Value.Find((RogueCardGameEffect e) => e.effectID == effectID);
				if (rogueCardGameEffect != null)
				{
					rogueCardGameEffect.OnDisabled();
					item2.Value.Remove(rogueCardGameEffect);
				}
			}
			break;
		}
		}
	}

	public void UnRegistAllEffects()
	{
		foreach (List<RogueCardGameEffect> value in playerEffectRegistry.Values)
		{
			foreach (RogueCardGameEffect item in value)
			{
				item.OnDisabled();
			}
			value.Clear();
		}
		foreach (List<RogueCardGameEffect> value2 in deckEffectRegistry.Values)
		{
			foreach (RogueCardGameEffect item2 in value2)
			{
				item2.OnDisabled();
			}
			value2.Clear();
		}
	}

	public List<RogueCardGameEffect> GetRegisteredEffects(EntityType entityType)
	{
		List<RogueCardGameEffect> list = new List<RogueCardGameEffect>();
		foreach (KeyValuePair<TriggerMoment, List<RogueCardGameEffect>> item in (entityType == EntityType.Player) ? playerEffectRegistry : deckEffectRegistry)
		{
			list.AddRange(item.Value);
		}
		return list;
	}

	public void TriggerEffects(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnCardPlayed || moment == TriggerMoment.OnRoundStart || moment == TriggerMoment.OnRoundWin)
		{
			RecoverEffect(moment);
		}
		Queue<RogueCardGameEffect> queue = new Queue<RogueCardGameEffect>();
		Queue<RogueCardGameEffect> queue2 = new Queue<RogueCardGameEffect>();
		for (int i = 0; i < deckEffectRegistry[moment].Count; i++)
		{
			queue.Enqueue(deckEffectRegistry[moment][i]);
		}
		for (int j = 0; j < playerEffectRegistry[moment].Count; j++)
		{
			queue.Enqueue(playerEffectRegistry[moment][j]);
		}
		List<RogueCardData> scoreCardData = RogueCardGameMain.GameContext.scoreResult.scoreCardData;
		List<RogueCardData> orderedHandData = RogueCardGameMain.GameContext.handData.GetOrderedHandData();
		List<RogueCardData> cards = RogueCardGameMain.GameContext.rogueDeck.cards;
		List<RogueCardData> list = new List<RogueCardData>();
		list.AddRange(scoreCardData);
		list.AddRange(orderedHandData);
		list.AddRange(cards);
		if (moment == TriggerMoment.OnRoundWin)
		{
			list.AddRange(RogueCardGameMain.GameContext.rogueDeck.discardPile);
		}
		for (int k = 0; k < list.Count; k++)
		{
			RogueCardData rogueCardData = list[k];
			for (int l = 0; l < rogueCardData.otherEffect.Count; l++)
			{
				if (rogueCardData.otherEffect[l].triggerMoment == moment)
				{
					queue.Enqueue(rogueCardData.otherEffect[l]);
				}
			}
		}
		List<RogueCardJokerData> orderedHandData2 = RogueCardGameMain.GameContext.jokerData.GetOrderedHandData();
		for (int m = 0; m < orderedHandData2.Count; m++)
		{
			RogueCardJokerData rogueCardJokerData = orderedHandData2[m];
			for (int n = 0; n < rogueCardJokerData.effect.Count; n++)
			{
				if (rogueCardJokerData.effect[n].effectID == 3061)
				{
					if (!(rogueCardJokerData.effect[n].action as CopyJokerEffectAction).CheckCopy())
					{
						continue;
					}
					RogueCardJokerData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
					for (int num = 0; num < cardDataAtDisplayIndex.effect.Count; num++)
					{
						if (cardDataAtDisplayIndex.effect[num].triggerMoment == moment)
						{
							RogueCardGameEffect item = new RogueCardGameEffect(cardDataAtDisplayIndex.effect[num], rogueCardJokerData);
							queue.Enqueue(item);
						}
					}
				}
				else if (rogueCardJokerData.effect[n].triggerMoment == moment)
				{
					queue.Enqueue(rogueCardJokerData.effect[n]);
				}
			}
		}
		while (queue.Count > 0)
		{
			RogueCardGameEffect rogueCardGameEffect = queue.Dequeue();
			if (rogueCardGameEffect.CheckConditions(moment))
			{
				queue2.Enqueue(rogueCardGameEffect);
			}
		}
		while (queue2.Count > 0)
		{
			queue2.Dequeue().ExecuteActions(moment);
		}
	}

	public bool TriggerCard(RogueCardData card, TriggerMoment moment)
	{
		if (card == null || card.effectDisable)
		{
			return false;
		}
		bool result = false;
		Queue<RogueCardGameEffect> queue = new Queue<RogueCardGameEffect>();
		Queue<RogueCardGameEffect> queue2 = new Queue<RogueCardGameEffect>();
		multiQueue.Clear();
		if (card.enhanceID != 0 && card.GetEnhanceEffect() != null)
		{
			queue.Enqueue(card.GetEnhanceEffect());
		}
		if (card.tagID != 0 && card.GetTagEffect() != null)
		{
			queue.Enqueue(card.GetTagEffect());
		}
		List<RogueCardJokerData> orderedHandData = RogueCardGameMain.GameContext.jokerData.GetOrderedHandData();
		for (int i = 0; i < orderedHandData.Count; i++)
		{
			RogueCardJokerData rogueCardJokerData = orderedHandData[i];
			for (int j = 0; j < rogueCardJokerData.effect.Count; j++)
			{
				if (rogueCardJokerData.effect[j].effectID == 3061)
				{
					if (!(rogueCardJokerData.effect[j].action as CopyJokerEffectAction).CheckCopy())
					{
						continue;
					}
					RogueCardJokerData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
					for (int k = 0; k < cardDataAtDisplayIndex.effect.Count; k++)
					{
						if (cardDataAtDisplayIndex.effect[j].triggerMoment == moment)
						{
							RogueCardGameEffect item = new RogueCardGameEffect(cardDataAtDisplayIndex.effect[j], rogueCardJokerData);
							queue.Enqueue(item);
						}
					}
				}
				else if (rogueCardJokerData.effect[j].triggerMoment == moment)
				{
					queue.Enqueue(rogueCardJokerData.effect[j]);
				}
			}
		}
		while (queue.Count > 0)
		{
			RogueCardGameEffect rogueCardGameEffect = queue.Dequeue();
			if (rogueCardGameEffect.CheckConditions(moment))
			{
				queue2.Enqueue(rogueCardGameEffect);
			}
		}
		while (queue2.Count > 0)
		{
			result = true;
			queue2.Dequeue().ExecuteActions(moment);
		}
		return result;
	}

	public bool TriggerJoker(RogueCardJokerData joker)
	{
		bool result = false;
		Queue<RogueCardGameEffect> queue = new Queue<RogueCardGameEffect>();
		Queue<RogueCardGameEffect> queue2 = new Queue<RogueCardGameEffect>();
		multiQueue.Clear();
		if (joker.versionID > 0 && joker.versionEffect.triggerMoment == TriggerMoment.OnJokerPlayed)
		{
			queue.Enqueue(joker.versionEffect);
		}
		for (int i = 0; i < joker.effect.Count; i++)
		{
			if (joker.effect[i].effectID == 3061)
			{
				if (!(joker.effect[i].action as CopyJokerEffectAction).CheckCopy())
				{
					continue;
				}
				RogueCardJokerData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
				for (int j = 0; j < cardDataAtDisplayIndex.effect.Count; j++)
				{
					if (cardDataAtDisplayIndex.effect[i].triggerMoment == TriggerMoment.OnJokerPlayed)
					{
						RogueCardGameEffect item = new RogueCardGameEffect(cardDataAtDisplayIndex.effect[i], joker);
						queue.Enqueue(item);
					}
				}
			}
			else if (joker.effect[i].triggerMoment == TriggerMoment.OnJokerPlayed)
			{
				queue.Enqueue(joker.effect[i]);
			}
		}
		while (queue.Count > 0)
		{
			RogueCardGameEffect rogueCardGameEffect = queue.Dequeue();
			if (rogueCardGameEffect.CheckConditions(TriggerMoment.OnJokerPlayed))
			{
				queue2.Enqueue(rogueCardGameEffect);
			}
		}
		while (queue2.Count > 0)
		{
			result = true;
			queue2.Dequeue().ExecuteActions(TriggerMoment.OnJokerPlayed);
		}
		return result;
	}

	private void RecoverEffect(TriggerMoment moment)
	{
		Queue<RogueCardGameEffect> queue = new Queue<RogueCardGameEffect>();
		foreach (KeyValuePair<TriggerMoment, List<RogueCardGameEffect>> item in deckEffectRegistry)
		{
			for (int i = 0; i < item.Value.Count; i++)
			{
				queue.Enqueue(item.Value[i]);
			}
		}
		foreach (KeyValuePair<TriggerMoment, List<RogueCardGameEffect>> item2 in playerEffectRegistry)
		{
			for (int j = 0; j < item2.Value.Count; j++)
			{
				queue.Enqueue(item2.Value[j]);
			}
		}
		List<RogueCardJokerData> orderedHandData = RogueCardGameMain.GameContext.jokerData.GetOrderedHandData();
		for (int k = 0; k < orderedHandData.Count; k++)
		{
			RogueCardJokerData rogueCardJokerData = orderedHandData[k];
			for (int l = 0; l < rogueCardJokerData.effect.Count; l++)
			{
				queue.Enqueue(rogueCardJokerData.effect[l]);
			}
		}
		while (queue.Count > 0)
		{
			RogueCardGameEffect rogueCardGameEffect = queue.Dequeue();
			if (rogueCardGameEffect.triggerResetMoment == moment)
			{
				rogueCardGameEffect.RecoverTriggerNum();
			}
			if (rogueCardGameEffect.lifeResetMoment == moment)
			{
				rogueCardGameEffect.RecoverLifeNum();
			}
		}
	}

	public static BaseCondition CreateCondition(ConditionType type, int[] param)
	{
		return type switch
		{
			ConditionType.HandType => new HandTypeCondition(param), 
			ConditionType.SameRank => new SameRankCondition(param), 
			ConditionType.CardNumLess => new CardNumLessCondition(param), 
			ConditionType.IsTargetSuit => new IsTargetSuitCondition(param), 
			ConditionType.IsTargetRank => new IsTargetRankCondition(param), 
			ConditionType.ArithmeticSequence => new ArithmeticSequenceCondition(), 
			ConditionType.Random => new RandomCondition(param), 
			ConditionType.FirstUseCard => new FirstUseCardCondition(), 
			ConditionType.UnsameSuit => new UnsameSuitCondition(), 
			ConditionType.ContainsSuit => new ContainsSuitCondition(param), 
			_ => new RandomCondition(param), 
		};
	}

	public static BaseAction CreateAction(RogueCardEffectCfg cfg)
	{
		int[] param = cfg.param2;
		return cfg.action switch
		{
			ActionType.ChangeGlobalData => new ChangeGlobalDataAction(param[0], param[1], param[2]), 
			ActionType.AddEnhance => new AddEnhanceAction(), 
			ActionType.AddEffect => new AddEffectAction(param[0], param[1]), 
			ActionType.ChangeValue => new ChangeValueAction(param[0], param[1], param[2]), 
			ActionType.AddJoker => new AddJokerAction(param[0], param[1]), 
			ActionType.ChangeSuit => new ChangeSuitAction(param[0]), 
			ActionType.AddRank => new AddRankAction(param[0]), 
			ActionType.ChangeRank => new ChangeRankAction(param[0]), 
			ActionType.DeleteCard => new DeleteCardAction(param[0]), 
			ActionType.AddUseHandTypeLevel => new AddUseHandTypeLevelAction(param[0]), 
			ActionType.CopyCard => new CopyCardAction(), 
			ActionType.RandomCopyCard => new RandomCopyCardAction(param[0], param[1]), 
			ActionType.AllSuit => new AllSuitAction(), 
			ActionType.MutliTrigger => new MutliTriggerAction(param[0]), 
			ActionType.OtherSuit => new OtherSuitAction(), 
			ActionType.BetterStraight => new BetterStraightAction(), 
			ActionType.BetterHand => new BetterHandAction(), 
			ActionType.DeleteSelf => new DeleteSelfAction(), 
			ActionType.ChangeAtPlay => new ChangeAtPlayAction(param[0], param[1]), 
			ActionType.AlwaysWuChang => new AlwaysWuChangAction(), 
			ActionType.IgnoreBossEffect => new IgnoreBossEffectAction(), 
			ActionType.CopyJokerEffect => new CopyJokerEffectAction(param[0]), 
			ActionType.RandomJoker => new RandomJokerAction(param[0]), 
			ActionType.AddByRank => new AddByRankAction(param[0], param[1], param[2]), 
			ActionType.RandomVersion => new RandomVersionAction(), 
			ActionType.GetGoldByPoint => new GetGoldByPointAction(param[0]), 
			ActionType.AddByDeckNum => new AddByDeckNumAction(param[0], param[1], param[2]), 
			ActionType.AddByDeckEnhance => new AddByDeckEnhanceAction(param[0], param[1]), 
			ActionType.AddByCardNum => new AddByCardNumAction(param[0], param[1]), 
			ActionType.ForceSelect => new ForceSelectAction(param[0]), 
			ActionType.NoRepeat => new NoRepeatAction(), 
			ActionType.OnlyOne => new OnlyOneAction(), 
			ActionType.CardFail => new CardFailAction(), 
			ActionType.RandomDiscard => new RandomDiscardAction(param[0]), 
			ActionType.AddTargetHandTypeLevel => new AddTargetHandTypeLevelAction(param[0], param[1]), 
			ActionType.DrawSameRankCard => new DrawSameRankCardAction(), 
			ActionType.RandomRank => new RandomRankAction(), 
			ActionType.AddRandomEnhance => new AddRandomEnhanceAction(param[0]), 
			ActionType.OddEven => new OddEvenAction(param[0], param[1]), 
			ActionType.TargetScore => new TargetScoreAction(param), 
			ActionType.ChangeValueByJokerSlot => new ChangeValueByJokerSlotAction(param[0], param[1]), 
			ActionType.ComboCard => new ComboCardAction(param[0], param[1]), 
			ActionType.MoreScore => new MoreScoreAction(param[0]), 
			_ => null, 
		};
	}
}
