using UnityEngine;

namespace RogueCard;

public class CalScoreState : IState
{
	private StageState parentStage;

	private bool calScoreCompleted;

	public CalScoreState(StageState parent)
	{
		parentStage = parent;
	}

	public void Enter()
	{
		Debug.Log("进入结算阶段");
		calScoreCompleted = false;
	}

	public void Update()
	{
		if (!calScoreCompleted && !RogueCardGameMain.GameContext.scoreResult.Show)
		{
			calScoreCompleted = true;
			CompleteCalScore();
		}
	}

	private void CompleteCalScore()
	{
		if (RogueCardGameMain.Instance.CheckRoundSuccess())
		{
			Debug.Log("回合成功");
			if (parentStage.CheckStageVictory())
			{
				if (parentStage.CheckStageFinish())
				{
					RogueCardGameMain.GameContext.resultContinue = true;
					RogueCardGameMain.Instance.ChangeMainState(new SettleState());
				}
				else
				{
					RogueCardGameMain.Instance.CompleteStage(victory: true);
					RogueCardGameMain.Instance.ChangeMainState(new TurnSettleState());
					RogueCardSaveSystem.SendTrackingPoint1(RogueCardGameMain.Instance.saveSystem.GetGameData(), isFinish: false, 1, RogueCardGameMain.GameContext.score, (int)((RogueCardGameMain.GameContext.GetTargetScore <= int.MaxValue) ? RogueCardGameMain.GameContext.GetTargetScore : int.MaxValue));
				}
			}
			else if (RogueCardGameMain.Instance.gameContext.playNum > 0 && RogueCardGameMain.Instance.CheckNoCard())
			{
				RogueCardGameMain.Instance.ChangeMainState(new SettleState());
			}
			else
			{
				RogueCardGameMain.Instance.ReserveDrawLock();
				parentStage.ChangeSubState(new DrawCardState(parentStage));
			}
		}
		else
		{
			Debug.Log("回合失败");
			RogueCardGameMain.GameContext.result = RogueCardGameMain.GameContext.stageType == LevelType.Challenge && RogueCardGameMain.GameContext.curRound > RogueCardGameMain.GameContext.allRoundNum;
			RogueCardGameMain.Instance.ChangeMainState(new SettleState());
		}
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 6;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
