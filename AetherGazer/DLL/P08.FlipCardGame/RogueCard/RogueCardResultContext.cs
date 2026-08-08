using System.Collections.Generic;

namespace RogueCard;

public class RogueCardResultContext
{
	public Dictionary<HandType, int> handTypeUseNum;

	public List<int> handTypeContainNum;

	public List<int> useItemID;

	public List<int> enhanceID;

	public List<int> wealWoeID;

	public int mostHandType;

	public int round;

	public int maxScore;

	public int useCardNum;

	public int discardNum;

	public int blackWuChangNum;

	public int whiteWuChangNum;

	public int gainGoldNum;

	public int useGoldNum;

	public int gainJokerNum;

	public int useANum;

	public int useEnhanceNum;

	public int useTime;

	public int score;

	public RogueCardResultContext()
	{
		handTypeUseNum = new Dictionary<HandType, int>
		{
			[HandType.HighCard] = 0,
			[HandType.Pair] = 0,
			[HandType.Straight] = 0,
			[HandType.Flush] = 0,
			[HandType.Bomb] = 0,
			[HandType.StraightFlush] = 0
		};
		handTypeContainNum = new List<int> { 0, 0, 0, 0, 0, 0 };
		useItemID = new List<int>();
		enhanceID = new List<int>();
		wealWoeID = new List<int>();
		mostHandType = 0;
		round = 0;
		maxScore = 0;
		useCardNum = 0;
		discardNum = 0;
		blackWuChangNum = 0;
		whiteWuChangNum = 0;
		gainGoldNum = 0;
		useGoldNum = 0;
		gainJokerNum = 0;
		useANum = 0;
		useEnhanceNum = 0;
		useTime = 0;
		score = 0;
	}
}
