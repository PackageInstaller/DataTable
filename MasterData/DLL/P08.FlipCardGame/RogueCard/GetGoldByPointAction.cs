using System.Collections.Generic;

namespace RogueCard;

public class GetGoldByPointAction : BaseAction
{
	public int ratio;

	public GetGoldByPointAction(int ratio)
	{
		this.ratio = ratio;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		int num = 0;
		for (int i = 0; i < getWuChangSelect.Count; i++)
		{
			RogueCardData rogueCardData = getWuChangSelect[i];
			num += rogueCardData.GetFinalRank;
		}
		int num2 = (int)((float)ratio / 100f * (float)num);
		RogueCardGameMain.GameContext.gold += num2;
		RogueCardGameMain.GameContext.settleContext.gainGoldNum += num2;
		RogueCardGameMain.Instance.RefreshUI();
	}
}
