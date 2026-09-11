using UnityEngine;

namespace RogueCard;

public class HandPlayState : IState
{
	private StageState parentStage;

	public HandPlayState(StageState parent)
	{
		parentStage = parent;
	}

	public void Enter()
	{
		Debug.Log("进入手牌操作阶段");
	}

	public void Update()
	{
		RogueCardGameMain.Instance.HandlePlayerInput();
		if (RogueCardGameMain.Instance.PlayerFinishedTurn())
		{
			parentStage.ChangeSubState(new CalScoreState(parentStage));
		}
		else if (!RogueCardGameMain.CheckDisableInput() && RogueCardGameMain.Instance.CheckNoCard())
		{
			RogueCardGameMain.Instance.ChangeMainState(new SettleState());
			RogueCardSaveSystem.SendTrackingPoint1(RogueCardGameMain.Instance.saveSystem.GetGameData(), isFinish: false, 2, RogueCardGameMain.GameContext.score, (int)((RogueCardGameMain.GameContext.GetTargetScore <= int.MaxValue) ? RogueCardGameMain.GameContext.GetTargetScore : int.MaxValue));
		}
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 5;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
