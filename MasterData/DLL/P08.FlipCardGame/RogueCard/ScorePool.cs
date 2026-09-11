using System.Collections.Generic;

namespace RogueCard;

public static class ScorePool
{
	private static Stack<CardScore> cardScorePool = new Stack<CardScore>();

	private static Stack<JokerScore> jokerScorePool = new Stack<JokerScore>();

	public static CardScore GetCardScore(RogueCardData cardData = null)
	{
		CardScore obj = ((cardScorePool.Count > 0) ? cardScorePool.Pop() : new CardScore());
		obj.cardData = cardData;
		return obj;
	}

	public static JokerScore GetJokerScore(RogueCardJokerData jokerData = null)
	{
		JokerScore obj = ((jokerScorePool.Count > 0) ? jokerScorePool.Pop() : new JokerScore());
		obj.jokerData = jokerData;
		return obj;
	}

	public static void Release(ScoreBase score)
	{
		if (score != null)
		{
			score.Reset();
			if (score is CardScore item)
			{
				cardScorePool.Push(item);
			}
			else if (score is JokerScore item2)
			{
				jokerScorePool.Push(item2);
			}
		}
	}
}
