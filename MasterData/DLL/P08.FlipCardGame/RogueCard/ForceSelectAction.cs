using System.Collections.Generic;

namespace RogueCard;

public class ForceSelectAction : BaseAction
{
	public int num;

	public ForceSelectAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			List<RogueCardData> orderedHandData = RogueCardGameMain.GameContext.handData.GetOrderedHandData();
			if (RogueCardGameMain.GameContext.restoreForceSelectIndex >= 0)
			{
				if (RogueCardGameMain.GameContext.restoreForceSelectIndex < orderedHandData.Count)
				{
					RogueCardGameMain.GameContext.handData.forceSelect = orderedHandData[RogueCardGameMain.GameContext.restoreForceSelectIndex];
					RogueCardGameMain.GameContext.restoreForceSelectIndex = -1;
					if (!RogueCardGameMain.Instance.suppressRoundStartForceSelectRefresh)
					{
						RogueCardGameMain.Instance.RefreshUI();
					}
				}
			}
			else
			{
				RogueCardGameMain.GameContext.handData.forceSelect = null;
			}
		}
		else
		{
			RogueCardGameMain.GameContext.handData.forceSelect = RogueCardGameMain.Random.RandomChoice(RogueCardGameMain.GameContext.handData.handCards);
			if (!RogueCardGameMain.Instance.suppressRoundStartForceSelectRefresh)
			{
				RogueCardGameMain.Instance.RefreshUI();
			}
		}
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.restoreForceSelectIndex = -1;
		RogueCardGameMain.GameContext.handData.forceSelect = null;
	}
}
