namespace RogueCard;

public class ChangeValueAction : BaseAction
{
	private enum ValueType
	{
		Rank = 1,
		Mult,
		MultAll
	}

	private enum ExeType
	{
		Cal = 1,
		Self
	}

	private ValueType valueType;

	private ExeType exeType;

	private int num;

	public ChangeValueAction(int valueType, int exeType, int num)
	{
		this.valueType = (ValueType)valueType;
		this.exeType = (ExeType)exeType;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		switch (moment)
		{
		case TriggerMoment.OnScore:
		case TriggerMoment.OnHandPlayed:
			if (exeType == ExeType.Cal)
			{
				if (moment == TriggerMoment.OnHandPlayed && effectID == 3131 && effectEntity is RogueCardJokerData)
				{
					RogueCardJokerData rogueCardJokerData = effectEntity as RogueCardJokerData;
					JokerScore jokerScore2 = null;
					if (rogueCardJokerData != null)
					{
						jokerScore2 = GetScoreBase() as JokerScore;
						if (jokerScore2 != null)
						{
							jokerScore2.suppressFlyText = true;
							jokerScore2.playTogetherWithNext = true;
							RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(jokerScore2);
						}
					}
					RogueCardData curEffectData = RogueCardGameMain.GameContext.curEffectData;
					if (curEffectData != null)
					{
						CardScore cardScore = ScorePool.GetCardScore(curEffectData);
						cardScore.linkedJokerData = rogueCardJokerData;
						if (valueType == ValueType.Rank)
						{
							cardScore.score = num;
						}
						else if (valueType == ValueType.Mult)
						{
							cardScore.multi = num;
						}
						else
						{
							cardScore.allMulti = num;
						}
						cardScore.playTogetherWithNext = false;
						if (jokerScore2 != null)
						{
							jokerScore2.linkedCardData = curEffectData;
						}
						RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(cardScore);
					}
					return;
				}
				if (valueType == ValueType.Rank)
				{
					ScoreBase scoreBase = GetScoreBase();
					scoreBase.score = num;
					RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase);
				}
				else if (valueType == ValueType.Mult)
				{
					ScoreBase scoreBase2 = GetScoreBase();
					scoreBase2.multi = num;
					RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase2);
				}
				else
				{
					ScoreBase scoreBase3 = GetScoreBase();
					scoreBase3.allMulti = num;
					RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase3);
				}
			}
			else if (exeType == ExeType.Self)
			{
				(effectEntity as RogueCardJokerData).addPoint += num;
			}
			break;
		case TriggerMoment.OnJokerPlayed:
			if (exeType == ExeType.Cal)
			{
				JokerScore jokerScore = GetScoreBase() as JokerScore;
				if (valueType == ValueType.Rank)
				{
					jokerScore.score += num;
				}
				else if (valueType == ValueType.Mult)
				{
					jokerScore.multi += num;
				}
				else
				{
					jokerScore.allMulti *= (float)num / 100f;
				}
				RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(jokerScore);
			}
			else if (exeType == ExeType.Self)
			{
				(effectEntity as RogueCardJokerData).addPoint += num;
			}
			break;
		}
		if (moment == TriggerMoment.OnCardPlayed && exeType == ExeType.Self)
		{
			if (valueType == ValueType.Rank)
			{
				(effectEntity as RogueCardJokerData).addPoint += num;
			}
			else if (valueType == ValueType.Mult)
			{
				(effectEntity as RogueCardJokerData).addMutli += num;
			}
		}
		if (moment == TriggerMoment.OnAcquire && exeType == ExeType.Self)
		{
			if (RogueCardGameMain.GameContext.isRestoringSave)
			{
				return;
			}
			if (valueType == ValueType.Rank)
			{
				(effectEntity as RogueCardJokerData).addPoint += num;
			}
			else if (valueType == ValueType.Mult)
			{
				(effectEntity as RogueCardJokerData).addMutli += num;
			}
		}
		if (moment == TriggerMoment.OnDiscardPlayed && exeType == ExeType.Self)
		{
			if (valueType == ValueType.Rank)
			{
				(effectEntity as RogueCardJokerData).addPoint += num;
			}
			else if (valueType == ValueType.Mult)
			{
				(effectEntity as RogueCardJokerData).addMutli += num;
			}
			else if (valueType == ValueType.MultAll)
			{
				(effectEntity as RogueCardJokerData).mulRatio += num;
			}
			if (effectEntity is RogueCardJokerData)
			{
				RogueCardJokerData joker = effectEntity as RogueCardJokerData;
				RogueCard rogueCard = RogueCardGameMain.Instance.jokerHolder.cards.Find((RogueCard card) => card.ParentIndex() == RogueCardGameMain.GameContext.jokerData.GetDataIndex(joker));
				if (rogueCard != null && rogueCard.cardVisual != null)
				{
					(rogueCard.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa");
					(rogueCard.cardVisual as VisualJokerCard).PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_CARD_LEVEL_UP"), FlyNumberType.Normal);
				}
			}
		}
		if (moment != TriggerMoment.OnCardDiscarded || exeType != ExeType.Self)
		{
			return;
		}
		if (valueType == ValueType.Rank)
		{
			(effectEntity as RogueCardJokerData).addPoint += num;
		}
		else if (valueType == ValueType.Mult)
		{
			(effectEntity as RogueCardJokerData).addMutli += num;
		}
		else if (valueType == ValueType.MultAll)
		{
			(effectEntity as RogueCardJokerData).mulRatio += num;
		}
		if (effectEntity is RogueCardJokerData)
		{
			RogueCardJokerData joker2 = effectEntity as RogueCardJokerData;
			RogueCard rogueCard2 = RogueCardGameMain.Instance.jokerHolder.cards.Find((RogueCard card) => card.ParentIndex() == RogueCardGameMain.GameContext.jokerData.GetDataIndex(joker2));
			if (rogueCard2 != null && rogueCard2.cardVisual != null)
			{
				(rogueCard2.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa");
				(rogueCard2.cardVisual as VisualJokerCard).PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_CARD_LEVEL_UP"), FlyNumberType.Normal);
			}
		}
	}
}
