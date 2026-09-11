using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace RogueCard;

public class RogueCardScoreSystem : MonoBehaviour
{
	public RogueCardData curScoringCard;

	public int curScoringIndex;

	public bool isMulting;

	public RogueCardJokerData curScoringJokerData;

	public JokerScore curJokerScore;

	public static RogueCardScoreSystem Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
	}

	private void EnqueueZeroScoreCards(ScoreResult scoreResult, params RogueCardData[] cards)
	{
		if (cards == null)
		{
			return;
		}
		foreach (RogueCardData rogueCardData in cards)
		{
			if (rogueCardData != null)
			{
				CardScore cardScore = ScorePool.GetCardScore(rogueCardData);
				cardScore.score = 0f;
				scoreResult.scoreQueue.Enqueue(cardScore);
			}
		}
	}

	public void CalculateScore(ScoreResult scoreResult, params RogueCardData[] cards)
	{
		if (cards == null || cards.Length == 0 || cards.Length > 3)
		{
			throw new ArgumentException("必须传入1到3张牌");
		}
		if (IsStraightFlush(cards))
		{
			RogueCardGameMain.GameContext.settleContext.handTypeContainNum[0]++;
		}
		if (IsBomb(cards))
		{
			RogueCardGameMain.GameContext.settleContext.handTypeContainNum[1]++;
		}
		if (IsStraight(cards))
		{
			RogueCardGameMain.GameContext.settleContext.handTypeContainNum[3]++;
		}
		if (IsFlush(cards))
		{
			RogueCardGameMain.GameContext.settleContext.handTypeContainNum[2]++;
		}
		if (IsPair(cards))
		{
			RogueCardGameMain.GameContext.settleContext.handTypeContainNum[4]++;
		}
		RogueCardGameMain.GameContext.settleContext.handTypeContainNum[5]++;
		HandType bestHandType = GetBestHandType(cards);
		RogueCardGameMain.GameContext.settleContext.handTypeUseNum[bestHandType]++;
		int num = 0;
		HandType mostHandType = HandType.HighCard;
		foreach (KeyValuePair<HandType, int> item in RogueCardGameMain.GameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				mostHandType = item.Key;
			}
		}
		RogueCardGameMain.GameContext.settleContext.mostHandType = (int)mostHandType;
		RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[bestHandType];
		scoreResult.HandType = bestHandType;
		scoreResult.HandTypeScore = 0;
		scoreResult.HandTypeMulti = 0;
		scoreResult.TotalScore = 0L;
		scoreResult.FinalScore = 0f;
		scoreResult.FinalMulti = 0f;
		scoreResult.shouleSubLv = 0;
		scoreResult.HandTypeName = rogueHandTypeCfg.name;
		scoreResult.Show = true;
		scoreResult.scoreCardData.Clear();
		scoreResult.scoreCardData.AddRange(cards);
		scoreResult.originScoreCardData.Clear();
		RogueCardData[] array = cards;
		foreach (RogueCardData rogueCardData in array)
		{
			RogueCardData rogueCardData2 = new RogueCardData(rogueCardData);
			rogueCardData2.effectDisable = rogueCardData.effectDisable;
			scoreResult.originScoreCardData.Add((rogueCardData == null) ? null : rogueCardData2);
		}
		foreach (ScoreBase item2 in scoreResult.scoreQueue)
		{
			ScorePool.Release(item2);
		}
		foreach (ScoreBase item3 in scoreResult.multiQueue)
		{
			ScorePool.Release(item3);
		}
		foreach (ScoreBase item4 in scoreResult.priorityQueue)
		{
			ScorePool.Release(item4);
		}
		scoreResult.scoreQueue.Clear();
		scoreResult.multiQueue.Clear();
		scoreResult.priorityQueue.Clear();
		scoreResult.beforeLvJoker.Clear();
		scoreResult.leftJokerSet.Clear();
		scoreResult.silentHandPlayedJokerSet.Clear();
		if (RogueCardGameMain.GameContext.isDisableType)
		{
			if (RogueCardGameMain.GameContext.disableType.Contains(bestHandType))
			{
				EnqueueZeroScoreCards(scoreResult, cards);
				return;
			}
			RogueCardGameMain.GameContext.disableType.Add(bestHandType);
		}
		if (RogueCardGameMain.GameContext.isOnlyType)
		{
			if (RogueCardGameMain.GameContext.onlyType.HasValue && bestHandType != RogueCardGameMain.GameContext.onlyType)
			{
				EnqueueZeroScoreCards(scoreResult, cards);
				return;
			}
			if (!RogueCardGameMain.GameContext.onlyType.HasValue)
			{
				RogueCardGameMain.GameContext.onlyType = bestHandType;
			}
		}
		List<RogueCardData> orderedHandData = RogueCardGameMain.GameContext.handData.GetOrderedHandData();
		int beforeLv = RogueCardGameMain.GameContext.handTypeLevel[bestHandType];
		RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnCardPlayed);
		int num2 = RogueCardGameMain.GameContext.handTypeLevel[bestHandType];
		scoreResult.beforeLv = beforeLv;
		int num3 = rogueHandTypeCfg.base_score + (num2 - 1) * rogueHandTypeCfg.add_score;
		int num4 = rogueHandTypeCfg.base_multi + (num2 - 1) * rogueHandTypeCfg.add_multi;
		scoreResult.HandType = bestHandType;
		scoreResult.HandTypeScore = num3;
		scoreResult.HandTypeMulti = num4;
		curScoringIndex = -1;
		isMulting = false;
		array = cards;
		foreach (RogueCardData rogueCardData3 in array)
		{
			curScoringIndex++;
			if (rogueCardData3.effectDisable)
			{
				CardScore cardScore = ScorePool.GetCardScore(rogueCardData3);
				cardScore.score = 0f;
				scoreResult.scoreQueue.Enqueue(cardScore);
				continue;
			}
			CardScore cardScore2 = ScorePool.GetCardScore(rogueCardData3);
			cardScore2.score = rogueCardData3.GetFinalRank;
			scoreResult.scoreQueue.Enqueue(cardScore2);
			curScoringCard = rogueCardData3;
			RogueCardEffectManager.Instance.TriggerCard(rogueCardData3, TriggerMoment.OnScore);
			if (rogueCardData3.mutliTrigger)
			{
				isMulting = true;
				CardScore cardScore3 = ScorePool.GetCardScore(rogueCardData3);
				cardScore3.isMulti = true;
				scoreResult.priorityQueue.Enqueue(cardScore3);
				CardScore cardScore4 = ScorePool.GetCardScore(rogueCardData3);
				cardScore4.score = rogueCardData3.GetFinalRank;
				scoreResult.priorityQueue.Enqueue(cardScore4);
				scoreResult.multiTag = true;
				scoreResult.priorityMultiTag = true;
				RogueCardEffectManager.Instance.TriggerCard(rogueCardData3, TriggerMoment.OnScore);
				scoreResult.multiTag = false;
				scoreResult.priorityMultiTag = false;
				isMulting = false;
			}
			scoreResult.PushMultiScore();
		}
		if (RogueCardGameMain.GameContext.handTrigger)
		{
			curScoringIndex++;
			foreach (RogueCardData item5 in orderedHandData)
			{
				if (item5.effectDisable)
				{
					CardScore cardScore5 = ScorePool.GetCardScore(item5);
					cardScore5.score = 0f;
					scoreResult.scoreQueue.Enqueue(cardScore5);
					continue;
				}
				CardScore cardScore6 = ScorePool.GetCardScore(item5);
				cardScore6.score = item5.GetFinalRank;
				scoreResult.scoreQueue.Enqueue(cardScore6);
				curScoringCard = item5;
				RogueCardEffectManager.Instance.TriggerCard(item5, TriggerMoment.OnScore);
				if (item5.mutliTrigger)
				{
					isMulting = true;
					CardScore cardScore7 = ScorePool.GetCardScore(item5);
					cardScore7.isMulti = true;
					scoreResult.priorityQueue.Enqueue(cardScore7);
					CardScore cardScore8 = ScorePool.GetCardScore(item5);
					cardScore8.score = item5.GetFinalRank;
					scoreResult.priorityQueue.Enqueue(cardScore8);
					scoreResult.multiTag = true;
					scoreResult.priorityMultiTag = true;
					RogueCardEffectManager.Instance.TriggerCard(item5, TriggerMoment.OnScore);
					scoreResult.multiTag = false;
					scoreResult.priorityMultiTag = false;
					isMulting = false;
				}
				scoreResult.PushMultiScore();
			}
		}
		foreach (RogueCardData item6 in orderedHandData)
		{
			if (!item6.effectDisable)
			{
				RogueCardGameMain.GameContext.curEffectData = item6;
				if (RogueCardEffectManager.Instance.TriggerCard(item6, TriggerMoment.OnHandPlayed) && item6.mutliTrigger)
				{
					isMulting = true;
					CardScore cardScore9 = ScorePool.GetCardScore(item6);
					cardScore9.isMulti = true;
					scoreResult.priorityQueue.Enqueue(cardScore9);
					scoreResult.multiTag = true;
					scoreResult.priorityMultiTag = true;
					RogueCardEffectManager.Instance.TriggerCard(item6, TriggerMoment.OnHandPlayed);
					scoreResult.multiTag = false;
					scoreResult.priorityMultiTag = false;
					isMulting = false;
				}
				scoreResult.PushMultiScore();
			}
		}
		List<RogueCardJokerData> orderedHandData2 = RogueCardGameMain.GameContext.jokerData.GetOrderedHandData();
		if (orderedHandData2.Count > 0)
		{
			for (int j = 0; j < orderedHandData2.Count; j++)
			{
				RogueCardJokerData rogueCardJokerData = orderedHandData2[j];
				JokerScore jokerScore = ScorePool.GetJokerScore(rogueCardJokerData);
				bool flag = false;
				curScoringJokerData = rogueCardJokerData;
				curJokerScore = jokerScore;
				RogueCardEffectManager.Instance.TriggerJoker(rogueCardJokerData);
				if (rogueCardJokerData.addPoint != 0)
				{
					jokerScore.score = rogueCardJokerData.addPoint;
					flag = true;
				}
				if (rogueCardJokerData.addMutli != 0)
				{
					jokerScore.multi = rogueCardJokerData.addMutli;
					flag = true;
				}
				if (rogueCardJokerData.mulRatio != 100)
				{
					jokerScore.allMulti = rogueCardJokerData.mulRatio;
					flag = true;
				}
				if (flag)
				{
					scoreResult.scoreQueue.Enqueue(jokerScore);
					if (j == 0)
					{
						scoreResult.leftJokerSet.Add(jokerScore);
					}
				}
			}
		}
		scoreResult.PushMultiScore();
		double num5 = num3;
		double num6 = num4;
		foreach (ScoreBase item7 in scoreResult.scoreQueue)
		{
			num5 += (double)item7.score;
			num6 += (double)item7.multi;
			num6 = num6 * (double)item7.allMulti / 100.0;
		}
		scoreResult.FinalScore = (float)num5;
		scoreResult.FinalMulti = (float)num6;
		double num7 = num5 * num6;
		if (double.IsNaN(num7) || double.IsInfinity(num7) || num7 >= 2147483647.0 || num7 < -2147483648.0)
		{
			scoreResult.TotalScore = 2147483647L;
		}
		else
		{
			scoreResult.TotalScore = (int)Math.Round(num7);
		}
	}

	public HandType GetBestHandType(RogueCardData[] cards)
	{
		if (IsStraightFlush(cards))
		{
			return HandType.StraightFlush;
		}
		if (IsBomb(cards))
		{
			return HandType.Bomb;
		}
		if (IsStraight(cards))
		{
			return HandType.Straight;
		}
		if (IsFlush(cards))
		{
			return HandType.Flush;
		}
		if (IsPair(cards))
		{
			return HandType.Pair;
		}
		return HandType.HighCard;
	}

	public Tuple<HandType, int, int> GetPreviewData(params RogueCardData[] cards)
	{
		if (cards == null || cards.Length == 0 || cards.Length > 3)
		{
			return null;
		}
		HandType bestHandType = GetBestHandType(cards);
		int num = RogueCardGameMain.GameContext.handTypeLevel[bestHandType];
		RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[bestHandType];
		if (RogueCardGameMain.GameContext.isDisableType && RogueCardGameMain.GameContext.disableType.Contains(bestHandType))
		{
			return new Tuple<HandType, int, int>(bestHandType, 0, 0);
		}
		if (RogueCardGameMain.GameContext.isOnlyType && RogueCardGameMain.GameContext.onlyType.HasValue && bestHandType != RogueCardGameMain.GameContext.onlyType)
		{
			return new Tuple<HandType, int, int>(bestHandType, 0, 0);
		}
		int item = rogueHandTypeCfg.base_score + (num - 1) * rogueHandTypeCfg.add_score;
		int item2 = rogueHandTypeCfg.base_multi + (num - 1) * rogueHandTypeCfg.add_multi;
		return new Tuple<HandType, int, int>(bestHandType, item, item2);
	}

	public bool IsContainHandType(HandType type, List<RogueCardData> roguecards)
	{
		RogueCardData[] cards = roguecards.ToArray();
		return type switch
		{
			HandType.HighCard => true, 
			HandType.Pair => IsPair(cards), 
			HandType.Straight => IsStraight(cards), 
			HandType.Flush => IsFlush(cards), 
			HandType.Bomb => IsBomb(cards), 
			HandType.StraightFlush => IsStraightFlush(cards), 
			_ => false, 
		};
	}

	private bool IsStraightFlush(RogueCardData[] cards)
	{
		if (cards.Length == 3 && IsFlush(cards))
		{
			return IsStraight(cards);
		}
		return false;
	}

	private bool IsBomb(RogueCardData[] cards)
	{
		if (cards.Length != 3)
		{
			return false;
		}
		for (int i = 0; i < 3; i++)
		{
			if (cards[i] == null)
			{
				return false;
			}
		}
		if (cards[0].GetRank == cards[1].GetRank)
		{
			return cards[1].GetRank == cards[2].GetRank;
		}
		return false;
	}

	private bool IsStraight(RogueCardData[] cards)
	{
		if (cards.Length != 3)
		{
			return false;
		}
		for (int i = 0; i < 3; i++)
		{
			if (cards[i] == null)
			{
				return false;
			}
		}
		if (RogueCardGameMain.GameContext.isBetterStraight)
		{
			return IsBetterStraight(cards);
		}
		Rank[] sortedRanks = GetSortedRanks(cards);
		if (IsConsecutive((int)sortedRanks[0], (int)sortedRanks[1], (int)sortedRanks[2]))
		{
			return true;
		}
		if (sortedRanks.Contains(Rank.A) && sortedRanks.Contains(Rank.Two) && sortedRanks.Contains(Rank.Three))
		{
			return true;
		}
		if (sortedRanks.Contains(Rank.Nine) && sortedRanks.Contains(Rank.Ten) && sortedRanks.Contains(Rank.A))
		{
			return true;
		}
		return false;
	}

	private bool IsBetterStraight(RogueCardData[] cards)
	{
		Rank[] sortedRanks = GetSortedRanks(cards);
		int num = (int)sortedRanks[0];
		int num2 = (int)sortedRanks[1];
		int num3 = (int)sortedRanks[2];
		if ((num2 - num == 1 || num2 - num == 2) && (num3 - num2 == 1 || num3 - num2 == 2))
		{
			return true;
		}
		if (num3 == 11)
		{
			num3 = 1;
			if ((num - num3 == 1 || num - num3 == 2) && (num2 - num == 1 || num2 - num == 2))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsFlush(RogueCardData[] cards)
	{
		if (cards.Length != 3)
		{
			return false;
		}
		for (int i = 0; i < 3; i++)
		{
			if (cards[i] == null)
			{
				return false;
			}
		}
		if (cards[0].allSuit)
		{
			if (cards[1].GetSuit != cards[2].GetSuit && !cards[1].allSuit)
			{
				return cards[2].allSuit;
			}
			return true;
		}
		if (cards[1].allSuit)
		{
			if (cards[0].GetSuit != cards[2].GetSuit && !cards[0].allSuit)
			{
				return cards[2].allSuit;
			}
			return true;
		}
		if (cards[2].allSuit)
		{
			if (cards[0].GetSuit != cards[1].GetSuit && !cards[0].allSuit)
			{
				return cards[1].allSuit;
			}
			return true;
		}
		if (cards[0].GetSuit == cards[1].GetSuit)
		{
			return cards[1].GetSuit == cards[2].GetSuit;
		}
		return false;
	}

	private bool IsPair(RogueCardData[] cards)
	{
		if (cards.Length < 2)
		{
			return false;
		}
		if (cards.Length == 2)
		{
			return cards[0].GetRank == cards[1].GetRank;
		}
		if (cards[0].GetRank != cards[1].GetRank && cards[0].GetRank != cards[2].GetRank)
		{
			return cards[1].GetRank == cards[2].GetRank;
		}
		return true;
	}

	private int GetFinalRankValue(RogueCardData data)
	{
		return data.GetFinalRank;
	}

	private Rank[] GetSortedRanks(RogueCardData[] cards)
	{
		int num = cards.Length;
		Rank[] array = new Rank[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = cards[i].GetRank;
		}
		Array.Sort(array, delegate(Rank a, Rank b)
		{
			int num2 = (int)a;
			return num2.CompareTo((int)b);
		});
		return array;
	}

	private bool IsConsecutive(int val1, int val2, int val3)
	{
		if (val2 - val1 == 1)
		{
			return val3 - val2 == 1;
		}
		return false;
	}
}
