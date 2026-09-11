using System.Collections.Generic;

namespace RogueCard;

public class ScoreResult
{
	public List<RogueCardData> scoreCardData = new List<RogueCardData>();

	public List<RogueCardData> originScoreCardData = new List<RogueCardData>();

	public Queue<ScoreBase> scoreQueue = new Queue<ScoreBase>();

	public Queue<ScoreBase> multiQueue = new Queue<ScoreBase>();

	public Queue<ScoreBase> priorityQueue = new Queue<ScoreBase>();

	public HashSet<JokerScore> leftJokerSet = new HashSet<JokerScore>();

	public HashSet<RogueCardJokerData> silentHandPlayedJokerSet = new HashSet<RogueCardJokerData>();

	public int beforeLv;

	public int shouleSubLv;

	public HashSet<int> beforeLvJoker = new HashSet<int>();

	public bool multiTag;

	public bool priorityMultiTag;

	public bool enhanceTag;

	public int enhanceID;

	public HandType HandType { get; set; }

	public int HandTypeScore { get; set; }

	public int HandTypeMulti { get; set; }

	public float FinalScore { get; set; }

	public float FinalMulti { get; set; }

	public long TotalScore { get; set; }

	public string HandTypeName { get; set; }

	public bool Show { get; set; }

	public void AddScoreData(ScoreBase score)
	{
		if (multiTag)
		{
			if (priorityMultiTag)
			{
				priorityQueue.Enqueue(score);
			}
			else
			{
				multiQueue.Enqueue(score);
			}
		}
		else
		{
			scoreQueue.Enqueue(score);
		}
	}

	public void PushMultiScore()
	{
		while (priorityQueue.Count > 0)
		{
			scoreQueue.Enqueue(priorityQueue.Dequeue());
		}
		while (multiQueue.Count > 0)
		{
			scoreQueue.Enqueue(multiQueue.Dequeue());
		}
	}
}
