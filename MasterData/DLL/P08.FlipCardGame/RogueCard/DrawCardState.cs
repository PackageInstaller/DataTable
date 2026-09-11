using UnityEngine;

namespace RogueCard;

public class DrawCardState : IState
{
	private StageState parentStage;

	private float drawTimer;

	public DrawCardState(StageState parent)
	{
		parentStage = parent;
	}

	public void Enter()
	{
		Debug.Log("进入抽牌阶段");
		drawTimer = 0f;
		RogueCardGameMain.Instance.DrawCard();
	}

	public void Update()
	{
		drawTimer += Time.deltaTime;
		if (drawTimer >= RogueCardGameMain.Instance.CardDrawDuration && RogueCardGameMain.Instance.CardsReadyToPlay())
		{
			parentStage.ChangeSubState(new HandPlayState(parentStage));
		}
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 4;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
