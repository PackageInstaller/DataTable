using System.Collections.Generic;
using System.Linq;

namespace RogueCard;

public class AddRandomEnhanceAction : BaseAction
{
	private int type1;

	private int type2;

	public AddRandomEnhanceAction(int type1)
	{
		this.type1 = type1;
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardData cardData = ((moment != TriggerMoment.OnCardPlayed && moment != TriggerMoment.OnScore) ? RogueCardGameMain.GameContext.GetSelectDataList()[0] : RogueCardGameMain.GameContext.scoreResult.scoreCardData[0]);
		if (type1 > 0 && type1 < 3)
		{
			List<RogueCardEnhanceCfg> list = RogueCardDataManager.enhanceDatabase.Values.ToList().FindAll((RogueCardEnhanceCfg cfg) => cfg.type == (EnhanceType)type1);
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardGameMain.Random.RandomChoice(list);
			RogueCardEffectManager.Instance.RegistEffect(rogueCardEnhanceCfg.effect_list[0], cardData, rogueCardEnhanceCfg.id);
			JokerScore jokerScore = GetScoreBase() as JokerScore;
			jokerScore.jokerData = effectEntity as RogueCardJokerData;
			jokerScore.isEnhance = rogueCardEnhanceCfg.id;
			RogueCardGameMain.GameContext.scoreResult.enhanceTag = true;
			RogueCardGameMain.GameContext.scoreResult.enhanceID = rogueCardEnhanceCfg.id;
			RogueCardGameMain.GameContext.scoreResult.AddScoreData(jokerScore);
		}
	}
}
