using System.Collections.Generic;

namespace RogueCard;

public class TargetScoreAction : BaseAction
{
	private List<int> scores;

	public TargetScoreAction(params int[] scores)
	{
		this.scores = new List<int>();
		this.scores.AddRange(scores);
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext._scoreList.Clear();
		RogueCardGameMain.GameContext._scoreList.AddRange(scores);
	}

	public override void OnDisabled()
	{
		base.OnDisabled();
		RogueCardGameContext gameContext = RogueCardGameMain.GameContext;
		if (gameContext != null)
		{
			RogueCardStageCfg rogueCardStageCfg = RogueCardDataManager.stageDatabase[gameContext.stageID];
			gameContext._scoreList.Clear();
			gameContext._scoreList.AddRange(rogueCardStageCfg.score_list);
			gameContext.SetTargetScore();
		}
	}
}
