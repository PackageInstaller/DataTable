using System;
using System.Collections.Generic;

namespace RogueCard;

[Serializable]
public class RogueCardData : IComparable<RogueCardData>, IEffectEntity
{
	public Suit suit;

	public Rank rank;

	public int enhanceID;

	public int tagID;

	public List<RogueCardGameEffect> otherEffect = new List<RogueCardGameEffect>();

	public bool effectDisable;

	public RogueCardGameEffect enhanceEffect { private get; set; }

	public RogueCardGameEffect tagEffect { private get; set; }

	public bool allSuit
	{
		get
		{
			RogueCardGameEffect rogueCardGameEffect = GetEnhanceEffect();
			if (rogueCardGameEffect == null)
			{
				return false;
			}
			return rogueCardGameEffect.effectID == 104;
		}
	}

	public bool mutliTrigger
	{
		get
		{
			RogueCardGameEffect rogueCardGameEffect = GetTagEffect();
			if (rogueCardGameEffect == null)
			{
				return false;
			}
			return rogueCardGameEffect.effectID == 202;
		}
	}

	public Suit GetSuit
	{
		get
		{
			if (RogueCardGameMain.GameContext.isOtherSuit)
			{
				if (suit == Suit.Clubs)
				{
					return Suit.Spades;
				}
				if (suit == Suit.Diamonds)
				{
					return Suit.Hearts;
				}
			}
			return suit;
		}
	}

	public Rank GetRank
	{
		get
		{
			if (RogueCardGameMain.GameContext.isOddEven)
			{
				if ((int)rank % 2 == 1)
				{
					return RogueCardGameMain.GameContext.oddValue;
				}
				return RogueCardGameMain.GameContext.evenValue;
			}
			return rank;
		}
	}

	public int GetFinalRank => (int)GetRank;

	public string GetRankStr()
	{
		if (rank != Rank.A)
		{
			int num = (int)rank;
			return num.ToString();
		}
		return "A";
	}

	public RogueCardGameEffect GetEnhanceEffect()
	{
		if (effectDisable)
		{
			return null;
		}
		return enhanceEffect;
	}

	public RogueCardGameEffect GetTagEffect()
	{
		if (effectDisable)
		{
			return null;
		}
		return tagEffect;
	}

	public RogueCardData(Suit suit, Rank rank)
	{
		this.suit = suit;
		this.rank = rank;
		otherEffect = new List<RogueCardGameEffect>();
	}

	public RogueCardData(RogueCardData data)
	{
		suit = data.suit;
		rank = data.rank;
		AddBlackWuChangByEnhance(data.enhanceID);
		AddBlackWuChangByEnhance(data.tagID);
		effectDisable = data.effectDisable;
		otherEffect = new List<RogueCardGameEffect>();
	}

	public RogueCardData(RogueCardSaveCardData saveCard)
	{
		suit = (Suit)saveCard.suit;
		rank = (Rank)saveCard.rank;
		AddBlackWuChangByEnhance(saveCard.enhance_id);
		AddBlackWuChangByEnhance(saveCard.tag_id);
		effectDisable = saveCard.effect_disable;
		for (int i = 0; i < saveCard.other_data.Count; i++)
		{
			if (i % 3 == 0)
			{
				RogueCardEffectManager.Instance.RegistEffect(saveCard.other_data[i], this);
			}
			else if (i % 3 == 1)
			{
				otherEffect[i / 3].triggerCount = saveCard.other_data[i];
			}
			else
			{
				otherEffect[i / 3].lifeCount = saveCard.other_data[i];
			}
		}
	}

	public int CompareTo(RogueCardData other)
	{
		if (suit != other.suit)
		{
			return suit - other.suit;
		}
		return GetFinalRank - other.GetFinalRank;
	}

	public void AddBlackWuChang(int id)
	{
		if (id > 0)
		{
			RogueCardGameMain.Instance.RecordItem(1, id);
			if (RogueCardGameMain.Instance != null && RogueCardGameMain.Instance.gameContext != null)
			{
				RogueCardGameMain.Instance.gameContext.settleContext.useEnhanceNum++;
			}
			RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == id);
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[rogueCardItemCfg.effect_list[0]];
			EnhanceType type = rogueCardEnhanceCfg.type;
			int num = rogueCardEnhanceCfg.effect_list[0];
			switch (type)
			{
			case EnhanceType.Enhance:
				RogueCardEffectManager.Instance.RegistEffect(num, this, rogueCardEnhanceCfg.id);
				break;
			case EnhanceType.Tag:
				RogueCardEffectManager.Instance.RegistEffect(num, this, rogueCardEnhanceCfg.id);
				break;
			}
		}
	}

	public void AddBlackWuChangByEnhance(int id)
	{
		if (id > 0)
		{
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[id];
			EnhanceType type = rogueCardEnhanceCfg.type;
			int num = rogueCardEnhanceCfg.effect_list[0];
			switch (type)
			{
			case EnhanceType.Enhance:
				RogueCardEffectManager.Instance.RegistEffect(num, this, rogueCardEnhanceCfg.id);
				break;
			case EnhanceType.Tag:
				RogueCardEffectManager.Instance.RegistEffect(num, this, rogueCardEnhanceCfg.id);
				break;
			}
		}
	}
}
