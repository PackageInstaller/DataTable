using UnityEngine;

namespace RogueCard;

public class InitStageState : IState
{
	private StageState parentStage;

	public InitStageState(StageState parent)
	{
		parentStage = parent;
	}

	public void Enter()
	{
		Debug.Log("初始化关卡数据");
		RogueCardGameMain.Instance.isHandle = false;
		RogueCardGameMain.Instance.EnterInitStageSubState();
		if (RogueCardGameMain.GameContext.isChallengeContinue)
		{
			RogueCardGameMain.GameContext.isChallengeContinue = false;
		}
		parentStage.ChangeSubState(new DrawCardState(parentStage));
	}

	public void Update()
	{
	}

	public void Exit()
	{
		RogueCardGameMain.Instance.ExitInitStageSubState();
	}

	public int GetIndex()
	{
		return 3;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
