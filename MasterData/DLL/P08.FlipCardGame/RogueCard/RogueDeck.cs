using System;
using System.Collections.Generic;

namespace RogueCard;

[Serializable]
public class RogueDeck
{
	public int deckID;

	public List<RogueCardData> cards = new List<RogueCardData>();

	public List<RogueCardData> discardPile = new List<RogueCardData>();

	public RogueDeck(int deckID)
	{
		this.deckID = deckID;
	}

	public static RogueDeck CreateDefaultDeck(int deckID)
	{
		RogueDeck rogueDeck = new RogueDeck(deckID);
		RogueDeckCfg rogueDeckCfg = RogueCardDataManager.deckDatabase[deckID];
		if (rogueDeckCfg.deck == 1)
		{
			foreach (Suit value in Enum.GetValues(typeof(Suit)))
			{
				foreach (Rank value2 in Enum.GetValues(typeof(Rank)))
				{
					if (value2 == Rank.A || value2 <= Rank.Ten)
					{
						rogueDeck.cards.Add(new RogueCardData(value, value2));
					}
				}
			}
		}
		else if (rogueDeckCfg.deck == 2)
		{
			foreach (Rank value3 in Enum.GetValues(typeof(Rank)))
			{
				if (value3 == Rank.A || value3 <= Rank.Ten)
				{
					rogueDeck.cards.Add(new RogueCardData(Suit.Spades, value3));
					rogueDeck.cards.Add(new RogueCardData(Suit.Spades, value3));
					rogueDeck.cards.Add(new RogueCardData(Suit.Hearts, value3));
					rogueDeck.cards.Add(new RogueCardData(Suit.Hearts, value3));
				}
			}
		}
		else if (rogueDeckCfg.deck == 3)
		{
			for (int i = 0; i < 40; i++)
			{
				int num = RogueCardGameMain.Random.Range(10, 50);
				int num2 = num % 10;
				Rank rank3 = num2 switch
				{
					0 => Rank.Ten, 
					1 => Rank.A, 
					_ => (Rank)num2, 
				};
				Suit suit2 = (Suit)(num / 10);
				rogueDeck.cards.Add(new RogueCardData(suit2, rank3));
			}
		}
		int[] effect_list = rogueDeckCfg.effect_list;
		foreach (int effectID in effect_list)
		{
			RogueCardEffectManager.Instance.RegistEffect(effectID, EntityType.Deck);
		}
		return rogueDeck;
	}

	public void MakeDeck()
	{
		cards.AddRange(discardPile);
		discardPile.Clear();
	}

	public void ShuffleCard(DeterministicRandom random)
	{
		cards.AddRange(discardPile);
		discardPile.Clear();
		int num = cards.Count;
		while (num > 1)
		{
			num--;
			int index = random.Range(0, num);
			RogueCardData value = cards[index];
			cards[index] = cards[num];
			cards[num] = value;
		}
	}

	public RogueCardData DrawCard()
	{
		if (cards.Count == 0)
		{
			return null;
		}
		RogueCardData result = cards[0];
		cards.RemoveAt(0);
		return result;
	}

	public RogueCardData DrawCard(Rank rank)
	{
		if (cards.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCardData rogueCardData = cards[i];
			if (rogueCardData.GetRank == rank)
			{
				cards.RemoveAt(i);
				return rogueCardData;
			}
		}
		return null;
	}

	public RogueCardData DrawCard(Rank rank, Suit suit)
	{
		if (cards.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCardData rogueCardData = cards[i];
			if (rogueCardData.GetRank == rank && (rogueCardData.GetSuit == suit || rogueCardData.allSuit))
			{
				cards.RemoveAt(i);
				return rogueCardData;
			}
		}
		RogueCardData result = cards[0];
		cards.RemoveAt(0);
		return result;
	}

	public List<RogueCardData> GetCard(int num)
	{
		List<RogueCardData> list = RogueCardGameMain.Random.RandomSample(cards, num);
		for (int i = 0; i < list.Count; i++)
		{
			cards.Remove(list[i]);
		}
		return list;
	}

	public void AddCard(RogueCardData data)
	{
		cards.Add(data);
		int num = cards.Count;
		DeterministicRandom randomSystem = RogueCardGameMain.Instance.randomSystem;
		while (num > 1)
		{
			num--;
			int index = randomSystem.Range(0, num);
			RogueCardData value = cards[index];
			cards[index] = cards[num];
			cards[num] = value;
		}
	}

	public void DiscardCard(RogueCardData data)
	{
		if (!discardPile.Contains(data))
		{
			discardPile.Add(data);
		}
	}

	public void RemoveCard(RogueCardData data)
	{
		if (cards.Contains(data))
		{
			cards.Remove(data);
		}
		else if (discardPile.Contains(data))
		{
			discardPile.Remove(data);
		}
	}
}
