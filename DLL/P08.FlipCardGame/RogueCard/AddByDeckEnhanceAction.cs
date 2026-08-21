using System.Collections.Generic;

namespace RogueCard;

public class AddByDeckEnhanceAction : BaseAction
{
	public int numType;

	public int num;

	public AddByDeckEnhanceAction(int numType, int num)
	{
		this.numType = numType;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getAllCards = RogueCardGameMain.GameContext.GetAllCards;
		int num = 0;
		for (int i = 0; i < getAllCards.Count; i++)
		{
			RogueCardData rogueCardData = getAllCards[i];
			if (rogueCardData.enhanceID != 0 || rogueCardData.tagID != 0)
			{
				num++;
			}
		}
		ScoreBase scoreBase = GetScoreBase();
		scoreBase.score = num * this.num;
		RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase);
	}
}
